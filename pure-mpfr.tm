<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-mpfr-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-octave.tm> \|
  <hlink|previous|pure-gsl.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-mpfr<label|module-mpfr>>

  Version 0.5, September 17, 2014

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  The <hlink|GNU MPFR|http://www.mpfr.org/> library is a C library for
  multiple-precision floating-point computations with correct rounding. It is
  based on <hlink|GMP|http://gmplib.org> which Pure also uses for its bigint
  support.

  This module makes the MPFR multiprecision floats (henceforth referred to as
  <verbatim|mpfr> numbers or values) available in Pure, so that they work
  with the other types of Pure numbers in an almost seamless fashion. Pure
  <verbatim|mpfr> values are represented as pointers which can readily be
  passed as arguments to the MPFR functions, so the representation only
  involves minimal overhead on the Pure side.

  The module defines the type of <verbatim|mpfr> values as an instance of
  Pure's <verbatim|real> type, so that it becomes a well-behaved citizen of
  Pure's numeric tower. Memory management of these values is automatic. You
  can create an <verbatim|mpfr> value from any other kind of Pure real value
  (<verbatim|int>, <verbatim|bigint> or <verbatim|double>), or from a string
  in decimal notation, using the <verbatim|mpfr> function. Back conversions
  are provided from <verbatim|mpfr> to <verbatim|int>, <verbatim|bigint>,
  <verbatim|double> and <verbatim|string> (the latter by means of a custom
  pretty-printer installed by this module, so that mpfr values are printed in
  a format similar to the <verbatim|printf> <verbatim|%g> format).
  Integration with Pure's <verbatim|complex> type is provided as well.

  Please note that this module needs more testing and the API hasn't been
  finalized yet, but it should be perfectly usable already. As usual, please
  report any bugs on the Pure issue tracker, on the Pure mailing list, or
  directly to the author, see <hlink|http://purelang.bitbucket.org/|http://purelang.bitbucket.org/>.

  <subsection|Copying<label|copying>>

  Copyright (c) 2011 by Albert Graef.

  pure-mpfr is free software: you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-mpfr is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
  for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation<label|installation>>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-mpfr-0.5.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-mpfr-0.5.tar.gz>.

  Run <verbatim|make> to compile the module and <verbatim|make>
  <verbatim|install> (as root) to install it in the Pure library directory.
  This requires GNU make, and of course you need to have Pure and libmpfr
  installed.

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually, please check the Makefile for details.

  <with|font-series|bold|Note:> This module requires Pure 0.50 or later and
  libmpfr 3.x (3.0.0 has been tested). Older libmpfr versions (2.x) probably
  require some work.

  <subsection|Usage<label|usage>>

  After installation, you can use the operations of this module by placing
  the following import declaration in your Pure programs:

  <\verbatim>
    using mpfr;
  </verbatim>

  <with|font-series|bold|Note:> This also pulls in the
  <hlink|<with|font-family|tt|math>|purelib.tm#module-math> standard library
  module, whose operations are overloaded by the <verbatim|mpfr> module in
  order to provide support for <verbatim|mpfr> values. Thus you don't need to
  explicitly import the <verbatim|math> module when using the <verbatim|mpfr>
  module.

  If you use both the <hlink|<with|font-family|tt|mpfr>|#module-mpfr> module
  and the <hlink|<with|font-family|tt|pointers>|purelib.tm#module-pointers>
  standard library module in your script, make sure that you import the
  <verbatim|pointers> module <em|after> <verbatim|mpfr>, so that the
  definitions of pointer arithmetic in the <verbatim|pointers> module do not
  interfere with the overloading of arithmetic operations in the
  <verbatim|mpfr> module.

  <subsubsection|Precision and Rounding<label|precision-and-rounding>>

  The following operations of the MPFR library are provided to inspect and
  change the default precision and rounding modes used by MPFR.

  <\description>
    <item*|mpfr_get_default_prec<label|mpfr-get-default-prec>>

    <item*|mpfr_set_default_prec prec<label|mpfr-set-default-prec>>Get and
    set the default precision in terms of number of bits in the mantissa,
    including the sign. MPFR initially sets this to 53 (matching the mantissa
    size of <verbatim|double> values). It can be changed to any desired value
    not less than 2.
  </description>

  <\description>
    <item*|mpfr_get_prec x<label|mpfr-get-prec>>Get the precision of an
    <verbatim|mpfr> number <verbatim|x>. Note that <verbatim|mpfr> numbers
    always keep the precision they were created with, but it is possible to
    create a new <verbatim|mpfr> number with any given precision from an
    existing <verbatim|mpfr> number using the
    <hlink|<with|font-family|tt|mpfr>|#mpfr> function, see below.
  </description>

  <\description>
    <item*|mpfr_get_default_rounding_mode<label|mpfr-get-default-rounding-mode>>

    <item*|mpfr_set_default_rounding_mode
    rnd<label|mpfr-set-default-rounding-mode>>Get and set the default
    rounding mode, which is used for all arithmetic operations and
    mathematical functions provided by this module. The given rounding mode
    <verbatim|rnd> must be one of the supported rounding modes listed below.
  </description>

  <\description>
    <item*|<em|constant> MPFR_RNDN // round to nearest, with ties to
    even<label|MPFR-RNDN>>

    <item*|<em|constant> MPFR_RNDZ // round toward zero<label|MPFR-RNDZ>>

    <item*|<em|constant> MPFR_RNDU // round toward +Inf<label|MPFR-RNDU>>

    <item*|<em|constant> MPFR_RNDD // round toward -Inf<label|MPFR-RNDD>>

    <item*|<em|constant> MPFR_RNDA // round away from
    zero<label|MPFR-RNDA>>Supported rounding modes. Please check the MPFR
    documentation for details.
  </description>

  In addition, the following operations enable you to control the precision
  in textual representations of <verbatim|mpfr> values. This information is
  used by the custom pretty-printer for <verbatim|mpfr> values installed by
  the module.

  <\description>
    <item*|mpfr_get_print_prec<label|mpfr-get-print-prec>>

    <item*|mpfr_set_print_prec prec<label|mpfr-set-print-prec>>Get and set
    the precision (number of decimal digits in the mantissa) used by the
    pretty-printer.
  </description>

  <subsubsection|MPFR Numbers<label|mpfr-numbers>>

  The module defines the following data type for representing <verbatim|mpfr>
  values, which is a subtype of the Pure <hlink|<with|font-family|tt|real>|purelib.tm#real/type>
  type:

  <\description>
    <item*|<em|type> mpfr<label|mpfr/type>>This is a tagged pointer type
    (denoted <verbatim|mpfr*> in Pure extern declarations) which is
    compatible with the <verbatim|mpfr_t> and <verbatim|mpfr_ptr> data types
    of the MPFR C library. Members of this type are ``cooked'' pointers,
    which are allocated dynamically and freed automatically when they are
    garbage-collected (by means of a corresponding Pure sentry).
  </description>

  <\description>
    <item*|mpfrp x<label|mpfrp>>Type predicate checking for <verbatim|mpfr>
    values.
  </description>

  <subsubsection|Conversions<label|conversions>>

  The following operations are provided to convert between <verbatim|mpfr>
  numbers and other kinds of Pure <verbatim|real> values.

  <\description>
    <item*|mpfr x<label|mpfr>>

    <item*|mpfr (x,prec)<label|mpfr/2>>

    <item*|mpfr (x,prec,rnd)<label|mpfr/3>>This function converts any real
    number (<hlink|<with|font-family|tt|int>|pure.tm#int/type>,
    <hlink|<with|font-family|tt|bigint>|pure.tm#bigint/type>,
    <hlink|<with|font-family|tt|double>|pure.tm#double/type>,
    <hlink|<with|font-family|tt|rational>|purelib.tm#rational/type>,
    <hlink|<with|font-family|tt|mpfr>|#mpfr/type>) to an <verbatim|mpfr>
    value.

    Optionally, it is possible to specify a precision (number of bits in the
    mantissa) <verbatim|prec> and a rounding mode <verbatim|rnd> (one of the
    <verbatim|MPFR_RND> constants), otherwise MPFR's default precision and
    rounding mode are used (see <hlink|Precision and
    Rounding|#precision-and-rounding> above). Note that this function may
    also be used to convert an <verbatim|mpfr> to a new <verbatim|mpfr>
    number, possibly with a different precision and rounding.

    The argument <verbatim|x> can also be a string denoting a floating point
    number in decimal notation with optional sign, decimal point and/or
    scaling factor, which is parsed and converted to an <verbatim|mpfr>
    number using the corresponding MPFR function.
  </description>

  <\description>
    <item*|int x<label|int/mpfr>>

    <item*|bigint x<label|bigint/mpfr>>

    <item*|double x<label|double/mpfr>>Convert an <verbatim|mpfr> number x to
    the corresponding type of real number. Please note that there is no
    <verbatim|rational> conversion, as MPFR does not provide such an
    operation, but if you need this then you can first convert <verbatim|x>
    to a <verbatim|double> and then apply the standard library
    <hlink|<with|font-family|tt|rational>|purelib.tm#rational> function to it
    (this may loose precision, of course).
  </description>

  <\description>
    <item*|str x<label|str/mpfr>>By virtue of the custom pretty-printer
    provided by this module, the standard library
    <hlink|<with|font-family|tt|str>|purelib.tm#str> function can be used to
    obtain a printable representation of an <verbatim|mpfr> number
    <verbatim|x> in decimal notation. The result is a string.
  </description>

  <\description>
    <item*|floor x<label|floor/mpfr>>

    <item*|ceil x<label|ceil/mpfr>>

    <item*|round x<label|round/mpfr>>

    <item*|trunc x<label|trunc/mpfr>>

    <item*|frac x<label|frac/mpfr>>Rounding and truncation functions. These
    all take and yield <verbatim|mpfr> numbers.
    <hlink|<with|font-family|tt|frac>|#frac/mpfr> returns the fractional part
    of an <verbatim|mpfr> number, i.e., <verbatim|x-trunc> <verbatim|x>.
  </description>

  <subsubsection|Arithmetic<label|arithmetic>>

  The following standard operators (see the <hlink|<em|Pure Library
  Manual>|purelib.tm>) are overloaded to provide <verbatim|mpfr> arithmetic
  and comparisons. These all handle mixed <verbatim|mpfr>/<verbatim|real>
  operands.

  <\description>
    <item*|- x<label|-/mpfr>>

    <item*|x + y<label|+/mpfr>>

    <item*|x - y>

    <item*|x * y<label|*/mpfr>>

    <item*|x / y<label|//mpfr>>

    <item*|x ^ y<label|?5E/mpfr>>Arithmetic operations.
  </description>

  <\description>
    <item*|x == y<label|==/mpfr>>

    <item*|x <math|\<sim\>>= y<label|-tilde=/mpfr>>

    <item*|x \<less\>= y<label|\<less\>=/mpfr>>

    <item*|x \<gtr\>= y<label|\<gtr\>=/mpfr>>

    <item*|x \<less\> y<label|\<less\>/mpfr>>

    <item*|x \<gtr\> y<label|\<gtr\>/mpfr>>Comparisons.
  </description>

  <subsubsection|Math Functions<label|math-functions>>

  The following functions from the <hlink|<with|font-family|tt|math>|purelib.tm#module-math>
  module are overloaded to provide support for <verbatim|mpfr> values. Note
  that it is also possible to invoke the corresponding functions from the
  MPFR library in a direct fashion, using the same function names with an
  additional <verbatim|_mpfr> suffix. These functions also accept other kinds
  of <verbatim|real> arguments which are converted to <verbatim|mpfr> before
  applying the MPFR function.

  <\description>
    <item*|abs x<label|abs/mpfr>>Absolute value (this is implemented
    directly, so there's no corresponding <verbatim|_mpfr> function for
    this).
  </description>

  <\description>
    <item*|sqrt x<label|sqrt/mpfr>>

    <item*|exp x<label|exp/mpfr>>

    <item*|ln x<label|ln/mpfr>>

    <item*|log x<label|log/mpfr>>Square root, exponential and logarithms.
  </description>

  <\description>
    <item*|sin x<label|sin/mpfr>>

    <item*|cos x<label|cos/mpfr>>

    <item*|tan x<label|tan/mpfr>>

    <item*|asin x<label|asin/mpfr>>

    <item*|acos x<label|acos/mpfr>>

    <item*|atan x<label|atan/mpfr>>

    <item*|atan2 y x<label|atan2/mpfr>>Trigonometric functions.
  </description>

  <\description>
    <item*|sinh x<label|sinh/mpfr>>

    <item*|cosh x<label|cosh/mpfr>>

    <item*|tanh x<label|tanh/mpfr>>

    <item*|asinh x<label|asinh/mpfr>>

    <item*|acosh x<label|acosh/mpfr>>

    <item*|atanh x<label|atanh/mpfr>>Hyperbolic trigonometric functions.
  </description>

  <subsubsection|Complex Number Support<label|complex-number-support>>

  The following functions from the <hlink|<with|font-family|tt|math>|purelib.tm#module-math>
  module are overloaded to provide support for complex values involving
  <verbatim|mpfr> numbers:

  <\description>
    <item*|complex x<label|complex/mpfr>>

    <item*|polar x<label|polar/mpfr>>

    <item*|rect x<label|rect/mpfr>>

    <item*|cis x<label|cis/mpfr>>

    <item*|arg x<label|arg/mpfr>>

    <item*|re x<label|re/mpfr>>

    <item*|im x<label|im/mpfr>>

    <item*|conj x<label|conj/mpfr>>
  </description>

  <subsection|Examples<label|examples>>

  Import the module and set the default precision:

  <\verbatim>
    \<gtr\> using mpfr;

    \<gtr\> mpfr_set_default_prec 64; // extended precision (long double on
    x86)

    ()
  </verbatim>

  Calculate pi with the current precision. Note that mixed arithmetic works
  with any combination of real and mpfr numbers.

  <\verbatim>
    \<gtr\> let Pi = 4*atan (mpfr 1);

    \<gtr\> pi; Pi; abs (Pi-pi);

    3.14159265358979

    3.14159265358979323851

    1.22514845490862001043e-16

    \;

    \<gtr\> let Pi2 = Pi^2;

    \<gtr\> Pi2; sqrt Pi2; sqrt Pi2 == Pi;

    9.86960440108935861941

    3.14159265358979323851

    1
  </verbatim>

  You can also query the precision of a number and change it on the fly:

  <\verbatim>
    \<gtr\> Pi; mpfr_get_prec Pi;

    3.14159265358979323851

    64

    \<gtr\> let Pi1 = mpfr (Pi,53); Pi1; mpfr_get_prec Pi1;

    3.1415926535897931

    53
  </verbatim>

  Complex <verbatim|mpfr> numbers work, too:

  <\verbatim>
    \<gtr\> let z = mpfr 2^(1/i); z;

    0.769238901363972126565+:-0.638961276313634801184

    \<gtr\> let z = ln z/ln (mpfr 2); z;

    0.0+:-1.0

    \<gtr\> abs z, arg z;

    1.0,-1.57079632679489661926

    \<gtr\> polar z;

    1.0\<less\>:-1.57079632679489661926
  </verbatim>

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-mpfr-toc>>

  <\itemize>
    <item><hlink|pure-mpfr|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <\itemize>
        <item><hlink|Precision and Rounding|#precision-and-rounding>

        <item><hlink|MPFR Numbers|#mpfr-numbers>

        <item><hlink|Conversions|#conversions>

        <item><hlink|Arithmetic|#arithmetic>

        <item><hlink|Math Functions|#math-functions>

        <item><hlink|Complex Number Support|#complex-number-support>
      </itemize>

      <item><hlink|Examples|#examples>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-gsl - GNU Scientific Library Interface for Pure|pure-gsl.tm>

  Next topic

  <hlink|pure-octave|pure-octave.tm>

  <hlink|toc|#pure-mpfr-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-octave.tm> \|
  <hlink|previous|pure-gsl.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Sep
  17, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
