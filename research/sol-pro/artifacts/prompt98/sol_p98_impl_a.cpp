#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <functional>
#include <iostream>
#include <numeric>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

using U64 = std::uint64_t;
static constexpr int H = 30;
static constexpr int NMIN = 2;
static constexpr int NMAX = 7;
static constexpr int MAXW = 4;

struct Bits { std::array<U64, MAXW> w{}; };
static Bits bor(const Bits& x, const Bits& y){ Bits z; for(int q=0;q<MAXW;++q) z.w[q]=x.w[q]|y.w[q]; return z; }
static Bits bandnot(const Bits& x, const Bits& y){ Bits z; for(int q=0;q<MAXW;++q) z.w[q]=x.w[q]&~y.w[q]; return z; }
static bool beq(const Bits& x,const Bits& y){return x.w==y.w;}
static bool bempty(const Bits& x){for(auto z:x.w)if(z)return false;return true;}
static void bset(Bits& x,int r){x.w[r>>6]|=U64(1)<<(r&63);}

static int rho_int(int M,long long x){int y=(int)(x%M);if(y<0)y+=M;return std::min(y,M-y);}

struct GenericRow{int M{};std::set<int>R;std::vector<std::set<int>>B;std::set<int>Q;};
static bool valid_tuple(const std::vector<int>&a){if(a.size()<2)return false;for(int x:a)if(x<=0)return false;return std::set<int>(a.begin(),a.end()).size()==a.size();}
static GenericRow generic_row(const std::vector<int>&a,int j){
    if(!valid_tuple(a))throw std::invalid_argument("tuple must be positive and injective");
    if(j<0||j>=(int)a.size())throw std::invalid_argument("bad pivot label");
    int n=(int)a.size(),N=n+1,p=a[j],M=N*p;GenericRow out;out.M=M;out.B.resize(n);
    for(int r=0;r<M;++r)if(r%N)out.R.insert(r);
    std::set<int>U;
    for(int i=0;i<n;++i)if(i!=j)for(int r:out.R)if(rho_int(M,1LL*r*a[i])<p){out.B[i].insert(r);U.insert(r);}
    std::set_difference(out.R.begin(),out.R.end(),U.begin(),U.end(),std::inserter(out.Q,out.Q.end()));return out;
}
static std::vector<int> generic_F(const std::vector<int>&a){std::vector<int>F;for(int j=0;j<(int)a.size();++j)if(generic_row(a,j).Q.empty())F.push_back(j);return F;}
static std::set<int> set_union_labels(const GenericRow&rw,const std::vector<int>&labels){std::set<int>U;for(int i:labels)U.insert(rw.B[i].begin(),rw.B[i].end());return U;}
static bool is_complete(const GenericRow&rw,const std::vector<int>&labels,int pivot){for(int i:labels)if(i==pivot)throw std::invalid_argument("owner set contains pivot");return set_union_labels(rw,labels)==rw.R;}
static std::vector<std::vector<int>> generic_min_covers(const std::vector<int>&a,int j){
    auto rw=generic_row(a,j);std::vector<int>own;for(int i=0;i<(int)a.size();++i)if(i!=j)own.push_back(i);std::vector<std::vector<int>>ans;int m=(int)own.size();
    for(int k=0;k<=m;++k){std::vector<int>pick;std::function<void(int,int)>rec=[&](int pos,int need){if(!need){if(!is_complete(rw,pick,j))return;bool minimal=true;for(int x=0;x<(int)pick.size();++x){auto d=pick;d.erase(d.begin()+x);if(is_complete(rw,d,j)){minimal=false;break;}}if(minimal)ans.push_back(pick);return;}for(int z=pos;z<=m-need;++z){pick.push_back(own[z]);rec(z+1,need-1);pick.pop_back();}};rec(0,k);}return ans;
}

static void fixture_preflight(std::ostream&s){
    std::vector<int>f1{6,7,12,24,144};auto F1=generic_F(f1);std::vector<int>Fs1;for(int i:F1)Fs1.push_back(f1[i]);assert((Fs1==std::vector<int>{6,7,12,24}));
    int js1=F1.front();for(int i:F1)if(f1[i]>f1[js1])js1=i;assert(f1[js1]==24);auto rw7=generic_row(f1,1);assert(rw7.M==42&&rw7.R.size()==35);
    auto mc7=generic_min_covers(f1,1);std::vector<std::vector<int>>mcs;for(auto C:mc7){std::vector<int>z;for(int i:C)z.push_back(f1[i]);mcs.push_back(z);}assert((mcs==std::vector<std::vector<int>>{{6,12,24},{6,12,144}}));
    assert(is_complete(rw7,{0,2,3},1));assert(!is_complete(rw7,{0,2},1));auto U612=set_union_labels(rw7,{0,2});std::vector<int>miss;std::set_difference(rw7.R.begin(),rw7.R.end(),U612.begin(),U612.end(),std::back_inserter(miss));assert(miss.front()==2);
    assert(rw7.B[0].count(7)&&rw7.B[2].count(7)&&rw7.B[3].count(7)&&rw7.B[4].count(7));assert(f1[js1]!=7);assert(miss.front()!=3);
    std::vector<int>f2{1,8,13,15,27,28};auto F2=generic_F(f2);std::vector<int>Fs2;for(int i:F2)Fs2.push_back(f2[i]);assert((Fs2==std::vector<int>{1,8}));auto rw8=generic_row(f2,1);assert(rw8.M==56&&rw8.R.size()==48&&rw8.Q.empty());assert(rw8.B[5].count(8)&&!rw8.B[0].count(8));assert(!is_complete(rw8,{0},1));
    std::vector<int>f3{1,6,11,12,13};auto F3=generic_F(f3);std::vector<int>Fs3;for(int i:F3)Fs3.push_back(f3[i]);assert((Fs3==std::vector<int>{1,6}));
    std::vector<int>f4{1,3,4,5};auto rw3=generic_row(f4,1);assert(rw3.R.count(3)&&!rw3.B[0].count(3)&&rho_int(15,3)==3);assert(rw3.B[3].count(3)&&rho_int(15,15)==0);assert(rw3.B[0].count(1)&&rw3.B[0].count(14));
    std::vector<int>f5{1,3,13};auto rwc=generic_row(f5,1);assert(rwc.B[0]==rwc.B[2]);
    std::vector<int>f6{1,2,3};auto rwn=generic_row(f6,2);assert(rwn.R.count(3)&&rwn.R.count(9)&&!rwn.B[0].count(3)&&!rwn.B[0].count(9));
    std::vector<int>sf2{7,56,91,105,189,196};auto SF=generic_F(sf2);std::vector<int>SFs;for(int i:SF)SFs.push_back(sf2[i]);assert((SFs==std::vector<int>{7,56}));
    bool malformed=false;try{generic_F({1,1,2});}catch(const std::invalid_argument&){malformed=true;}assert(malformed);bool pivot_owner=false;try{is_complete(rw3,{1},1);}catch(const std::invalid_argument&){pivot_owner=true;}assert(pivot_owner);assert(generic_F(f5).empty());
    s<<"PREFLIGHT_OK\nFIRST_MALFORMED_INPUT=(1,1,2):repeated_speed\nWRONG_JSTAR_CONTROL=claimed_7,actual_24:detected\nALTERED_FIRST_UNCOVERED=claimed_3,actual_2:detected\nSYNTHETIC_PREMISE_RECORD=(1,3,13),claimed_F_nonempty:detected\n";
}

struct Precomp{int n{},N{};std::array<Bits,H+1>R{};std::array<std::array<Bits,H+1>,H+1>B{};};
static Precomp build_precomp(int n){Precomp P;P.n=n;P.N=n+1;for(int p=1;p<=H;++p){int M=P.N*p;for(int r=0;r<M;++r)if(r%P.N)bset(P.R[p],r);for(int b=1;b<=H;++b)for(int r=0;r<M;++r)if(r%P.N&&rho_int(M,1LL*r*b)<p)bset(P.B[p][b],r);}return P;}
static std::vector<int> subset_masks_card_lex(const std::vector<int>&owners){int m=(int)owners.size();std::vector<int>masks;for(int k=0;k<=m;++k){std::function<void(int,int,int)>rec=[&](int pos,int need,int mask){if(!need){masks.push_back(mask);return;}for(int q=pos;q<=m-need;++q)rec(q+1,need-1,mask|(1<<q));};rec(0,k,0);}return masks;}
struct Counts{unsigned long long raw=0,primitive=0,Fnonempty=0,branch=0,branch_primitive=0,subsets=0,complete_internal=0,minimal_internal=0,private_sets=0;};
static std::string tuple_text(const std::vector<int>&a){std::ostringstream o;for(int i=0;i<(int)a.size();++i){if(i)o<<',';o<<a[i];}return o.str();}

int main(int argc,char**argv){
    if(argc!=3){std::cerr<<"usage: impl_a RECORDS SUMMARY\n";return 2;}std::ofstream rec(argv[1]),sum(argv[2]);if(!rec||!sum)return 3;fixture_preflight(sum);
    sum<<"IMPLEMENTATION=A\nLANGUAGE=C++20\nDOMAIN=n=2..7,H=30,strictly_increasing_positive_tuples\nORDER=n_then_lex;rows=pivot_label_increasing;residues=canonical_increasing;owners=increasing;subsets=cardinality_then_lex\n";
    bool any_failure=false;std::string first_failure="NONE";
    for(int n=NMIN;n<=NMAX;++n){auto P=build_precomp(n);Counts cnt;std::vector<int>a(n);std::function<void(int,int)>gen=[&](int pos,int lo){
        if(pos==n){++cnt.raw;int g=0;for(int x:a)g=std::gcd(g,x);bool prim=g==1;if(prim)++cnt.primitive;std::vector<int>F;std::vector<Bits>rowQ(n);
            for(int j=0;j<n;++j){Bits U{};int p=a[j];for(int i=0;i<n;++i)if(i!=j){Bits Bij=P.B[p][a[i]];U=bor(U,Bij);}rowQ[j]=bandnot(P.R[p],U);if(bempty(rowQ[j]))F.push_back(j);}
            int js=-1;if(!F.empty()){++cnt.Fnonempty;js=F.front();for(int j:F)if(a[j]>a[js])js=j;}bool branch=js>=0&&a[js]%(n+1)!=0;if(branch){++cnt.branch;if(prim)++cnt.branch_primitive;}bool internal_union_complete=false;
            if(branch){int p=a[js];Bits R=P.R[p];std::vector<int>internal;for(int i:F)if(i!=js)internal.push_back(i);auto smasks=subset_masks_card_lex(internal);for(int sm:smasks){++cnt.subsets;Bits U{};std::vector<int>C;for(int q=0;q<(int)internal.size();++q)if((sm>>q)&1){int i=internal[q];C.push_back(i);U=bor(U,P.B[p][a[i]]);}if(!beq(U,R))continue;internal_union_complete=true;++cnt.complete_internal;bool minimal=true;for(int i:C){Bits V{};for(int h:C)if(h!=i)V=bor(V,P.B[p][a[h]]);if(beq(V,R)){minimal=false;break;}}if(minimal){++cnt.minimal_internal;for(int i:C){Bits O{};for(int h:C)if(h!=i)O=bor(O,P.B[p][a[h]]);Bits Priv=bandnot(P.B[p][a[i]],O);assert(!bempty(Priv));++cnt.private_sets;}if(!any_failure){any_failure=true;first_failure="n="+std::to_string(n)+";a="+tuple_text(a)+";jstar="+std::to_string(js);}}}}
            rec<<n<<'|'<<tuple_text(a)<<'|';for(int i=0;i<n;++i)rec<<(std::find(F.begin(),F.end(),i)!=F.end()?'1':'0');rec<<'|'<<js<<'|'<<(branch?1:0)<<'|'<<(internal_union_complete?1:0)<<'\n';return;}
        for(int x=lo;x<=H-(n-pos)+1;++x){a[pos]=x;gen(pos+1,x+1);} };gen(0,1);
        sum<<"n="<<n<<" raw="<<cnt.raw<<" primitive="<<cnt.primitive<<" F_nonempty="<<cnt.Fnonempty<<" branch="<<cnt.branch<<" branch_primitive="<<cnt.branch_primitive<<" subsets="<<cnt.subsets<<" complete_internal="<<cnt.complete_internal<<" minimal_internal="<<cnt.minimal_internal<<" private_sets="<<cnt.private_sets<<"\n";}
    sum<<"FIRST_THEOREM_DOMAIN_FAILURE="<<first_failure<<"\nCOMPLETION_MARKER=SOL_P98_IMPL_A_COMPLETE\n";return any_failure?10:0;
}
