#include <algorithm>
#include <array>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <functional>
#include <iostream>
#include <numeric>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

using Word=std::uint64_t;
constexpr int LIMIT=30;
constexpr int FIRST_N=2;
constexpr int LAST_N=7;
constexpr int WORDS=4;

struct Mask{std::array<Word,WORDS>q{};};
static void put(Mask&m,int x){m.q[x/64]|=Word(1)<<(x%64);} 
static Mask meet(const Mask&a,const Mask&b){Mask c;for(int i=0;i<WORDS;++i)c.q[i]=a.q[i]&b.q[i];return c;}
static bool none(const Mask&m){for(Word x:m.q)if(x)return false;return true;}
static bool same(const Mask&a,const Mask&b){return a.q==b.q;}
static int circular_distance(int modulus,long long value){long long z=value%modulus;if(z<0)z+=modulus;return int(std::min(z,(long long)modulus-z));}
static void require(bool x,const char*msg){if(!x)throw std::runtime_error(msg);}

struct LiteralRow{int modulus=0;std::vector<int>candidates;std::vector<std::vector<int>>bad;std::vector<int>uncovered;};
static void validate(const std::vector<int>&v){
    if(v.size()<2)throw std::invalid_argument("dimension");std::set<int>s;
    for(int x:v){if(x<=0)throw std::invalid_argument("positive");if(!s.insert(x).second)throw std::invalid_argument("injective");}
}
static LiteralRow literal_row(const std::vector<int>&v,int pivot){
    validate(v);if(pivot<0||pivot>=(int)v.size())throw std::invalid_argument("pivot");int N=(int)v.size()+1,p=v[pivot],M=N*p;
    LiteralRow z;z.modulus=M;z.bad.resize(v.size());for(int r=0;r<M;++r)if(r%N)z.candidates.push_back(r);
    for(int r:z.candidates){bool hit=false;for(int i=0;i<(int)v.size();++i)if(i!=pivot&&circular_distance(M,1LL*r*v[i])<p){z.bad[i].push_back(r);hit=true;}if(!hit)z.uncovered.push_back(r);}return z;
}
static std::vector<int> literal_F(const std::vector<int>&v){std::vector<int>f;for(int j=0;j<(int)v.size();++j)if(literal_row(v,j).uncovered.empty())f.push_back(j);return f;}
static bool contains(const std::vector<int>&x,int r){return std::binary_search(x.begin(),x.end(),r);} 
static bool literal_complete(const std::vector<int>&v,int pivot,const std::vector<int>&owners){
    for(int i:owners)if(i==pivot)throw std::invalid_argument("pivot owner");auto z=literal_row(v,pivot);
    for(int r:z.candidates){bool hit=false;for(int i:owners)if(contains(z.bad[i],r)){hit=true;break;}if(!hit)return false;}return true;
}

static void preflight(std::ostream&o){
    std::vector<int>a{6,7,12,24,144};auto f=literal_F(a);std::vector<int>fs;for(int i:f)fs.push_back(a[i]);require(fs==std::vector<int>({6,7,12,24}),"f1 F");int js=f[0];for(int i:f)if(a[i]>a[js])js=i;require(a[js]==24,"f1 js");auto r7=literal_row(a,1);require(r7.modulus==42&&r7.candidates.size()==35&&r7.uncovered.empty(),"f1 row");
    require(literal_complete(a,1,{0,2,3})&&literal_complete(a,1,{0,2,4})&&!literal_complete(a,1,{0,2}),"f1 covers");int first=-1;for(int r:r7.candidates){bool hit=contains(r7.bad[0],r)||contains(r7.bad[2],r);if(!hit){first=r;break;}}require(first==2,"f1 first");require(a[js]!=7&&first!=3,"negative controls");
    std::vector<int>b{1,8,13,15,27,28};auto fb=literal_F(b);std::vector<int>fbs;for(int i:fb)fbs.push_back(b[i]);require(fbs==std::vector<int>({1,8}),"f2 F");auto r8=literal_row(b,1);require(r8.modulus==56&&r8.candidates.size()==48&&r8.uncovered.empty(),"f2 row");require(contains(r8.bad[5],8)&&!contains(r8.bad[0],8)&&!literal_complete(b,1,{0}),"f2 slice");
    std::vector<int>c{1,6,11,12,13};auto fc=literal_F(c);std::vector<int>fcs;for(int i:fc)fcs.push_back(c[i]);require(fcs==std::vector<int>({1,6}),"f3");
    std::vector<int>d{1,3,4,5};auto rd=literal_row(d,1);require(contains(rd.candidates,3)&&!contains(rd.bad[0],3)&&contains(rd.bad[3],3),"strict");require(contains(rd.bad[0],1)&&contains(rd.bad[0],14),"both sides");
    std::vector<int>e{1,3,13};auto re=literal_row(e,1);require(re.bad[0]==re.bad[2]&&literal_F(e).empty(),"collision");
    std::vector<int>g{1,2,3};auto rg=literal_row(g,2);require(contains(rg.candidates,3)&&contains(rg.candidates,9)&&!contains(rg.bad[0],3)&&!contains(rg.bad[0],9),"nonunit");
    std::vector<int>scaled{7,56,91,105,189,196};auto sx=literal_F(scaled);std::vector<int>sxs;for(int i:sx)sxs.push_back(scaled[i]);require(sxs==std::vector<int>({7,56}),"scale");
    bool malformed=false;try{literal_F({1,1,2});}catch(const std::invalid_argument&){malformed=true;}require(malformed,"malformed");bool po=false;try{literal_complete(d,1,{1});}catch(const std::invalid_argument&){po=true;}require(po,"pivot owner");
    o<<"PREFLIGHT_OK\nFIRST_MALFORMED_INPUT=(1,1,2):repeated_speed\nWRONG_JSTAR_CONTROL=claimed_7,actual_24:detected\nALTERED_FIRST_UNCOVERED=claimed_3,actual_2:detected\nSYNTHETIC_PREMISE_RECORD=(1,3,13),claimed_F_nonempty:detected\n";
}

struct Tables{int N=0;std::array<Mask,LIMIT+1>candidate{};std::array<std::array<Mask,LIMIT+1>,LIMIT+1>safe{};};
static Tables make_tables(int n){
    Tables t;t.N=n+1;for(int p=1;p<=LIMIT;++p){int M=t.N*p;for(int r=0;r<M;++r)if(r%t.N)put(t.candidate[p],r);for(int b=1;b<=LIMIT;++b){for(int r=0;r<M;++r)if(r%t.N&&circular_distance(M,1LL*r*b)>=p)put(t.safe[p][b],r);}}
    return t;
}
static std::string print_tuple(const std::vector<int>&v){std::ostringstream s;for(size_t i=0;i<v.size();++i){if(i)s<<',';s<<v[i];}return s.str();}
static bool covers_direct(const std::vector<int>&v,int pivot,const std::vector<int>&owners){int N=(int)v.size()+1,p=v[pivot],M=N*p;for(int r=0;r<M;++r)if(r%N){bool hit=false;for(int i:owners)if(circular_distance(M,1LL*r*v[i])<p){hit=true;break;}if(!hit)return false;}return true;}

struct Stats{unsigned long long raw=0,primitive=0,withF=0,branch=0,branchPrimitive=0,unionEqual=0,deletions=0;};
int main(int argc,char**argv){
    if(argc!=3){std::cerr<<"usage: impl_b RECORDS SUMMARY\n";return 2;}std::ofstream records(argv[1]),summary(argv[2]);if(!records||!summary)return 3;preflight(summary);
    summary<<"IMPLEMENTATION=B\nLANGUAGE=C++20\nDOMAIN=n=2..7,H=30,strictly_increasing_positive_tuples\nORDER=n_then_lex;rows=pivot_label_increasing;residues=canonical_increasing;owners=increasing;deletion=least_label_then_restart\n";
    bool failed=false;std::string first="NONE";
    for(int n=FIRST_N;n<=LAST_N;++n){Tables tab=make_tables(n);Stats st;std::vector<int>v(n);std::function<void(int,int)>enumerate=[&](int pos,int next){
        if(pos==n){++st.raw;int d=0;for(int x:v)d=std::gcd(d,x);bool primitive=d==1;if(primitive)++st.primitive;std::vector<int>F;
            for(int j=0;j<n;++j){Mask q=tab.candidate[v[j]];for(int i=0;i<n;++i)if(i!=j)q=meet(q,tab.safe[v[j]][v[i]]);if(none(q))F.push_back(j);}int js=-1;if(!F.empty()){++st.withF;js=F[0];for(int j:F)if(v[j]>v[js])js=j;}bool inBranch=js>=0&&v[js]%(n+1)!=0;if(inBranch){++st.branch;if(primitive)++st.branchPrimitive;}bool equal=false;
            if(inBranch){std::vector<int>internal;for(int i:F)if(i!=js)internal.push_back(i);Mask missing=tab.candidate[v[js]];for(int i:internal)missing=meet(missing,tab.safe[v[js]][v[i]]);equal=none(missing);if(equal){++st.unionEqual;std::vector<int>C=internal;bool changed=true;while(changed){changed=false;for(size_t q=0;q<C.size();++q){std::vector<int>D=C;D.erase(D.begin()+q);if(covers_direct(v,js,D)){C.swap(D);++st.deletions;changed=true;break;}}}require(covers_direct(v,js,C),"minimal cover construction");for(size_t q=0;q<C.size();++q){auto D=C;D.erase(D.begin()+q);require(!covers_direct(v,js,D),"minimality");}if(!failed){failed=true;first="n="+std::to_string(n)+";a="+print_tuple(v)+";jstar="+std::to_string(js);}}}
            records<<n<<'|'<<print_tuple(v)<<'|';for(int i=0;i<n;++i)records<<(std::find(F.begin(),F.end(),i)!=F.end()?'1':'0');records<<'|'<<js<<'|'<<(inBranch?1:0)<<'|'<<(equal?1:0)<<'\n';return;}
        for(int x=next;x<=LIMIT-(n-pos)+1;++x){v[pos]=x;enumerate(pos+1,x+1);} };enumerate(0,1);
        summary<<"n="<<n<<" raw="<<st.raw<<" primitive="<<st.primitive<<" F_nonempty="<<st.withF<<" branch="<<st.branch<<" branch_primitive="<<st.branchPrimitive<<" full_internal_union_equal="<<st.unionEqual<<" deletion_steps="<<st.deletions<<"\n";}
    summary<<"FIRST_THEOREM_DOMAIN_FAILURE="<<first<<"\nCOMPLETION_MARKER=SOL_P98_IMPL_B_COMPLETE\n";return failed?10:0;
}
