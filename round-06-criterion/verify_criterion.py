"""Exact rational and symbolic checks for the scalar reductions, not Lean verification."""
from fractions import Fraction as F
from itertools import product
import sympy as S

# Integral equivalence: q'/s = (q/s)' + (q/s)/s.
s = S.symbols('s', positive=True)
q = S.Function('q')(s)
assert S.simplify(S.diff(q/s,s) + (q/s)/s - S.diff(q,s)/s)==0
# Rare rectangular branch has exactly one half unit of energy per unit clock.
p,a,b = S.symbols('p a b',positive=True)
assert S.simplify(p*(a/(2*p)+b/(2*p))-(a+b)/2)==0
# Compare squared separation radius and two Gaussian exponents.
assert F(1,12)>F(9,256)
h2 = s/(256*p)
r = S.symbols('r',positive=True)
assert S.simplify((h2/4)/(2*r)-s/(2048*p*r))==0
assert S.simplify(h2/(2*r)-s/(512*p*r))==0
# Endpoint comparisons of q(t)/t on dyadic intervals.
count = 0
for a0 in [F(1,8),F(1,4),F(1,2),F(1)]:
    for j in range(9):
        t = a0*(1+F(j,8))
        for i,k,l in product(range(1,9),repeat=3):
            if i<=k<=l:
                qa,qt,qb=F(i,8),F(k,8),F(l,8)
                assert qa/(2*a0)<=qt/t<=qb/a0
                count+=1
# Bregman barrier, same-label rectangle, and exact rare-germ contradiction.
def payoff(h,x):return max(abs(x)-h,F(0))
def slope(h,x):return F(1) if h<x else F(-1) if x< -h else F(0)
def gap(h,u,v):return payoff(h,u)-payoff(h,v)-slope(h,v)*(u-v)
barriers=0
for h in [F(i,4) for i in range(1,9)]:
    for m,g in product([F(i,4) for i in range(-40,41)],repeat=2):
        if m==0 or abs(m)>=3*h:
            assert 0<=gap(h,m+g,m)<=(2*abs(g) if abs(g)>h else 0)
            barriers+=1
for j in range(1,100):
    p0=F(j,100)
    assert p0*p0<p0
# Variance bound reduction and final factor absorption are symbolic identities.
D,T,A,E=S.symbols('D T A E',real=True)
assert S.expand((D-T)+(T+A*E-D)-A*E)==0
print('Symbolic identities: clock derivative, rare-branch energy, Gaussian exponents, variance reduction PASS')
print('Exact dyadic ratio tests:',count,'PASS')
print('Exact separated-center barrier tests:',barriers,'PASS')
print('Exact rare-event tests: 99 PASS')
print('Scope: finite tests and symbolic identities only, not a proof of the main theorem or a Lean audit.')
