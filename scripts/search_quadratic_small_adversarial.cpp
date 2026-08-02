#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <numeric>
#include <set>
#include <string>
#include <vector>
using namespace std;

static inline int rho(int M, long long x){int y=int(x%M);return min(y,M-y);}
static bool primitive(const vector<int>&a){int g=0;for(int x:a)g=gcd(g,x);return g==1;}
static long long qscore(const vector<int>&a,int j){
 int n=a.size(),N=n+1,A=a[j],M=N*A,H0=n*A,H1=0,H2=0;
 for(int r=1;r<M;r++)if(r%N){int k=0;for(int i=0;i<n;i++)if(i!=j&&rho(M,1LL*a[i]*r)<A)k++;H1+=k;H2+=k*(k-1)/2;}
 return n==3?49LL*(H0-H1)+48LL*H2:3LL*(H0-H1)+2LL*H2;
}
static uint64_t mix(uint64_t h,uint64_t x){h^=x+UINT64_C(0x9e3779b97f4a7c15)+(h<<6)+(h>>2);return h;}
struct Run{uint64_t total=0,primitive=0;uint64_t hash=UINT64_C(0xcbf29ce484222325);};
static bool eval(const vector<int>&a,Run&z,const string&domain){
 z.total++;if(!primitive(a))return false;z.primitive++;vector<long long>q(a.size());bool fail=true;
 for(int j=0;j<(int)a.size();j++){q[j]=qscore(a,j);if(q[j]>0)fail=false;}
 for(int x:a) z.hash=mix(z.hash,x);
 for(long long x:q) z.hash=mix(z.hash,uint64_t(x));
 if(fail){cout<<"FOUND domain="<<domain<<" n="<<a.size()<<" tuple=";for(int x:a)cout<<x<<',';cout<<" qscaled=";for(auto x:q)cout<<x<<',';cout<<"\n";return true;}return false;
}
static bool pool_rec(const vector<int>&p,int n,int at,vector<int>&a,Run&z){
 if((int)a.size()==n)return eval(a,z,"highly_composite_pool");
 for(int i=at;i<=(int)p.size()-(n-(int)a.size());i++){a.push_back(p[i]);if(pool_rec(p,n,i+1,a,z))return true;a.pop_back();}return false;
}
int main(int argc,char**argv){int random_count=argc>1?atoi(argv[1]):20000;uint64_t state=UINT64_C(0x42f0e1eba9ea3693);
 vector<int>pool={1,2,3,4,5,6,7,8,9,10,12,14,15,16,18,20,24,28,30,32,36,40,42,48,54,56,60,64,72,84,90,96,108,120,126,144,168,180,210,240,252,280,315,336,360,420,504,560,630,720,840,1008,1260,1680,2520,5040};
 for(int n:{3,4}){Run z;vector<int>a;if(pool_rec(pool,n,0,a,z))return 0;cout<<"pool n="<<n<<" total="<<z.total<<" primitive="<<z.primitive<<" hash="<<hex<<z.hash<<dec<<"\n";
  vector<vector<int>>bases=n==3?vector<vector<int>>{{1,2520,5040},{840,1260,2520},{35,48,60}}:vector<vector<int>>{{1,840,2520,5040},{360,840,1260,2520},{35,48,56,60}};
  set<vector<int>>seen;
  Run m;
  for(auto base:bases)for(int k=0;k<n;k++)for(int x=1;x<=10000;x++){
    auto b=base;b[k]=x;sort(b.begin(),b.end());
    if(unique(b.begin(),b.end())!=b.end())continue;
    if(seen.insert(b).second&&eval(b,m,"mutations"))return 0;
  }
  cout<<"mutations n="<<n<<" total="<<m.total<<" primitive="<<m.primitive<<" hash="<<hex<<m.hash<<dec<<"\n";
  Run r;
  for(int it=0;it<random_count;it++){vector<int>b;while((int)b.size()<n){state=state*UINT64_C(6364136223846793005)+UINT64_C(1442695040888963407);int x=1+int((state>>17)%10000);b.push_back(x);sort(b.begin(),b.end());b.erase(unique(b.begin(),b.end()),b.end());}if(eval(b,r,"random"))return 0;}
  cout<<"random n="<<n<<" total="<<r.total<<" primitive="<<r.primitive<<" hash="<<hex<<r.hash<<dec<<"\n";
 }
}
