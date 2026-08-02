#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <iostream>
#include <numeric>
#include <set>
#include <string>
#include <vector>
using namespace std; using i128=__int128_t;
static inline int rho(int M,long long x){int y=int(x%M);return min(y,M-y);} 
static int degree(int n){return int(ceill(sqrt((long double)(n-1))/2*log((long double)(4LL*n*(n+1)))-1e-18L));}
static i128 ipow(i128 a,int e){i128 z=1;while(e--)z*=a;return z;}
static i128 scaledT(int r,long long y,long long c){if(r==0)return 1;if(r==1)return y;i128 a=1,b=y,cc=(i128)c*c;for(int d=2;d<=r;d++){i128 z=2*(i128)y*b-cc*a;a=b;b=z;}return b;}
struct P{array<i128,16>num;}; static P mkP(){int n=15,m=14,c=13,r=13;i128 cp=ipow(c,r);P p{};for(int k=0;k<n;k++)p.num[k]=scaledT(r,m+1-2*k,c)-cp;return p;}
static i128 score(const vector<int>&a,int j,const P&p){int N=16,A=a[j],M=N*A;i128 s=0;for(int rr=1;rr<M;rr++)if(rr%N){int k=0;for(int i=0;i<15;i++)if(i!=j&&rho(M,1LL*a[i]*rr)<A)k++;s+=p.num[k];}return s;}
static bool prim(const vector<int>&a){int g=0;for(int x:a)g=gcd(g,x);return g==1;}
struct Sum{long long total=0,primitive=0,fail=0;int maxPassed=0;vector<int> hardest;};
static void eval(Sum&z,const vector<int>&a,const P&p){z.total++;if(!prim(a))return;z.primitive++;int passed=0;for(int j=0;j<15;j++){if(score(a,j,p)>0){if(passed>z.maxPassed){z.maxPassed=passed;z.hardest=a;}return;}passed++;}z.fail++;if(passed>z.maxPassed){z.maxPassed=passed;z.hardest=a;}}
static void print(const string&name,const Sum&z){cout<<name<<" total="<<z.total<<" primitive="<<z.primitive<<" failures="<<z.fail<<" max_nonpositive_prefix="<<z.maxPassed<<" hardest=";for(int x:z.hardest)cout<<x<<',';cout<<"\n"<<flush;}
static void rec(const vector<int>&base,const vector<int>&pool,int need,int at,vector<int>&pick,set<vector<int>>&seen,Sum&z,const P&p){if((int)pick.size()==need){vector<int>a=base;a.insert(a.end(),pick.begin(),pick.end());sort(a.begin(),a.end());if(a.size()!=15||unique(a.begin(),a.end())!=a.end())return;if(seen.insert(a).second)eval(z,a,p);return;}for(int i=at;i<=(int)pool.size()-(need-(int)pick.size());i++){pick.push_back(pool[i]);rec(base,pool,need,i+1,pick,seen,z,p);pick.pop_back();}}
static Sum ext(vector<int>b,vector<int>p){P poly=mkP();Sum z;vector<int>pick;set<vector<int>>seen;rec(b,p,6,0,pick,seen,z,poly);return z;}
static Sum muts(vector<int>base,int vmax,bool cover){P p=mkP();Sum z;set<vector<int>>seen;for(int k=0;k<15;k++)for(int b=1;b<=vmax;b++){vector<int>a=base;a[k]=b;sort(a.begin(),a.end());if(unique(a.begin(),a.end())!=a.end())continue;if(cover){ if(a[0]==1) continue;bool ok=true;for(int q=2;q<=16;q++){bool hit=false;for(int x:a)if(x%q==0){hit=true;break;}if(!hit){ok=false;break;}}if(!ok)continue;}if(seen.insert(a).second)eval(z,a,p);}return z;}
int main(){vector<int>pool={16,24,32,64,72,80,96,112,144,160,168,192,224,240,336,504,560,720,840,1008};
 print("G_plus_choose6_pool20",ext({15,21,40,48,56,105,126,280,1200},pool));
 print("F_plus_choose6_pool20",ext({8,15,35,40,48,56,75,132,147},pool));
 vector<int>c;for(int x=2;x<=16;x++)c.push_back(x);print("no1_divisor_cover_mutations_through5000",muts(c,5000,true));
 print("near_consecutive_mutations_through5000",muts({1,2,3,4,5,7,8,9,10,11,12,13,14,15,16},5000,false));}
