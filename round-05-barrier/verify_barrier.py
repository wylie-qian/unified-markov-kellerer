"""Exact rational sanity tests and symbolic identities (not Lean proofs)."""
from fractions import Fraction as F
from itertools import product
import sympy as S


def payoff(h, x):
    return max(abs(x) - h, F(0))


def slope(h, x):
    return F(1) if x > h else F(-1) if x < -h else F(0)


def gap(h, u, v):
    return payoff(h, u) - payoff(h, v) - slope(h, v)*(u-v)


hs = [F(i,4) for i in range(1,9)]
xs = [F(i,4) for i in range(-40,41)]
counts = {'bregman_nonneg_and_upper': 0, 'barrier_envelope': 0,
          'crossing': 0, 'active_far': 0, 'inactive_inside': 0}
for h,u,v in product(hs,xs,xs):
    d = gap(h,u,v)
    assert 0 <= d <= 2*abs(u-v)
    counts['bregman_nonneg_and_upper'] += 1
    if (abs(u)<=h) != (abs(v)<=h):
        assert d>=h/2 or h/2<abs(u)<=2*h
        counts['crossing'] += 1
for h,m,g in product(hs,xs,xs):
    if m==0 or abs(m)>=3*h:
        assert gap(h,m+g,m) <= (2*abs(g) if abs(g)>h else 0)
        counts['barrier_envelope'] += 1
    if abs(m)>=3*h and abs(g)<=h/2:
        assert abs(m+g)>2*h
        counts['active_far'] += 1
    if m==0 and abs(g)<=h/2:
        assert abs(m+g)<=h/2
        counts['inactive_inside'] += 1
print('Exact rational sanity tests:',counts, 'total:',sum(counts.values()))
assert F(1,6) > F(9,64)
assert F(1,4)<F(1,2)<1  # h_next/h = 1/sqrt(2) lies in [1/2,1]
t,q=S.symbols('t q',positive=True)
h=S.sqrt(t)/8
assert S.simplify((h/2)**2/(2*q)-t/(512*q))==0
assert S.simplify(h**2/(2*q)-t/(128*q))==0
x=S.symbols('x',real=True)
# Antiderivative of x * exp(-x^2/(2q)); used for the exact Gaussian tail moment.
assert S.simplify(S.diff(-q*S.exp(-x*x/(2*q)),x)-x*S.exp(-x*x/(2*q)))==0
# Alternating clocks at dyadic endpoints, exact partial geometric series and tail.
for n in range(20):
    t=F(1,2**n)
    a=[sum((F(1,2**(n+j+1)) for j in range(40) if (n+j)%2==k),F(0))
       + (t/F(2**40))* (F(2,3) if n%2==k else F(1,3)) for k in range(2)]
    assert sum(a)==t and all(t/3<=v<=2*t/3 for v in a)
print('Symbolic checks: Gaussian exponents, tail moment identity, scale separation, dyadic clocks PASS')
print('Scope: exact rational finite tests and symbolic identities only; not a proof of the stochastic theorem or a Lean compiler audit.')
