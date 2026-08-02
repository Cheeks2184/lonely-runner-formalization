#include <algorithm>
#include <boost/multiprecision/cpp_int.hpp>
#include <cmath>
#include <cstdint>
#include <iostream>
#include <numeric>
#include <random>
#include <set>
#include <vector>

using boost::multiprecision::cpp_int;
using namespace std;

static int rho(int M, long long x) {
  int y = int(x % M); if (y < 0) y += M; return min(y, M-y);
}
static int degree_rule(int n) {
  int m=n-1;
  return (int)ceill(sqrt((long double)m)/2 * log((long double)(4LL*n*(n+1)))-1e-18L);
}
static cpp_int sct(int r,int y,int c) {
  if(r==0)return 1;if(r==1)return y;cpp_int a=1,b=y,c2=cpp_int(c)*c;
  for(int z=2;z<=r;z++){cpp_int d=cpp_int(2)*y*b-c2*a;a=b;b=d;}return b;
}
struct Poly { int degree; cpp_int den; vector<cpp_int> num; vector<long double> p; };
static Poly poly(int n) {
  int m=n-1,c=m-1,r=degree_rule(n);cpp_int cp=1;for(int i=0;i<r;i++)cp*=c;
  cpp_int top=sct(r,m+1,c),den=top-cp; vector<cpp_int> num(n); vector<long double> p(n);
  for(int k=0;k<n;k++){num[k]=sct(r,m+1-2*k,c)-cp;p[k]=num[k].convert_to<long double>()/den.convert_to<long double>();}
  return {r,den,num,p};
}
struct FastRow { long double score; int safe; };
static FastRow row(const vector<int>&a,int j,const Poly&P){
  int n=a.size(),N=n+1,A=a[j],M=N*A; long double s=0;int sf=0;
  for(int r=1;r<M;r++)if(r%N){int k=0;for(int i=0;i<n;i++)if(i!=j&&rho(M,1LL*a[i]*r)<A)k++;s+=P.p[k];sf+=(k==0);}
  return{s,sf};
}
static vector<FastRow> rows(const vector<int>&a,const Poly&P){vector<FastRow> z(a.size());for(int j=0;j<(int)a.size();j++)z[j]=row(a,j,P);return z;}
// The positive-part sum drives every pivot toward nonpositivity; a small max
// tie-breaker keeps one especially large pivot from dominating late searches.
static long double energy(const vector<FastRow>&z){long double e=0,m=-1e100L;for(auto&r:z){e+=max((long double)0,r.score);m=max(m,r.score);}return e+1e-4L*max((long double)0,m);}
static int positive(const vector<FastRow>&z){int q=0;for(auto&r:z)q+=(r.score>1e-12L);return q;}
static int total_safe(const vector<FastRow>&z){int q=0;for(auto&r:z)q+=r.safe;return q;}

static void print_tuple(const vector<int>&a,const vector<FastRow>&z,const Poly&P,const char*tag){
  cout<<tag<<" degree="<<P.degree<<" tuple=";for(int x:a)cout<<x<<',';
  cout<<" positive="<<positive(z)<<" safe_total="<<total_safe(z)<<" max_score="<<(double)energy(z)<<"\nrows:";
  for(int j=0;j<(int)a.size();j++)cout<<" ("<<a[j]<<","<<(double)z[j].score<<","<<z[j].safe<<")";cout<<"\n";
}

static cpp_int exact_row(const vector<int>&a,int j,const Poly&P,int*safe_out=nullptr){
  int n=a.size(),N=n+1,A=a[j],M=N*A,sf=0;cpp_int s=0;
  for(int r=1;r<M;r++)if(r%N){int k=0;for(int i=0;i<n;i++)if(i!=j&&rho(M,1LL*a[i]*r)<A)k++;s+=P.num[k];sf+=(k==0);}
  if(safe_out)*safe_out=sf;return s;
}
static bool divisor_cover(const vector<int>&a){for(int q=2;q<=(int)a.size()+1;q++){bool ok=false;for(int x:a)ok|=(x%q==0);if(!ok)return false;}return true;}
static bool exact_failure(const vector<int>&a,const Poly&P,vector<cpp_int>*scores=nullptr,vector<int>*safes=nullptr){
  vector<int> order(a.size());iota(order.begin(),order.end(),0);sort(order.begin(),order.end(),[&](int i,int j){return a[i]>a[j];});
  vector<cpp_int> ss(a.size());vector<int> sf(a.size());
  for(int j:order){ss[j]=exact_row(a,j,P,&sf[j]);if(ss[j]>0)return false;}
  if(scores)*scores=ss;if(safes)*safes=sf;return true;
}
static void scan_family(const vector<vector<int>>&fam,const Poly&P,const string&name){
  uint64_t distinct=0,primitive=0,covered=0,fail=0,covered_fail=0;set<vector<int>>seen;
  for(auto a:fam){sort(a.begin(),a.end());if(adjacent_find(a.begin(),a.end())!=a.end())continue;if(!seen.insert(a).second)continue;distinct++;
    int g=0;for(int x:a)g=gcd(g,x);if(g!=1)continue;primitive++;bool cover=divisor_cover(a);covered+=cover;
    vector<cpp_int> ss;vector<int> sf;if(exact_failure(a,P,&ss,&sf)){fail++;covered_fail+=cover;cout<<"EXACT_FAIL tuple=";for(int x:a)cout<<x<<',';cout<<" rows:";for(int j=0;j<(int)a.size();j++)cout<<" ("<<a[j]<<","<<ss[j]<<","<<sf[j]<<")";cout<<"\n";}
  }
  cout<<name<<" distinct="<<distinct<<" primitive="<<primitive<<" divisor_cover="<<covered<<" exact_all_pivot_failures="<<fail<<" divisor_cover_failures="<<covered_fail<<"\n";
}

static void exact_domains(const Poly&P){
  vector<vector<int>> family;
  vector<int>a(15);
  function<void(int,int)> rec=[&](int p,int start){if(p==15){family.push_back(a);return;}for(int x=start;x<=22-(15-p)+1;x++){a[p]=x;rec(p+1,x+1);}};
  rec(0,2);scan_family(family,P,"box_2_to_22_choose_15");family.clear();
  const vector<int>pool={11,13,16,18,20,21,24,28,30,32,35,36,40,42,45,48,60,72,120,720};
  function<void(int,int)> poolrec=[&](int p,int start){if(p==15){family.push_back(a);return;}for(int i=start;i<=(int)pool.size()-(15-p);i++){a[p]=pool[i];poolrec(p+1,i+1);}};
  poolrec(0,0);scan_family(family,P,"hc_pool_20_choose_15");family.clear();
  const vector<int>seed={11,13,16,18,20,21,24,28,30,35,36,40,42,60,120};
  for(int j=0;j<15;j++)for(int x=2;x<=2000;x++){a=seed;a[j]=x;family.push_back(a);}
  scan_family(family,P,"hc_seed_one_replacement_2_to_2000");
}

static void exact_no_one_box(int n,int maximum,const Poly&P){
  vector<vector<int>>family;vector<int>a(n);
  function<void(int,int)> rec=[&](int p,int start){if(p==n){family.push_back(a);return;}for(int x=start;x<=maximum-(n-p)+1;x++){a[p]=x;rec(p+1,x+1);}};
  rec(0,2);scan_family(family,P,"no_speed_1_box_n="+to_string(n)+"_max="+to_string(maximum));
}

int main(int argc,char**argv){
  const int n=argc>1?stoi(argv[1]):15, maxv=argc>2?stoi(argv[2]):800, restarts=argc>3?stoi(argv[3]):200;
  Poly P=poly(n); mt19937_64 gen(0x42c0ffeeULL+n*1000003ULL+maxv); uniform_int_distribution<int> speed(2,maxv);
  if(argc>4 && string(argv[4])=="scan"){if(n!=15)throw runtime_error("scan domains are n=15");exact_domains(P);return 0;}
  if(argc>4 && string(argv[4])=="box"){exact_no_one_box(n,maxv,P);return 0;}
  long double global=1e100L; vector<int> ga; vector<FastRow> gz;
  for(int rep=0;rep<restarts;rep++){
    set<int>s;
    if(n==15 && rep==0) {
      const int seedv[]={15,21,24,30,40,48,56,70,84,105,126,168,280,420,1200};
      for(int x:seedv) if(x<=maxv)s.insert(x);
    }
    while((int)s.size()<n)s.insert(speed(gen));
    vector<int>a(s.begin(),s.end()); auto z=rows(a,P); long double cur=energy(z);
    long double temp=1.0L;
    for(int it=0;it<2500;it++){
      vector<int>b=a; int idx=gen()%n; int old=b[idx]; int nv;
      if((gen()&3)==0) nv=speed(gen); else {int span=max(2,maxv/20); nv=clamp(old+int(gen()%(2*span+1))-span,2,maxv);}
      if(find(b.begin(),b.end(),nv)!=b.end())continue;b[idx]=nv;sort(b.begin(),b.end());int g=0;for(int x:b)g=gcd(g,x);if(g!=1)continue;
      auto w=rows(b,P);long double ne=energy(w);bool take=ne<cur;
      if(!take && temp>1e-7L){long double u=(gen()+1.0L)/(numeric_limits<uint64_t>::max()+2.0L);take=log(u)<(cur-ne)/temp;}
      if(take){a=move(b);z=move(w);cur=ne;}temp*=0.997L;
      if(cur<global){global=cur;ga=a;gz=z;if(positive(z)==0){print_tuple(a,z,P,"FAIL");return 0;}}
    }
    if(rep%10==9)cerr<<"rep="<<rep+1<<" best="<<(double)global<<" positives="<<positive(gz)<<" safe="<<total_safe(gz)<<"\n";
  }
  print_tuple(ga,gz,P,"BEST");
}
