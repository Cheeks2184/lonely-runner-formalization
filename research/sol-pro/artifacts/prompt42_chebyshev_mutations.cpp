#include <algorithm>
#include <boost/multiprecision/cpp_int.hpp>
#include <cmath>
#include <cstdint>
#include <iostream>
#include <numeric>
#include <set>
#include <string>
#include <tuple>
#include <vector>
using boost::multiprecision::cpp_int; using namespace std;
static int rho(int M,long long x){int y=int(x%M);if(y<0)y+=M;return min(y,M-y);} 
static int degree_rule(int n){int m=n-1;return (int)ceill(sqrt((long double)m)/2*log((long double)(4LL*n*(n+1)))-1e-18L);} 
static cpp_int SCT(int r,int y,int c){if(r==0)return 1;if(r==1)return y;cpp_int a=1,b=y,c2=cpp_int(c)*c;for(int z=2;z<=r;z++){cpp_int d=cpp_int(2)*y*b-c2*a;a=b;b=d;}return b;}
struct Poly{int r;cpp_int den;vector<cpp_int>num;};
static Poly poly(int n){int m=n-1,c=m-1,r=degree_rule(n);cpp_int cp=1;for(int i=0;i<r;i++)cp*=c;cpp_int top=SCT(r,m+1,c);Poly P{r,top-cp,vector<cpp_int>(n)};for(int k=0;k<n;k++)P.num[k]=SCT(r,m+1-2*k,c)-cp;return P;}
struct Row{cpp_int s;int safe;};
static Row prow(const vector<int>&a,int j,const Poly&P){int n=a.size(),N=n+1,A=a[j],M=N*A;cpp_int s=0;int sf=0;for(int r=1;r<M;r++)if(r%N){int k=0;for(int i=0;i<n;i++)if(i!=j&&rho(M,1LL*a[i]*r)<A)k++;s+=P.num[k];sf+=(k==0);}return{s,sf};}
int main(){vector<int>base;for(int i=1;i<=14;i++)base.push_back(i);base.push_back(210);int n=base.size();auto P=poly(n);set<vector<int>>fam;for(int idx=0;idx<n;idx++)for(int b=1;b<=300;b++){auto a=base;a[idx]=b;sort(a.begin(),a.end());if(unique(a.begin(),a.end())!=a.end())continue;int g=0;for(int x:a)g=gcd(g,x);if(g==1)fam.insert(a);}cpp_int best;bool have=false;vector<int>ba;vector<Row>br;long long fails=0;for(auto&a:fam){vector<Row>rows(n);cpp_int mx;bool first=true,fail=true;for(int j=0;j<n;j++){rows[j]=prow(a,j,P);if(first||rows[j].s>mx){mx=rows[j].s;first=false;}if(rows[j].s>0)fail=false;}if(fail)fails++;if(!have||mx<best||(mx==best&&a<ba)){have=true;best=mx;ba=a;br=rows;}}
cout<<"base=(1,...,14,210) replacements=1..300\n";cout<<"unique_primitive_tuples="<<fam.size()<<" all_pivot_failures="<<fails<<" degree="<<P.r<<" denominator="<<P.den<<"\n";cout<<"minimum_best_tuple=";for(int x:ba)cout<<x<<",";cout<<"\nbest_score_numerator="<<best<<"\nrows:";for(int j=0;j<n;j++)cout<<" ("<<ba[j]<<","<<br[j].s<<","<<br[j].safe<<")";cout<<"\n";
}

