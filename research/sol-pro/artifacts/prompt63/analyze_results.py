#!/usr/bin/env python3
"""Produce deterministic summaries and literal counterexample tables."""
from __future__ import annotations

import hashlib
import json
import math
import platform
import subprocess
from collections import Counter, defaultdict
from fractions import Fraction
from pathlib import Path

VERSION = "PRO-C-RESULTS-1.0.0"
ROOT = Path(__file__).resolve().parent


def rho(m: int, x: int) -> int:
    y = x % m
    return min(y, m-y)


def fparse(s: str) -> Fraction:
    p, q = s.split('/')
    return Fraction(int(p), int(q))


def sha(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read_core():
    rows = {}
    for line in (ROOT/'impl_a_core.tsv').read_text().splitlines():
        f = line.split('\t')
        rows[int(f[0])] = {
            'id': int(f[0]), 'families': f[1].split(','), 'n': int(f[2]),
            'a': tuple(map(int,f[3].split(','))), 'primitive': f[4]=='1',
            'residual': f[5]=='1', 'ndiv': [] if f[6]=='-' else list(map(int,f[6].split(','))),
            'cert_counts': list(map(int,f[7].split(','))),
            'good_counts': list(map(int,f[8].split(','))),
            'pivot_good_counts': list(map(int,f[9].split(','))),
            'cert_total': int(f[10]), 'good_total': int(f[11]),
            'all_nonempty': f[12]=='1', 'any_good': f[13]=='1',
            'empty_rows': list(map(int,f[14].split(','))),
            'deep': [list(map(int,x.split(','))) for x in f[15].split(';')],
            'shell': [list(map(int,x.split(','))) for x in f[16].split(';')],
            'certificate_digest': f[17],
        }
    return rows


def read_active():
    rows = defaultdict(list)
    for line in (ROOT/'impl_a_active.tsv').read_text().splitlines():
        f=line.split('\t')
        rec={'id':int(f[0]),'k':int(f[1]),'components':int(f[2]),'eta':None if f[3]=='EMPTY' else fparse(f[3]),
             'max_times':[] if f[4]=='-' else [fparse(x) for x in f[4].split(';')],
             'active_desc':f[5], 'edges':[]}
        if f[6] != '-':
            for es in f[6].split('|'):
                x=es.split(',')
                rec['edges'].append({
                    't':fparse(x[0]),'eps':int(x[1]),'j':int(x[2]),'s':int(x[3]),
                    'p':int(x[4]),'r':int(x[5]),'d':int(x[6]),'b':int(x[7]),
                    'z':int(x[8]),'q':int(x[9]),'R':int(x[10]),'delta':fparse(x[11]),
                    'reverse_full':x[12]=='1','reverse_residues':list(map(int,x[13:])),
                })
        rows[rec['id']].append(rec)
    return rows


def cert_members(a):
    n=len(a);N=n+1
    out=[]
    for j,p in enumerate(a):
        m=n*p
        for r in range(m):
            if r%n==0: continue
            vals=[rho(m,r*x) for x in a]
            bad=[i for i,u in enumerate(vals) if u<p]
            if not bad:
                ks=[k for k in range(n) if k!=j]
            elif len(bad)==1:
                ks=bad
            else:
                ks=[]
            for k in ks:
                out.append({'k':k,'j':j,'p':p,'m':m,'r':r,'d':vals[k],
                            'good':N*vals[k]>=m,'residues':vals})
    return out


def frac_json(x): return {'num':x.numerator,'den':x.denominator,'text':f'{x.numerator}/{x.denominator}'}


def main():
    core=read_core(); active=read_active()
    no_good=[rid for rid,r in core.items() if not r['any_good']]
    selector=[]
    selector_fail=[]
    nonpositive=[]
    for rid in no_good:
        edges=[e for row in active[rid] for e in row['edges']]
        if not edges:
            selector_fail.append({'id':rid,'reason':'no oriented active edge'})
            continue
        for e in edges:
            if e['delta'] <= 0: nonpositive.append((rid,e))
        positive=[e for e in edges if e['delta']>0]
        if not positive:
            selector_fail.append({'id':rid,'reason':'no positive escape edge'})
            continue
        md=min(e['delta'] for e in positive)
        mins=[e for e in positive if e['delta']==md]
        full=[e for e in mins if e['reverse_full']]
        selector.append({'id':rid,'a':list(core[rid]['a']),'min_delta':frac_json(md),
                         'min_count':len(mins),'min_reverse_full_count':len(full),
                         'all_min_reverse_full':len(full)==len(mins),
                         'one_min':({k:(frac_json(v) if isinstance(v,Fraction) else v) for k,v in mins[0].items()} if mins else None)})
        if not full: selector_fail.append({'id':rid,'reason':'minimum layer has no reverse-full edge'})

    family_counts=Counter()
    n_counts=Counter()
    max_speed=0
    for r in core.values():
        for fam in r['families']: family_counts[fam]+=1
        n_counts[r['n']]+=1
        max_speed=max(max_speed,max(r['a']))

    dplp_premise=[r for r in core.values() if r['primitive'] and r['residual'] and r['ndiv'] and r['all_nonempty']]
    dplp_fail=[r for r in dplp_premise if not r['any_good']]

    # Literal tables.
    c047=cert_members((1,3,4,7))
    c12360=cert_members((1,2,3,60))
    c126810=cert_members((1,2,6,8,10))
    c134518=cert_members((1,3,4,5,18))
    clarge=cert_members((15,21,40,48,56,105,126,280,1200))

    incidence=[]
    for c in c12360:
        if c['j']==3 and c['k'] in (0,1,2):
            kind='shell' if c['good'] else 'deep'
            incidence.append({**c,'kind':kind})

    divpivot=[c for c in c126810 if c['j']==2]

    summary={
        'version':VERSION,
        'domain':{
            'record_count':len(core),'family_membership_counts':dict(sorted(family_counts.items())),
            'dimension_counts':{str(k):v for k,v in sorted(n_counts.items())},'max_speed':max_speed,
            'ordering':'domain.tsv order: first insertion by generator family order; tuple sorted; duplicates merged',
        },
        'core':{
            'all_primitive_count':sum(r['primitive'] for r in core.values()),
            'all_deletions_nonempty_count':sum(r['all_nonempty'] for r in core.values()),
            'any_exceptional_count':sum(r['any_good'] for r in core.values()),
            'no_exceptional_count':len(no_good),
            'no_exceptional_ids':no_good,
            'corrected_dplp_premise_count':len(dplp_premise),
            'corrected_dplp_failure_count':len(dplp_fail),
            'corrected_dplp_failure_ids':[r['id'] for r in dplp_fail],
        },
        'minimum_escape_selector':{
            'population':'all tuples in domain with zero exceptional-good certificates; all maximizing choices and oriented active blockers enumerated',
            'tested_tuple_count':len(selector),
            'nonpositive_edge_count':len(nonpositive),
            'failure_count':len(selector_fail),
            'failures':selector_fail,
            'every_min_layer_has_at_least_one_reverse_full':not selector_fail,
            'records':selector,
        },
        'mandatory':{},
        'literal':{
            'raw_lift_1347':c047,
            'incidence_pivot60_12360':incidence,
            'divisible_pivot6_126810':divpivot,
        },
    }
    for rid in range(5):
        r=core[rid]
        summary['mandatory'][str(rid)]={
            'a':list(r['a']),'cert_counts':r['cert_counts'],'good_counts':r['good_counts'],
            'pivot_good_counts':r['pivot_good_counts'],'components':[x['components'] for x in active[rid]],
            'eta':[None if x['eta'] is None else frac_json(x['eta']) for x in active[rid]],
            'max_choice_counts':[len(x['max_times']) for x in active[rid]],
            'active_edge_counts':[len(x['edges']) for x in active[rid]],
        }

    (ROOT/'audit_summary.json').write_text(json.dumps(summary,sort_keys=True,separators=(',',':'))+'\n')

    # Human-readable literal appendix.
    md=[]
    md.append('# PRO-C literal audit tables\n')
    md.append('All indices are zero-based. Residue vectors list `rho_(n*p)(r*a_i)` in tuple order.\n')
    md.append('## `(1,3,4,7)`: every deletion certifiable, zero exceptional-good certificates\n')
    md.append('| deleted speed | pivot speed | r | residues | exceptional-good |\n|---:|---:|---:|---|:---:|')
    for c in c047:
        md.append(f"| {c['residues'] and (1,3,4,7)[c['k']]} | {(1,3,4,7)[c['j']]} | {c['r']} | `{','.join(map(str,c['residues']))}` | {'yes' if c['good'] else 'no'} |")
    md.append('\n## `(1,2,3,60)`, fixed pivot 60: deep/shell singleton incidence\n')
    md.append('| deleted speed | r | residues modulo 240 | class |\n|---:|---:|---|---|')
    for c in incidence:
        md.append(f"| {(1,2,3,60)[c['k']]} | {c['r']} | `{','.join(map(str,c['residues']))}` | {c['kind']} |")
    md.append('\n## `(1,2,6,8,10)`, N-divisible pivot 6: every certificate and no lift\n')
    md.append('| deleted speed | r | residues modulo 30 | exceptional-good |\n|---:|---:|---|:---:|')
    for c in divpivot:
        md.append(f"| {(1,2,6,8,10)[c['k']]} | {c['r']} | `{','.join(map(str,c['residues']))}` | {'yes' if c['good'] else 'no'} |")
    md.append('\n## `(1,3,4,5,18)`: all closed-boundary lifts\n')
    md.append('| deleted speed | pivot speed | r | residues modulo 90 |\n|---:|---:|---:|---|')
    for c in c134518:
        if c['good']:
            md.append(f"| {(1,3,4,5,18)[c['k']]} | {(1,3,4,5,18)[c['j']]} | {c['r']} | `{','.join(map(str,c['residues']))}` |")

    md.append('\n## `(1,2,6,8,10)`: every maximizing active choice and the forced cycle\n')
    md.append('| deleted speed | eta | all maximizing times | active pivot speed at every maximum | representative canonical numerator | representative residues |\n|---:|---:|---|---:|---|---|')
    for row in active[3]:
        k=row['k']; speeds=(1,2,6,8,10)
        target_indices=set()
        for part in row['active_desc'].split(';'):
            rhs=part.split(':',1)[1]
            if rhs!='-': target_indices.update(map(int,rhs.split(',')))
        targets=','.join(str(speeds[j]) for j in sorted(target_indices)) if target_indices else '-'
        rep=row['edges'][0] if row['edges'] else None
        canonical='-' if rep is None else f"r={rep['r']}=5*{rep['z']}{'+' if rep['s']>0 else '-'}1, p={rep['p']}"
        residues='-' if rep is None else '`'+','.join(map(str,[rho(5*rep['p'],rep['r']*x) for x in speeds]))+'`'
        md.append(f"| {speeds[k]} | {row['eta'].numerator}/{row['eta'].denominator} | `{';'.join(f'{t.numerator}/{t.denominator}' for t in row['max_times'])}` | {targets} | {canonical} | {residues} |")
    md.append('\nThe active map in speed labels is `1->10, 2->8, 6->8, 8->10, 10->8`; its only directed cycle is `8<->10`, which excludes the `N`-divisible speed 6.\n')

    md.append('\n## Minimum-escape layer on the nonconsecutive tight records\n')
    md.append('| tuple | minimum Delta | number of minimizing oriented edges | reverse-full minimizing edges | one reverse numerator R | reverse residues |\n|---|---:|---:|---:|---:|---|')
    sel_by_id={x['id']:x for x in selector}
    for rid in [0,34,35,36,37,38,39]:
        x=sel_by_id[rid]; e=x['one_min']
        md.append(f"| `{','.join(map(str,x['a']))}` | {x['min_delta']['text']} | {x['min_count']} | {x['min_reverse_full_count']} | {e['R']} | `{','.join(map(str,e['reverse_residues']))}` |")

    md.append('\n## Mandatory tuple summary\n')
    md.append('| tuple | certificate counts by deletion | exceptional-good counts | K component counts | eta values |\n|---|---|---|---|---|')
    for rid in range(5):
        x=summary['mandatory'][str(rid)]
        etas=','.join('-' if y is None else y['text'] for y in x['eta'])
        md.append(f"| `{','.join(map(str,x['a']))}` | `{','.join(map(str,x['cert_counts']))}` | `{','.join(map(str,x['good_counts']))}` | `{','.join(map(str,x['components']))}` | `{etas}` |")
    (ROOT/'literal_tables.md').write_text('\n'.join(md)+'\n')

    print(json.dumps({
        'records':len(core),'no_exceptional':len(no_good),'dplp_premise':len(dplp_premise),
        'dplp_failures':len(dplp_fail),'selector_tested':len(selector),'selector_failures':len(selector_fail),
        'summary_sha256':sha(ROOT/'audit_summary.json'),'literal_tables_sha256':sha(ROOT/'literal_tables.md')
    },sort_keys=True))

if __name__=='__main__': main()
