#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <inttypes.h>

#ifndef SOURCE_SHA256
#define SOURCE_SHA256 "unbound"
#endif

static int irho(long long x, int M) { int u=(int)(x%M); if(u<0)u+=M; return u < M-u ? u : M-u; }
static int target_valid(int N,int p,int b,int c){ return N>=4 && p>=1 && b>0 && c>0 && b<c && c<p; }
static int bad_literal(int N,int p,int d,int r){ int M=N*p; return (r%N)!=0 && irho((long long)r*d,M)<p; }

static uint64_t fnv_u64(uint64_t h, uint64_t x){ for(int i=0;i<8;i++){ h^=(uint8_t)(x>>(8*i)); h*=UINT64_C(1099511628211);} return h; }
static void bit_set(uint64_t *a,int r){ a[r>>6] |= UINT64_C(1)<<(r&63); }

static void build_bad_literal(int N,int p,int d,uint64_t *out,int words){
  memset(out,0,(size_t)words*sizeof(uint64_t)); int M=N*p;
  for(int r=0;r<M;r++) if(bad_literal(N,p,d,r)) bit_set(out,r);
}
static void build_R(int N,int p,uint64_t *out,int words){
  memset(out,0,(size_t)words*sizeof(uint64_t)); int M=N*p;
  for(int r=0;r<M;r++) if(r%N) bit_set(out,r);
}
static int least_uncovered_bits(int M,const uint64_t *R,const uint64_t *A,const uint64_t *B,int words){
  for(int w=0;w<words;w++){
    uint64_t z=R[w] & ~(A[w]|B[w]);
    if(w==words-1 && (M&63)) z &= (UINT64_C(1)<<(M&63))-1;
    if(z) return 64*w + __builtin_ctzll(z);
  }
  return -1;
}

static int list_equals(const int *got,int ng,const int *exp,int ne){ if(ng!=ne)return 0; for(int i=0;i<ng;i++)if(got[i]!=exp[i])return 0; return 1; }
static int compute_R_B_U(int N,int p,int b,int c,int *R,int *nR,int *Bb,int *nBb,int *Bc,int *nBc,int *U,int *nU){
  if(N<1||p<1||b<1||c<1) return 0;
  int M=N*p; *nR=*nBb=*nBc=*nU=0;
  for(int r=0;r<M;r++) if(r%N){ R[(*nR)++]=r; int xb=irho((long long)r*b,M)<p; int xc=irho((long long)r*c,M)<p; if(xb)Bb[(*nBb)++]=r; if(xc)Bc[(*nBc)++]=r; if(!xb&&!xc)U[(*nU)++]=r; }
  return 1;
}
static int check_exact_case(int N,int p,int b,int c,const int *eR,int nER,const int *eB,int nEB,const int *eC,int nEC,const int *eU,int nEU){
  int M=N*p; int *R=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*C=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)); int nR,nB,nC,nU;
  compute_R_B_U(N,p,b,c,R,&nR,B,&nB,C,&nC,U,&nU);
  int ok=list_equals(R,nR,eR,nER)&&list_equals(B,nB,eB,nEB)&&list_equals(C,nC,eC,nEC)&&list_equals(U,nU,eU,nEU);
  free(R);free(B);free(C);free(U);return ok;
}

static int subset_covers_literal(const int *a,int n,int pivot_speed,const int *owners,int m){
  (void)a;
  int N=n+1,M=N*pivot_speed;
  for(int r=0;r<M;r++) if(r%N){ int covered=0; for(int k=0;k<m;k++) if(irho((long long)r*owners[k],M)<pivot_speed){covered=1;break;} if(!covered)return 0; }
  return 1;
}
static int covered_speeds_literal(const int *a,int n,int *out){
  int N=n+1,q=0;
  for(int j=0;j<n;j++){ int p=a[j],M=N*p,covered=1; for(int r=0;r<M && covered;r++) if(r%N){ int hit=0; for(int i=0;i<n;i++)if(i!=j && irho((long long)r*a[i],M)<p){hit=1;break;} if(!hit)covered=0; } if(covered)out[q++]=p; }
  for(int i=0;i<q;i++)for(int j=i+1;j<q;j++)if(out[j]<out[i]){int t=out[i];out[i]=out[j];out[j]=t;}
  return q;
}
static void perm_rec(const int *base,int n,int pos,int *perm,const int *expectedF,int nF,const int *checks,int nchecks,int *ok,long long *count){
  if(!*ok)return;
  if(pos==n){
    int got[16],ng=covered_speeds_literal(perm,n,got); if(!list_equals(got,ng,expectedF,nF)){*ok=0;return;}
    int pivot=expectedF[nF-1];
    for(int t=0;t<nchecks;t+=4){ int m=checks[t]; int owners[3]={checks[t+1],checks[t+2],checks[t+3]}; if(subset_covers_literal(perm,n,pivot,owners,m)){*ok=0;return;} }
    int scaled[16],expS[16],chkS[64]; for(int i=0;i<n;i++)scaled[i]=5*perm[i]; for(int i=0;i<nF;i++)expS[i]=5*expectedF[i];
    int gotS[16],ngS=covered_speeds_literal(scaled,n,gotS); if(!list_equals(gotS,ngS,expS,nF)){*ok=0;return;}
    for(int t=0;t<nchecks;t+=4){ int m=checks[t]; for(int j=0;j<4;j++)chkS[t+j]=checks[t+j]*(j?5:1); int owners[3]={chkS[t+1],chkS[t+2],chkS[t+3]}; if(subset_covers_literal(scaled,n,5*pivot,owners,m)){*ok=0;return;} }
    (*count)+=2; return;
  }
  for(int i=0;i<n;i++){ int used=0; for(int j=0;j<pos;j++)if(perm[j]==base[i])used=1; if(!used){perm[pos]=base[i];perm_rec(base,n,pos+1,perm,expectedF,nF,checks,nchecks,ok,count);} }
}
static int audit_route_fixtures(long long *perm_checks){
  int ok=1,perm[16]; *perm_checks=0;
  {int a[]={1,6,11,12,13},F[]={1,6},checks[]={1,1,0,0}; perm_rec(a,5,0,perm,F,2,checks,4,&ok,perm_checks);}
  {int a[]={6,7,12,24,144},F[]={6,7,12,24},checks[]={2,6,7,0,2,6,12,0,2,7,12,0,3,6,7,12}; perm_rec(a,5,0,perm,F,4,checks,16,&ok,perm_checks);}
  {int a[]={1,4,5,6,7,11},F[]={1,4,5,11},checks[]={2,1,4,0,2,1,5,0,2,4,5,0,3,1,4,5}; perm_rec(a,6,0,perm,F,4,checks,16,&ok,perm_checks);}
  return ok;
}

static int run_fixtures(long long *perm_checks){
  const int R4312[]={1,2,3,5,6,7,9,10,11},B1[]={1,2,10,11},B2[]={1,5,6,7,11},U4312[]={3,9};
  const int R3412[]={1,2,4,5,7,8},N3B1[]={1,2,7,8},N3B2[]={1,4,5,8};
  const int R3523[]={1,2,4,5,7,8,10,11,13,14},N3C2[]={1,2,7,8,13,14},N3C3[]={1,4,5,10,11,14};
  const int U4413[]={7,9},U4523[]={3,5,15,17},U415[]={3,9,15,21,27,33,39,45,51,57};
  int ok=1;
  ok &= check_exact_case(4,3,1,2,R4312,9,B1,4,B2,5,U4312,2);
  {int M=16,*R=malloc(M*sizeof(int)),*A=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)),nR,nA,nB,nU;compute_R_B_U(4,4,1,3,R,&nR,A,&nA,B,&nB,U,&nU);ok&=list_equals(U,nU,U4413,2);free(R);free(A);free(B);free(U);}
  {int M=20,*R=malloc(M*sizeof(int)),*A=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)),nR,nA,nB,nU;compute_R_B_U(4,5,2,3,R,&nR,A,&nA,B,&nB,U,&nU);ok&=list_equals(U,nU,U4523,4);free(R);free(A);free(B);free(U);}
  {int M=60,*R=malloc(M*sizeof(int)),*A=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)),nR,nA,nB,nU;compute_R_B_U(4,15,5,10,R,&nR,A,&nA,B,&nB,U,&nU);ok&=list_equals(U,nU,U415,10);free(R);free(A);free(B);free(U);}
  ok &= check_exact_case(3,3,1,2,R3412,6,N3B1,4,N3B2,4,NULL,0);
  ok &= check_exact_case(3,5,2,3,R3523,10,N3C2,6,N3C3,6,NULL,0);
  ok &= (irho(6,24)==6 && irho(30,24)==6 && 6%24==6 && 30%24==6);
  ok &= ((2*1)%20==2 && (2*11)%20==2 && bad_literal(4,5,2,1) && bad_literal(4,5,2,11));
  for(int r=0;r<60;r++){ int s=r%12; int base=(s%4)!=0 && irho((long long)s*1,12)>=3 && irho((long long)s*2,12)>=3; int scaled=(r%4)!=0 && irho((long long)r*5,60)>=15 && irho((long long)r*10,60)>=15; if(base!=scaled)ok=0; }
  ok &= !target_valid(3,3,1,2); ok &= !target_valid(4,0,1,2); ok &= !target_valid(4,3,0,2); ok &= !target_valid(4,3,2,1); ok &= !target_valid(4,3,1,3); ok &= target_valid(4,3,1,2);
  {const int altered[]={3}; int M=12,*R=malloc(M*sizeof(int)),*A=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)),nR,nA,nB,nU;compute_R_B_U(4,3,1,2,R,&nR,A,&nA,B,&nB,U,&nU);ok &= !list_equals(U,nU,altered,1);free(R);free(A);free(B);free(U);}
  ok &= audit_route_fixtures(perm_checks);
  return ok;
}

int main(void){
  long long perm_checks=0; int fixtures=run_fixtures(&perm_checks);
  if(!fixtures){ fprintf(stderr,"fixture failure\n"); return 2; }
  uint64_t digest=UINT64_C(1469598103934665603); uint64_t cases=0,owner_rows=0,residue_checks=0; int firstN=-1,firstp=-1,firstb=-1,firstc=-1;
  for(int N=4;N<=18 && firstN<0;N++) for(int p=1;p<=160 && firstN<0;p++){
    int M=N*p,words=(M+63)/64; uint64_t *R=calloc((size_t)words,sizeof(uint64_t)); build_R(N,p,R,words);
    uint64_t *B=calloc((size_t)(p>1?p-1:1)*words,sizeof(uint64_t));
    for(int d=1;d<p;d++){ build_bad_literal(N,p,d,B+(size_t)(d-1)*words,words); owner_rows++; residue_checks+=(uint64_t)M; }
    for(int b=1;b<p && firstN<0;b++) for(int c=b+1;c<p;c++){
      int least=least_uncovered_bits(M,R,B+(size_t)(b-1)*words,B+(size_t)(c-1)*words,words); cases++;
      digest=fnv_u64(digest,(uint64_t)N);digest=fnv_u64(digest,(uint64_t)p);digest=fnv_u64(digest,(uint64_t)b);digest=fnv_u64(digest,(uint64_t)c);digest=fnv_u64(digest,(uint64_t)(least+1));
      if(least<0){firstN=N;firstp=p;firstb=b;firstc=c;break;}
    }
    free(R);free(B);
  }
  printf("{\n");
  printf("  \"implementation\": \"A-literal-canonical\",\n");
  printf("  \"source_sha256\": \"%s\",\n",SOURCE_SHA256);
  printf("  \"compiler\": \"gcc %s\",\n",__VERSION__);
  printf("  \"fixtures_passed\": true,\n");
  printf("  \"permutation_and_scale_checks\": %lld,\n",perm_checks);
  printf("  \"domain\": {\"N_min\":4,\"N_max\":18,\"p_min\":1,\"p_max\":160},\n");
  printf("  \"pair_cases\": %" PRIu64 ",\n",cases);
  printf("  \"owner_rows_built\": %" PRIu64 ",\n",owner_rows);
  printf("  \"literal_residue_predicate_checks\": %" PRIu64 ",\n",residue_checks);
  printf("  \"deterministic_order\": \"N,p,b,c; least r by canonical bit order\",\n");
  printf("  \"common_domain_fnv1a64\": \"%016" PRIx64 "\",\n",digest);
  if(firstN<0) printf("  \"first_failure\": null\n"); else printf("  \"first_failure\": {\"N\":%d,\"p\":%d,\"b\":%d,\"c\":%d}\n",firstN,firstp,firstb,firstc);
  printf("}\n");
  return firstN<0?0:1;
}
