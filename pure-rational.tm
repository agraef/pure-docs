<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-rational-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-reduce.tm> \|
  <hlink|previous|pure-octave.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Pure-Rational - Rational number library for the Pure programming
  language<label|pure-rational-rational-number-library-for-the-pure-programming-language>>

  Version 0.1, January 28, 2014

  Rob Hubbard

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  Jiri Spitz \<less\><hlink|jiri.spitz@bluetone.cz|mailto:jiri.spitz@bluetone.cz>\<gtr\>

  This package provides a Pure port of <hlink|Q+Q|http://q-lang.sourceforge.net/addons.html>,
  Rob Hubbard's rational number library for the Q programming language. The
  port was done by Jiri Spitz. It contains <verbatim|rational.pure>, a
  collection of utility functions for rational numbers, and
  <verbatim|rat_interval.pure>, a module for doing interval arithmetic needed
  by <verbatim|rational.pure>. These modules are designed to work with the
  <verbatim|math.pure> module (part of the standard Pure library), which
  contains the definition of Pure's rational type and implements the basic
  rational arithmetic.

  This document is an edited version of Rob's original <hlink|Q+Q
  manual|http://downloads.sourceforge.net/q-lang/rational.pdf?download>
  available from the Q website, slightly adjusted to account for the Pure
  specifics of the implementation. In particular, note that the operations
  provided by <verbatim|rational.pure> and <verbatim|rat_interval.pure> live
  in their own <verbatim|rational> and <verbatim|interval> namespaces,
  respectively, so if you want to get unqualified access to the symbols of
  these modules (as the examples in this manual assume) then you'll have to
  import the modules as follows:

  <\verbatim>
    using rational, rat_interval;

    using namespace rational, interval;
  </verbatim>

  Also note that <hlink|<with|font-family|tt|rational>|#module-rational>
  always pulls in the <hlink|<with|font-family|tt|math>|purelib.tm#module-math>
  module, so you don't have to import the latter explicitly if you are using
  <hlink|<with|font-family|tt|rational>|#module-rational>.

  Another minor difference to the Q version of this module is that rational
  results always have Pure bigints as their numerators and denominators,
  hence the <verbatim|L> suffix in the printed results. Also, unary minus
  binds weaker in Pure than the rational division operator, so a negative
  rational number will be printed as, e.g., <verbatim|(-1L)%2L>, which looks
  a bit funny but is correct since Pure rationals always carry their sign in
  the numerator.

  <subsection|Copying<label|copying>>

  Copyright (c) 2006 - 2010 by Rob Hubbard.

  Copyright (c) 2006 - 2010 by Albert Graef
  \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>.

  Copyright (c) 2010 by Jiri Spitz \<less\><hlink|jiri.spitz@bluetone.cz|mailto:jiri.spitz@bluetone.cz>\<gtr\>.

  Pure-rational is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  Pure-rational is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
  more details.

  You should have received a copy of the GNU Public License along with this
  program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation<label|installation>>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-rational-0.1.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-rational-0.1.tar.gz>.

  Then run <verbatim|make> <verbatim|install> (as root) to install
  pure-rational in the Pure library directory. This requires GNU make, and of
  course you need to have Pure installed.

  <verbatim|make> <verbatim|install> tries to guess your Pure installation
  directory. If it gets this wrong, you can install using <verbatim|make>
  <verbatim|install> <verbatim|prefix=/usr> which sets the installation
  prefix. Please see the Makefile for details.

  <subsection|Introduction<label|introduction>>

  <subsubsection|The Rational Module<label|module-rational>>

  This module provides additional operations on the rational number type
  provided by the <verbatim|math.pure> module in the standard library. The
  module is compatible with Pure version 0.43 (onwards).

  <subsubsection|The Files and the Default
  Prelude<label|the-files-and-the-default-prelude>>

  The implementation of the rational type and associated utilities is
  distributed across various files.

  <paragraph|math.pure and Other Files<label|math-pure-and-other-files>>

  The file <verbatim|math.pure> defines the type, its constructors and
  `deconstructors' and basic arithmetical and mathematical operators and
  functions. This is part of the standard Pure library. A few definitions
  associated with rationals are also defined in other standard library
  modules. In particular, the type tests are contained in
  <verbatim|primitives.pure>.

  It is also possible to create rational complex numbers (in addition to
  double complex numbers and integral or Gaussian complex numbers). That is,
  rationals play nicely with the complex number constructors provided in the
  <verbatim|math.pure> module. This is discussed further in <hlink|Rational
  Complex Numbers|#rational-complex-numbers>.

  <paragraph|rational.pure<label|rational-pure>>

  Additional `rational utilities', not included in the <verbatim|math.pure>
  module, are defined in <verbatim|rational.pure>. The functions include
  further arithmetical and mathematical operators and functions, continued
  fraction support, approximation routines and string formatting and
  evaluation.

  The rational utilities include some `rational complex number' functions.

  <paragraph|rat_interval.pure<label|rat-interval-pure>>

  Amongst the rational utilities are some functions that return a rational
  interval. The file <verbatim|rat_interval.pure> is a partial implementation
  of interval arithmetic. Intervals are discussed further in
  <hlink|Intervals|#intervals>.

  <subsubsection|Notation<label|notation>>

  Throughout this document, the parameters q, q0, q1, ... usually denote
  rationals (<math|\<in\>> <with|font-series|bold|Q>), parameters z, ...
  usually denote integers (<math|\<in\>> <with|font-series|bold|Z>), r, ...
  usually denote real numbers (<math|\<in\>> <with|font-series|bold|R>), c,
  ... usually denote complex numbers (<math|\<in\>>
  <with|font-series|bold|C>), n, ... usually denote parameters of any numeric
  type, v, ... usually denote parameters of any interval type, and x, ...
  usually denote parameters of any type.

  The reals are not just the doubles, but include rationals and integers. The
  term `rational' usually refers to a rational number <math|\<in\>>
  <with|font-series|bold|Q> <math|\<supset\>> <with|font-series|bold|Z>, or
  an expression of type rational or integer.

  <subsection|The Rational Type<label|the-rational-type>>

  <subsubsection|Constructors<label|constructors>>

  Rationals are constructed with the <verbatim|%> exact division operator,
  and other kinds of numbers can be converted to rationals with the
  <verbatim|rational> function. These are both defined in math.pure.

  <\description>
    <item*|n1 % n2<label|%/rational>>is the exact division operator, which
    may be used as a constructor (for integers n1 and n2). This is described
    in <hlink|More on Division|#more-on-division>.
  </description>

  <\description>
    <item*|rational x<label|rational/rational>>converts the given number
    <verbatim|x> to a rational.
  </description>

  <with|font-series|bold|Example 1> Constructing a fraction:

  <\verbatim>
    \<gtr\> 44%14;

    22L%7L
  </verbatim>

  <with|font-series|bold|Example 2> Converting from an integer:

  <\verbatim>
    \<gtr\> rational 3;

    3L%1L
  </verbatim>

  <subsubsection|`Deconstructors'<label|deconstructors>>

  A rational number is in simplest form if the numerator and denominator are
  coprime (i.e. do not have a factor in common) and the denominator is
  positive (and, specifically, non-zero). Sometimes the term `irreducible' is
  used for a rational in simplest form. This is a property of the
  representation of the rational number and not of the number itself.

  <\description>
    <item*|num q<label|num/rational>>given a rational or integer q, returns
    the `(signed) simplest numerator', i.e. the numerator of the normalised
    form of q.
  </description>

  <\description>
    <item*|den q<label|den/rational>>given a rational or integer q, returns
    the `(positive) simplest denominator', i.e. the denominator of the
    normalised form of q.
  </description>

  <\description>
    <item*|rational::num_den q<label|rational::num-den>>given a rational or
    integer q, returns a pair (n, d) containing the (signed) simplest
    numerator n and the (positive) simplest denominator d. This is the
    inverse (up to equivalence) of rational as defined on integer pairs (see
    <hlink|Constructors|#constructors>).
  </description>

  <with|font-series|bold|Example 3> Using num_den to obtain a representation
  in simplest form:

  <\verbatim>
    \<gtr\> let q = (44%(-14));

    \<gtr\> num q;

    -22L

    \<gtr\> den q;

    7L

    \<gtr\> num_den q;

    -22L,7L

    \<gtr\> num_den 3;

    3L,1L

    \<gtr\> num_den (-3);

    -3L,1L
  </verbatim>

  Together, <hlink|<with|font-family|tt|num>|purelib.tm#num> and
  <hlink|<with|font-family|tt|den>|purelib.tm#den> are a pair of
  `decomposition' operators, and <hlink|<with|font-family|tt|num_den>|#rational::num-den>
  is also a decomposition operator. There are others (see
  <hlink|Decomposition|#decomposition>). The integer and fraction function
  (see <hlink|Integer and Fraction Parts|#integer-and-fraction-parts>) may be
  used in conjunction with <hlink|<with|font-family|tt|num_den_gauss>|#rational::num-den-gauss>
  to decompose a rational into integer, numerator and denominator parts.

  <subsubsection|Type and Value Tests<label|type-and-value-tests>>

  The functions <hlink|<with|font-family|tt|rationalp>|purelib.tm#rationalp>
  and <hlink|<with|font-family|tt|ratvalp>|purelib.tm#ratvalp> and other
  rational variants are new for rationals and the standard functions
  <hlink|<with|font-family|tt|exactp>|purelib.tm#exactp> and
  <hlink|<with|font-family|tt|inexactp>|purelib.tm#inexactp> are extended for
  rationals.

  A value is `exact', or of an exact type, if it is of a type that is able to
  represent the values returned by arithmetical operations exactly; in a
  sense, it is `closed' under arithmetical operations. Otherwise, a value is
  `inexact'. Inexact types are able to store some values only approximately.

  The doubles are not an exact type. The results of some operations on some
  values that are stored exactly, can't be stored exactly. (Furthermore,
  doubles are intended to represent real numbers; no irrational number
  (<math|\<in\>> <with|font-series|bold|R> \\ <with|font-series|bold|Q>) can
  be stored exactly as a double; even some rational (<math|\<in\>>
  <with|font-series|bold|Q>) numbers are not stored exactly.)

  The rationals are an exact type. All rational numbers (subject to available
  resources, of course) are stored exactly. The results of the arithmetical
  operations on rationals are rationals represented exactly. Beware that the
  standard <verbatim|intvalp> and <hlink|<with|font-family|tt|ratvalp>|purelib.tm#ratvalp>
  may return 1 even if the value is of double type. However, these functions
  may be combined with <hlink|<with|font-family|tt|exactp>|purelib.tm#exactp>.

  <\description>
    <item*|exactp x<label|exactp/rational>>returns whether x has an exact
    value.
  </description>

  <\description>
    <item*|inexactp x<label|inexactp/rational>>returns whether x has an
    inexact value.
  </description>

  <\description>
    <item*|rationalp x<label|rationalp/rational>>returns whether x is of
    rational type.
  </description>

  <\description>
    <item*|ratvalp x<label|ratvalp/rational>>returns whether x has a rational
    value.
  </description>

  <with|font-series|bold|Example 4> Rational value tests:

  <\verbatim>
    \<gtr\> let l = [9, 9%1, 9%2, 4.5, sqrt 2, 1+i, inf, nan];

    \<gtr\> map exactp l;

    [1,1,1,0,0,1,0,0]

    \<gtr\> map inexactp l;

    [0,0,0,1,1,0,1,1]

    \<gtr\> map rationalp l;

    [0,1,1,0,0,0,0,0]

    \<gtr\> map ratvalp l;

    [1,1,1,1,1,0,0,0]

    \<gtr\> map (\\x -\<gtr\> (exactp x && ratvalp x)) l; // "has exact
    rational value"

    [1,1,1,0,0,0,0,0]

    \<gtr\> map intvalp l; // for comparison

    [1,1,0,0,0,0,0,0]

    \<gtr\> map (\\x -\<gtr\> (exactp x && intvalp x)) l; // "has exact
    integer value"

    [1,1,0,0,0,0,0,0]
  </verbatim>

  See <hlink|Rational Complex Numbers|#rational-complex-numbers> for details
  about rational complex numbers, and <hlink|Rational Complex Type and Value
  Tests|#rational-complex-type-and-value-tests> for details of their type and
  value tests.

  <subsection|Arithmetic<label|arithmetic>>

  <subsubsection|Operators<label|operators>>

  The standard arithmetic operators (+), (-) and (*) are overloaded to have
  at least one rational operand. If both operands are rational then the
  result is rational. If one operand is integer, then the result is rational.
  If one operand is double, then the result is double.

  The operators (/) and (%) are overloaded for division on at least one
  rational operand. The value returned by (/) is always <verbatim|inexact>
  (in the sense of <hlink|Type and Value Tests|#type-and-value-tests>). The
  value returned by (%) is <verbatim|exact> (if it exists).

  The standard function <verbatim|pow> is overloaded to have a rational left
  operand. If <verbatim|pow> is passed integer operands where the right
  operand is negative, then a rational is returned. The right operand should
  be an integer; negative values are permitted (because q<rsup|-z> =
  1/q<rsup|z>). It is not overloaded to also have a rational right operand
  because such values are not generally rational (e.g. q<rsup|1/n> =
  <rsup|n><math|<sqrt|>>q).

  The standard arithmetic operator (^) is also overloaded, but produces a
  double value (as always).

  <with|font-series|bold|Example 5> Arithmetic:

  <\verbatim>
    \<gtr\> 5%7 + 2%3;

    29L%21L

    \<gtr\> str_mixed ans;

    "1L+8L/21L"

    \<gtr\> 1 + 2%3;

    5L%3L

    \<gtr\> ans + 1.0;

    2.66666666666667

    \<gtr\> 3%8 - 1%3;

    1L%24L

    \<gtr\> (11%10) ^ 3;

    1.331

    \<gtr\> pow (11%10) 3;

    1331L%1000L

    \<gtr\> pow 3 5;

    243L

    \<gtr\> pow 3 (-5);

    1L%243L
  </verbatim>

  (See the function <hlink|<with|font-family|tt|str_mixed>|#rational::str-mixed>.)

  Beware that (/) on integers will not produce a rational result.

  <with|font-series|bold|Example 6> Division:

  <\verbatim>
    \<gtr\> 44/14;

    3.14285714285714

    \<gtr\> 44%14;

    22L%7L

    \<gtr\> str_mixed ans;

    "3L+1L/7L"
  </verbatim>

  (See the function <hlink|<with|font-family|tt|str_mixed>|#rational::str-mixed>.)

  <subsubsection|More on Division<label|more-on-division>>

  There is a rational-aware divide operator on the numeric types:

  <\description>
    <item*|n1 % n2>returns the quotient (<math|\<in\>>
    <with|font-series|bold|Q>) of n1 and n2. If n1 and n2 are rational or
    integer then the result is rational. This operator has the precedence of
    division (/).
  </description>

  <with|font-series|bold|Example 7> Using % like a constructor:

  <\verbatim>
    \<gtr\> 44 % 14;

    22L%7L

    \<gtr\> 2 + 3%8; // "2 3/8"

    19L%8L

    \<gtr\> str_mixed ans;

    "2L+3L/8L"
  </verbatim>

  (See the function <hlink|<with|font-family|tt|str_mixed>|#rational::str-mixed>.)

  <\description>
    <item*|rational::reciprocal n<label|rational::reciprocal>>returns the
    reciprocal of n: 1/n.
  </description>

  <with|font-series|bold|Example 8> Reciprocal:

  <\verbatim>
    \<gtr\> reciprocal (22%7);

    7L%22L
  </verbatim>

  The following division functions are parameterised by a rounding mode
  <verbatim|roundfun>. The available rounding modes are described in
  <hlink|Rounding to Integer|#rounding-to-integer>.

  <\description>
    <item*|rational::divide roundfun n d<label|rational::divide>>for
    rationals n and d returns a pair (q, r) of `quotient' and `remainder'
    where q is an integer and r is a rational such that \|r\| \<less\> \|d\|
    (or better) and n = q * d + r. Further conditions may hold, depending on
    the chosen rounding mode <verbatim|roundfun> (see <hlink|Rounding to
    Integer|#rounding-to-integer>). If <verbatim|roundfun> =
    <hlink|<with|font-family|tt|floor>|purelib.tm#floor> then 0
    <math|\<leq\>> r \<less\> d. If <verbatim|roundfun> =
    <hlink|<with|font-family|tt|ceil>|purelib.tm#ceil> then -d \<less\> r
    <math|\<leq\>> 0. If <verbatim|roundfun> =
    <hlink|<with|font-family|tt|trunc>|purelib.tm#trunc> then \|r\| \<less\>
    \|d\| and sgn r <math|\<in\>> {0, sgn d}. If <verbatim|roundfun> =
    <hlink|<with|font-family|tt|round>|purelib.tm#round>, <verbatim|roundfun>
    = <verbatim|round_zero_bias> or <verbatim|roundfun> =
    <hlink|<with|font-family|tt|round_unbiased>|#rational::round-unbiased>
    then \|r\| <math|\<leq\>> d/2.
  </description>

  <\description>
    <item*|rational::quotient roundfun nN d<label|rational::quotient>>returns
    just the quotient as produced by <hlink|<with|font-family|tt|divide>|#rational::divide>
    roundfun n d.
  </description>

  <\description>
    <item*|rational::modulus roundfun n d<label|rational::modulus>>returns
    just the remainder as produced by <hlink|<with|font-family|tt|divide>|#rational::divide>
    roundfun n d.
  </description>

  <\description>
    <item*|q1 div q2<label|div/rational>>(overload of the built-in div) q1
    and q2 may be rational or integer. Returns an integer.
  </description>

  <\description>
    <item*|q1 mod q2<label|mod/rational>>(overload of the built-in mod) q1
    and q2 may be rational or integer. Returns a rational. If q = q1 div q2
    and r = q1 mod q2 then q1 = q * q2 + q, q <math|\<in\>>
    <with|font-series|bold|Z>, \|r\| \<less\> \|q2\| and sgn r <math|\<in\>>
    {0, sgn q2}.
  </description>

  <subsubsection|Relations \V Equality and Inequality
  Tests<label|relations-equality-and-inequality-tests>>

  The standard arithmetic operators (==), (<math|\<sim\>>=), (\<less\>),
  (\<less\>=), (\<gtr\>), (\<gtr\>=) are overloaded to have at least one
  rational operand. The other operand may be rational, integer or double.

  <with|font-series|bold|Example 9> Inequality:

  <\verbatim>
    \<gtr\> 3%8 \<less\> 1%3;

    0
  </verbatim>

  <subsubsection|Comparison Function<label|comparison-function>>

  <\description>
    <item*|rational::cmp n1 n2<label|rational::cmp>>is the `comparison' (or
    `compare') function, and returns sgn (n1 - n2); that is, it returns -1 if
    n1 \<less\> n2, 0 if n1 = n2, and +1 if n1 \<gtr\> n2.
  </description>

  <with|font-series|bold|Example 10> Compare:

  <\verbatim>
    \<gtr\> cmp (3%8) (1%3);

    1
  </verbatim>

  <subsection|Mathematical Functions<label|mathematical-functions>>

  Most mathematical functions, including the elementary functions (sin,
  sin<rsup|-1>, sinh, sinh<rsup|-1>, cos, ... , exp, ln, ... ), are not
  closed on the set of rational numbers. That is, most mathematical functions
  do not yield a rational number in general when applied to a rational
  number. Therefore the elementary functions are not defined for rationals.
  To apply these functions, first apply a cast to double, or compose the
  function with a cast.

  <subsubsection|Absolute Value and Sign<label|absolute-value-and-sign>>

  The standard <verbatim|abs> and <verbatim|sgn> functions are overloaded for
  rationals.

  <\description>
    <item*|abs q<label|abs/rational>>returns absolute value, or magnitude,
    \|q\| of q; abs q = \|q\| = q <math|\<times\>> sgn q (see below).
  </description>

  <\description>
    <item*|sgn q<label|sgn/rational>>returns the sign of q as an integer;
    returns -1 if q \<less\> 0, 0 if q = 0, +1 if q \<gtr\> 0.
  </description>

  Together, these functions satisfy the property <math|\<forall\>>q
  <math|\<bullet\>> (sgn q) * (abs q) = q (i.e. <math|\<forall\>>q
  <math|\<bullet\>> (sgn q) * \|q\| = q). Thus these provide a pair of
  `decomposition' operators; there are others (see
  <hlink|Decomposition|#decomposition>).

  <subsubsection|Greatest Common Divisor (GCD) and Least Common Multiple
  (LCM)<label|greatest-common-divisor-gcd-and-least-common-multiple-lcm>>

  The standard functions <verbatim|gcd> and <verbatim|lcm> are overloaded for
  rationals, and mixtures of integer and rational.

  <\description>
    <item*|gcd n1 n2<label|gcd/rational>>The GCD is also known as the Highest
    Common Factor (HCF). The GCD of rationals q1 and q2 is the largest
    (therefore positive) rational f such that f divides into both q1 and q2
    exactly, i.e. an integral number of times. This is not defined for n1 and
    n2 both zero. For integral q1 and q2, this definition coincides with the
    usual definition of GCD for integers.
  </description>

  <with|font-series|bold|Example 11> With two rationals:

  <\verbatim>
    \<gtr\> let a = 7%12;

    \<gtr\> let b = 21%32;

    \<gtr\> let f = gcd a b;

    \<gtr\> f;

    7L%96L

    \<gtr\> a % f;

    8L%1L

    \<gtr\> b % f;

    9L%1L
  </verbatim>

  <with|font-series|bold|Example 12> With a rational and an integer:

  <\verbatim>
    \<gtr\> let f = gcd (6%5) 4;

    \<gtr\> f;

    2L%5L

    \<gtr\> (6%5) % f;

    3L%1L

    \<gtr\> 4 % f;

    10L%1L
  </verbatim>

  <with|font-series|bold|Example 13> With integral rationals and with
  integers:

  <\verbatim>
    \<gtr\> gcd (rational 18) (rational 24);

    6L%1L

    \<gtr\> gcd 18 24;

    6
  </verbatim>

  <with|font-series|bold|Example 14> The behaviour with negative numbers:

  <\verbatim>
    \<gtr\> gcd (rational (-18)) (rational 24);

    6L%1L

    \<gtr\> gcd (rational 18) (rational (-24));

    6L%1L

    \<gtr\> gcd (rational (-18)) (rational (-24));

    6L%1L
  </verbatim>

  <\description>
    <item*|lcm n1 n2<label|lcm/rational>>The LCM of rationals q1 and q2 is
    the smallest positive rational m such that both q1 and q2 divide m
    exactly. This is not defined for n1 and n2 both zero. For integral q1 and
    q2, this definition coincides with the usual definition of LCM for
    integers.
  </description>

  <with|font-series|bold|Example 15> With two rationals:

  <\verbatim>
    \<gtr\> let a = 7%12;

    \<gtr\> let bB = 21%32;

    \<gtr\> let m = lcm a b;

    \<gtr\> m;

    21L%4L

    \<gtr\> m % a;

    9L%1L

    \<gtr\> m % b;

    8L%1L
  </verbatim>

  <with|font-series|bold|Example 16> With a rational and an integer:

  <\verbatim>
    \<gtr\> let m = lcm (6%5) 4;

    \<gtr\> m;

    12L%1L

    \<gtr\> m % (6%5);

    10L%1L
  </verbatim>

  <with|font-series|bold|Example 17> The behaviour with negative numbers:

  <\verbatim>
    \<gtr\> lcm (rational (-18)) (rational 24);

    72L%1L

    \<gtr\> lcm (rational 18) (rational (-24));

    72L%1L

    \<gtr\> lcm (rational (-18)) (rational (-24));

    72L%1L
  </verbatim>

  Together, the GCD and LCM have the following property when applied to two
  numbers: (gcd q1 q2) * (lcm q1 q2) = \|q1 * q2\|.

  <subsubsection|Extrema (Minima and Maxima)<label|extrema-minima-and-maxima>>

  The standard <verbatim|min> and <verbatim|max> functions work with rational
  values.

  <with|font-series|bold|Example 18> Maximum:

  <\verbatim>
    \<gtr\> max (3%8) (1%3);

    3L%8L
  </verbatim>

  <subsection|Special Rational Functions<label|special-rational-functions>>

  <subsubsection|Complexity<label|complexity>>

  The `complexity' (or `complicatedness') of a rational is a measure of the
  greatness of its simplest (positive) denominator.

  The complexity of a number is not itself made available, but various
  functions and operators are provided to allow complexities to be compared.
  Generally, it does not make sense to operate directly on complexity values.

  The complexity functions in this section may be applied to integers (the
  least complex), rationals, or reals (doubles; the most complex).

  Functions concerning `complexity' are named with `cplx', whereas functions
  concerning `complex numbers' (see <hlink|Rational Complex
  Numbers|#rational-complex-numbers>) are named with `comp'.

  <paragraph|Complexity Relations<label|complexity-relations>>

  <\description>
    <item*|n1 rational::eq_cplx n2<label|rational::eq-cplx>>``[is] equally
    complex [to]'' \V returns 1 if n1 and n2 are equally complex; returns 0
    otherwise. Equal complexity is not the same a equality; n1 and n2 are
    equally complex if their simplest denominators are equal. Equal
    complexity forms an equivalence relation on rationals.
  </description>

  <with|font-series|bold|Example 19> Complexity equality test:

  <\verbatim>
    \<gtr\> (1%3) eq_cplx (100%3);

    1

    \<gtr\> (1%4) eq_cplx (1%5);

    0

    \<gtr\> (3%3) eq_cplx (1%3); // LHS is not in simplest form

    0
  </verbatim>

  <\description>
    <item*|n1 rational::not_eq_cplx n2<label|rational::not-eq-cplx>>``not
    equally complex'' \V returns 0 if n1 and n2 are equally complex; returns
    1 otherwise.
  </description>

  <\description>
    <item*|n1 rational::less_cplx n2<label|rational::less-cplx>>``[is] less
    complex [than]'' (or ``simpler'') \V returns 1 if n1 is strictly less
    complex than n2; returns 0 otherwise. This forms a partial strict
    ordering on rationals.
  </description>

  <with|font-series|bold|Example 20> Complexity inequality test:

  <\verbatim>
    \<gtr\> (1%3) less_cplx (100%3);

    0

    \<gtr\> (1%4) less_cplx (1%5);

    1

    \<gtr\> (3%3) less_cplx (1%3); // LHS is not in simplest form

    1
  </verbatim>

  <\description>
    <item*|n1 rational::less_eq_cplx n2<label|rational::less-eq-cplx>>``less
    or equally complex'' (or ``not more complex'') \V returns 1 if n1 is less
    complex than or equally complex to n2; returns 0 otherwise. This forms a
    partial non-strict ordering on rationals.
  </description>

  <\description>
    <item*|n1 rational::more_cplx n2<label|rational::more-cplx>>``[is] more
    complex [than]'' \V returns 1 if n1 is strictly more complex than n2;
    returns 0 otherwise. This forms a partial strict ordering on rationals.
  </description>

  <\description>
    <item*|n1 rational::more_eq_cplx n2<label|rational::more-eq-cplx>>``more
    or equally complex'' (or ``not less complex'') \V returns 1 if n1 is more
    complex than or equally complex to n2; returns 0 otherwise. This forms a
    partial non-strict ordering on rationals.
  </description>

  <paragraph|Complexity Comparison Function<label|complexity-comparison-function>>

  <\description>
    <item*|rational::cmp_complexity n1 n2<label|rational::cmp-complexity>>is
    the `complexity comparison' function, and returns the sign of the
    difference in complexity; that is, it returns -1 if n1 is less complex
    than n2, 0 if n1 and n2 are equally complex (but not necessarily equal),
    and +1 if n1 is more complex than n2.
  </description>

  <with|font-series|bold|Example 21> Complexity comparison:

  <\verbatim>
    \<gtr\> cmp_complexity (1%3) (100%3);

    0

    \<gtr\> cmp_complexity (1%4) (1%5);

    -1

    \<gtr\> cmp_complexity (3%3) (1%3); // LHS is not in simplest form

    -1
  </verbatim>

  <paragraph|Complexity Extrema<label|complexity-extrema>>

  <\description>
    <item*|rational::least_cplx n1 n2<label|rational::least-cplx>>returns the
    least complex of n1 and n2; if they're equally complex, n1 is returned.
  </description>

  <with|font-series|bold|Example 22> Complexity selection:

  <\verbatim>
    \<gtr\> least_cplx (100%3) (1%3);

    100L%3L

    \<gtr\> least_cplx (1%5) (1%4);

    1L%4L

    \<gtr\> least_cplx (1%3) (3%3); // second argument not in simplest form

    1L%1L
  </verbatim>

  <\description>
    <item*|rational::most_cplx n1 n2<label|rational::most-cplx>>returns the
    most complex of n1 and n2; if they're equally complex, n1 is returned.
  </description>

  <paragraph|Other Complexity Functions<label|other-complexity-functions>>

  <\description>
    <item*|rational::complexity_rel n1 op
    n2<label|rational::complexity-rel>>returns ``complexity-of n1'' compared
    by operator op to the ``complexity-of n2''. This is equivalent to prefix
    complexity rel op n1 n2 (below), but is the more readable form.
  </description>

  <with|font-series|bold|Example 23> Complexity relations:

  <\verbatim>
    \<gtr\> complexity_rel (1%3) (==) (100%3);

    1

    \<gtr\> complexity_rel (1%4) (\<less\>=) (1%5);

    1

    \<gtr\> complexity_rel (1%4) (\<gtr\>) (1%5);

    0
  </verbatim>

  <\description>
    <item*|rational::_complexity_rel op n1
    n2<label|rational::-complexity-rel>>returns the same as complexity_rel n1
    op n2, but this form is more convenient for currying.
  </description>

  <subsubsection|Mediants and Farey Sequences<label|mediants-and-farey-sequences>>

  <\description>
    <item*|rational::mediant q1 q2<label|rational::mediant>>returns the
    canonical mediant of the rationals q1 and q2, a form of (nonarithmetic)
    average on rationals. The mediant of the representations n1/d1 = q1 and
    n2/d2 = q2, where d1 and d2 must be positive, is defined as (n1 + n2)/(d1
    + d2). A mediant of the rationals q1 and q2 is a mediant of some
    representation of each of q1 and q2. That is, the mediant is dependent
    upon the representations and therefore is not well-defined as a function
    on pairs of rationals. The canonical mediant always assumes the simplest
    representation, and therefore is well-defined as a function on pairs of
    rationals.

    By the phrase ``the mediant'' (as opposed to just ``a mediant'') we
    always mean ``the canonical mediant''.

    If q1 \<less\> q2, then any mediant q is always such that q1 \<less\> q
    \<less\> q2.

    The (canonical) mediant has some special properties. If q1 and q2 are
    integers, then the mediant is the arithmetic mean. If q1 and q2 are unit
    fractions (reciprocals of integers), then the mediant is the harmonic
    mean. The mediant of q and 1/q is <math|\<pm\>>1, (which happens to be a
    geometric mean with the correct sign, although this is a somewhat
    uninteresting and degenerate case).
  </description>

  <with|font-series|bold|Example 24> Mediants:

  <\verbatim>
    \<gtr\> mediant (1%4) (3%10);

    2L%7L

    \<gtr\> mediant 3 7; // both integers

    5L%1L

    \<gtr\> mediant 3 8; // both integers again

    11L%2L

    \<gtr\> mediant (1%3) (1%7); // both unit fractions

    1L%5L

    \<gtr\> mediant (1%3) (1%8); // both unit fractions again

    2L%11L

    \<gtr\> mediant (-10) (-1%10);

    (-1L)%1L
  </verbatim>

  <\description>
    <item*|rational::farey k<label|rational::farey>>for an integer k, farey
    returns the ordered list containing the order-k Farey sequence, which is
    the ordered list of all rational numbers between 0 and 1 inclusive with
    (simplest) denominator at most k.
  </description>

  <with|font-series|bold|Example 25> A Farey sequence:

  <\verbatim>
    \<gtr\> map str_mixed (farey 6);

    ["0L","1L/6L","1L/5L","1L/4L","1L/3L","2L/5L","1L/2L","3L/5L","2L/3L",

    "3L/4L","4L/5L","5L/6L","1L"]
  </verbatim>

  (See the function <hlink|<with|font-family|tt|str_mixed>|#rational::str-mixed>.)

  Farey sequences and mediants are closely related. Three rationals q1
  \<less\> q2 \<less\> q3 are consecutive members of a Farey sequence if and
  only if q2 is the mediant of q1 and q3. If rationals q1 = n1/d1 \<less\> q2
  = n2/d2 are consecutive members of a Farey sequence, then n2d1 - n1d2 = 1.

  <subsubsection|Rational Type Simplification<label|rational-type-simplification>>

  <\description>
    <item*|rational::rat_simplify q<label|rational::rat-simplify>>returns q
    with rationals simplified to integers, if possible.
  </description>

  <with|font-series|bold|Example 26> Rational type simplification:

  <\verbatim>
    \<gtr\> let l = [9, 9%1, 9%2, 4.5, 9%1+i, 9%2+i]; l;

    [9,9L%1L,9L%2L,4.5,9L%1L+:1,9L%2L+:1]

    \<gtr\> map rat_simplify l;

    [9,9,9L%2L,4.5,9+:1,9L%2L+:1]
  </verbatim>

  See <hlink|Rational Complex Numbers|#rational-complex-numbers> for details
  about rational complex numbers, and <hlink|Rational Complex Type
  Simplification|#rational-complex-type-simplification> for details of their
  type simplification.

  <subsection|Q -\<gtr\> Z \V Rounding<label|q-z-rounding>>

  <subsubsection|Rounding to Integer<label|rounding-to-integer>>

  Some of these are new functions, and some are overloads of standard
  functions. The behaviour of the overloads is consistent with that of the
  standard functions.

  <\description>
    <item*|floor q<label|floor/rational>>(overload of standard function)
    returns q rounded downwards, i.e. towards -1, to an integer, usually
    denoted bQc.
  </description>

  <\description>
    <item*|ceil q<label|ceil/rational>>(overload of standard function)
    returns q rounded upwards, i.e. towards +1, to an integer, usually
    denoted dQe.
  </description>

  <\description>
    <item*|trunc q<label|trunc/rational>>(overload of standard function)
    returns q truncated, i.e. rounded towards 0, to an integer.
  </description>

  <\description>
    <item*|round q<label|round/rational>>(overload of standard function)
    returns q `rounded off', i.e. rounded to the nearest integer, with
    `half-integers' (values that are an integer plus a half) rounded away
    from zero.
  </description>

  <\description>
    <item*|rational::round_zero_bias q<label|rational::round-zero-bias>>(new
    function) returns q `rounded off', i.e. rounded to the nearest integer,
    but with `half-integers' rounded towards zero.
  </description>

  <\description>
    <item*|rational::round_unbiased q<label|rational::round-unbiased>>(new
    function) returns q rounded to the nearest integer, with `half-integers'
    rounded to the nearest even integer.
  </description>

  <with|font-series|bold|Example 27> Illustration of the different rounding
  modes:

  <\verbatim>
    \<gtr\> let l = iterwhile (\<less\>= 3) (+(1%2)) (- rational 3);

    \<gtr\> map double l; // (just to show the values in a familiar format)

    [-3.0,-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5,3.0]

    \<gtr\> map floor l;

    [-3L,-3L,-2L,-2L,-1L,-1L,0L,0L,1L,1L,2L,2L,3L]

    \<gtr\> map ceil l;

    [-3L,-2L,-2L,-1L,-1L,0L,0L,1L,1L,2L,2L,3L,3L]

    \<gtr\> map trunc l;

    [-3L,-2L,-2L,-1L,-1L,0L,0L,0L,1L,1L,2L,2L,3L]

    \<gtr\> map round l;

    [-3L,-3L,-2L,-2L,-1L,-1L,0L,1L,1L,2L,2L,3L,3L]

    \<gtr\> map round_zero_bias l;

    [-3L,-2L,-2L,-1L,-1L,0L,0L,0L,1L,1L,2L,2L,3L]

    \<gtr\> map round_unbiased l;

    [-3L,-2L,-2L,-2L,-1L,0L,0L,0L,1L,2L,2L,2L,3L]
  </verbatim>

  (See the function <hlink|<with|font-family|tt|double>|purelib.tm#double>.)

  <subsubsection|Integer and Fraction Parts<label|integer-and-fraction-parts>>

  <\description>
    <item*|rational::integer_and_fraction roundfun
    q<label|rational::integer-and-fraction>>returns a pair (z, f) where z is
    the `integer part' as an integer, f is the `fraction part' as a rational,
    where the rounding operations are performed using rounding mode
    <verbatim|roundfun> (see <hlink|Rounding to
    Integer|#rounding-to-integer>).
  </description>

  <with|font-series|bold|Example 28> Integer and fraction parts with the
  different rounding modes:

  <\verbatim>
    \<gtr\> let nc = -22%7;

    \<gtr\> integer_and_fraction floor nc;

    -4L,6L%7L

    \<gtr\> integer_and_fraction trunc nc;

    -3L,(-1L)%7L

    \<gtr\> integer_and_fraction round nc;

    -3L,(-1L)%7L
  </verbatim>

  It is always the case that z and f have the property that q = z + f.
  However, the remaining properties depend upon the choice of
  <verbatim|roundfun>. Thus this provides a `decomposition' operator; there
  are others (see <hlink|Decomposition|#decomposition>). If
  <verbatim|roundfun> = <hlink|<with|font-family|tt|floor>|purelib.tm#floor>
  then 0 <math|\<leq\>> f \<less\> 1. If <verbatim|roundfun> =
  <hlink|<with|font-family|tt|ceil>|purelib.tm#ceil> then -1 \<less\> f
  <math|\<leq\>> 0. If <verbatim|roundfun> =
  <hlink|<with|font-family|tt|trunc>|purelib.tm#trunc> then \|f\| \<less\> 1
  and sgn f <math|\<in\>> {0, sgn q}. If <verbatim|roundfun> =
  <hlink|<with|font-family|tt|round>|purelib.tm#round>, <verbatim|roundfun> =
  <hlink|<with|font-family|tt|round_zero_bias>|#rational::round-zero-bias> or
  <verbatim|roundfun> = <hlink|<with|font-family|tt|round_unbiased>|#rational::round-unbiased>
  then \|f\| <math|\<leq\>> 1/2.

  <\description>
    <item*|rational::fraction roundfun q<label|rational::fraction>>returns
    just the `fraction part' as a rational, where the rounding operations are
    performed using <verbatim|roundfun>. The corresponding function `integer'
    is not provided, as integer <verbatim|roundfun> q would be just
    <verbatim|roundfun> q. The integer and fraction function (probably with
    <hlink|<with|font-family|tt|trunc>|purelib.tm#trunc> or
    <hlink|<with|font-family|tt|floor>|purelib.tm#floor> rounding mode) may
    be used in conjunction with <hlink|<with|font-family|tt|num_den>|#rational::num-den>
    (see <hlink|`Deconstructors'|#deconstructors>) to decompose a rational
    into integer, numerator and denominator parts.
  </description>

  <\description>
    <item*|int q<label|int/rational>>overloads the built-in int and returns
    the `integer part' of q consistent with the built-in.
  </description>

  <\description>
    <item*|frac q<label|frac/rational>>overloads the built-in frac and
    returns the `fraction part' of q consistent with the built-in.
  </description>

  <with|font-series|bold|Example 29> Standard integer and fraction parts:

  <\verbatim>
    \<gtr\> let nc = -22%7;

    \<gtr\> int nc;

    -3

    \<gtr\> frac nc;

    (-1L)%7L
  </verbatim>

  <subsection|Rounding to Multiples<label|rounding-to-multiples>>

  <\description>
    <item*|rational::round_to_multiple roundfun multOf
    q<label|rational::round-to-multiple>>returns q rounded to an integer
    multiple of a non-zero value multOf, using <verbatim|roundfun> as the
    rounding mode (see <hlink|Rounding to Integer|#rounding-to-integer>).
    Note that it is the multiple that is rounded in the prescribed way, and
    not the final result, which may make a difference in the case that multOf
    is negative. If that is not the desired behaviour, pass this function the
    absolute value of multOf rather than multOf. Similar comments apply to
    the following functions.
  </description>

  <\description>
    <item*|rational::floor_multiple multOf
    q<label|rational::floor-multiple>>returns q rounded to a downwards
    integer multiple of multOf.
  </description>

  <\description>
    <item*|rational::ceil_multiple multOf
    q<label|rational::ceil-multiple>>returns q rounded to an upwards integer
    multiple of multOf.
  </description>

  <\description>
    <item*|rational::trunc_multiple multOf
    q<label|rational::trunc-multiple>>returns q rounded towards zero to an
    integer multiple of multOf.
  </description>

  <\description>
    <item*|rational::round_multiple multOf
    q<label|rational::round-multiple>>returns q rounded towards the nearest
    integer multiple of multOf, with half-integer multiples rounded away from
    0.
  </description>

  <\description>
    <item*|rational::round_multiple_zero_bias multOf
    q<label|rational::round-multiple-zero-bias>>returns q rounded towards the
    nearest integer multiple of multOf, with half-integer multiples rounded
    towards 0.
  </description>

  <\description>
    <item*|rational::round_multiple_unbiased multOf
    q<label|rational::round-multiple-unbiased>>returns q rounded towards the
    nearest integer multiple of multOf, with half-integer multiples rounded
    to an even multiple.
  </description>

  <with|font-series|bold|Example 30> Round to multiple:

  <\verbatim>
    \<gtr\> let l = [34.9, 35, 35%1, 35.0, 35.1];

    \<gtr\> map double l; // (just to show the values in a familiar format)

    [34.9,35.0,35.0,35.0,35.1]

    \<gtr\> map (floor_multiple 10) l;

    [30.0,30L,30L,30.0,30.0]

    \<gtr\> map (ceil_multiple 10) l;

    [40.0,40L,40L,40.0,40.0]

    \<gtr\> map (trunc_multiple 10) l;

    [30.0,30L,30L,30.0,30.0]

    \<gtr\> map (round_multiple 10) l;

    [30.0,40L,40L,40.0,40.0]

    \<gtr\> map (round_multiple_zero_bias 10) l;

    [30.0,30L,30L,30.0,40.0]

    \<gtr\> map (round_multiple_unbiased 10) l;

    [30.0,40L,40L,40.0,40.0]
  </verbatim>

  (See the function <hlink|<with|font-family|tt|double>|purelib.tm#double>.)

  The round multiple functions may be used to find a fixed denominator
  approximation of a number. (The simplest denominator may actually be a
  proper factor of the chosen value.) To approximate for a bounded (rather
  than particular) denominator, use rational approx max den instead (see
  <hlink|Best Approximation with Bounded Denominator|#best-approximation-with-bounded-denominator>).

  <with|font-series|bold|Example 31> Finding the nearest q = n/d value to 1/e
  <math|\<approx\>> 0.368 where d = 1000 (actually, where d\|1000):

  <\verbatim>
    \<gtr\> let co_E = exp (-1);

    co_E;

    0.367879441171442

    \<gtr\> round_multiple (1%1000) (rational co_E);

    46L%125L

    \<gtr\> 1000 * ans;

    368L%1L
  </verbatim>

  <with|font-series|bold|Example 32> Finding the nearest q = n/d value to
  1/<math|\<phi\>> <math|\<approx\>> 0.618 where d = 3<rsup|5> = 243
  (actually, where d\|243):

  <\verbatim>
    \<gtr\> let co_Phi = (sqrt 5 - 1) / 2;

    \<gtr\> round_multiple (1%243) (rational co_Phi);

    50L%81L
  </verbatim>

  Other methods for obtaining a rational approximation of a number are
  described in <hlink|R -\<gtr\> Q \V Approximation|#r-q-approximation>.

  <subsection|Q -\<gtr\> R \V Conversion /
  Casting<label|q-r-conversion-casting>>

  <\description>
    <item*|double q<label|double/rational>>(overload of built-in) returns a
    double having a value as close as possible to q. (Overflow, underflow and
    loss of accuracy are potential problems. rationals that are too
    absolutely large or too absolutely small may overflow or underflow; some
    rationals can not be represented exactly as a double.)
  </description>

  <subsection|R -\<gtr\> Q \V Approximation<label|r-q-approximation>>

  This section describes functions that approximate a number (usually a
  double) by a rational. See <hlink|Rounding to
  Multiples|#rounding-to-multiples> for approximation of a number by a
  rational with a fixed denominator. See <hlink|Numeral String -\<gtr\> Q \V
  Approximation|#numeral-string-q-approximation> for approximation by a
  rational of a string representation of a real number.

  <subsubsection|Intervals<label|module-rat-interval>>

  Some of the approximation functions return an
  <with|font-series|bold|interval>. The file <verbatim|rat_interval.pure> is
  a basic implementation of interval arithmetic, and is not included in the
  default prelude. It is not intended to provide a complete implementation of
  interval arithmetic. The notions of `open' and `closed' intervals are not
  distinguished. Infinite and half-infinite intervals are not specifically
  provided. Some operations and functions may be missing. The most likely
  functions to be used are simply the `deconstructors'; see <hlink|Interval
  Constructors and `Deconstructors'|#interval-constructors-and-deconstructors>.

  <paragraph|Interval Constructors and `Deconstructors'<label|interval-constructors-and-deconstructors>>

  Intervals are constructed with the function interval.

  <\description>
    <item*|interval::interval (n1, n2)<label|interval::interval>>given a pair
    of numbers (z1 \<less\>= z2), this returns the interval z1..z2. This is
    the inverse of <verbatim|lo_up>.
  </description>

  <with|font-series|bold|Example 33> Constructing an interval:

  <\verbatim>
    \<gtr\> let v = interval (3, 8);

    \<gtr\> v;

    interval::Ivl 3 8
  </verbatim>

  <\description>
    <item*|interval::lower v<label|interval::lower>>returns the infimum
    (roughly, minimum) of v.
  </description>

  <\description>
    <item*|interval::upper v<label|interval::upper>>returns the supremum
    (roughly, maximum) of v.
  </description>

  <\description>
    <item*|interval::lo_up v<label|interval::lo-up>>returns a pair (l, u)
    containing the lower l and upper u extrema of the interval v. This is the
    inverse of interval as defined on number pairs.
  </description>

  <with|font-series|bold|Example 34> Deconstructing an interval:

  <\verbatim>
    \<gtr\> lower v;

    3

    \<gtr\> upper v;

    8

    \<gtr\> lo_up v;

    3,8
  </verbatim>

  <paragraph|Interval Type Tests<label|interval-type-tests>>

  <\description>
    <item*|exactp v>returns whether an interval v has exact extrema.
  </description>

  <\description>
    <item*|inexactp v>returns whether an interval v has an inexact extremum.
  </description>

  <\description>
    <item*|interval::intervalp x<label|interval::intervalp>>returns whether x
    is of type interval.
  </description>

  <\description>
    <item*|interval::interval_valp x<label|interval::interval-valp>>returns
    whether x has an interval value.
  </description>

  <\description>
    <item*|interval::ratinterval_valp x<label|interval::ratinterval-valp>>returns
    whether x has an interval value with rational extrema.
  </description>

  <\description>
    <item*|interval::intinterval_valp x<label|interval::intinterval-valp>>returns
    whether x has an interval value with integral extrema.
  </description>

  <with|font-series|bold|Example 35> Interval value tests:

  <\verbatim>
    \<gtr\> let l = [interval(0,1), interval(0,1%1), interval(0,3%2),
    interval(0,1.5)];

    \<gtr\> map exactp l;

    [1,1,1,0]

    \<gtr\> map inexactp l;

    [0,0,0,1]

    \<gtr\> map intervalp l;

    [1,1,1,1]

    \<gtr\> map interval_valp l;

    [1,1,1,1]

    \<gtr\> map ratinterval_valp l;

    [1,1,1,1]

    \<gtr\> map intinterval_valp l;

    [1,1,0,0]
  </verbatim>

  <paragraph|Interval Arithmetic Operators and
  Relations<label|interval-arithmetic-operators-and-relations>>

  The standard arithmetic operators (+), (-), (*), (/) and (%) are overloaded
  for intervals. The divide operators (/) and (%) do not produce a result if
  the right operand is an interval containing 0.

  <label|example-36><with|font-series|bold|Example 36> Some intervals:

  <\verbatim>
    \<gtr\> let a = interval (11, 19);

    \<gtr\> let b = interval (16, 24);

    \<gtr\> let c = interval (21, 29);

    \<gtr\> let d = interval (23, 27);
  </verbatim>

  <with|font-series|bold|Example 37> Interval arithmetic:

  <\verbatim>
    \<gtr\> let p = interval (0, 1);

    \<gtr\> let s = interval (-1, 1);

    \<gtr\> a + b;

    interval::Ivl 27 43

    \<gtr\> a - b;

    interval::Ivl (-13) 3

    \<gtr\> a * b;

    interval::Ivl 176 456

    \<gtr\> p * 2;

    interval::Ivl 0 2

    \<gtr\> (-2) * p;

    interval::Ivl (-2) 0

    \<gtr\> -c;

    interval::Ivl (-29) (-21)

    \<gtr\> s * a;

    interval::Ivl (-19) 19

    \<gtr\> a % 2;

    interval::Ivl (11L%2L) (19L%2L)

    \<gtr\> a / 2;

    interval::Ivl 5.5 9.5

    \<gtr\> reciprocal a;

    interval::Ivl (1L%19L) (1L%11L)

    \<gtr\> 2 % a;

    interval::Ivl (2L%19L) (2L%11L)

    \<gtr\> a % b;

    interval::Ivl (11L%24L) (19L%16L)

    \<gtr\> a % a; // notice that the intervals are mutually independent here

    interval::Ivl (11L%19L) (19L%11L)
  </verbatim>

  There are also some relations defined for intervals. The standard relations
  (==) and (<math|\<sim\>>=) are overloaded.

  However, rather than overloading (\<less\>), (\<less\>=), (\<gtr\>),
  (\<gtr\>=), which could be used for either ordering or containment with
  some ambiguity, the module defines <verbatim|(before)>,
  <verbatim|(within)>, and so on. `Strictness' refers to the properties at
  the end-points.

  <\description>
    <item*|v1 interval::before v2<label|interval::before>>returns whether v1
    is entirely before v2.
  </description>

  <\description>
    <item*|v1 interval::strictly_before v2<label|interval::strictly-before>>returns
    whether v1 is strictly entirely before v2.
  </description>

  <\description>
    <item*|v1 interval::after v2<label|interval::after>>returns whether v1 is
    entirely after v2.
  </description>

  <\description>
    <item*|v1 interval::strictly_after v2<label|interval::strictly-after>>returns
    whether v1 is strictly entirely after v2.
  </description>

  <\description>
    <item*|v1 interval::within v2<label|interval::within>>returns whether v1
    is entirely within v2; i.e. whether v1 is subinterval of v2.
  </description>

  <\description>
    <item*|v1 interval::strictly_within v2<label|interval::strictly-within>>returns
    whether v1 is strictly entirely within v2; i.e. whether v1 is proper
    subinterval of v2.
  </description>

  <\description>
    <item*|v1 interval::without v2<label|interval::without>>returns whether
    v1 entirely contains v2; i.e. whether v1 is superinterval of v2.
    `Without' is used in the sense of outside or around.
  </description>

  <\description>
    <item*|v1 interval::strictly_without v2<label|interval::strictly-without>>returns
    whether v1 strictly entirely contains v2; i.e. whether v1 is proper
    superinterval of v2.
  </description>

  <\description>
    <item*|v1 interval::disjoint v2<label|interval::disjoint>>returns whether
    v1 and v2 are entirely disjoint.
  </description>

  <\description>
    <item*|v interval::strictly_disjoint v2<label|interval::strictly-disjoint>>returns
    whether v1 and v2 are entirely strictly disjoint.
  </description>

  <with|font-series|bold|Example 38> Interval relations:

  <\verbatim>
    \<gtr\> a == b;

    0

    \<gtr\> a == a;

    1

    \<gtr\> a before b;

    0

    \<gtr\> a before c;

    1

    \<gtr\> c before a;

    0

    \<gtr\> a disjoint b;

    0

    \<gtr\> c disjoint a;

    1

    \<gtr\> a within b;

    0

    \<gtr\> a within c;

    0

    \<gtr\> d within c;

    1

    \<gtr\> c within d;

    0

    \<gtr\> a strictly_within a;

    0

    \<gtr\> a within a;

    1
  </verbatim>

  (The symbols a through d were defined in <hlink|Example 36|#example-36>.)

  These may also be used with a simple (real) value, and in particular to
  test membership.

  <with|font-series|bold|Example 39> Membership:

  <\verbatim>
    \<gtr\> 10 within a;

    0

    \<gtr\> 11 within a;

    1

    \<gtr\> 11.0 within a;

    1

    \<gtr\> 12 within a;

    1

    \<gtr\> 12.0 within a;

    1

    \<gtr\> 10 strictly_within a;

    0

    \<gtr\> 11 strictly_within a;

    0

    \<gtr\> (11%1) strictly_within a;

    0

    \<gtr\> 12 strictly_within a;

    1

    \<gtr\> (12%1) strictly_within a;

    1
  </verbatim>

  (The symbol a was defined in <hlink|Example 36|#example-36>.)

  <paragraph|Interval Maths<label|interval-maths>>

  Some standard functions are overloaded for intervals; some new functions
  are provided.

  <\description>
    <item*|abs v>returns the interval representing the range of (x) as x
    varies over v.
  </description>

  <with|font-series|bold|Example 40> Absolute interval:

  <\verbatim>
    \<gtr\> abs (interval (1, 5));

    interval::Ivl 1 5

    \<gtr\> abs (interval (-1, 5));

    interval::Ivl 0 5

    \<gtr\> abs (interval (-5, -1));

    interval::Ivl 1 5
  </verbatim>

  <\description>
    <item*|sgn v>returns the interval representing the range of sgn(x) as x
    varies over v.
  </description>

  <\description>
    <item*|# v<label|#/rational>>returns the length of an interval.
  </description>

  <with|font-series|bold|Example 41> Absolute interval:

  <\verbatim>
    \<gtr\> #d;

    4
  </verbatim>

  (The symbol d was defined in <hlink|Example 36|#example-36>.)

  <subsubsection|Least Complex Approximation within
  Epsilon<label|least-complex-approximation-within-epsilon>>

  <\description>
    <item*|rational::rational_approx_epsilon <math|\<varepsilon\>>
    r<label|rational::rational-approx-epsilon>>Find the least complex (see
    <hlink|Complexity Extrema|#complexity-extrema>) rational approximation to
    r (usually a double) that is <math|\<varepsilon\>>-close. That is find
    the q with the smallest possible denominator such that such that \|q -
    r\| <math|\<leq\>> <math|\<varepsilon\>>. (<math|\<varepsilon\>> \<gtr\>
    0.)
  </description>

  <with|font-series|bold|Example 42> Rational approximation to <math|\<pi\>>
  <math|\<approx\>> 3.142 <math|\<approx\>> 22/7:

  <\verbatim>
    \<gtr\> rational_approx_epsilon .01 pi;

    22L%7L

    \<gtr\> abs (ans - pi);

    0.00126448926734968
  </verbatim>

  <label|example-43><with|font-series|bold|Example 43> The golden ratio
  <math|\<phi\>> = (1 + <math|<sqrt|>>5) / 2 <math|\<approx\>> 1.618:

  <\verbatim>
    \<gtr\> let phi = (1 + sqrt 5) / 2;

    \<gtr\> rational_approx_epsilon .001 phi;

    55L%34L

    \<gtr\> abs (ans - phi);

    0.000386929926365465
  </verbatim>

  <\description>
    <item*|rational::rational_approxs_epsilon <math|\<varepsilon\>>
    r<label|rational::rational-approxs-epsilon>>Produce a list of ever better
    rational approximations to r (usually a double) that is eventually
    <math|\<varepsilon\>>-close. (<math|\<varepsilon\>> \<gtr\> 0.)
  </description>

  <with|font-series|bold|Example 44> Rational approximations to
  <math|\<pi\>>:

  <\verbatim>
    \<gtr\> rational_approxs_epsilon .0001 pi;

    [3L%1L,25L%8L,47L%15L,69L%22L,91L%29L,113L%36L,135L%43L,157L%50L,179L%57L,

    201L%64L,223L%71L,245L%78L,267L%85L,289L%92L,311L%99L,333L%106L]
  </verbatim>

  <with|font-series|bold|Example 45> Rational approximations to the golden
  ratio <math|\<phi\>>; these approximations are always reverse consecutive
  Fibonacci numbers (from f1: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...):

  <\verbatim>
    \<gtr\> rational_approxs_epsilon .0001 phi;

    [1L%1L,3L%2L,8L%5L,21L%13L,55L%34L,144L%89L]
  </verbatim>

  (The symbol phi was defined in <hlink|Example 43|#example-43>.)

  <\description>
    <item*|rational::rational_interval_epsilon <math|\<varepsilon\>>
    r<label|rational::rational-interval-epsilon>>Find the least complex (see
    <hlink|Complexity Extrema|#complexity-extrema>) rational interval
    containing r (usually a double) that is <math|\<varepsilon\>>-small. That
    is find the least complex (see <hlink|Complexity
    Extrema|#complexity-extrema>) q1 <math|\<leq\>> q2 such that r
    <math|\<in\>> [q1, q2] and q2 - q1 <math|\<leq\>> <math|\<varepsilon\>>.
    (<math|\<varepsilon\>> \<gtr\> 0.)
  </description>

  <with|font-series|bold|Example 46> Rational interval surrounding
  <math|\<pi\>>:

  <\verbatim>
    \<gtr\> let i_Pi = rational_interval_epsilon .01 pi;

    \<gtr\> i_Pi;

    interval::Ivl (47L%15L) (22L%7L)

    \<gtr\> double (lower i_Pi); pi; double (upper i_Pi);

    3.13333333333333

    3.14159265358979

    3.14285714285714
  </verbatim>

  (The functions lower and upper are described in <hlink|Interval
  Constructors and `Deconstructors'|#interval-constructors-and-deconstructors>.)

  <with|font-series|bold|Example 47> Rational interval surrounding the golden
  ratio <math|\<phi\>>:

  <\verbatim>
    \<gtr\> rational_interval_epsilon .001 phi;

    interval::Ivl (55L%34L) (89L%55L)

    \<gtr\> #ans;

    1L%1870L
  </verbatim>

  (The symbol phi was defined in <hlink|Example 43|#example-43>. The function
  <verbatim|#> is described in <hlink|Interval Maths|#interval-maths>.)

  <subsubsection|Best Approximation with Bounded
  Denominator<label|best-approximation-with-bounded-denominator>>

  <\description>
    <item*|rational::rational_approx_max_den maxDen
    r<label|rational::rational-approx-max-den>>Find the closest rational
    approximation to r (usually a double) that has a denominator no greater
    than maxDen. (maxDen \<gtr\> 0).
  </description>

  <with|font-series|bold|Example 48> Rational approximation to <math|\<pi\>>:

  <\verbatim>
    \<gtr\> rational_approx_max_den 10 pi;

    22L%7L
  </verbatim>

  <with|font-series|bold|Example 49> Rational approximation to the golden
  ratio <math|\<phi\>>:

  <\verbatim>
    \<gtr\> rational_approx_max_den 1000 phi;

    1597L%987L
  </verbatim>

  (The symbol phi was defined in <hlink|Example 43|#example-43>.)

  <\description>
    <item*|rational::rational_approxs_max_den maxDen
    r<label|rational::rational-approxs-max-den>>Produce a list of ever better
    rational approximations to r (usually a double) while the denominator is
    bounded by maxDen (maxDen \<gtr\> 0).
  </description>

  <with|font-series|bold|Example 50> Rational approximations to
  <math|\<pi\>>:

  <\verbatim>
    \<gtr\> rational_approxs_max_den 100 pi;

    [3L%1L,25L%8L,47L%15L,69L%22L,91L%29L,113L%36L,135L%43L,157L%50L,179L%57L,

    201L%64L,223L%71L,245L%78L,267L%85L,289L%92L,311L%99L]
  </verbatim>

  <with|font-series|bold|Example 51> Rational approximations to the golden
  ratio <math|\<phi\>>:

  <\verbatim>
    \<gtr\> rational_approxs_max_den 100 phi;

    [1L%1L,3L%2L,8L%5L,21L%13L,55L%34L,144L%89L]
  </verbatim>

  (The symbol phi was defined in <hlink|Example 43|#example-43>.)

  <\description>
    <item*|rational::rational_interval_max_den maxDen
    r<label|rational::rational-interval-max-den>>Find the smallest rational
    interval containing r (usually a double) that has endpoints with
    denominators no greater than maxDen (maxDen \<gtr\> 0).
  </description>

  <with|font-series|bold|Example 52> Rational interval surrounding
  <math|\<pi\>>:

  <\verbatim>
    \<gtr\> let i_Pi = rational_interval_max_den 100 pi ; i_Pi;

    interval::Ivl (311L%99L) (22L%7L)

    \<gtr\> double (lower i_Pi); pi; double (upper i_Pi);

    3.14141414141414

    3.14159265358979

    3.14285714285714
  </verbatim>

  <with|font-series|bold|Example 53> Rational interval surrounding the golden
  ratio <math|\<phi\>>:

  <\verbatim>
    \<gtr\> rational_interval_max_den 1000 phi;

    interval::Ivl (987L%610L) (1597L%987L)
  </verbatim>

  (The symbol phi was defined in <hlink|Example 43|#example-43>.)

  To approximate for a particular (rather than bounded) denominator, use
  round to multiple instead (see <hlink|Rounding to
  Multiples|#rounding-to-multiples>).

  <subsection|Decomposition<label|decomposition>>

  There is more than one way to `decompose' a rational number into its
  `components'. It might be split into an integer and a fraction part \V see
  <hlink|Integer and Fraction Parts|#integer-and-fraction-parts>; or sign and
  absolute value \V see <hlink|Absolute Value and
  Sign|#absolute-value-and-sign>; or numerator and denominator \V see
  <hlink|`Deconstructors'|#deconstructors>.

  <subsection|Continued Fractions<label|continued-fractions>>

  <subsubsection|Introduction>

  In ``pure-rational'', a continued fraction a<textsubscr|0> + (1 /
  (a<textsubscr|1> + (1 / (a<textsubscr|2> + <math|\<cdots\>> + 1 /
  a<textsubscr|n>)))) where <math|\<forall\>>i \<gtr\> 0 <math|\<bullet\>>
  a<textsubscr|i> <math|\<neq\>> 0, is represented by [a<textsubscr|0>,
  a<textsubscr|1>, a<textsubscr|2>, ... , a<textsubscr|n>].

  A `simple' continued fraction is one in which <math|\<forall\>>i
  <math|\<bullet\>> a<textsubscr|i> <math|\<in\>> <with|font-series|bold|Z>
  and <math|\<forall\>>i \<gtr\> 0 <math|\<bullet\>> a<textsubscr|i> \<gtr\>
  0.

  Simple continued fractions for rationals are not quite unique since
  [a<textsubscr|0>, a<textsubscr|1>, ... , a<textsubscr|n>, 1] =
  [a<textsubscr|0>, a<textsubscr|1>, ... , a<textsubscr|n+1>]. We will refer
  to these as the `non-standard' and `standard' forms, respectively. The
  following functions return the standard form.

  <subsubsection|Generating Continued Fractions<label|generating-continued-fractions>>

  <paragraph|Exact<label|exact>>

  <\description>
    <item*|rational::continued_fraction q<label|rational::continued-fraction>>Find
    `the' (exact) continued fraction of a rational (including, trivially,
    integer) value q.
  </description>

  <with|font-series|bold|Example 54> The rational 1234/1001:

  <\verbatim>
    \<gtr\> continued_fraction (1234%1001);

    [1L,4L,3L,2L,1L,1L,1L,8L]

    \<gtr\> evaluate_continued_fraction ans;

    1234L%1001L
  </verbatim>

  <paragraph|Inexact<label|inexact>>

  <\description>
    <item*|rational::continued_fraction_max_terms n
    r<label|rational::continued-fraction-max-terms>>Find up to n initial
    terms of continued fraction of the value r with the `remainder', if any,
    in the final element. (If continued_fraction_max_terms n r returns a list
    of length n or less, then the result is exact.)
  </description>

  <with|font-series|bold|Example 55> First 5 terms of the continued fraction
  for the golden ratio <math|\<phi\>>:

  <\verbatim>
    \<gtr\> continued_fraction_max_terms 5 phi;

    \ \ [1.0,1.0,1.0,1.0,1.0,1.61803398874989]

    \<gtr\> evaluate_continued_fraction ans;

    1.61803398874989
  </verbatim>

  (The symbol phi was defined in <hlink|Example 43|#example-43>.)

  <\description>
    <item*|rational::continued_fraction_epsilon <math|\<varepsilon\>>
    r<label|rational::continued-fraction-epsilon>>Find enough of the initial
    terms of a continued fraction to within <math|\<varepsilon\>> of the
    value r with the `remainder', if any, in the final element.
  </description>

  <with|font-series|bold|Example 56> First few terms of the value
  <math|<sqrt|>>2:

  <\verbatim>
    \<gtr\> continued_fraction_epsilon .001 (sqrt 2);

    [1.0,2.0,2.0,2.0,2.0,2.41421356237241]

    \<gtr\> map double (convergents ans);

    [1.0,1.5,1.4,1.41666666666667,1.41379310344828,1.41421356237309]
  </verbatim>

  <subsubsection|Evaluating Continued Fractions<label|evaluating-continued-fractions>>

  <\description>
    <item*|rational::evaluate_continued_fraction
    aa<label|rational::evaluate-continued-fraction>>Fold a continued fraction
    aa into the value it represents. This function is not limited to simple
    continued fractions. (Exact simple continued fractions are folded into a
    rational.)
  </description>

  <with|font-series|bold|Example 57> The continued fraction [1, 2, 3, 4] and
  the non-standard form [4, 3, 2, 1]:

  <\verbatim>
    \<gtr\> evaluate_continued_fraction [1,2,3,4];

    43L%30L

    \<gtr\> continued_fraction ans;

    [1L,2L,3L,4L]

    \<gtr\> evaluate_continued_fraction [4,3,2,1];

    43L%10L

    \<gtr\> continued_fraction ans;

    [4L,3L,3L]
  </verbatim>

  <paragraph|Convergents<label|convergents>>

  <\description>
    <item*|rational::convergents aa<label|rational::convergents>>Calculate
    the convergents of the continued fraction aa. This function is not
    limited to simple continued fractions.
  </description>

  <with|font-series|bold|Example 58> Convergents of a continued fraction
  approximation of the value <math|<sqrt|>>2:

  <\verbatim>
    \<gtr\> continued_fraction_max_terms 5 (sqrt 2);

    [1.0,2.0,2.0,2.0,2.0,2.41421356237241]

    \<gtr\> convergents ans;

    [1.0,1.5,1.4,1.41666666666667,1.41379310344828,1.41421356237309]
  </verbatim>

  <subsection|Rational Complex Numbers<label|rational-complex-numbers>>

  Pure together with <verbatim|rational.pure> provide various types of
  number, including integers (<with|font-series|bold|Z>), doubles
  (<with|font-series|bold|R>, roughly), complex numbers
  (<with|font-series|bold|C>) and Gaussian integers
  (<with|font-series|bold|Z>[i]), rationals (<with|font-series|bold|Q>) and
  rational complex numbers (<with|font-series|bold|Q>[i]).

  Functions concerning `complex numbers' are named with `comp', whereas
  functions concerning `complexity' (see <hlink|Complexity|#complexity>) are
  named with `cplx'.

  <subsubsection|Rational Complex Constructors and
  `Deconstructors'<label|rational-complex-constructors-and-deconstructors>>

  Complex numbers can have rational parts.

  <with|font-series|bold|Example 59> Forming a rational complex:

  <\verbatim>
    \<gtr\> 1 +: 1 * (1%2);

    1+:1L%2L

    \<gtr\> ans * ans;

    3L%4L+:1L%1L
  </verbatim>

  And rational numbers can be given complex parts.

  <with|font-series|bold|Example 60> Complex rationals and complicated
  rationals:

  <\verbatim>
    \<gtr\> (1 +: 2) % (3 +: 4);

    11L%25L+:2L%25L

    \<gtr\> ans * (3 +: 4);

    1L%1L+:2L%1L

    \<gtr\> ((4%1) * (0 +: 1)) % 2;

    0L%1L+:2L%1L

    \<gtr\> ((4%1) * (0 +: 1)) % (1%2);

    0L%1L+:8L%1L

    \<gtr\> ((4%1) * (0 +: 1)) % (1 + (1%2) * (0 +: 1));

    8L%5L+:16L%5L

    \<gtr\> ans * (1+(1%2) * (0 +: 1));

    0L%1L+:4L%1L

    \<gtr\> ((4%1) * (0 +: 1)) / (1 + (1%2) * (0 +: 1));

    1.6+:3.2
  </verbatim>

  The various parts of a complex rational may be deconstructed using
  combinations of num and den and the standard functions re and im.

  Thus, taking real and imaginary parts first, a rational complex number may
  be considered to be (x<textsubscr|n> / x<textsubscr|d>) + (y<textsubscr|n>
  / y<textsubscr|d>) * i with x<textsubscr|n>, x<textsubscr|d>,
  y<textsubscr|n>, y<textsubscr|d> <math|\<in\>> <with|font-series|bold|Z>.

  A rational complex number may also be decomposed into its `numerator' and
  `denominator', where these are both integral complex numbers, or `Gaussian
  integers', and the denominatoris a minimal choice in some sense.

  One way to do this is so that the denominator is the minimum positive
  integer. The denominator is a complex number with zero imaginary part.

  Thus, taking numerator and denominator parts first, a rational complex
  number may be considered to be (n<textsubscr|x> + n<textsubscr|y> * i) / (d
  + 0 * i) with n<textsubscr|x>, n<textsubscr|y>, d <math|\<in\>>
  <with|font-series|bold|Z>.

  Another way to do this is so that the denominator is a Gaussian integer
  with minimal absolute value. Thus, taking numerator and denominator parts
  first, a rational complex number may be considered to be (n<textsubscr|x> +
  n<textsubscr|y> * i) / (d<textsubscr|x> + d<textsubscr|y> * i) with
  n<textsubscr|x>, n<textsubscr|y>, d<textsubscr|x>, d<textsubscr|y>
  <math|\<in\>> <with|font-series|bold|Z>.

  The d<textsubscr|x>, d<textsubscr|y> are not unique, but can be chosen such
  that d<textsubscr|x> \<gtr\> 0 and either \|d<textsubscr|y>\| \<less\>
  d<textsubscr|x> or d<textsubscr|y> = d<textsubscr|x> \<gtr\> 0.

  <\description>
    <item*|rational::num_den_nat c<label|rational::num-den-nat>>given a
    complex rational or integer c, returns a pair (n, d) containing an
    integral complex (Gaussian integral) numerator n, and the smallest
    natural (i.e. positive integral real) complex denominator d, i.e. a
    complex number where <math|<with|math-font|Euler|R>>(d) <math|\<in\>>
    <with|font-series|bold|Z>, <math|<with|math-font|Euler|R>>(d) \<gtr\> 0,
    <math|<with|math-font|Euler|I>>(d) = 0; i.e. the numerator and
    denominator of one `normalised' form of c.

    This is an inverse (up to equivalence) of rational as defined on integral
    complex pairs (see <hlink|Constructors|#constructors>).
  </description>

  <\description>
    <item*|rational::num_den_gauss c<label|rational::num-den-gauss>>given a
    complex rational or integer c, returns a pair (n, d) containing an
    integral complex (Gaussian integral) numerator n, and an absolutely
    smallest integral complex denominator d chosen s.t.
    <math|<with|math-font|Euler|R>>(d),=(d) <math|\<in\>>
    <with|font-series|bold|Z>, <math|<with|math-font|Euler|R>>(d) \<gtr\> 0,
    and either \|<math|<with|math-font|Euler|R>>(d)\| \<less\>
    <math|<with|math-font|Euler|I>>(d) or <math|<with|math-font|Euler|R>>(d)
    = <math|<with|math-font|Euler|I>>(d) \<gtr\> 0; i.e. the numerator and
    denominator of another `normalised' form of c.

    This is an inverse (up to equivalence) of rational as defined on integral
    complex pairs (see <hlink|Constructors|#constructors>).
  </description>

  <\description>
    <item*|rational::num_den c>synonymous with num_den_gauss.

    This is an inverse (up to equivalence) of rational as defined on integer
    pairs (see <hlink|Constructors|#constructors>).
  </description>

  <\description>
    <item*|num c>given a complex rational or integer c, returns just the
    numerator of the normalised form of c given by num_den c.
  </description>

  <\description>
    <item*|den c>given a complex rational or integer c, returns just the
    denominator of the normalised form of c given by num_den c.
  </description>

  <with|font-series|bold|Example 61> Rational complex number deconstruction:

  <\verbatim>
    \<gtr\> let cq = (1+2*i)%(3+3*i); cq;

    1L%2L+:1L%6L

    \<gtr\> (re cq, im cq);

    1L%2L,1L%6L

    \<gtr\> (num . re) cq;

    1L

    \<gtr\> (den . re) cq;

    2L

    \<gtr\> (num . im) cq;

    1L

    \<gtr\> (den . im) cq;

    6L

    \<gtr\> let (n_nat,d_nat) = num_den_nat cq;

    \<gtr\> (n_nat, d_nat);

    3+:1,6+:0

    \<gtr\> n_nat % d_nat;

    1L%2L+:1L%6L

    \<gtr\> abs d_nat;

    6.0

    \<gtr\> let (n, d) = num_den_gauss cq; (n, d);

    1L+:2L,3L+:3L

    \<gtr\> let (n,d) = num_den cq; (n, d);

    1L+:2L,3L+:3L

    \<gtr\> n % d;

    1L%2L+:1L%6L

    \<gtr\> abs d;

    4.24264068711928

    \<gtr\> (re . num) cq;

    1L

    \<gtr\> (im . num) cq;

    2L

    \<gtr\> (re . den) cq; //always \<gtr\> 0

    3L

    \<gtr\> (im . den) cq; //always \<less\>= (re.den)

    3L
  </verbatim>

  <subsubsection|Rational Complex Type and Value
  Tests<label|rational-complex-type-and-value-tests>>

  Beware that <verbatim|intcompvalp> and <verbatim|ratcompvapl> may return 1
  even if the value is of complex type with double parts. However, these
  functions may be combined with <verbatim|exactp>.

  <\description>
    <item*|complexp x<label|complexp/rational>>standard function; returns
    whether x is of complex type.
  </description>

  <\description>
    <item*|compvalp x<label|compvalp/rational>>standard function; returns
    whether x has a complex value (<math|\<in\>> <with|font-series|bold|C> =
    <with|font-series|bold|R>[i]).
  </description>

  <\description>
    <item*|rational::ratcompvalp x<label|rational::ratcompvalp>>returns
    whether x has a rational complex value (<math|\<in\>>
    <with|font-series|bold|Q>[i]).
  </description>

  <\description>
    <item*|rational::intcompvalp x<label|rational::intcompvalp>>returns
    whether x has an integral complex value (<math|\<in\>>
    <with|font-series|bold|Z>[i]), i.e. a Gaussian integer value.
  </description>

  <with|font-series|bold|Example 62> Rational complex number value tests:

  <\verbatim>
    \<gtr\> let l = [9, 9%1, 9%2, 4.5, sqrt 2, 1+:1, 1%2+:1, 0.5+:1, inf,
    nan];

    \<gtr\> map exactp l;

    [1,1,1,0,0,1,1,0,0,0]

    \<gtr\> map inexactp l;

    [0,0,0,1,1,0,0,1,1,1]

    \<gtr\> map complexp l;

    [0,0,0,0,0,1,1,1,0,0]

    \<gtr\> map compvalp l;

    [1,1,1,1,1,1,1,1,1,1]

    \<gtr\> map (\\x -\<gtr\> (exactp x and compvalp x)) l; // "has exact
    complex value"

    [1,1,1,0,0,1,1,0,0,0]

    \<gtr\> map ratcompvalp l;

    [1,1,1,1,1,1,1,1,0,0]

    \<gtr\> map (\\x -\<gtr\> (exactp x and ratcompvalp x)) l;

    [1,1,1,0,0,1,1,0,0,0]

    \<gtr\> map intcompvalp l;

    [1,1,0,0,0,1,0,0,0,0]

    \<gtr\> map (\\x -\<gtr\> (exactp x and intcompvalp x)) l;

    [1,1,0,0,0,1,0,0,0,0]

    \<gtr\> map ratvalp l;

    [1,1,1,1,1,0,0,0,0,0]

    \<gtr\> map (\\x -\<gtr\> (exactp x and ratvalp x)) l;

    [1,1,1,0,0,0,0,0,0,0]

    \<gtr\> map intvalp l; // for comparison

    [1,1,0,0,0,0,0,0,0,0]

    \<gtr\> map (\\x -\<gtr\> (exactp x and intvalp x)) l;

    [1,1,0,0,0,0,0,0,0,0]

    \;

    See `Type and Value Tests`_ for some details of rational type and value
    tests.
  </verbatim>

  <subsubsection|Rational Complex Arithmetic Operators and
  Relations<label|rational-complex-arithmetic-operators-and-relations>>

  The standard arithmetic operators (+), (-), (*), (/), (%), (), (==) and
  (<math|\<sim\>>=) are overloaded to have at least one complex and/or
  rational operand, but (\<less\>), (\<less\>=), (\<gtr\>), (\<gtr\>=) are
  not, as complex numbers are unordered.

  <with|font-series|bold|Example 63> Rational complex arithmetic:

  <\verbatim>
    \<gtr\> let w = 1%2 +: 3%4;

    \<gtr\> let z = 5%6 +: 7%8;

    \<gtr\> w + z;

    4L%3L+:13L%8L

    \<gtr\> w % z;

    618L%841L+:108L%841L

    \<gtr\> w / z;

    0.734839476813318+:0.128418549346017

    \<gtr\> w ^ 2;

    -0.3125+:0.75

    \<gtr\> w == z;

    0

    \<gtr\> w == w;

    1
  </verbatim>

  <subsubsection|Rational Complex Maths<label|rational-complex-maths>>

  The standard functions <verbatim|re> and <verbatim|im> work with rational
  complex numbers (see <hlink|Rational Complex Constructors and
  `Deconstructors'|#rational-complex-constructors-and-deconstructors>).

  The standard functions <verbatim|polar>, <verbatim|abs> and <verbatim|arg>
  work with rational complex numbers, but the results are inexact.

  <with|font-series|bold|Example 64> Rational complex maths:

  <\verbatim>
    \<gtr\> polar (1%2+:1%2);

    0.707106781186548\<less\>:0.785398163397448

    \<gtr\> abs (4%2+:3%2);

    2.5

    \<gtr\> arg (-1%1);

    3.14159265358979
  </verbatim>

  There are some additional useful functions for calculating with rational
  complex numbers and more general mathematical values.

  <\description>
    <item*|rational::norm_gauss c<label|rational::norm-gauss>>returns the
    Gaussian norm \|\|c\|\| of any complex (or real) number c; this is the
    square of the absolute value, and is returned as an (exact) integer.
  </description>

  <\description>
    <item*|rational::div_mod_gauss n d<label|rational::div-mod-gauss>>performs
    Gaussian integer division, returning (q, r) where q is a (not always
    unique) quotient, and r is a (not always unique) remainder. q and r are
    such that n = q * d + r and \|\|r\|\| \<less\> \|\|d\|\| (equivalently,
    \|r\| \<less\> \|d\|).
  </description>

  <\description>
    <item*|rational::n_div_gauss d<label|rational::n-div-gauss>>returns just
    a quotient from Gaussian integer division as produced by div_mod_gauss n
    d.
  </description>

  <\description>
    <item*|rational::n_mod_gauss d<label|rational::n-mod-gauss>>returns just
    a remainder from Gaussian integer division as produced by div_mod_gauss n
    d.
  </description>

  <\description>
    <item*|rational::gcd_gauss c1 c2<label|rational::gcd-gauss>>returns a GCD
    G of the Gaussian integers c1,c2. This is chosen so that s.t.
    <math|<with|math-font|Euler|R>>(G) \<gtr\> 0, and either
    \|<math|<with|math-font|Euler|I>>(G)\| \<less\>
    <math|<with|math-font|Euler|R>>(G) or <math|<with|math-font|Euler|I>>(G)
    = <math|<with|math-font|Euler|R>>(G) \<gtr\> 0;
  </description>

  <\description>
    <item*|rational::euclid_gcd zerofun modfun x
    y<label|rational::euclid-gcd>>returns a (non-unique) GCD calculated by
    performing the Euclidean algorithm on the values x and y (of any type)
    where zerofun is a predicate for equality to 0, and modfun is a binary
    modulus (remainder) function.
  </description>

  <\description>
    <item*|rational::euclid_alg zerofun divfun x
    y<label|rational::euclid-alg>>returns (g, a, b) where the g is a
    (non-unique) GCD and a, b are (arbitrary, non-unique) values such that a
    * x + b * y = g calculated by performing the generalised Euclidean
    algorithm on the values x and y (of any type) where zerofun is a
    predicate for equality to 0, and div is a binary quotient function.
  </description>

  <with|font-series|bold|Example 65> More rational complex and other maths:

  <\verbatim>
    \<gtr\> norm_gauss (1 +: 3);

    10

    \<gtr\> abs (1 +: 3);

    3.16227766016838

    \<gtr\> norm_gauss (-5);

    25

    \<gtr\> let (q, r) = div_mod_gauss 100 (12 +: 5);

    \<gtr\> (q, r);

    7L+:-3L,1L+:1L

    \<gtr\> q * (12 +: 5) + r;

    100L+:0L

    \<gtr\> 100 div_gauss (12 +: 5);

    7L+:-3L

    \<gtr\> 100 mod_gauss (12 +: 5);

    1L+:1L

    \<gtr\> div_mod_gauss 23 5;

    5L+:0L,-2L+:0L

    \<gtr\> gcd_gauss (1 +: 2) (3 +: 4);

    1L+:0L

    \<gtr\> gcd_gauss 25 15;

    5L+:0L

    \<gtr\> euclid_gcd (==0) (mod_gauss) (1+: 2) (3 +: 4);

    1L+:0L

    \<gtr\> euclid_gcd (==0) (mod) 25 15;

    5

    \<gtr\> let (g, a, b) = euclid_alg (==0) (div_gauss) (1 +: 2) (3 +: 4);
    g;

    1L+:0L

    \<gtr\> (a, b);

    -2L+:0L,1L+:0L

    \<gtr\> a * (1 +: 2) + b * (3 +: 4);

    1L+:0L

    \<gtr\> let (g, a, b) = euclid_alg (==0) (div) 25 15; g;

    5

    \<gtr\> (a, b);

    -1,2

    \<gtr\> a * 25 + b * 15;

    5
  </verbatim>

  <subsubsection|Rational Complex Type Simplification<label|rational-complex-type-simplification>>

  <\description>
    <item*|rational::comp_simplify c<label|rational::comp-simplify>>returns q
    with complex numbers simplified to reals, if possible.
  </description>

  <\description>
    <item*|rational::ratcomp_simplify c<label|rational::ratcomp-simplify>>returns
    q with rationals simplified to integers, and complex numbers simplified
    to reals, if possible.
  </description>

  <with|font-series|bold|Example 66> Rational complex number type
  simplification:

  <\verbatim>
    \<gtr\> let l = [9+:1, 9%1+:1, 9%2+:1, 4.5+:1, 9%1+:0, 9%2+:0, 4.5+:0.0];

    \<gtr\> l;

    [9+:1,9L%1L+:1,9L%2L+:1,4.5+:1,9L%1L+:0,9L%2L+:0,4.5+:0.0]

    \<gtr\> map comp_simplify l;

    [9+:1,9L%1L+:1,9L%2L+:1,4.5+:1,9L%1L,9L%2L,4.5+:0.0]

    \<gtr\> map ratcomp_simplify l;

    [9+:1,9+:1,9L%2L+:1,4.5+:1,9,9L%2L,4.5+:0.0]

    \;

    See `Rational Type Simplification`_ for some details of rational type

    simplification.
  </verbatim>

  <subsection|String Formatting and Evaluation<label|string-formatting-and-evaluation>>

  <subsubsection|The Naming of the String Conversion
  Functions<label|the-naming-of-the-string-conversion-functions>>

  There are several families of functions for converting between strings and
  rationals.

  The functions that convert from rationals to strings have names based on
  that of the standard function <verbatim|str>. The <verbatim|str_*>
  functions convert to a formatted string, and depend on a `format structure'
  parameter (see <hlink|Internationalisation and Format
  Structures|#internationalisation-and-format-structures>). The
  <verbatim|strs_*> functions convert to a tuple of string fragments.

  The functions that convert from strings to rationals have names based on
  that of the standard function <verbatim|eval> (<verbatim|val> in Q). The
  <verbatim|val_*> functions convert from a formatted string, and depend on a
  format structure parameter. The <verbatim|sval_*> functions convert from a
  tuple of string fragments.

  There are also <verbatim|join_*> and <verbatim|split_*> functions to join
  string fragments into formatted strings, and to split formatted strings
  into string fragments, respectively; these depend on a format structure
  parameter. These functions are not always invertible, because some of the
  functions reduce an error term to just a sign, e.g.
  <hlink|<with|font-family|tt|str_real_approx_dp>|#rational::str-real-approx-dp>
  may round a value. Thus sometimes the <verbatim|join_*> and
  <verbatim|split_*> pairs, and the <verbatim|str_*> and <verbatim|val_*>
  pairs are not quite mutual inverses.

  <subsubsection|Internationalisation and Format
  Structures<label|internationalisation-and-format-structures>>

  Many of the string formatting functions in the following sections are
  parameterised by a `format structure'. Throughout this document, the formal
  parameter for the format structure will be <verbatim|fmt>. This is simply a
  record mapping some string `codes' to functions as follows. The functions
  are mostly from strings to a string, or from a string to a tuple of
  strings.

  <\description>
    <item*|<with|font-family|tt|"sm">>a function mapping a sign and an
    unsigned mantissa (or integer) strings to a signed mantissa (or integer)
    string.

    <item*|<with|font-family|tt|"se">>a function mapping a sign and an
    unsigned exponent string to a signed exponent string.

    <item*|<with|font-family|tt|"-s">>a function mapping a signed number
    string to a pair containing a sign and the unsigned number string.

    <item*|<with|font-family|tt|"gi">>a function mapping an integer
    representing the group size and an integer string to a grouped integer
    string.

    <item*|<with|font-family|tt|"gf">>a function mapping an integer
    representing the group size and a fraction-part string to a grouped
    fraction-part string.

    <item*|<with|font-family|tt|"-g">>a function mapping a grouped number
    string to an ungrouped number string.

    <item*|<with|font-family|tt|"zi">>a function mapping an integer number
    string to a number string. The input string representing zero integer
    part is ``'', which should be mapped to the desired representation of
    zero. All other number strings should be returned unaltered.

    <item*|<with|font-family|tt|"zf">>a function mapping a fraction-part
    number string to a number string. The input string representing zero
    fraction part is ``'', which should be mapped to the desired
    representation of zero. All other number strings should be returned
    unaltered.

    <item*|<with|font-family|tt|"ir">>a function mapping initial and
    recurring parts of a fraction part to the desired format.

    <item*|<with|font-family|tt|"-ir">>a function mapping a formatted
    fraction part to the component initial and recurring parts.

    <item*|<with|font-family|tt|"if">>a function mapping an integer string
    and fraction part string to the radix-point formatted string.

    <item*|<with|font-family|tt|"-if">>a function mapping a radix-point
    formatted string to the component integer fraction part strings

    <item*|<with|font-family|tt|"me">>a function mapping a mantissa string
    and exponent string to the formatted exponential string.

    <item*|<with|font-family|tt|"-me">>a function mapping a formatted
    exponential string to the component mantissa and exponent strings.

    <item*|<with|font-family|tt|"e">>a function mapping an `error' number
    (not string) and a number string to a formatted number string indicating
    the sign of the error.

    <item*|<with|font-family|tt|"-e">>a function mapping a formatted number
    string indicating the sign of the error to the component `error' string
    (not number) and number strings.
  </description>

  Depending upon the format structure, some parameters of some of the
  functions taking a format structure may have no effect. For example, an
  <verbatim|intGroup> parameter specifying the size of the integer digit
  groups will have no effect if the integer group separator is the empty
  string.

  <\description>
    <item*|rational::create_format options<label|rational::create-format>>is
    a function that provides an easy way to prepare a `format structure' from
    the simpler `options structure'. The options structure is another record,
    but from more descriptive strings to a string or tuple of strings.
  </description>

  For example, <verbatim|format_uk> is generated from <verbatim|options_uk>
  as follows:

  <\verbatim>
    public options_uk;

    const options_uk =

    \ \ {

    \ \ \ \ "sign" =\<gtr\> ("-","",""), \ \ \ \ \ \ \ \ \ \ \ \ //
    alternative: ("-"," ","+")

    \ \ \ \ "exponent sign" =\<gtr\> ("-","",""), \ \ \ // alternative:
    ("-","","+")

    \ \ \ \ "group separator" =\<gtr\> ",", \ \ \ \ \ \ \ \ \ // might be " "
    or "." or "'" elsewhere

    \ \ \ \ "zero" =\<gtr\> "0",

    \ \ \ \ "radix point" =\<gtr\> ".", \ \ \ \ \ \ \ \ \ \ \ \ \ // might be
    "," elsewhere

    \ \ \ \ "fraction group separator" =\<gtr\> ",",

    \ \ \ \ "fraction zero" =\<gtr\> "0", \ \ \ \ \ \ \ \ \ \ \ //
    alternative: ""

    \ \ \ \ "recur brackets" =\<gtr\> ("[","...]"),

    \ \ \ \ "exponent" =\<gtr\> "*10^", \ \ \ \ \ \ \ \ \ \ \ \ \ // (poor)
    alternative: "e"

    \ \ \ \ "error sign" =\<gtr\> ("-","","+"),

    \ \ \ \ "error brackets" =\<gtr\> ("(",")")

    \ \ };

    \;

    public format_uk;

    const format_uk = create_format options_uk;
  </verbatim>

  The exponent string need not depend on the radix, as the numerals for the
  number radix in that radix are always ``10''.

  Beware of using ``e'' or ``E'' as an exponent string as these have the
  potential of being treated as digits in, e.g., hexadecimal.

  Format structures do not have to be generated via create format; they may
  also be constructed directly.

  <subsubsection|Digit Grouping<label|digit-grouping>>

  Some functions take <verbatim|group> parameters. A value of 0 means ``don't
  group''.

  <subsubsection|Radices<label|radices>>

  The functions that produce a decimal expansion take a Radix argument. The
  fraction parts are expanded in that radix (or `base'), in addition to the
  integer parts. The parameter Radix is not restricted to the usual {2, 8,
  10, 16}, but may be any integer from 2 to 36; the numerals (`digits') are
  chosen from [``0'', ... , ``9'', ``A'', ... , ``Z'']. The letter-digits are
  always upper case.

  The functions do not attach a prefix (such as ``0x'' for hexadecimal) to
  the resulting string.

  <subsubsection|Error Terms<label|error-terms>>

  Some functions return a value including an `error' term (in a tuple) or
  sign (at the end of a string). Such an error is represents what the next
  digit would be as a fraction of the radix.

  <with|font-series|bold|Example 67> Error term in the tuple of string
  `fragments':

  <\verbatim>
    \<gtr\> strs_real_approx_sf 10 floor 3 (234567%100000);

    "+","2","34",567L%1000L

    \<gtr\> strs_real_approx_sf 10 ceil 3 (234567%100000);

    "+","2","35",(-433L)%1000L
  </verbatim>

  (See the function <hlink|<with|font-family|tt|strs_real_approx_sf>|#rational::strs-real-approx-sf>.)

  In strings, only the sign of the error term is given. A ``+'' should be
  read as ``and a bit more''; ``-'' as ``but a bit less''.

  <with|font-series|bold|Example 68> Error sign in the string:

  <\verbatim>
    \<gtr\> str_real_approx_sf format_uk 10 0 0 floor 3 (234567%100000);

    "2.34(+)"

    \<gtr\> str_real_approx_sf format_uk 10 0 0 ceil 3 (234567%100000);

    "2.35(-)"
  </verbatim>

  (See the function <hlink|<with|font-family|tt|str_real_approx_sf>|#rational::str-real-approx-sf>.)

  <subsection|Q \<less\>-\<gtr\> Fraction String (``i +
  n/d'')<label|q-fraction-string-i-n-d>>

  <subsubsection|Formatting to Fraction Strings<label|formatting-to-fraction-strings>>

  <\description>
    <item*|rational::str_vulgar q<label|rational::str-vulgar>>returns a
    String representing the rational (or integer) q in the form

    <\itemize>
      <item>``[-]n/d''
    </itemize>
  </description>

  <\description>
    <item*|rational::str_vulgar_or_int q<label|rational::str-vulgar-or-int>>returns
    a String representing the rational (or integer) q in one of the forms

    <\itemize>
      <item>``[-]n/d''

      <item>``[-]i''
    </itemize>
  </description>

  <\description>
    <item*|rational::str_mixed q<label|rational::str-mixed>>returns a String
    representing the rational (or integer) q in one of the forms

    <\itemize>
      <item>``i + n/d''

      <item>``-(i + n/d)''

      <item>``[-]n/d''

      <item>``[-]i''
    </itemize>
  </description>

  <with|font-series|bold|Example 69> The fraction string representations:

  <\verbatim>
    \<gtr\> let l = iterwhile (\<less\>= 3%2) (+(1%2)) (-3%2);

    \<gtr\> l;

    [(-3L)%2L,(-1L)%1L,(-1L)%2L,0L%1L,1L%2L,1L%1L,3L%2L]

    \<gtr\> map str_vulgar l;

    ["-3L/2L","-1L/1L","-1L/2L","0L/1L","1L/2L","1L/1L","3L/2L"]

    \<gtr\> map str_vulgar_or_int l;

    ["-3L/2L","-1L","-1L/2L","0L","1L/2L","1L","3L/2L"]

    \<gtr\> map str_mixed l;

    ["-(1L+1L/2L)","-1L","-1L/2L","0L","1L/2L","1L","1L+1L/2L"]
  </verbatim>

  These might be compared to the behaviour of the standard function
  <verbatim|str>.

  <\description>
    <item*|str x<label|str/rational>>returns a string representing the value
    x.
  </description>

  <with|font-series|bold|Example 70> The standard function str:

  <\verbatim>
    \<gtr\> map str l;

    ["(-3L)%2L","(-1L)%1L","(-1L)%2L","0L%1L","1L%2L","1L%1L","3L%2L"]
  </verbatim>

  <subsubsection|Evaluation of Fraction Strings<label|evaluation-of-fraction-strings>>

  <\description>
    <item*|rational::val_vulgar strg<label|rational::val-vulgar>>returns a
    rational q represented by the string strg in the form

    <\itemize>
      <item>``[-]n/d''
    </itemize>
  </description>

  Such strings can also be evaluated by the <verbatim|val_mixed> function.

  <\description>
    <item*|rational::val_mixed strg<label|rational::val-mixed>>returns a
    rational q represented by the string strg

    <\itemize>
      <item>``i + n/d''

      <item>``-(i + n/d)''

      <item>``[-]n/d'' \V thus val_mixed strictly extends val_vulgar

      <item>``[-]i''
    </itemize>
  </description>

  <with|font-series|bold|Example 71> Evaluating fraction strings:

  <\verbatim>
    \<gtr\> val_vulgar "-22/7";

    (-22L)%7L

    \<gtr\> val_mixed "1L+5L/6L";

    11L%6L
  </verbatim>

  These might be compared to the behaviour of the standard function eval.

  <\description>
    <item*|eval s<label|eval/rational>>evaluates the string s.
  </description>

  <with|font-series|bold|Example 72> The standard function eval:

  <\verbatim>
    \<gtr\> eval "1+5%6";

    11L%6L

    \<gtr\> eval "1L+5L/6L";

    1.83333333333333
  </verbatim>

  <subsection|Q \<less\>-\<gtr\> Recurring Numeral Expansion String
  (``I.FR'')<label|q-recurring-numeral-expansion-string-i-fr>>

  See <hlink|Internationalisation and Format
  Structures|#internationalisation-and-format-structures> for information
  about the formatting structure to be supplied in the <verbatim|fmt>
  parameter.

  <subsubsection|Formatting to Recurring Expansion
  Strings<label|formatting-to-recurring-expansion-strings>>

  <\description>
    <item*|rational::str_real_recur fmt radix intGroup
    q<label|rational::str-real-recur>>returns a string (exactly) representing
    the rational (or integer) q as base-Radix expansion of one the forms

    <\itemize>
      <item>``[-]int.frac''

      <item>``[-]int.init frac part[smallest recurring frac part ...]''
    </itemize>
  </description>

  Note that there is no fracGroup parameter.

  Beware that the string returned by this function can be very long. The
  length of the recurring part of such a decimal expansion may be up to one
  less than the simplest denominator of q.

  <with|font-series|bold|Example 73> The recurring radix expansion-type
  string representations:

  <\verbatim>
    \<gtr\> str_real_recur format_uk 10 3 (4000001%4); // grouped with commas

    "1,000,000.25"

    \<gtr\> str_real_recur format_uk 10 0 (4000001%4); // no grouping

    "1000000.25"

    \<gtr\> str_real_recur format_uk 10 3 (1000000%3);

    "333,333.[3...]"

    \<gtr\> str_real_recur format_uk 10 3 (1000000%7);

    "142,857.[142857...]"

    \<gtr\> str_real_recur format_uk 10 3 (-1%700);

    "-0.00[142857...]"

    \<gtr\> str_real_recur format_uk 10 3 (127%128);

    "0.9921875"

    \<gtr\> str_real_recur format_uk 2 4 (-127%128);

    "-0.1111111"

    \<gtr\> str_real_recur format_uk 16 4 (127%128);

    "0.FE"

    \<gtr\> str_real_recur format_uk 10 0 (70057%350); // 1%7 + 10001%50;

    "200.16[285714...]"
  </verbatim>

  The function allows expansion to different radices (bases).

  <with|font-series|bold|Example 74> The recurring radix expansion in decimal
  and hexadecimal:

  <\verbatim>
    \<gtr\> str_real_recur format_uk 10 0 (1%100);

    "0.01"

    \<gtr\> str_real_recur format_uk 16 0 (1%100);

    "0.0[28F5C...]"
  </verbatim>

  <with|font-series|bold|Example 75> The recurring radix expansion in
  duodecimal:

  <\verbatim>
    \<gtr\> str_real_recur format_uk 12 0 (1%100);

    "0.0[15343A0B62A68781B059...]"
  </verbatim>

  Note that this bracket notation is not standard in the literature. Usually
  the recurring numerals are indicated by a single dot over the initial and
  final numerals of the recurring part, or an overline over the recurring
  part. For example 1/70 = 0.0

  14285

  7 = 0.0142857 and 1/3 = 0.

  3 = 0.3.

  <\description>
    <item*|rational::strs_real_recur radix
    q<label|rational::strs-real-recur>>returns a quadruple of the four
    strings:

    <\itemize>
      <item>the sign,

      <item>integer part (which is empty for 0),

      <item>initial fraction part

      <item>and recurring fraction part (either and both of which may be
      empty).
    </itemize>
  </description>

  <with|font-series|bold|Example 76> The recurring radix expansion in decimal
  \V the fragments:

  <\verbatim>
    \<gtr\> strs_real_recur 10 (100%7);

    "+","14","","285714"

    \<gtr\> strs_real_recur 10 (-1%700);

    "-","","00","142857"

    \<gtr\> strs_real_recur 10 (70057%350);

    "+","200","16","285714"
  </verbatim>

  This function may be used to also, e.g. format the integer part with
  comma-separated groupings.

  <\description>
    <item*|rational::join_str_real_recur fmt intGroup sign i fracInit
    fracRecur<label|rational::join-str-real-recur>>formats the parts in the
    quadruple returned by <hlink|<with|font-family|tt|strs_real_recur>|#rational::strs-real-recur>
    to the sort of string as returned by <hlink|<with|font-family|tt|str_real_recur>|#rational::str-real-recur>.
  </description>

  <subsubsection|Evaluation of Recurring Expansion
  Strings<label|evaluation-of-recurring-expansion-strings>>

  The <verbatim|str_*> and <verbatim|val_*> functions depend on a `format
  structure' parameter (fmt) such as format uk. Conversions may be performed
  between rationals and differently formatted strings if a suitable
  alternative format structure is supplied. See <hlink|Internationalisation
  and Format Structures|#internationalisation-and-format-structures> for
  information about formatting structures.

  <\description>
    <item*|rational::val_real_recur fmt radix
    strg<label|rational::val-real-recur>>returns the rational q represented
    by the base-radix expansion string strg of one the forms

    <\itemize>
      <item>``[-]int.frac''

      <item>``[-]int.init frac part[recurring frac part ...]''
    </itemize>
  </description>

  <with|font-series|bold|Example 77> Conversion from the recurring radix
  expansion-type string representations:

  <\verbatim>
    \<gtr\> val_real_recur format_uk 10 "-12.345";

    (-2469L)%200L

    \<gtr\> val_real_recur format_uk 10 "0.3";

    3L%10L

    \<gtr\> val_real_recur format_uk 10 "0.[3...]";

    1L%3L

    \<gtr\> val_real_recur format_uk 10 ".333[33...]";

    1L%3L

    \<gtr\> val_real_recur format_uk 10 ".[9...]";

    1L%1L
  </verbatim>

  <\description>
    <item*|rational::sval_real_recur radix sign iStr fracStr
    recurPartStr<label|rational::sval-real-recur>>returns the rational q
    represented by the parts

    <\itemize>
      <item>sign

      <item>integer part

      <item>initial fraction part

      <item>recurring fraction part
    </itemize>
  </description>

  <\description>
    <item*|rational::split_str_real_recur Fmt
    strg<label|rational::split-str-real-recur>>returns a tuple containing the
    parts

    <\itemize>
      <item>sign

      <item>integer part

      <item>initial fraction part

      <item>recurring fraction part of one the forms - ``[-]int.frac'' -
      ``[-]int.init frac part[recurring frac part ...]''
    </itemize>
  </description>

  <subsection|Q \<less\>-\<gtr\> Numeral Expansion String (``I.F
  <math|\<times\>> 10E'')<label|q-numeral-expansion-string-i-f-10e>>

  See <hlink|Internationalisation and Format
  Structures|#internationalisation-and-format-structures> for information
  about the formatting structure to be supplied in the <verbatim|fmt>
  parameter.

  The exponent string ``*10^'' need not depend on the radix, as the numerals
  for the number radix in that radix are always ``10''.

  <subsubsection|Formatting to Expansion Strings<label|formatting-to-expansion-strings>>

  <paragraph|Functions for Fixed Decimal Places<label|functions-for-fixed-decimal-places>>

  <\description>
    <item*|rational::str_real_approx_dp fmt radix intGroup fracGroup roundfun
    dp q<label|rational::str-real-approx-dp>>returns a string representing a
    numeral expansion approximation of q to dp decimal places, using rounding
    mode <verbatim|roundfun> (see <hlink|Rounding to
    Integer|#rounding-to-integer>) <verbatim|roundfun> is usually
    <hlink|<with|font-family|tt|round>|purelib.tm#round> or
    <hlink|<with|font-family|tt|round_unbiased>|#rational::round-unbiased>.
    (dp may be positive, zero or negative; non-positive dps may look
    misleading \V use e.g. scientific notation instead.)
  </description>

  <with|font-series|bold|Example 78> Decimal places:

  <\verbatim>
    \<gtr\> str_real_approx_dp format_uk 10 3 3 round 2 (22%7);

    "3.14(+)"

    \<gtr\> str_real_approx_dp format_uk 10 3 3 ceil 2 (22%7);

    "3.15(-)"
  </verbatim>

  <\description>
    <item*|rational::strs_real_approx_dp radix roundfun do
    q<label|rational::strs-real-approx-dp>>returns a tuple of strings

    <\itemize>
      <item>sign

      <item>integer part

      <item>fraction part
    </itemize>

    representing an expansion to a number of decimal places, together with

    <\itemize>
      <item>the rounding ``error'': a fraction representing the next
      numerals.
    </itemize>
  </description>

  <with|font-series|bold|Example 79> Decimal places \V the fragments:

  <\verbatim>
    \<gtr\> strs_real_approx_dp 10 round 2 (22%7);

    "+","3","14",2L%7L

    \<gtr\> strs_real_approx_dp 10 ceil 2 (22%7);

    "+","3","15",(-5L)%7L
  </verbatim>

  <\description>
    <item*|rational::join_str_real_approx fmt intGroup fracGroup sign i frac
    err<label|rational::join-str-real-approx>>formats the parts in the
    quadruple returned by <hlink|<with|font-family|tt|strs_real_approx_dp>|#rational::strs-real-approx-dp>
    or <hlink|<with|font-family|tt|strs_real_approx_sf>|#rational::strs-real-approx-sf>
    to the sort of string as returned by <hlink|<with|font-family|tt|str_real_approx_dp>|#rational::str-real-approx-dp>
    or <hlink|<with|font-family|tt|str_real_approx_sf>|#rational::str-real-approx-sf>.
  </description>

  <paragraph|Functions for Significant Figures<label|functions-for-significant-figures>>

  <\description>
    <item*|rational::str_real_approx_sf fmt radix intGroup fracGroup roundfun
    sf q<label|rational::str-real-approx-sf>>returns a string representing a
    numeral expansion approximation of q to sf significant figures, using
    rounding mode <verbatim|roundfun> (see <hlink|Rounding to
    Integer|#rounding-to-integer>).
  </description>

  <verbatim|roundfun> is usually <hlink|<with|font-family|tt|round>|purelib.tm#round>
  or <hlink|<with|font-family|tt|round_unbiased>|#rational::round-unbiased>.
  (sf must be positive.)

  <with|font-series|bold|Example 80> Significant figures:

  <\verbatim>
    \<gtr\> str_real_approx_sf format_uk 10 3 3 floor 2 (22%7);

    "3.1(+)"

    \<gtr\> str_real_approx_sf format_uk 10 3 3 floor 2 ((-22)%7);

    "-3.2(+)"
  </verbatim>

  <\description>
    <item*|rational::strs_real_approx_sf radix roundfun sf
    q<label|rational::strs-real-approx-sf>>returns a tuple of strings

    <\itemize>
      <item>sign,

      <item>integer part,

      <item>fraction part, representing an expansion to a number of
      significant figures, together with

      <item>the rounding ``error'': a fraction representing the next numerals
    </itemize>
  </description>

  <\description>
    <item*|rational::join_str_real_approx>see
    <hlink|<with|font-family|tt|join_str_real_approx>|#rational::join-str-real-approx>.
  </description>

  <paragraph|Functions for Scientific Notation and Engineering
  Notation<label|functions-for-scientific-notation-and-engineering-notation>>

  <\description>
    <item*|rational::str_real_approx_sci fmt radix intGroup fracGroup
    roundfun sf q<label|rational::str-real-approx-sci>>returns a string
    expansion with a number of significant figures in scientific notation,
    using rounding mode <verbatim|roundfun> (see <hlink|Rounding to
    Integer|#rounding-to-integer>).

    (sf must be positive; expStep is usually 3, radix is usually 10,
    <verbatim|roundfun> is usually <hlink|<with|font-family|tt|round>|purelib.tm#round>
    or <hlink|<with|font-family|tt|round_unbiased>|#rational::round-unbiased>;
    <hlink|<with|font-family|tt|str_real_approx_sci>|#rational::str-real-approx-sci>
    is equivalent to <hlink|<with|font-family|tt|str_real_approx_eng>|#rational::str-real-approx-eng>
    (below) with expStep = 1.)
  </description>

  <\description>
    <item*|rational::strs_real_approx_sci radix roundfun sf
    q<label|rational::strs-real-approx-sci>>returns a tuple of strings:

    <\itemize>
      <item>sign of mantissa,

      <item>integer part of mantissa,

      <item>fraction part of mantissa,

      <item>sign of exponent,

      <item>exponent magnitude
    </itemize>

    representing an expansion to a number of significant figures in
    scientific notation together with

    <\itemize>
      <item>the rounding ``error'': a fraction representing the next
      numerals.
    </itemize>
  </description>

  <\description>
    <item*|rational::str_real_approx_eng fmt expStep radix intGroup fracGroup
    round sf q<label|rational::str-real-approx-eng>>returns a string
    expansion with a number of significant figures in engineering notation,
    using rounding mode roundfun.

    The ExpStep parameter specifies the granularity of the exponent;
    specifically, the exponent will always be divisible by expStep.

    (sf must be positive; expStep is usually 3 and must be positive, radix is
    usually 10, <verbatim|roundfun> is usually
    <hlink|<with|font-family|tt|round>|purelib.tm#round> or
    <hlink|<with|font-family|tt|round_unbiased>|#rational::round-unbiased>.)
  </description>

  <with|font-series|bold|Example 81> Engineering notation:

  <\verbatim>
    \<gtr\> str_real_approx_eng format_uk 3 10 3 3 round 7 (rational 999950);

    "999.950,0*10^3"

    \<gtr\> str_real_approx_eng format_uk 3 10 3 3 round 4 999950;

    "1.000*10^6(-)"
  </verbatim>

  <\description>
    <item*|rational::strs_real_approx_eng expStep radix roundfun sf
    q<label|rational::strs-real-approx-eng>>returns a tuple of strings:

    <\itemize>
      <item>sign of mantissa,

      <item>integer part of mantissa,

      <item>fraction part of mantissa,

      <item>sign of exponent,

      <item>exponent magnitude
    </itemize>

    representing an expansion to a number of significant figures in
    engineering notation together with

    <\itemize>
      <item>the rounding ``error'': a fraction representing the next
      numerals.
    </itemize>
  </description>

  <with|font-series|bold|Example 82> Engineering notation \V the fragments:

  <\verbatim>
    \<gtr\> strs_real_approx_eng 3 10 round 7 (rational 999950);

    "+","999","9500","+","3",0L%1L

    \<gtr\> strs_real_approx_eng 3 10 round 4 999950;

    "+","1","000","+","6",(-1L)%20L
  </verbatim>

  <\description>
    <item*|rational::join_str_real_eng fmt intGroup fracGroup mantSign mantI
    mantF rac expSign expI err<label|rational::join-str-real-eng>>formats the
    parts in the quadruple returned by <verbatim|strs_real_approx_eng> or
    strs_real_approx_sci to the sort of string as returned by
    <hlink|<with|font-family|tt|str_real_approx_eng>|#rational::str-real-approx-eng>
    or <hlink|<with|font-family|tt|str_real_approx_sci>|#rational::str-real-approx-sci>.
  </description>

  <subsubsection|Evaluation of Expansion Strings<label|evaluation-of-expansion-strings>>

  The <verbatim|str_*> and <verbatim|val_*> functions depend on a `format
  structure' parameter (fmt) such as format uk. Conversions may be performed
  between rationals and differently formatted strings if a suitable
  alternative format structure is supplied. See <hlink|Internationalisation
  and Format Structures|#internationalisation-and-format-structures> for
  information about formatting structures.

  <\description>
    <item*|rational::val_real_eng fmt radix
    strg<label|rational::val-real-eng>>returns the rational q represented by
    the base-radix expansion string strg of one the forms

    <\itemize>
      <item>``[-]int.frac''

      <item>``[-]int.frace[-]exponent''
    </itemize>
  </description>

  <with|font-series|bold|Example 83> Conversion from the recurring radix
  expansion-type string representations:

  <\verbatim>
    \<gtr\> val_real_eng format_uk 10 "-12.345";

    (-2469L)%200L

    \<gtr\> val_real_eng format_uk 10 "-12.345*10^2";

    (-2469L)%2L
  </verbatim>

  <\description>
    <item*|rational::sval_real_eng radix signStr mantIStr mantF racStr
    expSignStr expStr<label|rational::sval-real-eng>>returns the rational q
    represented by the parts

    <\itemize>
      <item>sign

      <item>integer part of mantissa

      <item>fraction part of mantissa

      <item>sign of exponent

      <item>exponent
    </itemize>
  </description>

  <\description>
    <item*|rational::split_str_real_eng fmt
    strg<label|rational::split-str-real-eng>>returns a tuple containing the
    string parts

    <\itemize>
      <item>sign

      <item>integer part of mantissa

      <item>fraction part of mantissa

      <item>sign of exponent

      <item>exponent

      <item>the ``error'' sign
    </itemize>

    of one the forms

    <\itemize>
      <item>``[-]int.frac''

      <item>``[-]int.frac <math|\<times\>>10^[-]exponent''
    </itemize>
  </description>

  These functions can deal with the fixed decimal places, the significant
  figures and the scientific notation in addition to the engineering
  notation.

  <subsection|Numeral String -\<gtr\> Q \V
  Approximation<label|numeral-string-q-approximation>>

  This section describes functions to approximate by a rational a real number
  represented by a string. See <hlink|R -\<gtr\> Q \V
  Approximation|#r-q-approximation> for approximation by a rational of a
  double.

  The <verbatim|str_*> and <verbatim|val_*> functions depend on a `format
  structure' parameter (fmt) such as format uk. Conversions may be performed
  between rationals and differently formatted strings if a format structure
  is supplied. See <hlink|Internationalisation and Format
  Structures|#internationalisation-and-format-structures> for information
  about formatting structures.

  <\description>
    <item*|rational::val_eng_approx_epsilon fmt radix epsilon
    strg<label|rational::val-eng-approx-epsilon>>Find the least complex
    rational approximation q to the number represented by the base-radix
    expansion string str in one of the forms

    <\itemize>
      <item>``[-]int.frac''

      <item>``[-]int.frac <math|\<times\>>10^[-]exponent''
    </itemize>

    that is <math|\<varepsilon\>>-close. That is find a q such that \|q -
    eval str\| <math|\<leq\>> <math|\<varepsilon\>>.
  </description>

  <with|font-series|bold|Example 84> Rational from a long string:

  <\verbatim>
    \<gtr\> let strg = "123.456,789,876,543,212,345,678,987,654,321*10^27";

    \<gtr\> let x = val_real_eng format_uk 10 strg;

    \<gtr\> x;

    123456789876543212345678987654321L%1000L

    \<gtr\> let q = val_eng_approx_epsilon format_uk 10 (1%100) strg;

    \<gtr\> q;

    1975308638024691397530863802469L%16L

    \<gtr\> double (x - q);

    0.0085

    \<gtr\> str_real_approx_eng format_uk 3 10 3 3 round 30 q;

    "123.456,789,876,543,212,345,678,987,654*10^27(+)"

    \<gtr\> str_real_approx_eng format_uk 3 10 3 3 round 42 q;

    "123.456,789,876,543,212,345,678,987,654,312,500,000,000*10^27"

    \<gtr\> double q;

    1.23456789876543e+029
  </verbatim>

  <\description>
    <item*|rational::val_eng_interval_epsilon fmt radix epsilon
    strg<label|rational::val-eng-interval-epsilon>>Find the least complex
    rational interval containing the number represented by the base-radix
    expansion string strg in one of the forms

    <\itemize>
      <item>``[-]int.frac''

      <item>``[-]int.frac <math|\<times\>>10^[-]exponent''
    </itemize>

    that is ``-small.
  </description>

  <\description>
    <item*|rational::val_eng_approx_max_den fmt radix maxDen
    strg<label|rational::val-eng-approx-max-den>>Find the closest rational
    approximation to the number represented by the base-rRadix expansion
    string strg in one of the forms

    <\itemize>
      <item>``[-]int.frac''

      <item>``[-]int.frac <math|\<times\>>10^[-]exponent''
    </itemize>

    that has a denominator no greater than maxDen. (maxDen \<gtr\> 0)
  </description>

  <\description>
    <item*|rational::val_eng_interval_max_den fmt radix maxDen
    strg<label|rational::val-eng-interval-max-den>>Find the smallest rational
    interval containing the number represented by the base-radix expansion
    string strg in one of the forms

    <\itemize>
      <item>``[-]int.frac''

      <item>``[-]int.frac <math|\<times\>>10^[-]exponent''
    </itemize>

    that has endpoints with denominators no greater than maxDen. (maxDen
    \<gtr\> 0)
  </description>

  <with|font-series|bold|Example 85> Other rationals from a long string:

  <\verbatim>
    \<gtr\> val_eng_approx_epsilon format_uk 10 (1%100) strg;

    1975308638024691397530863802469L%16L

    \<gtr\> val_eng_interval_epsilon format_uk 10 (1%100) strg;

    interval::Ivl (3086419746913580308641974691358L%25L)

    (3456790116543209945679011654321L%28L)

    \<gtr\> val_eng_approx_max_den format_uk 10 100 strg;

    9999999980000000199999998000000L%81L

    \<gtr\> val_eng_interval_max_den format_uk 10 100 strg;

    interval::Ivl 9999999980000000199999998000000L%81L

    3456790116543209945679011654321L%28L
  </verbatim>

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-rational-toc>>

  <\itemize>
    <item><hlink|Pure-Rational - Rational number library for the Pure
    programming language|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Introduction|#introduction>

      <\itemize>
        <item><hlink|The Rational Module|#module-rational>

        <item><hlink|The Files and the Default
        Prelude|#the-files-and-the-default-prelude>

        <\itemize>
          <item><hlink|math.pure and Other Files|#math-pure-and-other-files>

          <item><hlink|rational.pure|#rational-pure>

          <item><hlink|rat_interval.pure|#rat-interval-pure>
        </itemize>

        <item><hlink|Notation|#notation>
      </itemize>

      <item><hlink|The Rational Type|#the-rational-type>

      <\itemize>
        <item><hlink|Constructors|#constructors>

        <item><hlink|`Deconstructors'|#deconstructors>

        <item><hlink|Type and Value Tests|#type-and-value-tests>
      </itemize>

      <item><hlink|Arithmetic|#arithmetic>

      <\itemize>
        <item><hlink|Operators|#operators>

        <item><hlink|More on Division|#more-on-division>

        <item><hlink|Relations \V Equality and Inequality
        Tests|#relations-equality-and-inequality-tests>

        <item><hlink|Comparison Function|#comparison-function>
      </itemize>

      <item><hlink|Mathematical Functions|#mathematical-functions>

      <\itemize>
        <item><hlink|Absolute Value and Sign|#absolute-value-and-sign>

        <item><hlink|Greatest Common Divisor (GCD) and Least Common Multiple
        (LCM)|#greatest-common-divisor-gcd-and-least-common-multiple-lcm>

        <item><hlink|Extrema (Minima and Maxima)|#extrema-minima-and-maxima>
      </itemize>

      <item><hlink|Special Rational Functions|#special-rational-functions>

      <\itemize>
        <item><hlink|Complexity|#complexity>

        <\itemize>
          <item><hlink|Complexity Relations|#complexity-relations>

          <item><hlink|Complexity Comparison
          Function|#complexity-comparison-function>

          <item><hlink|Complexity Extrema|#complexity-extrema>

          <item><hlink|Other Complexity Functions|#other-complexity-functions>
        </itemize>

        <item><hlink|Mediants and Farey Sequences|#mediants-and-farey-sequences>

        <item><hlink|Rational Type Simplification|#rational-type-simplification>
      </itemize>

      <item><hlink|<with|font-series|bold|Q> -\<gtr\>
      <with|font-series|bold|Z> \V Rounding|#q-z-rounding>

      <\itemize>
        <item><hlink|Rounding to Integer|#rounding-to-integer>

        <item><hlink|Integer and Fraction Parts|#integer-and-fraction-parts>
      </itemize>

      <item><hlink|Rounding to Multiples|#rounding-to-multiples>

      <item><hlink|<with|font-series|bold|Q> -\<gtr\>
      <with|font-series|bold|R> \V Conversion /
      Casting|#q-r-conversion-casting>

      <item><hlink|<with|font-series|bold|R> -\<gtr\>
      <with|font-series|bold|Q> \V Approximation|#r-q-approximation>

      <\itemize>
        <item><hlink|Intervals|#module-rat-interval>

        <\itemize>
          <item><hlink|Interval Constructors and
          `Deconstructors'|#interval-constructors-and-deconstructors>

          <item><hlink|Interval Type Tests|#interval-type-tests>

          <item><hlink|Interval Arithmetic Operators and
          Relations|#interval-arithmetic-operators-and-relations>

          <item><hlink|Interval Maths|#interval-maths>
        </itemize>

        <item><hlink|Least Complex Approximation within
        Epsilon|#least-complex-approximation-within-epsilon>

        <item><hlink|Best Approximation with Bounded
        Denominator|#best-approximation-with-bounded-denominator>
      </itemize>

      <item><hlink|Decomposition|#decomposition>

      <item><hlink|Continued Fractions|#continued-fractions>

      <\itemize>
        <item>Introduction

        <item><hlink|Generating Continued
        Fractions|#generating-continued-fractions>

        <\itemize>
          <item><hlink|Exact|#exact>

          <item><hlink|Inexact|#inexact>
        </itemize>

        <item><hlink|Evaluating Continued
        Fractions|#evaluating-continued-fractions>

        <\itemize>
          <item><hlink|Convergents|#convergents>
        </itemize>
      </itemize>

      <item><hlink|Rational Complex Numbers|#rational-complex-numbers>

      <\itemize>
        <item><hlink|Rational Complex Constructors and
        `Deconstructors'|#rational-complex-constructors-and-deconstructors>

        <item><hlink|Rational Complex Type and Value
        Tests|#rational-complex-type-and-value-tests>

        <item><hlink|Rational Complex Arithmetic Operators and
        Relations|#rational-complex-arithmetic-operators-and-relations>

        <item><hlink|Rational Complex Maths|#rational-complex-maths>

        <item><hlink|Rational Complex Type
        Simplification|#rational-complex-type-simplification>
      </itemize>

      <item><hlink|String Formatting and Evaluation|#string-formatting-and-evaluation>

      <\itemize>
        <item><hlink|The Naming of the String Conversion
        Functions|#the-naming-of-the-string-conversion-functions>

        <item><hlink|Internationalisation and Format
        Structures|#internationalisation-and-format-structures>

        <item><hlink|Digit Grouping|#digit-grouping>

        <item><hlink|Radices|#radices>

        <item><hlink|Error Terms|#error-terms>
      </itemize>

      <item><hlink|<with|font-series|bold|Q> \<less\>-\<gtr\> Fraction String
      (``i + n/d'')|#q-fraction-string-i-n-d>

      <\itemize>
        <item><hlink|Formatting to Fraction
        Strings|#formatting-to-fraction-strings>

        <item><hlink|Evaluation of Fraction
        Strings|#evaluation-of-fraction-strings>
      </itemize>

      <item><hlink|<with|font-series|bold|Q> \<less\>-\<gtr\> Recurring
      Numeral Expansion String (``I.FR'')|#q-recurring-numeral-expansion-string-i-fr>

      <\itemize>
        <item><hlink|Formatting to Recurring Expansion
        Strings|#formatting-to-recurring-expansion-strings>

        <item><hlink|Evaluation of Recurring Expansion
        Strings|#evaluation-of-recurring-expansion-strings>
      </itemize>

      <item><hlink|<with|font-series|bold|Q> \<less\>-\<gtr\> Numeral
      Expansion String (``I.F <math|\<times\>>
      10E'')|#q-numeral-expansion-string-i-f-10e>

      <\itemize>
        <item><hlink|Formatting to Expansion
        Strings|#formatting-to-expansion-strings>

        <\itemize>
          <item><hlink|Functions for Fixed Decimal
          Places|#functions-for-fixed-decimal-places>

          <item><hlink|Functions for Significant
          Figures|#functions-for-significant-figures>

          <item><hlink|Functions for Scientific Notation and Engineering
          Notation|#functions-for-scientific-notation-and-engineering-notation>
        </itemize>

        <item><hlink|Evaluation of Expansion
        Strings|#evaluation-of-expansion-strings>
      </itemize>

      <item><hlink|Numeral String -\<gtr\> <with|font-series|bold|Q> \V
      Approximation|#numeral-string-q-approximation>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-octave|pure-octave.tm>

  Next topic

  <hlink|Computer Algebra with Pure: A Reduce Interface|pure-reduce.tm>

  <hlink|toc|#pure-rational-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-reduce.tm> \|
  <hlink|previous|pure-octave.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Jan
  28, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
