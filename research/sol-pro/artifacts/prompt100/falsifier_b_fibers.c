#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <inttypes.h>

#ifndef SOURCE_SHA256
#define SOURCE_SHA256 "unbound"
#endif

static int igcd(int a,int b){while(b){int t=a%b;a=b;b=t;}return a<0?-a:a;}
static long long egcd(long long a,long long b,long long *x,long long *y){if(!b){*x=1;*y=0;return a;}long long x1,y1,g=egcd(b,a%b,&x1,&y1);*x=y1;*y=x1-(a/b)*y1;return g;}
static int inv_mod(int a,int m){if(m==1)return 0;long long x,y;long long g=egcd(a,m,&x,&y);if(g!=1)return -1;x%=m;if(x<0)x+=m;return (int)x;}
static int irho(long long x,int M){int u=(int)(x%M);if(u<0)u+=M;return u<M-u?u:M-u;}
static int target_valid(int N,int p,int b,int c){return N>=4&&p>=1&&b>0&&c>0&&b<c&&c<p;}
static void bit_set(uint64_t *a,int r){a[r>>6]|=UINT64_C(1)<<(r&63);}
static int bit_get(const uint64_t *a,int r){return (int)((a[r>>6]>>(r&63))&1U);}
static uint64_t fnv_u64(uint64_t h,uint64_t x){for(int i=0;i<8;i++){h^=(uint8_t)(x>>(8*i));h*=UINT64_C(1099511628211);}return h;}

typedef struct {uint64_t target_visits,soluble_targets,solution_visits;} FiberStats;
static void solve_target(int N,int M,int d,int x,uint64_t *out,FiberStats *st){
  int g=igcd(d,M); if(st)st->target_visits++;
  if(x%g) return;
  if(st) st->soluble_targets++;
  int m=M/g,r0;
  if(m==1)r0=0;else{int a=d/g,rhs=x/g,inv=inv_mod(a,m);r0=(int)(((long long)inv*rhs)%m);}
  for(int k=0;k<g;k++){int r=r0+k*m;if(st)st->solution_visits++;if(r%N)bit_set(out,r);}
}
static void build_bad_fiber(int N,int p,int d,uint64_t *out,int words,FiberStats *st){
  int M=N*p;memset(out,0,(size_t)words*sizeof(uint64_t));
  for(int x=0;x<=p-1;x++)solve_target(N,M,d,x,out,st);
  for(int x=M-p+1;x<=M-1;x++)solve_target(N,M,d,x,out,st);
}
static void build_R(int N,int p,uint64_t *out,int words){int M=N*p;memset(out,0,(size_t)words*sizeof(uint64_t));for(int r=0;r<M;r++)if(r%N)bit_set(out,r);}
static int least_uncovered_bits(int M,const uint64_t *R,const uint64_t *A,const uint64_t *B,int words){for(int w=0;w<words;w++){uint64_t z=R[w]&~(A[w]|B[w]);if(w==words-1&&(M&63))z&=(UINT64_C(1)<<(M&63))-1;if(z)return 64*w+__builtin_ctzll(z);}return -1;}

static int list_equals(const int *got,int ng,const int *exp,int ne){if(ng!=ne)return 0;for(int i=0;i<ng;i++)if(got[i]!=exp[i])return 0;return 1;}
static int compute_R_B_U_fiber(int N,int p,int b,int c,int *R,int *nR,int *Bb,int *nBb,int *Bc,int *nBc,int *U,int *nU){
  if(N<1||p<1||b<1||c<1) return 0;
  int M=N*p,words=(M+63)/64;
  uint64_t *A=calloc(words,sizeof(uint64_t)),*B=calloc(words,sizeof(uint64_t));
  build_bad_fiber(N,p,b,A,words,NULL); build_bad_fiber(N,p,c,B,words,NULL);
  *nR=*nBb=*nBc=*nU=0;
  for(int r=0;r<M;r++) if(r%N){
    R[(*nR)++]=r;
    if(bit_get(A,r)) Bb[(*nBb)++]=r;
    if(bit_get(B,r)) Bc[(*nBc)++]=r;
    if(!bit_get(A,r)&&!bit_get(B,r)) U[(*nU)++]=r;
  }
  free(A); free(B); return 1;
}
static int check_exact_case(int N,int p,int b,int c,const int *eR,int nER,const int *eB,int nEB,const int *eC,int nEC,const int *eU,int nEU){int M=N*p,*R=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*C=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)),nR,nB,nC,nU;compute_R_B_U_fiber(N,p,b,c,R,&nR,B,&nB,C,&nC,U,&nU);int ok=list_equals(R,nR,eR,nER)&&list_equals(B,nB,eB,nEB)&&list_equals(C,nC,eC,nEC)&&list_equals(U,nU,eU,nEU);free(R);free(B);free(C);free(U);return ok;}

static int subset_covers_fiber(int n,int pivot_speed,const int *owners,int m){int N=n+1,M=N*pivot_speed,words=(M+63)/64;uint64_t *R=calloc(words,sizeof(uint64_t)),*U=calloc(words,sizeof(uint64_t)),*T=calloc(words,sizeof(uint64_t));build_R(N,pivot_speed,R,words);for(int k=0;k<m;k++){build_bad_fiber(N,pivot_speed,owners[k],T,words,NULL);for(int w=0;w<words;w++)U[w]|=T[w];}int cover=1;for(int w=0;w<words;w++)if(R[w]&~U[w]){cover=0;break;}free(R);free(U);free(T);return cover;}
static int covered_speeds_fiber(const int *a,int n,int *out){int N=n+1,q=0;for(int j=0;j<n;j++){int p=a[j],M=N*p,words=(M+63)/64;uint64_t *R=calloc(words,sizeof(uint64_t)),*U=calloc(words,sizeof(uint64_t)),*T=calloc(words,sizeof(uint64_t));build_R(N,p,R,words);for(int i=0;i<n;i++)if(i!=j){build_bad_fiber(N,p,a[i],T,words,NULL);for(int w=0;w<words;w++)U[w]|=T[w];}int cover=1;for(int w=0;w<words;w++)if(R[w]&~U[w]){cover=0;break;}if(cover)out[q++]=p;free(R);free(U);free(T);}for(int i=0;i<q;i++)for(int j=i+1;j<q;j++)if(out[j]<out[i]){int t=out[i];out[i]=out[j];out[j]=t;}return q;}
static void perm_rec(const int *base,int n,int pos,int *perm,const int *expectedF,int nF,const int *checks,int nchecks,int *ok,long long *count){if(!*ok)return;if(pos==n){int got[16],ng=covered_speeds_fiber(perm,n,got);if(!list_equals(got,ng,expectedF,nF)){*ok=0;return;}int pivot=expectedF[nF-1];for(int t=0;t<nchecks;t+=4){int m=checks[t],owners[3]={checks[t+1],checks[t+2],checks[t+3]};if(subset_covers_fiber(n,pivot,owners,m)){*ok=0;return;}}int scaled[16],expS[16],chkS[64];for(int i=0;i<n;i++)scaled[i]=5*perm[i];for(int i=0;i<nF;i++)expS[i]=5*expectedF[i];int gotS[16],ngS=covered_speeds_fiber(scaled,n,gotS);if(!list_equals(gotS,ngS,expS,nF)){*ok=0;return;}for(int t=0;t<nchecks;t+=4){int m=checks[t];for(int j=0;j<4;j++)chkS[t+j]=checks[t+j]*(j?5:1);int owners[3]={chkS[t+1],chkS[t+2],chkS[t+3]};if(subset_covers_fiber(n,5*pivot,owners,m)){*ok=0;return;}}(*count)+=2;return;}for(int i=0;i<n;i++){int used=0;for(int j=0;j<pos;j++)if(perm[j]==base[i])used=1;if(!used){perm[pos]=base[i];perm_rec(base,n,pos+1,perm,expectedF,nF,checks,nchecks,ok,count);}}}
static int audit_route_fixtures(long long *perm_checks){int ok=1,perm[16];*perm_checks=0;{int a[]={1,6,11,12,13},F[]={1,6},checks[]={1,1,0,0};perm_rec(a,5,0,perm,F,2,checks,4,&ok,perm_checks);}{int a[]={6,7,12,24,144},F[]={6,7,12,24},checks[]={2,6,7,0,2,6,12,0,2,7,12,0,3,6,7,12};perm_rec(a,5,0,perm,F,4,checks,16,&ok,perm_checks);}{int a[]={1,4,5,6,7,11},F[]={1,4,5,11},checks[]={2,1,4,0,2,1,5,0,2,4,5,0,3,1,4,5};perm_rec(a,6,0,perm,F,4,checks,16,&ok,perm_checks);}return ok;}

static int run_fixtures(long long *perm_checks){
  const int R4312[]={1,2,3,5,6,7,9,10,11},B1[]={1,2,10,11},B2[]={1,5,6,7,11},U4312[]={3,9};
  const int R3412[]={1,2,4,5,7,8},N3B1[]={1,2,7,8},N3B2[]={1,4,5,8};
  const int R3523[]={1,2,4,5,7,8,10,11,13,14},N3C2[]={1,2,7,8,13,14},N3C3[]={1,4,5,10,11,14};
  const int U4413[]={7,9},U4523[]={3,5,15,17},U415[]={3,9,15,21,27,33,39,45,51,57};int ok=1;
  ok&=check_exact_case(4,3,1,2,R4312,9,B1,4,B2,5,U4312,2);
  {int M=16,*R=malloc(M*sizeof(int)),*A=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)),nR,nA,nB,nU;compute_R_B_U_fiber(4,4,1,3,R,&nR,A,&nA,B,&nB,U,&nU);ok&=list_equals(U,nU,U4413,2);free(R);free(A);free(B);free(U);}
  {int M=20,*R=malloc(M*sizeof(int)),*A=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)),nR,nA,nB,nU;compute_R_B_U_fiber(4,5,2,3,R,&nR,A,&nA,B,&nB,U,&nU);ok&=list_equals(U,nU,U4523,4);free(R);free(A);free(B);free(U);}
  {int M=60,*R=malloc(M*sizeof(int)),*A=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)),nR,nA,nB,nU;compute_R_B_U_fiber(4,15,5,10,R,&nR,A,&nA,B,&nB,U,&nU);ok&=list_equals(U,nU,U415,10);free(R);free(A);free(B);free(U);}
  ok&=check_exact_case(3,3,1,2,R3412,6,N3B1,4,N3B2,4,NULL,0);ok&=check_exact_case(3,5,2,3,R3523,10,N3C2,6,N3C3,6,NULL,0);
  ok&=(irho(6,24)==6&&irho(30,24)==6&&(6%24)==6&&(30%24)==6);
  {int M=20,w=(M+63)/64;uint64_t *A=calloc(w,sizeof(uint64_t));build_bad_fiber(4,5,2,A,w,NULL);ok&=bit_get(A,1)&&bit_get(A,11)&&((2*1)%20==2)&&((2*11)%20==2);free(A);}
  for(int r=0;r<60;r++){int s=r%12;int base=(s%4)&&irho((long long)s,12)>=3&&irho((long long)s*2,12)>=3;int scaled=(r%4)&&irho((long long)r*5,60)>=15&&irho((long long)r*10,60)>=15;if(base!=scaled)ok=0;}
  ok&=!target_valid(3,3,1,2);ok&=!target_valid(4,0,1,2);ok&=!target_valid(4,3,0,2);ok&=!target_valid(4,3,2,1);ok&=!target_valid(4,3,1,3);ok&=target_valid(4,3,1,2);
  {const int altered[]={3};int M=12,*R=malloc(M*sizeof(int)),*A=malloc(M*sizeof(int)),*B=malloc(M*sizeof(int)),*U=malloc(M*sizeof(int)),nR,nA,nB,nU;compute_R_B_U_fiber(4,3,1,2,R,&nR,A,&nA,B,&nB,U,&nU);ok&=!list_equals(U,nU,altered,1);free(R);free(A);free(B);free(U);}
  ok&=audit_route_fixtures(perm_checks);return ok;
}

int main(void){
  long long perm_checks=0;if(!run_fixtures(&perm_checks)){fprintf(stderr,"fixture failure\n");return 2;}
  uint64_t digest_all=UINT64_C(1469598103934665603),digest_common=UINT64_C(1469598103934665603);uint64_t cases=0,common_cases=0,owner_rows=0,pointwise=0,mismatches=0;FiberStats st={0,0,0};int firstN=-1,firstp=-1,firstb=-1,firstc=-1;
  for(int N=4;N<=24&&firstN<0;N++)for(int p=1;p<=240&&firstN<0;p++){
    int M=N*p,words=(M+63)/64;uint64_t *R=calloc(words,sizeof(uint64_t));build_R(N,p,R,words);uint64_t *B=calloc((size_t)(p>1?p-1:1)*words,sizeof(uint64_t));
    for(int d=1;d<p;d++){uint64_t *row=B+(size_t)(d-1)*words;build_bad_fiber(N,p,d,row,words,&st);owner_rows++;if(N<=18&&p<=160){for(int r=0;r<M;r++){int literal=(r%N)&&irho((long long)r*d,M)<p;pointwise++;if(literal!=bit_get(row,r))mismatches++;}}}
    for(int b=1;b<p&&firstN<0;b++)for(int c=b+1;c<p;c++){
      int least=least_uncovered_bits(M,R,B+(size_t)(b-1)*words,B+(size_t)(c-1)*words,words);cases++;
      digest_all=fnv_u64(digest_all,N);digest_all=fnv_u64(digest_all,p);digest_all=fnv_u64(digest_all,b);digest_all=fnv_u64(digest_all,c);digest_all=fnv_u64(digest_all,(uint64_t)(least+1));
      if(N<=18&&p<=160){common_cases++;digest_common=fnv_u64(digest_common,N);digest_common=fnv_u64(digest_common,p);digest_common=fnv_u64(digest_common,b);digest_common=fnv_u64(digest_common,c);digest_common=fnv_u64(digest_common,(uint64_t)(least+1));}
      if(least<0){firstN=N;firstp=p;firstb=b;firstc=c;break;}
    }
    free(R);free(B);
  }
  printf("{\n  \"implementation\": \"B-congruence-fibers\",\n  \"source_sha256\": \"%s\",\n  \"compiler\": \"gcc %s\",\n",SOURCE_SHA256,__VERSION__);
  printf("  \"fixtures_passed\": true,\n  \"permutation_and_scale_checks\": %lld,\n",perm_checks);
  printf("  \"domain\": {\"N_min\":4,\"N_max\":24,\"p_min\":1,\"p_max\":240},\n  \"pair_cases\": %" PRIu64 ",\n  \"owner_rows_built\": %" PRIu64 ",\n",cases,owner_rows);
  printf("  \"fiber_target_visits\": %" PRIu64 ",\n  \"fiber_soluble_targets\": %" PRIu64 ",\n  \"fiber_solution_visits\": %" PRIu64 ",\n",st.target_visits,st.soluble_targets,st.solution_visits);
  printf("  \"common_domain_pair_cases\": %" PRIu64 ",\n  \"common_domain_pointwise_checks\": %" PRIu64 ",\n  \"common_domain_pointwise_mismatches\": %" PRIu64 ",\n",common_cases,pointwise,mismatches);
  printf("  \"deterministic_order\": \"N,p,b,c; targets 0..p-1 then M-p+1..M-1; fiber k increasing; least r canonical\",\n");
  printf("  \"all_domain_fnv1a64\": \"%016" PRIx64 "\",\n  \"common_domain_fnv1a64\": \"%016" PRIx64 "\",\n",digest_all,digest_common);
  if(firstN<0)printf("  \"first_failure\": null\n");else printf("  \"first_failure\": {\"N\":%d,\"p\":%d,\"b\":%d,\"c\":%d}\n",firstN,firstp,firstb,firstc);
  printf("}\n");return firstN<0&&mismatches==0?0:1;
}
