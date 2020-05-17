<TeXmacs|1.99.12>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-gsl-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-mpfr.tm> \|
  <hlink|previous|pure-gplot.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-gsl - GNU Scientific Library Interface for
  Pure><label|module-gsl>

  Version 0.12, April 11, 2018

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  Eddie Rucker \<less\><hlink|erucker@bmc.edu|mailto:erucker@bmc.edu>\<gtr\>

  License: GPL V3 or later, see the accompanying COPYING file

  Building on Pure's GSL-compatible matrix support, this module aims to
  provide a complete wrapper for the GNU Scientific Library which provides a
  wide range of mathematical routines useful for scientific programming,
  number crunching and signal processing applications.

  This is still work in progress, only a small part of the interface is
  finished right now. Here is a brief summary of the operations which are
  implemented:

  <\itemize>
    <item>Matrix-scalar and matrix-matrix arithmetic. This is fairly complete
    and includes matrix multiplication, as well as element-wise
    exponentiation (^) and integer operations (div, mod, bit shifts and
    bitwise logical operations) which aren't actually in the GSL API.

    <item>SVD (singular value decomposition), as well as the corresponding
    solvers, pseudo inverses and left and right matrix division. This is only
    available for real matrices right now, as GSL doesn't implement complex
    SVD.

    <item>Random distributions (p.d.f. and c.d.f.) and statistic functions.

    <item>Polynomial evaluation and roots.

    <item>Linear least-squares fitting. Multi-fitting is not available yet.
  </itemize>

  Installation instructions: Get the latest source from
  <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-gsl-0.12.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-gsl-0.12.tar.gz>.
  Run <verbatim|make> to compile the module and <verbatim|make>
  <verbatim|install> (as root) to install it in the Pure library directory.
  This requires GNU make, and of course you need to have Pure and GSL
  installed. The <verbatim|make> <verbatim|install> step is only necessary
  for system-wide installation.

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix, and <verbatim|make>
  <verbatim|PIC=-fPIC> or some similar flag might be needed for compilation
  on 64 bit systems. Please see the Makefile for details.

  The current release requires GSL 1.11 or later and Pure 0.45 or later.
  Older GSL versions might still work, but then some operations may be
  missing. The latest and greatest GSL version is always available from
  <hlink|http://www.gnu.org/software/gsl|http://www.gnu.org/software/gsl>.

  After installation, you can import the entire GSL interface as follows:

  <\verbatim>
    \;

    using gsl;

    \;
  </verbatim>

  For convenience, the different parts of the GSL interface are also
  available as separate modules. E.g., if you only need the matrix
  operations:

  <\verbatim>
    \;

    using gsl::matrix;

    \;
  </verbatim>

  In either case, the global <verbatim|gsl_version> variable reports the
  installed GSL version:

  <\verbatim>
    \;

    \<gtr\> show gsl_version

    let gsl_version = "1.11";

    \;
  </verbatim>

  (This variable used to be defined by the Pure runtime but has been moved
  into pure-gsl as of Pure 0.37.)

  Most other operations are declared in separate namespaces which are in 1-1
  correspondence with the module names. Thus, e.g., the
  <verbatim|gsl_poly_eval> routine is named <verbatim|gsl::poly::eval> in
  Pure and can be found in the <verbatim|gsl::poly> module and namespace. The
  <verbatim|using> <verbatim|namespace> declaration can be used to facilitate
  access to the operations in a given namespace, e.g.:

  <\verbatim>
    \;

    \<gtr\> using gsl::poly;

    \<gtr\> using namespace gsl::poly;

    \<gtr\> eval {1,2,3} 2;

    17

    \;
  </verbatim>

  See the <verbatim|examples> folder in the sources for some examples.

  If you'd like to contribute, please mail the authors or contact us at
  <hlink|http://groups.google.com/group/pure-lang|http://groups.google.com/group/pure-lang>.

  <subsection|Polynomials><label|module-gsl::poly>

  This module provides Pure wrappers for the GSL polynomial routines. For
  detail about the routines, see Chapter 6 of the GSL manual,

  <hlink|http://www.gnu.org/software/gsl/manual/html_node/Polynomials.html|http://www.gnu.org/software/gsl/manual/html-node/Polynomials.html>.

  Polynomials are represented by vectors (one row matrices).

  <subsubsection|Routines><label|routines>

  <\description>
    <item*|gsl::poly::eval c::matrix x<label|gsl::poly::eval>>implements
    <verbatim|gsl_poly_eval>, <verbatim|gsl_poly_complex_eval>, and
    <verbatim|gsl_complex_poly_eval> without the <verbatim|len> parameter.

    GSL does not supply an integer routine for evaluating polynomials with
    <verbatim|int> or <verbatim|bigint> coefficients. Therefore, an integer
    routine has been provided in pure-gsl using the Chinese Remainder
    Theorem.
  </description>

  <\description>
    <item*|gsl::poly::dd_init x::matrix y::matrix<label|gsl::poly::dd-init>>implements
    <verbatim|gsl_poly_dd_init> without the <verbatim|size> parameter.
  </description>

  <\description>
    <item*|gsl::poly::dd_eval dd::matrix xa::matrix
    x::double<label|gsl::poly::dd-eval>>implements
    <verbatim|gsl_poly_dd_eval> without the <verbatim|size> parameter.
  </description>

  <\description>
    <item*|gsl::poly::dd_taylor xp::double dd::matrix
    xa::matrix<label|gsl::poly::dd-taylor>>implements
    <verbatim|gsl_poly_dd_taylor> without the <verbatim|size> and workspace
    <verbatim|w> arguments.
  </description>

  <\description>
    <item*|gsl::poly::solve_quadratic a b
    c<label|gsl::poly::solve-quadratic>>implements
    <verbatim|gsl_poly_solve_quadratic>. This function returns a list of
    roots instead of passing them through the parameters <verbatim|x0> and
    <verbatim|x1>.
  </description>

  <\description>
    <item*|gsl::poly::complex_solve_quadratic a b
    c<label|gsl::poly::complex-solve-quadratic>>implements
    <verbatim|gsl_poly_complex_solve_quadratic>. This function returns a list
    of roots instead of passing trhough the parameters <verbatim|z0> and
    <verbatim|z1>.
  </description>

  <\description>
    <item*|gsl::poly::solve_cubic a b c<label|gsl::poly::solve-cubic>>implements
    <verbatim|gsl_poly_solve_cubic>. This function returns a list of roots
    instead of passing them through the parameters <verbatim|x0>,
    <verbatim|x1>, and <verbatim|x2>.
  </description>

  <\description>
    <item*|gsl::poly::complex_solve_cubic a b
    c<label|gsl::poly::complex-solve-cubic>>implements
    <verbatim|gsl_poly_complex_colve_cubic>. This function returns a list of
    roots instead of passing them through the parameters <verbatim|z0>,
    <verbatim|z1>, and <verbatim|z2>.
  </description>

  <\description>
    <item*|gsl::poly::complex_solve c::matrix<label|gsl::poly::complex-solve>>implements
    <verbatim|gsl_poly_complex_solve> omitting the parametrs <verbatim|n> and
    <verbatim|w>. The GSL routines for creating and freeing the workspace are
    handled automatically.
  </description>

  <subsubsection|Examples><label|examples>

  Usage of each library routine is illustrated below.

  <\verbatim>
    \;

    \<gtr\> using gsl::poly;

    \<gtr\> using namespace gsl::poly;

    \<gtr\> eval {1,2,3} 2;

    17

    \<gtr\> eval {1.0,2.0,3.0} (-2.0);

    9.0

    \<gtr\> eval {1, 2, 2} (1+:1);

    3.0+:6.0

    \<gtr\> eval {1+:2, 2+:3, 2+:3} (1+:1);

    -6.0+:11.0

    \<gtr\> let dd = dd_init {1,2,3} {2,4,6};

    \<gtr\> dd;

    {2.0,2.0,0.0}

    \<gtr\> dd_eval dd {1,2,3} 2;

    4.0

    \<gtr\> dd_taylor 0.0 dd {1,2,3};

    {0.0,2.0,0.0}

    \<gtr\> solve_quadratic 2 4 1;

    [-1.70710678118655,-0.292893218813452]

    \<gtr\> solve_quadratic 1 4 4;

    [-2.0,-2.0]

    \<gtr\> solve_quadratic 0 2 1;

    [-0.5]

    \<gtr\> solve_quadratic 1 2 8;

    []

    \<gtr\> complex_solve_quadratic 0 2 1;

    [-0.5+:0.0]

    \<gtr\> complex_solve_quadratic 2 2 3;

    [-0.5+:-1.11803398874989,-0.5+:1.11803398874989]

    \<gtr\> solve_cubic 3 3 1;

    [-1.0,-1.0,-1.0]

    \<gtr\> solve_cubic 3 2 1;

    [-2.32471795724475]

    \<gtr\> complex_solve_cubic 2 2 1;

    [-1.0+:0.0,-0.5+:-0.866025403784439,-0.5+:0.866025403784439]

    \<gtr\> complex_solve {6,1,-7,-1,1};

    [1.0+:0.0,-1.0+:0.0,-2.0+:0.0,3.0+:0.0]

    \;
  </verbatim>

  <subsection|Special Functions><label|module-gsl::sf>

  This module is loaded via the command <verbatim|using> <verbatim|gsl::sf>
  and provides Pure wrappers for the GSL Special Functions. For details, see
  Chapter 7 of the GSL manual,

  <hlink|http://www.gnu.org/software/gsl/manual/html_node/Special-Functions.html|http://www.gnu.org/software/gsl/manual/html-node/Special-Functions.html>.

  To load the library, use the Pure command <verbatim|using>
  <verbatim|gsl::sf>. Modes for the functions must be one of:

  <\verbatim>
    \;

    GSL_PREC_DOUBLE

    GSL_PREC_SINGLE

    GSL_PREC_APPROX

    \;
  </verbatim>

  Results for some of the functions are returned as a Pure list instead of
  the <verbatim|gsl_sf_result> or <verbatim|gsl_sf_result_e10> structures in
  C. In these cases, the resulting list is one of the following forms.

  <\quote-env>
    <\itemize>
      <item><verbatim|[val,> <verbatim|err]> for the <verbatim|gsl_sf_result>
      struct and

      <item><verbatim|[val,> <verbatim|err,> <verbatim|e10]> for the
      <verbatim|gsl_sf_result_e10> struct.
    </itemize>
  </quote-env>

  <subsubsection|Airy Functions><label|airy-functions><label|airy-functions>

  <\description>
    <item*|gsl::sf::airy_Ai x<label|gsl::sf::airy-Ai>>

    <item*|gsl::sf::airy_Ai (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Ai>. The first form computes the function with
    <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Ai_e x<label|gsl::sf::airy-Ai-e>>

    <item*|gsl::sf::airy_Ai_e (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Ai_e>. The first form computes the function with
    <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Ai_scaled x<label|gsl::sf::airy-Ai-scaled>>

    <item*|gsl::sf::airy_Ai_scaled (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Ai_scaled>. The first form computes the function
    with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Ai_scaled_e x<label|gsl::sf::airy-Ai-scaled-e>>

    <item*|gsl::sf::airy_Ai_scaled_e (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Ai_scaled_e>. The first form computes the function
    with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Bi x<label|gsl::sf::airy-Bi>>

    <item*|gsl::sf::airy_Bi (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Bi>. The first form computes the function with
    <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Bi_e x<label|gsl::sf::airy-Bi-e>>

    <item*|gsl::sf::airy_Bi_e (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Bi_e>. The first form computes the function with
    <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Bi_scaled x<label|gsl::sf::airy-Bi-scaled>>

    <item*|gsl::sf::airy_Bi_scaled (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Bi_scaled>. The first form computes the function
    with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Bi_scaled_e x<label|gsl::sf::airy-Bi-scaled-e>>

    <item*|gsl::sf::airy_Bi_scaled_e (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Bi_scaled_e>. The first form computes the function
    with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Ai_deriv x<label|gsl::sf::airy-Ai-deriv>>

    <item*|gsl::sf::airy_Ai_deriv (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Ai_deriv>. The first form computes the function
    with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Ai_deriv_e x<label|gsl::sf::airy-Ai-deriv-e>>

    <item*|gsl::sf::airy_Ai_deriv_e (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Ai_deriv_e>. The first form computes the function
    with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Ai_deriv_scaled x<label|gsl::sf::airy-Ai-deriv-scaled>>

    <item*|gsl::sf::airy_Ai_deriv_scaled (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Ai_deriv_scaled>. The first form computes the
    function with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Ai_deriv_scaled_e
    x<label|gsl::sf::airy-Ai-deriv-scaled-e>>

    <item*|gsl::sf::airy_Ai_deriv_scaled_e (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Ai_deriv_scaled_e>. The first form computes the
    function with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Bi_deriv x<label|gsl::sf::airy-Bi-deriv>>

    <item*|gsl::sf::airy_Bi_deriv (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Bi_deriv>. The first form computes the function
    with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Bi_deriv_e x<label|gsl::sf::airy-Bi-deriv-e>>

    <item*|gsl::sf::airy_Bi_deriv_e (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Bi_deriv_e>. The first form computes the function
    with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Bi_deriv_scaled x<label|gsl::sf::airy-Bi-deriv-scaled>>

    <item*|gsl::sf::airy_Bi_deriv_scaled (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Bi_deriv_scaled>. The first form computes the
    function with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_Bi_deriv_scaled_e
    x<label|gsl::sf::airy-Bi-deriv-scaled-e>>

    <item*|gsl::sf::airy_Bi_deriv_scaled_e (x, mode::int)>implements
    <verbatim|gsl_sf_airy_Bi_deriv_scaled_e>. The first form computes the
    function with <verbatim|mode> <verbatim|=> <verbatim|GSL_PREC_DOUBLE>.
  </description>

  <\description>
    <item*|gsl::sf::airy_zero_Ai s<label|gsl::sf::airy-zero-Ai>>implements
    <verbatim|gsl_sf_airy_zero_Ai>.
  </description>

  <\description>
    <item*|gsl::sf::airy_zero_Ai_e s<label|gsl::sf::airy-zero-Ai-e>>implements
    <verbatim|gsl_sf_airy_zero_Ai_e>.
  </description>

  <\description>
    <item*|gsl::sf::airy_zero_Bi s<label|gsl::sf::airy-zero-Bi>>implements
    <verbatim|gsl_sf_airy_zero_Bi>.
  </description>

  <\description>
    <item*|gsl::sf::airy_zero_Bi_e s<label|gsl::sf::airy-zero-Bi-e>>implements
    <verbatim|gsl_sf_airy_zero_Bi_e>.
  </description>

  <\description>
    <item*|gsl::sf::airy_zero_Ai_deriv s<label|gsl::sf::airy-zero-Ai-deriv>>implements
    <verbatim|gsl_sf_airy_zero_Ai_deriv>.
  </description>

  <\description>
    <item*|gsl::sf::airy_zero_Ai_deriv_e s<label|gsl::sf::airy-zero-Ai-deriv-e>>implements
    <verbatim|gsl_sf_airy_zero_Ai_deriv_e>.
  </description>

  <\description>
    <item*|gsl::sf::airy_zero_Bi_deriv s<label|gsl::sf::airy-zero-Bi-deriv>>implements
    <verbatim|gsl_sf_airy_zero_Bi_deriv>.
  </description>

  <\description>
    <item*|gsl::sf::airy_zero_Bi_deriv_e s<label|gsl::sf::airy-zero-Bi-deriv-e>>implements
    <verbatim|gsl_sf_airy_zero_Bi_deriv_e>.
  </description>

  <subsubsection|Examples>

  The following illustrate the Airy functions.

  <\verbatim>
    \;

    \<gtr\> using gsl::sf;

    \<gtr\> using namespace gsl::sf;

    \<gtr\> airy_Ai (-1.2); // defaults to GSL_PREC_DOUBLE

    0.52619437480212

    \<gtr\> airy_Ai_scaled (-1.2);

    0.52619437480212

    \<gtr\> airy_Ai (-1.2,GSL_PREC_APPROX);

    0.526194374771687

    \<gtr\> airy_Ai_scaled (-1.2, GSL_PREC_SINGLE);

    0.526194374771687

    \<gtr\> airy_Ai_e (-1.2);

    [0.52619437480212,1.88330586480371e-15]

    \<gtr\> airy_Ai_e (-1.2,GSL_PREC_APPROX);

    [0.526194374771687,1.01942940819652e-08]

    \<gtr\> airy_Ai_scaled_e (-1.2);

    [0.52619437480212,1.88330586480371e-15]

    \<gtr\> airy_Ai_scaled_e (-1.2,GSL_PREC_APPROX);

    [0.526194374771687,1.01942940819652e-08]

    \<gtr\> airy_Bi (-1.2);

    -0.015821370184632

    \<gtr\> airy_Bi_scaled (-1.2);

    -0.015821370184632

    \<gtr\> airy_Bi (-1.2,GSL_PREC_APPROX);

    -0.0158213701898015

    \<gtr\> airy_Bi_scaled (-1.2, GSL_PREC_SINGLE);

    -0.0158213701898015

    \<gtr\> airy_Bi_e (-1.2);

    [-0.015821370184632,1.31448899295896e-16]

    \<gtr\> airy_Bi_e (-1.2,GSL_PREC_APPROX);

    [-0.0158213701898015,4.10638404843775e-10]

    \<gtr\> airy_Bi_scaled_e (-1.2);

    [-0.015821370184632,1.31448899295896e-16]

    \<gtr\> airy_Bi_scaled_e (-1.2,GSL_PREC_APPROX);

    [-0.0158213701898015,4.10638404843775e-10]

    \<gtr\> airy_Ai_deriv (-1.2); // defaults to GSL_PREC_DOUBLE

    0.107031569272281

    \<gtr\> airy_Ai_deriv_scaled (-1.2);

    0.107031569272281

    \<gtr\> airy_Ai_deriv (-1.2,GSL_PREC_APPROX);

    0.107031569264504

    \<gtr\> airy_Ai_deriv_scaled (-1.2, GSL_PREC_SINGLE);

    0.107031569264504

    \<gtr\> airy_Ai_deriv_e (-1.2);

    [0.107031569272281,3.02919983680384e-16]

    \<gtr\> airy_Ai_deriv_e (-1.2,GSL_PREC_APPROX);

    [0.107031569264504,9.25921017197604e-11]

    \<gtr\> airy_Ai_deriv_scaled_e (-1.2);

    [0.107031569272281,3.02919983680384e-16]

    \<gtr\> airy_Ai_deriv_scaled_e (-1.2,GSL_PREC_APPROX);

    [0.107031569264504,9.25921017197604e-11]

    \<gtr\> airy_Bi_deriv (-1.2);

    0.601710157437464

    \<gtr\> airy_Bi_deriv_scaled (-1.2);

    0.601710157437464

    \<gtr\> airy_Bi_deriv (-1.2,GSL_PREC_APPROX);

    0.601710157441937

    \<gtr\> airy_Bi_deriv_scaled (-1.2, GSL_PREC_SINGLE);

    0.601710157441937

    \<gtr\> airy_Bi_deriv_e (-1.2);

    [0.601710157437464,1.7029557943563e-15]

    \<gtr\> airy_Bi_deriv_e (-1.2,GSL_PREC_APPROX);

    [0.601710157441937,5.20534347823991e-10]

    \<gtr\> airy_Bi_deriv_scaled_e (-1.2);

    [0.601710157437464,1.7029557943563e-15]

    \<gtr\> airy_Bi_deriv_scaled_e (-1.2,GSL_PREC_APPROX);

    [0.601710157441937,5.20534347823991e-10]

    \<gtr\> airy_zero_Ai 2;

    -4.08794944413097

    \<gtr\> airy_zero_Ai_e 3;

    [-5.52055982809555,1.22581052599448e-15]

    \<gtr\> airy_zero_Bi 2;

    -3.27109330283635

    \<gtr\> airy_zero_Bi_e 3;

    [-4.83073784166202,1.07263927554824e-15]

    \<gtr\> airy_zero_Ai_deriv 2;

    -3.24819758217984

    \<gtr\> airy_zero_Ai_deriv_e 3;

    [-4.82009921117874,1.07027702504564e-15]

    \<gtr\> airy_zero_Bi_deriv 2;

    -4.07315508907183

    \<gtr\> airy_zero_Bi_deriv_e 3;

    [-5.5123957296636,1.22399773198358e-15]

    \;
  </verbatim>

  <subsubsection|Bessel Functions><label|bessel-functions>

  <\description>
    <item*|gsl::sf::bessel_J0 x<label|gsl::sf::bessel-J0>>implements
    <verbatim|gsl_sf_bessel_J0>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_J0_e x<label|gsl::sf::bessel-J0-e>>implements
    <verbatim|gsl_sf_besselJ0_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_J1 x<label|gsl::sf::bessel-J1>>implements
    <verbatim|gsl_sf_bessel_J1>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_J1_e x<label|gsl::sf::bessel-J1-e>>implements
    <verbatim|gsl_sf_bessel_J1_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Jn n x<label|gsl::sf::bessel-Jn>>implements
    <verbatim|gsl_sf_bessel_Jn>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Jn_e n x<label|gsl::sf::bessel-Jn-e>>implements
    <verbatim|gsl_sf_bessel_Jn_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Jn_array nmin::int nmax::int
    x<label|gsl::sf::bessel-Jn-array>>implements
    <verbatim|gsl_sf_bessel_Jn_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Y0 x<label|gsl::sf::bessel-Y0>>implements
    <verbatim|gsl_sf_bessel_Y0>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Y0_e x<label|gsl::sf::bessel-Y0-e>>implements
    <verbatim|gsl_sf_bessel_Y0_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Y1 x<label|gsl::sf::bessel-Y1>>implements
    <verbatim|gsl_sf_bessel_Y1>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Y1_e x<label|gsl::sf::bessel-Y1-e>>implements
    <verbatim|gsl_sf_bessel_Y1_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Yn x<label|gsl::sf::bessel-Yn>>implements
    <verbatim|gsl_sf_bessel_Yn>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Yn_e x<label|gsl::sf::bessel-Yn-e>>implements
    <verbatim|gsl_sf_bessel_Yn_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Yn_array nmin::int nmax::int
    x<label|gsl::sf::bessel-Yn-array>>implements
    <verbatim|gsl_sf_bessel_Yn_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_I0 x<label|gsl::sf::bessel-I0>>implements
    <verbatim|gsl_sf_bessel_I0>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_I0_e x<label|gsl::sf::bessel-I0-e>>implements
    <verbatim|gsl_sf_bessel_I0_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_I1 x<label|gsl::sf::bessel-I1>>implements
    <verbatim|gsl_sf_bessel_I1>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_I1_e x<label|gsl::sf::bessel-I1-e>>implements
    <verbatim|gsl_sf_bessel_I1_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_In n::int x<label|gsl::sf::bessel-In>>implements
    <verbatim|gsl_sf_bessel_In>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_In_e n::int x<label|gsl::sf::bessel-In-e>>implements
    <verbatim|gsl_sf_bessel_In_e>
  </description>

  <\description>
    <item*|gsl::sf::bessel_In_array nmin::int nmax::int
    x<label|gsl::sf::bessel-In-array>>implements
    <verbatim|gsl_sf_bessel_In_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_I0_scaled x<label|gsl::sf::bessel-I0-scaled>>implements
    <verbatim|gsl_sf_bessel_I0_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_I0_scaled_e x<label|gsl::sf::bessel-I0-scaled-e>>implements
    <verbatim|gsl_sf_bessel_I0_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_I1_scaled x<label|gsl::sf::bessel-I1-scaled>>implements
    <verbatim|gsl_sf_bessel_I1_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_I1_scaled_e x<label|gsl::sf::bessel-I1-scaled-e>>implements
    <verbatim|gsl_sf_bessel_I1_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_In_scaled n::int
    x<label|gsl::sf::bessel-In-scaled>>implements
    <verbatim|gsl_sf_bessel_In_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_In_scaled_e n::int
    x<label|gsl::sf::bessel-In-scaled-e>>implements
    <verbatim|gsl_sf_bessel_In_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_In_scaled_array nmin::int nmax::int
    x<label|gsl::sf::bessel-In-scaled-array>>implements
    <verbatim|gsl_sf_bessel_In_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_K0 x<label|gsl::sf::bessel-K0>>implements
    <verbatim|gsl_sf_bessel_K0>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_K0_e x<label|gsl::sf::bessel-K0-e>>implements
    <verbatim|gsl_sf_bessel_K0_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_K1 x<label|gsl::sf::bessel-K1>>implements
    <verbatim|gsl_sf_bessel_K1>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_K1_e x<label|gsl::sf::bessel-K1-e>>implements
    <verbatim|gsl_sf_bessel_K1_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Kn n::int x<label|gsl::sf::bessel-Kn>>implements
    <verbatim|gsl_sf_bessel_Kn>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Kn_e n::int x<label|gsl::sf::bessel-Kn-e>>implements
    <verbatim|gsl_sf_bessel_Kn_e>
  </description>

  <\description>
    <item*|gsl::sf::bessel_Kn_array nmin::int nmax::int
    x<label|gsl::sf::bessel-Kn-array>>implements
    <verbatim|gsl_sf_bessel_Kn_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_K0_scaled x<label|gsl::sf::bessel-K0-scaled>>implements
    <verbatim|gsl_sf_bessel_K0_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_K0_scaled_e x<label|gsl::sf::bessel-K0-scaled-e>>implements
    <verbatim|gsl_sf_bessel_K0_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_K1_scaled x<label|gsl::sf::bessel-K1-scaled>>implements
    <verbatim|gsl_sf_bessel_K1_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_K1_scaled_e x<label|gsl::sf::bessel-K1-scaled-e>>implements
    <verbatim|gsl_sf_bessel_K1_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Kn_scaled n::int
    x<label|gsl::sf::bessel-Kn-scaled>>implements
    <verbatim|gsl_sf_bessel_Kn_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Kn_scaled_e n::int
    x<label|gsl::sf::bessel-Kn-scaled-e>>implements
    <verbatim|gsl_sf_bessel_Kn_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Kn_scaled_array nmin::int nmax::int
    x<label|gsl::sf::bessel-Kn-scaled-array>>implements
    <verbatim|gsl_sf_bessel_Kn_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_j0 x<label|gsl::sf::bessel-j0>>implements
    <verbatim|gsl_sf_bessel_j0>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_j0_e x<label|gsl::sf::bessel-j0-e>>implements
    <verbatim|gsl_sf_bessel_j0_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_j1 x<label|gsl::sf::bessel-j1>>implements
    <verbatim|gsl_sf_bessel_j1>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_j1_e x<label|gsl::sf::bessel-j1-e>>implements
    <verbatim|gsl_sf_bessel_j1_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_j2 x<label|gsl::sf::bessel-j2>>implements
    <verbatim|gsl_sf_bessel_j2>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_j2_e x<label|gsl::sf::bessel-j2-e>>implements
    <verbatim|gsl_sf_bessel_j2_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_jl l::int x<label|gsl::sf::bessel-jl>>implements
    <verbatim|gsl_sf_bessel_jl>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_jl_e l::int x<label|gsl::sf::bessel-jl-e>>implements
    <verbatim|gsl_sf_bessel_jl_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_jl_array lmax::int
    x<label|gsl::sf::bessel-jl-array>>implements
    <verbatim|gsl_sf_bessel_jl_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_jl_steed_array lmax::int
    x<label|gsl::sf::bessel-jl-steed-array>>implements
    <verbatim|gsl_sf_bessel_jl_steed_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_y0 x<label|gsl::sf::bessel-y0>>implements
    <verbatim|gsl_sf_bessel_y0>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_y0_e x<label|gsl::sf::bessel-y0-e>>implements
    <verbatim|gsl_sf_bessel_y0_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_y1 x<label|gsl::sf::bessel-y1>>implements
    <verbatim|gsl_sf_bessel_y1>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_y1_e x<label|gsl::sf::bessel-y1-e>>implements
    <verbatim|gsl_sf_bessel_y1_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_y2 x<label|gsl::sf::bessel-y2>>implements
    <verbatim|gsl_sf_bessel_y2>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_y2_e x<label|gsl::sf::bessel-y2-e>>implements
    <verbatim|gsl_sf_bessel_y2_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_yl l::int x<label|gsl::sf::bessel-yl>>implements
    <verbatim|gsl_sf_bessel_yl>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_yl_e l::int x<label|gsl::sf::bessel-yl-e>>implements
    <verbatim|gsl_sf_bessel_yl_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_yl_array lmax::int
    x<label|gsl::sf::bessel-yl-array>>implements
    <verbatim|gsl_sf_bessel_yl_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_i0_scaled x<label|gsl::sf::bessel-i0-scaled>>implements
    <verbatim|gsl_sf_bessel_i0_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_i0_scaled_e x<label|gsl::sf::bessel-i0-scaled-e>>implements
    <verbatim|gsl_sf_bessel_i0_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_i1_scaled x<label|gsl::sf::bessel-i1-scaled>>implements
    <verbatim|gsl_sf_bessel_i1_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_i1_scaled_e x<label|gsl::sf::bessel-i1-scaled-e>>implements
    <verbatim|gsl_sf_bessel_i1_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_i2_scaled x<label|gsl::sf::bessel-i2-scaled>>implements
    <verbatim|gsl_sf_bessel_i2_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_i2_scaled_e x<label|gsl::sf::bessel-i2-scaled-e>>implements
    <verbatim|gsl_sf_bessel_i2_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_il_scaled l::int
    x<label|gsl::sf::bessel-il-scaled>>implements
    <verbatim|gsl_sf_bessel_il_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_il_scaled_e l::int
    x<label|gsl::sf::bessel-il-scaled-e>>implements
    <verbatim|gsl_sf_bessel_il_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_il_scaled_array lmax::int
    x<label|gsl::sf::bessel-il-scaled-array>>implements
    <verbatim|gsl_sf_bessel_il_scaled_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_k0_scaled x<label|gsl::sf::bessel-k0-scaled>>implements
    <verbatim|gsl_sf_bessel_k0_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_k0_scaled_e x<label|gsl::sf::bessel-k0-scaled-e>>implements
    <verbatim|gsl_sf_bessel_k0_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_k1_scaled x<label|gsl::sf::bessel-k1-scaled>>implements
    <verbatim|gsl_sf_bessel_k1_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_k1_scaled_e x<label|gsl::sf::bessel-k1-scaled-e>>implements
    <verbatim|gsl_sf_bessel_ik_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_k2_scaled x<label|gsl::sf::bessel-k2-scaled>>implements
    <verbatim|gsl_sf_bessel_k2_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_k2_scaled_e x<label|gsl::sf::bessel-k2-scaled-e>>implements
    <verbatim|gsl_sf_bessel_k2_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_kl_scaled l::int
    x<label|gsl::sf::bessel-kl-scaled>>implements
    <verbatim|gsl_sf_bessel_kl_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_kl_scaled_e l::int
    x<label|gsl::sf::bessel-kl-scaled-e>>implements
    <verbatim|gsl_sf_bessel_kl_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_kl_scaled_array lmax::int
    x<label|gsl::sf::bessel-kl-scaled-array>>implements
    <verbatim|gsl_sf_bessel_il_scaled_array>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Jnu nu x<label|gsl::sf::bessel-Jnu>>implements
    <verbatim|gsl_sf_bessel_Jnu>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Jnu_e nu x<label|gsl::sf::bessel-Jnu-e>>implements
    <verbatim|gsl_sf_bessel_Jnu_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_sequence_Jnu_e nu
    v::matrix<label|gsl::sf::bessel-sequence-Jnu-e>>implements
    <verbatim|gsl_sf_bessel_sequence_Jnu_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Ynu nu x<label|gsl::sf::bessel-Ynu>>implements
    <verbatim|gsl_sf_bessel_Ynu>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Ynu_e nu x<label|gsl::sf::bessel-Ynu-e>>implements
    <verbatim|gsl_sf_bessel_Ynu_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Inu nu x<label|gsl::sf::bessel-Inu>>implements
    <verbatim|gsl_sf_bessel_Inu>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Inu_e nu x<label|gsl::sf::bessel-Inu-e>>implements
    <verbatim|gsl_sf_bessel_Inu_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Inu_scaled nu x<label|gsl::sf::bessel-Inu-scaled>>implements
    <verbatim|gsl_sf_bessel_Inu_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Inu_scaled_e nu
    x<label|gsl::sf::bessel-Inu-scaled-e>>implements
    <verbatim|gsl_sf_bessel_Inu_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Knu nu x<label|gsl::sf::bessel-Knu>>implements
    <verbatim|gsl_sf_bessel_Knu>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Knu_e nu x<label|gsl::sf::bessel-Knu-e>>implements
    <verbatim|gsl_sf_bessel_Knu>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_lnKnu nu x<label|gsl::sf::bessel-lnKnu>>implements
    <verbatim|gsl_sf_bessel_lnKnu>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_lnKnu_e nu x<label|gsl::sf::bessel-lnKnu-e>>implements
    <verbatim|gsl_sf_bessel_lnKnu_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Knu_scaled nu x<label|gsl::sf::bessel-Knu-scaled>>implements
    <verbatim|gsl_sf_bessel_Knu_scaled>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_Knu_scaled_e nu
    x<label|gsl::sf::bessel-Knu-scaled-e>>implements
    <verbatim|gsl_sf_bessel_Knu_scaled_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_zero_J0 s::int<label|gsl::sf::bessel-zero-J0>>implements
    <verbatim|gsl_sf_bessel_zero_J0>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_zero_J0_e s::int<label|gsl::sf::bessel-zero-J0-e>>implements
    <verbatim|gsl_sf_bessel_zero_J0_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_zero_J1 s::int<label|gsl::sf::bessel-zero-J1>>implements
    <verbatim|gsl_sf_bessel_zero_J1>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_zero_J1_e s::int<label|gsl::sf::bessel-zero-J1-e>>implements
    <verbatim|gsl_sf_bessel_zero_J1_e>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_zero_Jnu nu s::int<label|gsl::sf::bessel-zero-Jnu>>implements
    <verbatim|gsl_sf_bessel_zero_Jnu>.
  </description>

  <\description>
    <item*|gsl::sf::bessel_zero_Jnu_e nu s::int<label|gsl::sf::bessel-zero-Jnu-e>>implements
    <verbatim|gsl_sf_bessel_zero_Jnu>.
  </description>

  <subsubsection|Examples>

  The following illustrate the Bessel functions.

  <\verbatim>
    \;

    \<gtr\> using gsl::sf;

    \<gtr\> using namespace gsl::sf;

    \<gtr\> bessel_J0 (-1.2);

    0.671132744264363

    \<gtr\> bessel_J0_e 0.75;

    [0.864242275166649,7.07329111491049e-16]

    \<gtr\> bessel_J1 1.2;

    0.498289057567216

    \<gtr\> bessel_J1_e (-0.2);

    [-0.099500832639236,5.00768737808415e-17]

    \<gtr\> bessel_Jn 0 (-1.2);

    0.671132744264363

    \<gtr\> bessel_Jn_e 2 0.75;

    [0.0670739972996506,5.48959386474892e-17]

    \<gtr\> bessel_Jn_array 0 4 0.5;

    [0.938469807240813,0.242268457674874,0.0306040234586826,

    \ 0.00256372999458724,0.000160736476364288]

    \<gtr\> bessel_Y0 0.25;

    -0.931573024930059

    \<gtr\> bessel_Y0_e 0.25;

    [-0.931573024930059,6.4279898430593e-16]

    \<gtr\> bessel_Y1 0.125;

    -5.19993611253477

    \<gtr\> bessel_Y1_e 4.325;

    [0.343041276811844,2.74577716760089e-16]

    \<gtr\> bessel_Yn 3 4.325;

    -0.0684784962694202

    \<gtr\> bessel_Yn_e 3 4.325;

    [-0.0684784962694202,3.37764590906247e-16]

    \<gtr\> bessel_Yn_array 2 4 1.35;

    [-1.07379345815726,-2.66813016175689,-10.7845628163178]

    \<gtr\> bessel_I0 1.35;

    1.51022709775726

    \<gtr\> bessel_I0_e 1.35;

    [1.51022709775726,2.37852166449918e-15]

    \<gtr\> bessel_I1 0.35;

    0.177693400031422

    \<gtr\> bessel_I1_e 0.35;

    [0.177693400031422,1.55520651386126e-16]

    \<gtr\> bessel_In 2 3.0;

    2.24521244092995

    \<gtr\> bessel_In_e 2 3.0;

    2.24521244092995,5.98244771302867e-15]

    \<gtr\> bessel_In_array 3 5 (-0.1);

    [-2.08463574223272e-05,2.60546902129966e-07,-2.6052519298937e-09]

    \<gtr\> bessel_I0_scaled 1.05;

    0.453242541279856

    \<gtr\> bessel_I0_scaled_e 1.05;

    [0.453242541279856,4.10118141697477e-16]

    \<gtr\> bessel_I1_scaled 1.05;

    0.210226017612868

    \<gtr\> bessel_I1_scaled_e 1.05;

    [0.210226017612868,2.12903131803686e-16]

    \<gtr\> bessel_In_scaled 3 1.05;

    0.00903732602788281

    \<gtr\> bessel_In_scaled_e 3 1.05;

    [0.00903732602788281,2.00668948743994e-17]

    \<gtr\> bessel_In_scaled_array 3 5 1.05;

    [0.00903732602788281,0.0011701685245855,0.000121756316755217]

    \<gtr\> bessel_K0 2.3;

    0.0791399330020936

    \<gtr\> bessel_K0_e 2.3;

    [0.0791399330020936,1.15144454318261e-16]

    \<gtr\> bessel_K1 2.3;

    0.0949824438453627

    \<gtr\> bessel_K1_e 2.3;

    [0.0949824438453627,9.85583638959967e-17]

    \<gtr\> bessel_Kn 2 3.4;

    0.0366633035851529

    \<gtr\> bessel_Kn_e 2 3.4;

    [0.0366633035851529,2.01761856558251e-16]

    \<gtr\> bessel_Kn_array 1 3 2.5;

    [0.0738908163477471,0.121460206278564,0.268227146393449]

    \<gtr\> bessel_K0_scaled 1.5;

    0.367433609054158

    \<gtr\> bessel_K0_scaled_e 1.5;

    [0.958210053294896,1.25816573186951e-14]

    \<gtr\> bessel_K1_scaled 1.5;

    1.24316587355255

    \<gtr\> bessel_K1_scaled_e 1.5;

    [1.24316587355255,2.32370553362606e-15]

    \<gtr\> bessel_Kn_scaled 4 1.5;

    35.4899165934682

    \<gtr\> bessel_Kn_scaled_e 4 1.5;

    [35.4899165934682,3.89252285021454e-14]

    \<gtr\> bessel_Kn_scaled_array 4 6 1.5;

    [35.4899165934682,197.498093175689,1352.14387109806]

    \<gtr\> bessel_j0 0.01;

    0.999983333416666

    \<gtr\> bessel_j0_e 0.01;

    [0.999983333416666,4.44081808400239e-16]

    \<gtr\> bessel_j1 0.2;

    0.0664003806703222

    \<gtr\> bessel_j1_e 0.2;

    [0.0664003806703222,2.94876925856268e-17]

    \<gtr\> bessel_j2 0.3;

    0.00596152486862022

    \<gtr\> bessel_j2_e 0.3;

    [0.00596152486862022,2.64744886840705e-18]

    \<gtr\> bessel_jl 4 0.3;

    8.53642426502516e-06

    \<gtr\> bessel_jl_e 4 0.3;

    [8.53642426502516e-06,1.02355215483598e-19]

    \<gtr\> bessel_jl_array 2 1.2;

    [0.776699238306022,0.34528456985779,0.0865121863384538]

    \<gtr\> bessel_jl_steed_array 2 1.2;

    [0.776699238306022,0.34528456985779,0.0865121863384538]

    \<gtr\> bessel_y0 1;

    -0.54030230586814

    \<gtr\> bessel_y0_e 3;

    [0.329997498866815,2.93096657048522e-16]

    \<gtr\> bessel_y1 3;

    0.062959163602316

    \<gtr\> bessel_y1_e 3.0;

    [0.062959163602316,1.04609100698801e-16]

    \<gtr\> bessel_yl 3 5;

    -0.0154429099129942

    \<gtr\> bessel_yl_e 3 5;

    [-0.0154429099129942,2.87258769784673e-17]

    \<gtr\> bessel_i0_scaled 3;

    0.166253541303889

    \<gtr\> bessel_i0_scaled_e 3;

    [0.166253541303889,7.38314037924188e-17]

    \<gtr\> bessel_i1_scaled 3;

    0.111661944928148

    \<gtr\> bessel_i1_scaled_e 3;

    [0.111661944928148,4.95878648934625e-17]

    \<gtr\> bessel_i2_scaled 3;

    0.0545915963757409

    \<gtr\> bessel_i2_scaled_e 3;

    [0.0545915963757409,2.42435388989563e-17]

    \<gtr\> bessel_il_scaled 3 1;

    0.0037027398773348

    \<gtr\> bessel_il_scaled_e 3 1;

    [0.0037027398773348,8.46838615599053e-17]

    \<gtr\> bessel_il_scaled_array 3 1;

    [0.432332358381693,0.135335283236613,0.0263265086718556,0.0037027398773348]

    \<gtr\> bessel_k0_scaled 3;

    0.523598775598299

    \<gtr\> bessel_k0_scaled_e 3;

    [0.523598775598299,2.32524566533909e-16]

    \<gtr\> bessel_k1_scaled 4;

    0.490873852123405

    \<gtr\> bessel_k1_scaled_e 4;

    [0.490873852123405,2.17991781125539e-16]

    \<gtr\> bessel_k2_scaled 4;

    0.760854470791278

    \<gtr\> bessel_k2_scaled_e 4;

    [0.760854470791278,3.37887260744586e-16]

    \<gtr\> bessel_kl_scaled 2 4;

    0.760854470791278

    \<gtr\> bessel_kl_scaled_e 2 4;

    [0.760854470791278,3.37887260744586e-16]

    \<gtr\> bessel_kl_scaled_array 2 4;

    [0.392699081698724,0.490873852123405,0.760854470791278]

    \<gtr\> bessel_Jnu 2 2.3;

    0.413914591732062

    \<gtr\> bessel_Jnu_e 2 2.3;

    [0.413914591732062,6.43352513956959e-16]

    \<gtr\> bessel_sequence_Jnu_e 2 {.1,.2,.3};

    [0.00124895865879992,0.00498335415278356,0.011165861949064]

    \<gtr\> bessel_Ynu 1 0.5;

    -1.47147239267024

    \<gtr\> bessel_Ynu_e 1 0.5;

    [-1.47147239267024,8.49504515830242e-15]

    \<gtr\> bessel_Inu 1.2 3.4;

    5.25626563437082

    \<gtr\> bessel_Inu_e 1.2 3.4;

    [5.25626563437082,1.00839636820646e-13]

    \<gtr\> bessel_Inu_scaled 1.2 3.4;

    0.175418771999042

    \<gtr\> bessel_Inu_scaled_e 1.2 3.4;

    [0.175418771999042,3.15501414592188e-15]

    \<gtr\> bessel_Knu 3 3;

    0.122170375757184

    \<gtr\> bessel_Knu_e 3 3;

    [0.122170375757184,4.34036365096743e-16]

    \<gtr\> bessel_lnKnu 3 3;

    -2.10233868587978

    \<gtr\> bessel_lnKnu_e 3 3;

    [-2.10233868587978,4.24157124665032e-15]

    \<gtr\> bessel_Knu_scaled 3 3;

    2.45385759319062

    \<gtr\> bessel_Knu_scaled_e 3 3;

    [2.45385759319062,7.6281217575122e-15]

    \<gtr\> bessel_zero_J0 3;

    8.65372791291102

    \<gtr\> bessel_zero_J0_e 3;

    [8.65372791291102,2.59611837387331e-14]

    \<gtr\> bessel_zero_J1 3;

    10.1734681350627

    \<gtr\> bessel_zero_J1_e 3;

    [10.1734681350627,2.03469362701254e-13]

    \<gtr\> bessel_zero_Jnu 1.2 3;

    10.46769

    \<gtr\> bessel_zero_Jnu_e 1.2 3;

    [10.4676986203553,2.09353972407105e-14]86203553

    \;
  </verbatim>

  <subsubsection|Clausen Functions><label|clausen-functions>

  <\description>
    <item*|gsl::sf::clausen x<label|gsl::sf::clausen>>implements
    <verbatim|gsl_sf_clausen>.
  </description>

  <\description>
    <item*|gsl::sf::clausen_e x<label|gsl::sf::clausen-e>>implements
    <verbatim|gsl_sf_clausen_e>.
  </description>

  <subsubsection|Examples>

  The following illustrate the Clausen functions.

  <\verbatim>
    \;

    \<gtr\> using gsl::sf;

    \<gtr\> using namespace gsl::sf;

    \<gtr\> clausen 4.5;

    -0.831839220823219

    \<gtr\> clausen_e 4.5;

    [-0.831839220823219,8.60688668835964e-16]

    \;
  </verbatim>

  <subsubsection|Colomb Functions><label|colomb-functions>

  The results of the Coulomb wave functions are returned as a list whose
  elements are ordered corresponding to the argument order of the
  corresponding C functions in GSL library.

  <\description>
    <item*|gsl::sf::hydrogenicR_1 Z r<label|gsl::sf::hydrogenicR-1>>implements
    <verbatim|gsl_sf_hydrogenicR_1>.
  </description>

  <\description>
    <item*|gsl::sf::hydrogenicR_1_e Z r<label|gsl::sf::hydrogenicR-1-e>>implements
    <verbatim|gsl_sf_hydrogenicR_1_e>.
  </description>

  <\description>
    <item*|gsl::sf::hydrogenicR n::int l::int Z
    r<label|gsl::sf::hydrogenicR>>implements <verbatim|gsl_sf_hydrogenicR_1>.
  </description>

  <\description>
    <item*|gsl::sf::hydrogenicR_e n::int l::int Z
    r<label|gsl::sf::hydrogenicR-e>>implements
    <verbatim|gsl_sf_hydrogenicR_1_e>.
  </description>

  <\description>
    <item*|gsl::sf::coulomb_wave_FG_e eta x L_F
    k::int<label|gsl::sf::coulomb-wave-FG-e>>implements
    <verbatim|gsl_sf_coulomb_wave_FG_e>.
  </description>

  <\description>
    <item*|gsl::sf::coulomb_wave_F_array L_min kmax::int eta
    x<label|gsl::sf::coulomb-wave-F-array>>implements
    <verbatim|gsl_sf_coulomb_wave_F_array>.
  </description>

  <\description>
    <item*|gsl::sf::coulomb_wave_FG_array L_min kmax::int eta
    x<label|gsl::sf::coulomb-wave-FG-array>>implements
    <verbatim|gsl_sf_coulomb_wave_FG_array>.
  </description>

  <\description>
    <item*|gsl::sf::coulomb_wave_FGp_array L_min kmax::int eta
    x<label|gsl::sf::coulomb-wave-FGp-array>>implements
    <verbatim|gsl_sf_coulomb_wave_FGp_array>.
  </description>

  <\description>
    <item*|gsl::sf::coulomb_wave_sphF_array L_min kmax::int eta
    x<label|gsl::sf::coulomb-wave-sphF-array>>implements
    <verbatim|gsl_sf_coulomb_wave_sphF_array>.
  </description>

  <\description>
    <item*|gsl::sf::coulomb_CL_e L eta<label|gsl::sf::coulomb-CL-e>>implements
    <verbatim|gsl_sf_coulomb_wave_CL_e>.
  </description>

  <\description>
    <item*|gsl::sf::coulomb_CL_array Lmin kmax
    eta<label|gsl::sf::coulomb-CL-array>>implements
    <verbatim|gsl_sf_coulomb_wave_CL_array>.
  </description>

  <subsubsection|Examples>

  The following illustrate the Coulomb functions.

  <\verbatim>
    \;

    \<gtr\> using gsl::sf;

    \<gtr\> using namespace gsl::sf;

    \<gtr\> hydrogenicR_1 0.2 4;

    0.0803784086420537

    \<gtr\> hydrogenicR_1_e 0.2 4;

    [0.0803784086420537,2.85561471862841e-17]

    \<gtr\> hydrogenicR 3 1 0.25 3.2;

    0.00802954301593587

    \<gtr\> hydrogenicR_e 3 1 0.25 3.2;

    [0.00802954301593587,3.90138748076797e-17]

    \<gtr\> coulomb_wave_F_array 1 2 0.5 0.5;

    [{0.0387503306520188,0.0038612830533923,0.000274978904710252},0.0]

    \<gtr\> coulomb_wave_FG_array 1 2 0.5 0.5;

    [{0.0387503306520188,0.0038612830533923,0.000274978904710252},

    \ {4.13731494044202,25.4479852847406,257.269816591168},0.0,0.0]

    \<gtr\> coulomb_wave_FGp_array 1 2 0.5 0.5;

    [{0.0387503306520188,0.0038612830533923,0.000274978904710252},

    \ {4.13731494044202,25.4479852847406,257.269816591168},0.0,0.0]

    \<gtr\> coulomb_wave_sphF_array 1 2 0.5 0.5;

    [{0.0775006613040376,0.0077225661067846,0.000549957809420504},0.0]

    \<gtr\> coulomb_CL_e (-0.5) 3;

    [0.000143036170217949,2.92195771135514e-18]

    \<gtr\> coulomb_CL_array (-0.5) 4 1.5;

    [0.0159218263353144,0.0251746178646226,0.00890057150292734,

    \ 0.00172996014234001,0.000235267570111599]

    \;
  </verbatim>

  <subsubsection|Coupling Coefficients><label|coupling-coefficients>

  <\description>
    <item*|gsl::sf::coupling_3j m::matrix<label|gsl::sf::coupling-3j>>implements
    <verbatim|gsl_sf_coupling_3j> except the input is a 2x3 (row by column)
    integer matrix instead of six integer arguments.
  </description>

  <\description>
    <item*|gsl::sf::coupling_3j_e m::matrix<label|gsl::sf::coupling-3j-e>>implements
    <verbatim|gsl_sf_coupling_3j_e> except the input is a 2x3 (row by column)
    integer matrix instead of six integer arguments.
  </description>

  <\description>
    <item*|gsl::sf::coupling_6j m::matrix<label|gsl::sf::coupling-6j>>implements
    <verbatim|gsl_sf_coupling_6j> except the input is a 2x3 (row by column)
    integer matrix instead of six integer arguments.
  </description>

  <\description>
    <item*|gsl::sf::coupling_6j_e m::matrix<label|gsl::sf::coupling-6j-e>>implements
    <verbatim|gsl_sf_coupling_6j_e> except the input is a 2x3 (row by column)
    integer matrix instead of six integer arguments.
  </description>

  <\description>
    <item*|gsl::sf::coupling_9j m::matrix<label|gsl::sf::coupling-9j>>implements
    <verbatim|gsl_sf_coupling_9j> except the input is a 3x3 integer matrix
    instead of six integer arguments.
  </description>

  <\description>
    <item*|gsl::sf::coupling_9j_e m::matrix<label|gsl::sf::coupling-9j-e>>implements
    <verbatim|gsl_sf_coupling_9j_e> except the input is a 3x3 integer matrix
    instead of six integer arguments.
  </description>

  <subsubsection|Examples>

  The following illustrate the coupling coefficient functions.

  <\verbatim>
    \;

    \<gtr\> using gsl::sf;

    \<gtr\> using namespace gsl::sf;

    \<gtr\> coupling_3j {6,4,2;0,0,0};

    -0.29277002188456

    \<gtr\> coupling_3j_e {6,4,2;0,0,0};

    [-0.29277002188456,1.300160076865e-16]

    \<gtr\> coupling_6j {1,2,3;2,1,2};

    -0.166666666666667

    \<gtr\> coupling_6j_e {1,2,3;2,1,2};

    [-0.166666666666667,2.22044604925031e-16]

    \<gtr\> coupling_9j {1,2,3;2,1,2;1,1,1};

    -0.0962250448649376

    \<gtr\> coupling_9j_e {1,2,3;2,1,2;1,1,1};

    [-0.0962250448649376,4.84948508304183e-16]

    \;
  </verbatim>

  <subsubsection|Dawson Function><label|dawson-function>

  <\description>
    <item*|gsl::sf::dawson x<label|gsl::sf::dawson>>implements
    <verbatim|gsl_sf_dawson>.
  </description>

  <\description>
    <item*|gsl::sf::dawson_e x<label|gsl::sf::dawson-e>>implements
    <verbatim|gsl_sf_dawson_e>.
  </description>

  <subsubsection|Examples>

  The following illustrate the dawson functions.

  <\verbatim>
    \;

    \<gtr\> dawson 3;/**-

    0.178271030610558

    \<gtr\> dawson_e 3;

    [0.178271030610558,8.9920386788099e-16]

    \;
  </verbatim>

  <subsubsection|Debye Functions><label|debye-functions>

  <\description>
    <item*|gsl::sf::debye_1 x<label|gsl::sf::debye-1>>implements
    <verbatim|gsl_sf_debye_1>.
  </description>

  <\description>
    <item*|gsl::sf::debye_1_e x<label|gsl::sf::debye-1-e>>implements
    <verbatim|gsl_sf_debye_1_e>.
  </description>

  <\description>
    <item*|gsl::sf::debye_2 x<label|gsl::sf::debye-2>>implements
    <verbatim|gsl_sf_debye_2>.
  </description>

  <\description>
    <item*|gsl::sf::debye_2_e x<label|gsl::sf::debye-2-e>>implements
    <verbatim|gsl_sf_debye_2_e>.
  </description>

  <\description>
    <item*|gsl::sf::debye_3 x<label|gsl::sf::debye-3>>implements
    <verbatim|gsl_sf_debye_3>.
  </description>

  <\description>
    <item*|gsl::sf::debye_3_e x<label|gsl::sf::debye-3-e>>implements
    <verbatim|gsl_sf_debye_3_e>.
  </description>

  <\description>
    <item*|gsl::sf::debye_4 x<label|gsl::sf::debye-4>>implements
    <verbatim|gsl_sf_debye_4>.
  </description>

  <\description>
    <item*|gsl::sf::debye_4_e x<label|gsl::sf::debye-4-e>>implements
    <verbatim|gsl_sf_debye_4_e>.
  </description>

  <\description>
    <item*|gsl::sf::debye_5 x<label|gsl::sf::debye-5>>implements
    <verbatim|gsl_sf_debye_5>.
  </description>

  <\description>
    <item*|gsl::sf::debye_5_e x<label|gsl::sf::debye-5-e>>implements
    <verbatim|gsl_sf_debye_5_e>.
  </description>

  <\description>
    <item*|gsl::sf::debye_6 x<label|gsl::sf::debye-6>>implements
    <verbatim|gsl_sf_debye_6>.
  </description>

  <\description>
    <item*|gsl::sf::debye_6_e x<label|gsl::sf::debye-6-e>>implements
    <verbatim|gsl_sf_debye_6_e>.
  </description>

  <subsubsection|Examples>

  The following illustrate the debye functions.

  <\verbatim>
    \;

    \<gtr\> debye_1 0.4;

    0.904437352623294

    \<gtr\> debye_1_e 0.4;

    [0.904437352623294,3.84040456356756e-16]

    \<gtr\> debye_2 1.4;

    0.613281386045505

    \<gtr\> debye_2_e 1.4;

    [0.613281386045505,5.15090106564116e-16]

    \<gtr\> debye_3 2.4;

    0.370136882985216

    \<gtr\> debye_3_e 2.4;

    [0.370136882985216,6.0792125556598e-16]

    \<gtr\> debye_4 3.4;

    0.205914922541978

    \<gtr\> debye_4_e 3.4;

    [0.205914922541978,7.42872979584512e-16]

    \<gtr\> debye_5 4.4;

    0.107477287722471

    \<gtr\> debye_5_e 4.4;

    [0.107477287722471,2.38647518907499e-17]

    \<gtr\> debye_6 5.4;

    0.0533132925698824

    \<gtr\> debye_6_e 5.4;

    [0.0533132925698824,1.18379289859322e-17]

    \;
  </verbatim>

  <subsubsection|Dilogarithm><label|dilogarithm>

  <\description>
    <item*|gsl::sf::dilog x<label|gsl::sf::dilog>>implements
    <verbatim|gsl_sf_dilog>.
  </description>

  <\description>
    <item*|gsl::sf::dilog (r\<less\>:theta)>implements
    <verbatim|gsl_sf_complex_dilog_e> except that results are returned as the
    complex value <verbatim|re+:im> and the error values are not returned.
  </description>

  <\description>
    <item*|gsl::sf::dilog_e x<label|gsl::sf::dilog-e>>implements
    <verbatim|gsl_sf_dilog_e>.
  </description>

  <\description>
    <item*|gsl::sf::dilog_e (r\<less\>:theta)>implements
    <verbatim|gsl_sf_complex_dilog_e> except the results are returned as the
    list <verbatim|[re+:im,> <verbatim|re_error,> <verbatim|im_error]>.
  </description>

  <subsubsection|Examples>

  The following illustrate the dilog functions.

  <\verbatim>
    \;

    \<gtr\> dilog 1.0;

    1.64493406684823

    \<gtr\> dilog (1\<less\>:2);

    -0.496658586741567+:0.727146050863279

    \<gtr\> dilog_e (1%3);

    [0.366213229977064,8.22687466397711e-15]

    \<gtr\> dilog_e (1\<less\>:3);

    [-0.817454913536463+:0.0980262093913011,3.8224192909699e-15,

    \ 1.47247478976757e-15]

    \;
  </verbatim>

  <\description>
    <item*|gsl::sf::multiply_e x y<label|gsl::sf::multiply-e>>implements
    <verbatim|gsl_sf_multiply_e>.
  </description>

  <\description>
    <item*|gsl::sf::multiply_err_e x dx y
    dy<label|gsl::sf::multiply-err-e>>implements
    <verbatim|gsl_sf_multiply_err_e>.
  </description>

  <subsubsection|Examples>

  The following illustrate the multiply functions.

  <\verbatim>
    \;

    \<gtr\> multiply_e 10.0 11.0;

    [110.0,4.88498130835069e-14]

    \<gtr\> multiply_err_e 10.0 0.04 11.0 0.002;

    [110.0,0.460000000000049]

    \;
  </verbatim>

  <subsection|Matrices><label|module-gsl::matrix>

  This module is loaded via the command <verbatim|using>
  <verbatim|gsl::matrix> and provides wrappers for many of the GSL matrix,
  BLAS, and linear algebra routines found in Chapters 8, 12, and 13,
  respectively of the GSL Reference Manual:

  <\itemize>
    <item><hlink|Vectors and Matrices|http://www.gnu.org/software/gsl/manual/html-node/Vectors-and-Matrices.html>

    <item><hlink|BLAS Support|http://www.gnu.org/software/gsl/manual/html-node/BLAS-Support.html>

    <item><hlink|Linear Algebra|http://www.gnu.org/software/gsl/manual/html-node/Linear-Algebra.html>
  </itemize>

  It also contains some general utility functions for creating various types
  of matrices.

  <subsubsection|Matrix Creation><label|matrix-creation>

  The utility functions <verbatim|zeros> and <verbatim|ones> create matrices
  with all elements zero or one, respectively, and <verbatim|eye> creates
  identity matrices. These functions can be invoked either with a pair
  <with|font-series|bold|(n,m)> denoting the desired number of rows or
  columns, or an integer <with|font-series|bold|n> in which case a square
  <with|font-series|bold|n> x <with|font-series|bold|n> matrix is created.
  The result is always a double matrix. Analogous functions
  <verbatim|izeros>, <verbatim|czeros>, etc. are provided to create integer
  and complex matrices, respectively.

  <\description>
    <item*|gsl::matrix::zeros (n :: int, m ::
    int)<label|gsl::matrix::zeros>>creates an <with|font-series|bold|n> x
    <with|font-series|bold|m> double matrix with all of its entries being
    zero.
  </description>

  <\description>
    <item*|gsl::matrix::zeros n :: int>creates an <with|font-series|bold|n> x
    <with|font-series|bold|n> double matrix with all of its entries being
    zero.
  </description>

  <\description>
    <item*|gsl::matrix::izeros (n :: int, m ::
    int)<label|gsl::matrix::izeros>>creates an <with|font-series|bold|n> x
    <with|font-series|bold|m> integer matrix with all of its entries being
    zero.
  </description>

  <\description>
    <item*|gsl::matrix::izeros n :: int>creates an
    <with|font-series|bold|n`x`n> integer matrix with all of its entries
    being zero.
  </description>

  <\description>
    <item*|gsl::matrix::czeros (n :: int, m ::
    int)<label|gsl::matrix::czeros>>creates an <with|font-series|bold|n> x
    <with|font-series|bold|m> complex matrix with all of its entries being
    zero.
  </description>

  <\description>
    <item*|gsl::matrix::czeros n :: int>creates an <with|font-series|bold|n>
    x <with|font-series|bold|n> complex matrix with all of its entries being
    zero.
  </description>

  <\description>
    <item*|gsl::matrix::ones (n :: int, m ::
    int)<label|gsl::matrix::ones>>creates an <with|font-series|bold|n> x
    <with|font-series|bold|m> double matrix with all of its entries being
    one.
  </description>

  <\description>
    <item*|gsl::matrix::ones n :: int>creates an <with|font-series|bold|n> x
    <with|font-series|bold|n> double matrix with all of its entries being
    one.
  </description>

  <\description>
    <item*|gsl::matrix::iones (n :: int, m ::
    int)<label|gsl::matrix::iones>>creates an <with|font-series|bold|n> x
    <with|font-series|bold|m> integer matrix with all of its entries being
    one.
  </description>

  <\description>
    <item*|gsl::matrix::iones n :: int>creates an <with|font-series|bold|n> x
    <with|font-series|bold|n> integer matrix with all of its entries being
    one.
  </description>

  <\description>
    <item*|gsl::matrix::cones (n :: int, m ::
    int)<label|gsl::matrix::cones>>creates an <with|font-series|bold|n> x
    <with|font-series|bold|m> complex matrix with all of its entries being
    one.
  </description>

  <\description>
    <item*|gsl::matrix::cones n :: int>creates an <with|font-series|bold|n> x
    <with|font-series|bold|n> complex matrix with all of its entries being
    one.
  </description>

  <\description>
    <item*|gsl::matrix::eye (n :: int, m ::
    int)<label|gsl::matrix::eye>>creates an <with|font-series|bold|n> x
    <with|font-series|bold|m> identity matrix with double entries.
  </description>

  <\description>
    <item*|gsl::matrix::eye n :: int>creates an <with|font-series|bold|n> x
    <with|font-series|bold|n> identity matrix with double entries.
  </description>

  <\description>
    <item*|gsl::matrix::ieye (n :: int, m ::
    int)<label|gsl::matrix::ieye>>creates an <with|font-series|bold|n> x
    <with|font-series|bold|m> identity matrix with integer entries.
  </description>

  <\description>
    <item*|gsl::matrix::ieye n :: int>creates an <with|font-series|bold|n> x
    <with|font-series|bold|n> identity matrix with integer entries.
  </description>

  <\description>
    <item*|gsl::matrix::ceye (n :: int, m ::
    int)<label|gsl::matrix::ceye>>creates an <with|font-series|bold|n> x
    <with|font-series|bold|m> identity matrix with complex entries.
  </description>

  <\description>
    <item*|gsl::matrix::ceye n :: int>creates an <with|font-series|bold|n> x
    <with|font-series|bold|n> identity matrix with complex entries.
  </description>

  <subsubsection|Matrix Operators and Functions><label|matrix-operators-and-functions>

  The following operations are defined for constant <verbatim|a> and matrices
  <verbatim|x> and <verbatim|y>. Some operators are not defined in the GSL
  library but are provided here for convenience.

  <\description>
    <item*|a + x<label|+/gsl-matrix>>

    <item*|x + a>returns a matrix with entries <verbatim|a> <verbatim|+>
    <verbatim|x!(i,j)>.
  </description>

  <\description>
    <item*|x + y>adds matrix <verbatim|x> to matrix <verbatim|y>.
  </description>

  <\description>
    <item*|- x<label|-/gsl-matrix>>returns a matrix with entries <verbatim|->
    <verbatim|x!(i,j)>. Note that <verbatim|neg> <verbatim|x> is equivalent
    to <verbatim|-> <verbatim|x>.
  </description>

  <\description>
    <item*|a - x>returns a matrix with entries <verbatim|a> <verbatim|->
    <verbatim|x!(i,j)>.
  </description>

  <\description>
    <item*|x - a>returns a matrix with entries <verbatim|x!(i,j)>
    <verbatim|-> <verbatim|a>.
  </description>

  <\description>
    <item*|x - y>subtracts matrix <verbatim|y> from matrix <verbatim|x>.
  </description>

  <\description>
    <item*|a * x<label|*/gsl-matrix>>

    <item*|x * a>returns a matrix with entries <verbatim|a> <verbatim|*>
    <verbatim|x!(i,j)>.
  </description>

  <\description>
    <item*|x .* y<label|.*/gsl-matrix>>multiplies, element-wise, matrix
    <verbatim|x> to matrix <verbatim|y>.
  </description>

  <\description>
    <item*|x * y>multiplies matrix <verbatim|x> to matrix <verbatim|y>.
  </description>

  <\description>
    <item*|a / x<label|//gsl-matrix>>returns a matrix with entries
    <verbatim|a> <verbatim|/> <verbatim|x!(i,j)>. Note that matrix
    <verbatim|x> must not have any zero entries.
  </description>

  <\description>
    <item*|x / a>returns a matrix with entries <verbatim|x!(i,j)>
    <verbatim|/> <verbatim|a>. Note that <verbatim|a> must be nonzero.
  </description>

  <\description>
    <item*|x ./ y<label|.//gsl-matrix>>divides, element-wise, matrix
    <with|font-series|bold|x> by matrix <with|font-series|bold|y>.
  </description>

  <\description>
    <item*|x / y>right divides matrix <with|font-series|bold|x> by matrix
    <with|font-series|bold|y>.
  </description>

  <\description>
    <item*|x \\ y<label|?5C/gsl-matrix>>left divides matrix
    <with|font-series|bold|x> by matrix <with|font-series|bold|y>.
  </description>

  <\description>
    <item*|a div x<label|div/gsl-matrix>>returns an integer matrix with
    entries <verbatim|a> <verbatim|div> <verbatim|x!(i,j)>. Note that
    <with|font-series|bold|a> must be an integer and matrix <verbatim|x> must
    be an integer matrix with nonzero entries.
  </description>

  <\description>
    <item*|x div a>returns an integer matrix with entries <verbatim|x!(i,j)>
    <verbatim|div> <verbatim|a>. Note that <verbatim|a> must be a nonzero
    integer and matrix <verbatim|x> must have integer entries.
  </description>

  <\description>
    <item*|x div y>computes the quotient integer matrix <verbatim|x> by
    integer matrix <verbatim|y>.
  </description>

  <\description>
    <item*|a mod x<label|mod/gsl-matrix>>returns an integer matrix with
    entries <verbatim|a> <verbatim|mod> <verbatim|x!(i,j)>. Note that
    <verbatim|a> must be an integer and matrix <verbatim|x> must be an
    integer matrix with nonzero entries.
  </description>

  <\description>
    <item*|x mod a>returns an integer matrix with entries <verbatim|a>
    <verbatim|mod> <verbatim|x!(i,j)>. Note that <verbatim|a> must be an
    integer and matrix <verbatim|x> must be an integer matrix with nonzero
    entries.
  </description>

  <\description>
    <item*|x mod y>returns the remainder integer matrix <verbatim|x> mod
    integer matrix <verbatim|y>.
  </description>

  <\description>
    <item*|not x<label|not/gsl-matrix>>returns a matrix with integer entries
    <verbatim|not> <verbatim|x!(i,j)>. Note that <verbatim|x> must be a
    matrix with integer entries and <verbatim|not> is the bitwise negation
    operation.
  </description>

  <\description>
    <item*|a ^ x<label|?5E/gsl-matrix>>returns a matrix with entries
    <verbatim|a> <verbatim|^> <verbatim|x!(i,j)>. Note that <verbatim|0^0> is
    defined as 1.
  </description>

  <\description>
    <item*|x ^ a>returns a matrix with entries <verbatim|x!(i,j)>
    <verbatim|^> <verbatim|a>. Note that <verbatim|0^0> is defined as 1.
  </description>

  <\description>
    <item*|x .^ y<label|.?5E/gsl-matrix>>returns a matrix with entries
    <verbatim|x!(i,j)> <verbatim|^> <verbatim|y!(i,j)>.
  </description>

  <\description>
    <item*|x ^ y>returns a matrix with entries <verbatim|x!(i,j)>
    <verbatim|^> <verbatim|y!(i,j)>.
  </description>

  <\description>
    <item*|x \<less\>\<less\> a<label|\<less\>\<less\>/gsl-matrix>>returns an
    integer matrix with entries <verbatim|x!(i,j)> <verbatim|\<\<>
    <verbatim|a>. Note that <verbatim|a> must be an integer and matrix
    <verbatim|x> must have integer entries.
  </description>

  <\description>
    <item*|x \<less\>\<less\> y>returns an integer matrix with entries
    <verbatim|x!(i,j)> <verbatim|\<\<> <verbatim|y!(i,j)>. Note that
    <verbatim|x> and <verbatim|y> must have integer entries.
  </description>

  <\description>
    <item*|x \<gtr\>\<gtr\> a<label|\<gtr\>\<gtr\>/gsl-matrix>>returns an
    integer matrix with entries <verbatim|x!(i,j)> <verbatim|\>\>>
    <verbatim|a>. Note that <verbatim|a> must be an integer and matrix
    <verbatim|x> must have integer entries.
  </description>

  <\description>
    <item*|x \<gtr\>\<gtr\> y>returns an integer matrix with entries
    <verbatim|x!(i,j)> <verbatim|\>\>> <verbatim|y!(i,j)>. Note that
    <verbatim|x> and <verbatim|y> must have integer entries.
  </description>

  <\description>
    <item*|x and a<label|and/gsl-matrix>>

    <item*|a and x>returns an integer matrix with entries <verbatim|a>
    <verbatim|and> <verbatim|x!(i,j)>. Note that <verbatim|a> must be an
    integer, matrix <verbatim|x> must have integer entries, and
    <verbatim|and> is a bitwise operator.
  </description>

  <\description>
    <item*|x and y>returns an integer matrix with entries <verbatim|x!(i,j)>
    <verbatim|and> <verbatim|y!(i,j)>. Note that <verbatim|x> and
    <verbatim|y> must be matrices with integer entries.
  </description>

  <\description>
    <item*|x or a<label|or/gsl-matrix>>

    <item*|a or x>returns an integer matrix with entries <verbatim|a>
    <verbatim|or> <verbatim|x!(i,j)>. Note that <verbatim|a> must be an
    integer, matrix <verbatim|x> must have integer entries, and <verbatim|or>
    is a bitwise operator.
  </description>

  <\description>
    <item*|x or y>returns an integer matrix with entries <verbatim|x!(i,j)>
    <verbatim|or> <verbatim|y!(i,j)>. Note that <verbatim|x> and <verbatim|y>
    must be matrices with integer entries.
  </description>

  The <verbatim|pow> function computes powers of matrices by repeated matrix
  multiplication.

  <\description>
    <item*|pow x :: matrix k :: int<label|pow/gsl-matrix>>

    <item*|pow x :: matrix k :: bigint>Raises matrix <verbatim|x> to the
    <verbatim|k> th power. Note <verbatim|x> must be a square matrix and
    <verbatim|k> a nonnegative integer.
  </description>

  <subsubsection|Singular Value Decomposition><label|singular-value-decomposition>

  For a given <with|font-series|bold|n> x <with|font-series|bold|m> matrix
  <verbatim|x>, these functions yield a singular-value decomposition
  <verbatim|u>, <verbatim|s>, <verbatim|v> of the matrix such that
  <verbatim|x> <verbatim|==> <verbatim|u*s*transpose> <verbatim|v>, where
  <verbatim|u> and <verbatim|v> are orthogonal matrices of dimensions
  <with|font-series|bold|n> x <with|font-series|bold|m> and
  <with|font-series|bold|n> x <with|font-series|bold|n>, respectively, and
  <with|font-series|bold|s> is a <with|font-series|bold|n> x
  <with|font-series|bold|n> diagonal matrix which has the singular values in
  its diagonal, in descending order. Note that GSL implements this only for
  double matrices right now. Also, GSL only handles the case of square or
  overdetermined systems, but we work around that in our wrapper functions by
  just adding a suitable number of zero rows in the underdetermined case.

  <\description>
    <item*|gsl::matrix::svd x<label|gsl::matrix::svd>>singular-value
    decomposition of matrix <verbatim|x>.
  </description>

  <\description>
    <item*|gsl::matrix::svd_mod x<label|gsl::matrix::svd-mod>>This uses the
    modified Golub-Reinsch algorithm, which is faster if <verbatim|n>
    <verbatim|\>> <verbatim|m> but needs <with|font-series|bold|O(m^2)> extra
    memory as internal workspace.
  </description>

  <\description>
    <item*|gsl::matrix::svd_jacobi x<label|gsl::matrix::svd-jacobi>>This uses
    one-sided Jacobi orthogonalization which provides better relative
    accuracy but is slower.
  </description>

  <\description>
    <item*|gsl::matrix::svd_solve (u, s, v)
    b<label|gsl::matrix::svd-solve>>Solve the system <verbatim|Ax=b>, using
    the SVD of <verbatim|A>. <verbatim|svd_solve> takes the result
    <verbatim|(u,s,v)> of a <verbatim|svd> call, and a column vector
    <verbatim|b> of the appropriate dimension. The result is another column
    vector solving the system (possibly in the least-squares sense).
  </description>

  <\description>
    <item*|gsl::matrix::pinv x<label|gsl::matrix::pinv>>Computes the pseudo
    inverse of a matrix from its singular value decomposition.
  </description>

  <subsection|Least-Squares Fitting><label|module-gsl::fit>

  This module is loaded via the command <verbatim|using> <verbatim|gsl::fit>
  and provides Pure wrappers for the GSL least-squares fitting routines found
  in Chapter 36 of the GSL manual,

  <hlink|http://www.gnu.org/software/gsl/manual/html_node/Least_002dSquares-Fitting.html|http://www.gnu.org/software/gsl/manual/html-node/Least-002dSquares-Fitting.html>.

  <subsubsection|Routines>

  <\description>
    <item*|gsl::fit::linear x::matrix y::matrix<label|gsl::fit::linear>>implements
    <verbatim|gsl_fit_linear> without the <verbatim|xstride>,
    <verbatim|ystride>, and <verbatim|n> parameters. Results are returned as
    a list <verbatim|[c0,> <verbatim|c1,> <verbatim|cov00,> <verbatim|cov01,>
    <verbatim|cov11,> <verbatim|sumsq]>.
  </description>

  <\description>
    <item*|gsl::fit::wlinear x::matrix w::matrix
    y::matrix<label|gsl::fit::wlinear>>implements <verbatim|gsl_fit_wlinear>
    without the <verbatim|xstride>, <verbatim|wstride>, <verbatim|ystride>,
    and <verbatim|n> parameters. Results are given as a list <verbatim|[c0,>
    <verbatim|c1,> <verbatim|cov00,> <verbatim|cov01,> <verbatim|cov11,>
    <verbatim|chisq]>.
  </description>

  <\description>
    <item*|gsl::fit::linear_est x c0::double c1::double cov00::double
    cov01::double cov11::double<label|gsl::fit::linear-est>>implements
    <verbatim|gsl_fit_linear_est>. Results are returned as a list
    <verbatim|[y,> <verbatim|y_err]>.
  </description>

  <\description>
    <item*|gsl::fit::mul x::matrix y::matrix<label|gsl::fit::mul>>implements
    <verbatim|gsl_fit_mul> omitting the parameters <verbatim|xstride>,
    <verbatim|ystride>, and <verbatim|n>. Results are returned as a list
    <verbatim|[c1,> <verbatim|cov11,> <verbatim|sumsq]>.
  </description>

  <\description>
    <item*|gsl::fit::wmul x::matrix w::matrix
    y::matrix<label|gsl::fit::wmul>>implements <verbatim|gsl_fit_wmul>
    omitting the parametrs <verbatim|xstride>, <verbatim|ystride>, and
    <verbatim|n>. Results are returned as a list <verbatim|[c1,>
    <verbatim|cov11,> <verbatim|sumsq]>.
  </description>

  <\description>
    <item*|gsl::fit::mul_est x c1::double
    cov11::double<label|gsl::fit::mul-est>>implements
    <verbatim|gsl_fit_mul_est>. Results are returned as a list <verbatim|[y,>
    <verbatim|y_err]>.
  </description>

  <subsubsection|Examples>

  Usage of each implemented library routine is illustrated below.

  <\verbatim>
    \;

    \<gtr\> using gsl::fit;

    \<gtr\> using namespace gsl::fit;

    \;
  </verbatim>

  The following code determines the equation for the least-squares line
  through the points (1,0.01), (2,1.11), (3,1.9), (4,2.85), and (5,4.01).

  <\verbatim>
    \;

    \<gtr\> Y x = '(a + b * x)

    \<gtr\> when

    \<gtr\> \ \ a:b:_ = linear {1,2,3,4,5} {0.01,1.11,1.9,2.85,4.01}

    \<gtr\> end;

    \<gtr\> Y x;

    -0.946+0.974*x

    \<gtr\> eval $ Y 2;

    1.002

    \;
  </verbatim>

  The following code illustrates estimating y-values without constructing an
  equation for the least-squares line determined by the points
  <verbatim|{x1,x2,x3,...,xn}>, <verbatim|{y1,y2,y3,...,yn}>. Here we
  estimate the <with|font-series|bold|y>-value at <with|font-series|bold|x> =
  1, <with|font-series|bold|x> = 2, and <with|font-series|bold|x> = 3.
  Compare the output above at <with|font-series|bold|x> = 2 to the output at
  <with|font-series|bold|x> = 2 below.

  <\verbatim>
    \;

    \<gtr\> let c0:c1:cov00:cov01:cov11:_ = linear {1,2,3,4,5}

    \<gtr\> \ \ {0.01,1.11,1.9,2.85,4.01};

    \<gtr\> linear_est 1 c0 c1 cov00 cov01 cov11;

    [0.028,0.0838570211729465]

    \<gtr\> linear_est 2 c0 c1 cov00 cov01 cov11;

    [1.002,0.0592958683214944]

    \<gtr\> linear_est 3 c0 c1 cov00 cov01 cov11;

    [1.976,0.0484148737476408]

    \;
  </verbatim>

  Next, we determine a least-squares line through the points (1,0.01),
  (2,1.11), (3,1.9), (4,2.85), and (5,4.01) using weights 0.1, 0.2, 0.3, 0.4,
  and 0.5.

  <\verbatim>
    \;

    \<gtr\> W x = '(a + b * x)

    \<gtr\> when

    \<gtr\> \ \ a:b:_ = wlinear (matrix (1..5))

    \<gtr\> \ \ \ \ \ \ \ \ \ \ {0.1, 0.2, 0.3, 0.4, 0.5}

    \<gtr\> \ \ \ \ \ \ \ \ \ \ {0.01, 1.11, 1.9, 2.85, 4.01};

    \<gtr\> end;

    \<gtr\> W u;

    -0.99+0.986*u

    \<gtr\> eval $ W 2;

    0.982

    \;
  </verbatim>

  The least-squares slope for <verbatim|Y> <verbatim|=> <verbatim|c1>
  <verbatim|*> <verbatim|X> using the points (1,3), (2,5), and (3,7) is
  calculated below. Also, the <with|font-series|bold|y>-values and standard
  error about <with|font-series|bold|x> = 1, 2, and 3 are given.

  <\verbatim>
    \;

    \<gtr\> let c1:cov11:sumsq:_ = mul {1,2,3} {3,5,7};

    \<gtr\> mul_est 1 c1 cov11;

    [2.42857142857143,0.123717914826348]

    \<gtr\> mul_est 2 c1 cov11;

    [4.85714285714286,0.247435829652697]

    \<gtr\> mul_est 3 c1 cov11;

    [7.28571428571428,0.371153744479045]

    \;
  </verbatim>

  The least-squares slope for <verbatim|Y> <verbatim|=> <verbatim|c1>
  <verbatim|*> <verbatim|X> using the points (1,3), (2,5), and (3,7), and
  weights 0.4, 0.9, and 0.4 is calculated below. The approximation of
  y-values and standard error about <with|font-series|bold|x> = 1, 2, and 3
  follows.

  <\verbatim>
    \;

    \<gtr\> let c1:cov11:sumsq:_ = wmul {1,2,3} {0.4,0.9,0.4} {3,5,7};

    \<gtr\> mul_est 1 c1 cov11;

    [2.44736842105263,0.362738125055006]

    \<gtr\> mul_est 2 c1 cov11;

    [4.89473684210526,0.725476250110012]

    \<gtr\> mul_est 3 c1 cov11;

    [7.34210526315789,1.08821437516502]

    \;
  </verbatim>

  <subsection|Statistics><label|module-gsl::stats>

  This module is loaded via the command <verbatim|using>
  <verbatim|gsl::stats> and provides Pure wrappers for the GSL Statistics
  routines found in Chapter 20 of the GSL manual,

  <hlink|http://www.gnu.org/software/gsl/manual/html_node/Statistics.html|http://www.gnu.org/software/gsl/manual/html-node/Statistics.html>.

  <subsubsection|Routines>

  <\description>
    <item*|gsl::stats::mean data::matrix<label|gsl::stats::mean>>implements
    <verbatim|gsl_stats_mean> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::variance data::matrix<label|gsl::stats::variance>>implements
    <verbatim|gsl_stats_variance> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::variance data::matrix mean>implements
    <verbatim|gsl_stats_variance_m> without <verbatim|stride> and
    <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::sd data::matrix<label|gsl::stats::sd>>implements
    <verbatim|gsl_stats_sd> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::sd_m data::matrix mean<label|gsl::stats::sd-m>>implements
    <verbatim|gsl_stats_sd_m> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::tss data::matrix<label|gsl::stats::tss>>implements
    <verbatim|gsl_stats_tss> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::tss_m data::matrix
    mean<label|gsl::stats::tss-m>>implements <verbatim|gsl_stats_tss_m>
    without <verbatim|stride> and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::variance_with_fixed_mean data::matrix
    mean<label|gsl::stats::variance-with-fixed-mean>>implements
    <verbatim|gsl_stats_variance_with_fixed_mean> without <verbatim|stride>
    and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::sd_with_fixed_mean data::matrix
    mean<label|gsl::stats::sd-with-fixed-mean>>implements
    <verbatim|gsl_stats_sd_with_fixed_mean> without <verbatim|stride> and
    <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::absdev data::matrix<label|gsl::stats::absdev>>implements
    <verbatim|gsl_stats_absdev> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::absdev_m data::matrix
    mean<label|gsl::stats::absdev-m>>implements <verbatim|gsl_stats_absdev_m>
    without <verbatim|stride> and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::skew data::matrix mean<label|gsl::stats::skew>>implements
    <verbatim|gsl_stats_skew> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::skew_m_sd data::matrix mean
    sd<label|gsl::stats::skew-m-sd>>implements <verbatim|gsl_stats_skew_m_sd>
    without <verbatim|stride> and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::kurtosis data::matrix<label|gsl::stats::kurtosis>>implements
    <verbatim|gsl_stats_kurtosis> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::kurtosis_m_sd data::matrix mean
    sd<label|gsl::stats::kurtosis-m-sd>>implements
    <verbatim|gsl_stats_kurtosis_m_sd> without <verbatim|stride> and
    <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::lag1_autocorrelation
    data::matrix<label|gsl::stats::lag1-autocorrelation>>implements
    <verbatim|gsl_stats_lag1_autocorrelation> without <verbatim|stride> and
    <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::lag1_autocorrelation_m data::matrix
    mean<label|gsl::stats::lag1-autocorrelation-m>>implements
    <verbatim|gsl_stats_lag1_autocorrelation_m> without <verbatim|stride> and
    <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::covariance d1::matrix
    d2::matrix<label|gsl::stats::covariance>>implements
    <verbatim|gsl_stats_covariance> without <verbatim|stride1>,
    <verbatim|stride2>, and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::covariance_m d1::matrix d2::matrix mean1
    mean2<label|gsl::stats::covariance-m>>implements
    <verbatim|gsl_stats_covariance_m> without <verbatim|stride1>,
    <verbatim|stride2>, and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::correlation d1::matrix
    d2::matrix<label|gsl::stats::correlation>>implements
    <verbatim|gsl_stats_correlation> without <verbatim|stride1>,
    <verbatim|stride2>, and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::wmean weight::matrix
    data::matrix<label|gsl::stats::wmean>>implements
    <verbatim|gsl_stats_wmean> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::wvariance weight::matrix
    data::matrix<label|gsl::stats::wvariance>>implements
    <verbatim|gsl_stats_wvariance> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::wvariance_m weight::matrix data::matrix
    mean<label|gsl::stats::wvariance-m>>implements
    <verbatim|gsl_stats_wvariance_m> without <verbatim|stride> and
    <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::wsd weight::matrix
    data::matrix<label|gsl::stats::wsd>>implements <verbatim|gsl_stats_wsd>
    without <verbatim|stride> and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::wsd_m weight::matrix data::matrix
    mean<label|gsl::stats::wsd-m>>implements <verbatim|gsl_stats_wsd_m>
    without <verbatim|stride> and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::wvariance_with_fixed_mean weight::matrix data::matrix
    mean<label|gsl::stats::wvariance-with-fixed-mean>>implements
    <verbatim|gsl_stats_wvariance_with_fixed_mean> without <verbatim|stride>
    and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::wsd_with_fixed_mean weight::matrix data::matrix
    mean<label|gsl::stats::wsd-with-fixed-mean>>implements
    <verbatim|gsl_stats_wsd_with_fixed_mean> without <verbatim|stride> and
    <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::wtss weight::matrix
    data::matrix<label|gsl::stats::wtss>>implements <verbatim|gsl_stats_wtss>
    without <verbatim|stride> and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::wtss_m weight::matrix data::matrix
    mean<label|gsl::stats::wtss-m>>implements <verbatim|gsl_stats_wtss_m>
    without <verbatim|stride> and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::wabsdev weight::matrix
    data::matrix<label|gsl::stats::wabsdev>>implements
    <verbatim|gsl_stats_wabsdev> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::wabsdev_m weight::matrix data::matrix
    mean<label|gsl::stats::wabsdev-m>>implements
    <verbatim|gsl_stats_wabsdev_m> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::wskew weight::matrix
    data::matrix<label|gsl::stats::wskew>>implements
    <verbatim|gsl_stats_wskew> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::wskew_m_sd weight::matrix data::matrix mean
    sd<label|gsl::stats::wskew-m-sd>>implements
    <verbatim|gsl_stats_wskew_m_sd> without <verbatim|stride> and
    <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::wkurtosis weight::matrix
    data::matrix<label|gsl::stats::wkurtosis>>implements
    <verbatim|gsl_stats_wkurtosis> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::wkurtosis_m_sd weight::matrix
    data::matrix<label|gsl::stats::wkurtosis-m-sd>>implements
    <verbatim|gsl_stats_wkurtosis_m_sd> without <verbatim|stride> and
    <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::max data::matrix<label|gsl::stats::max>>implements
    <verbatim|gsl_stats_max> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::min data::matrix<label|gsl::stats::min>>implements
    <verbatim|gsl_stats_min> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::minmax data::matrix<label|gsl::stats::minmax>>implements
    <verbatim|gsl_stats_minmax> without <verbatim|stride> and <verbatim|n>
    arguments. Results are returned as a list <verbatim|[min,>
    <verbatim|max]>.
  </description>

  <\description>
    <item*|gsl::stats::min_index data::matrix<label|gsl::stats::min-index>>implements
    <verbatim|gsl_stats_min_index> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::max_index data::matrix<label|gsl::stats::max-index>>implements
    <verbatim|gsl_stats_max_index> without <verbatim|stride> and <verbatim|n>
    arguments.
  </description>

  <\description>
    <item*|gsl::stats::minmax_index data::matrix<label|gsl::stats::minmax-index>>implements
    <verbatim|gsl_stats_minmax_index> without <verbatim|stride> and
    <verbatim|n> arguments. Results are returned as a list
    <verbatim|[min_index,> <verbatim|max_index]>.
  </description>

  <\description>
    <item*|gsl::stats::median_from_sorted_data
    data::matrix<label|gsl::stats::median-from-sorted-data>>implements
    <verbatim|gsl_stats_median_from_sorted_data> without <verbatim|stride>
    and <verbatim|n> arguments.
  </description>

  <\description>
    <item*|gsl::stats::quantile_from_sorted_data data::matrix
    f::double<label|gsl::stats::quantile-from-sorted-data>>implements
    <verbatim|gsl_stats_quantile_from_sorted_data> without <verbatim|stride>
    and <verbatim|n> arguments.
  </description>

  <subsubsection|Examples>

  The following illustrates the use of each function in the <verbatim|stats>
  module.

  <\verbatim>
    \;

    \<gtr\> using gsl::stats;

    \<gtr\> using namespace gsl::stats;

    \<gtr\> mean {1,2,3,4,5};

    3.0

    \<gtr\> variance {1,2,3,4,5};

    2.5

    \<gtr\> variance_m {1,2,3,4,5} \ 4;

    3.75

    \<gtr\> sd {1,2,3,4,5};

    1.58113883008419

    \<gtr\> sd_m {1,2,3,4,5} 4;

    1.93649167310371

    \<gtr\> tss {1,2,3,4,5};

    10.0

    \<gtr\> tss_m {1,2,3,4,5} 4;

    15.0

    \<gtr\> variance_with_fixed_mean {0.0,1.2,3.4,5.6,6.0} 4.1;

    6.314

    \<gtr\> sd_with_fixed_mean {0.0,1.2,3.4,5.6,6.0} 4.1;

    2.51276739870606

    \<gtr\> absdev {2,2,3,4,4};

    0.8

    \<gtr\> absdev_m {2,2,3,4,4} 4;

    1.0

    \<gtr\> skew {1,1,1,1,2,2,2,2,2,2,2,2,3,30};

    2.94796699504537

    \<gtr\> skew_m_sd {1,2,2,3,3,3,3,3,3,3,4,4,5} 3 1;

    0.0

    \<gtr\> kurtosis \ {1,2,2,3,3,3,3,3,3,3,4,4,5};

    -0.230769230769231

    \<gtr\> kurtosis_m_sd {1,2,2,3,3,3,3,3,3,3,4,4,5} 3 1;

    -0.230769230769231

    \<gtr\> lag1_autocorrelation {1,2,3,4,5};

    0.4

    \<gtr\> lag1_autocorrelation_m {1,2,3,4,5} 2.5;

    0.444444444444444

    \<gtr\> covariance {1,2,3,4,5} {3.0,4.5,6.0,7.5,9.0};

    3.75

    \<gtr\> covariance_m {1,2,3,4,5} {3.0,4.5,6.0,7.5,9.0} 3 6;

    3.75

    \<gtr\> correlation {1,2,3,4} {2,3,4,5};

    1.0

    \<gtr\> wmean {0.4,0.2,0.3,0.3,0.3} {2,3,4,5,6};

    3.93333333333333

    \<gtr\> wvariance {0.4,0.2,0.3,0.3,0.3} {2,3,4,5,6};

    2.7752808988764

    \<gtr\> wvariance_m {0.4,0.2,0.3,0.3,0.3} {2,3,4,5,6} 3.0;

    3.87640449438202

    \<gtr\> wsd {0.4,0.2,0.3,0.3,0.3} {2,3,4,5,6};

    1.66591743459164

    \<gtr\> wsd_m {0.4,0.2,0.3,0.3,0.3} {2,3,4,5,6} 3.0;

    1.96885867811329

    \<gtr\> wvariance_with_fixed_mean {1,2,3,4} {1,2,3,4} 2.5;

    1.25

    \<gtr\> wsd_with_fixed_mean {1,2,3,4} {1,2,3,4} 2.5;

    1.11803398874989

    \<gtr\> wtss {1,1,2,2} {2,3,4,5};

    6.83333333333333

    \<gtr\> wtss_m {1,1,2,2} {2,3,4,5} 3.1;

    10.06

    \<gtr\> wabsdev {1,1,2,2} {2,3,4,5};

    0.888888888888889

    \<gtr\> wabsdev_m {1,1,2,2} {2,3,4,5} 3.1;

    1.13333333333333

    \<gtr\> wskew {1,1,2,2} {2,3,4,5};

    -0.299254338484713

    \<gtr\> wskew_m_sd {1,1,2,2} {2,3,4,5} 3.1 1.2;

    1.33526234567901

    \<gtr\> wkurtosis {1,1,2,2} {2,3,4,5};

    -1.96206512878137

    \<gtr\> wkurtosis_m_sd {1,1,2,2} {2,3,4,5} 3.1 1.2;

    -0.681921939300412

    \<gtr\> min {9,4,2,1,9};

    1

    \<gtr\> max {9.1,4.2,2.6,1.1,9.2};

    9.2

    \<gtr\> minmax {9.0,4.0,2.0,1.0,9.0};

    [1.0,9.0]

    \<gtr\> min_index {9.1,4.2,2.6,1.1,9.2};

    3

    \<gtr\> max_index {9,4,2,1,9};

    0

    \<gtr\> minmax_index {9,4,2,1,0,9};

    [4,0]

    \<gtr\> median_from_sorted_data {1.0,2.0,3.0};

    2.0

    \<gtr\> quantile_from_sorted_data {1.0,2.0,3.0} 0.25;

    1.5

    \;
  </verbatim>

  <subsection|Random Number Distributions><label|module-gsl::randist>

  This module is loaded via the command <verbatim|using>
  <verbatim|gsl::randist> and provides Pure wrappers for the GSL random
  distribution routines found in Chapter 19 of the GSL manual,

  <hlink|http://www.gnu.org/software/gsl/manual/html_node/Random-Number-Distributions.html|http://www.gnu.org/software/gsl/manual/html-node/Random-Number-Distributions.html>.

  There are two namespaces provided by randist.pure, <verbatim|gsl::ran> for
  probability densitity functions and <verbatim|gsl::cdf> for cumulative
  distribution functions. The two namespaces minimize typing of the prefixes
  <verbatim|gsl_ran_> and <verbatim|gsl_cdf_> respectively.

  <subsubsection|Routines>

  <\description>
    <item*|gsl::ran::ugaussian_pdf x<label|gsl::ran::ugaussian-pdf>>implements
    <verbatim|gsl_ran_ugaussian>.
  </description>

  <\description>
    <item*|gsl::ran::gaussian_pdf x sigma<label|gsl::ran::gaussian-pdf>>implements
    <verbatim|gsl_ran_gaussian_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::gaussian_tail_pdf x a
    sigma<label|gsl::ran::gaussian-tail-pdf>>implements
    <verbatim|gsl_ran_gaussian_tail_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::ugaussian_tail_pdf x
    a<label|gsl::ran::ugaussian-tail-pdf>>implements
    <verbatim|gsl_ran_ugaussian_tail_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::bivariate_gaussian_pdf x
    a<label|gsl::ran::bivariate-gaussian-pdf>>implements
    <verbatim|gsl_ran_bivariate_gaussian_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::exponential_pdf x mu<label|gsl::ran::exponential-pdf>>implements
    <verbatim|gsl_ran_exponential_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::laplace_pdf x a<label|gsl::ran::laplace-pdf>>implements
    <verbatim|gsl_ran_laplace_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::exppow_pdf x a b<label|gsl::ran::exppow-pdf>>implements
    <verbatim|gsl_ran_exppow_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::cauchy_pdf x a<label|gsl::ran::cauchy-pdf>>implements
    <verbatim|gsl_ran_cauchy_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::rayleigh_pdf x sigma<label|gsl::ran::rayleigh-pdf>>implements
    <verbatim|gsl_ran_rayleigh_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::rayleigh_tail_pdf x a
    sigma<label|gsl::ran::rayleigh-tail-pdf>>implements
    <verbatim|gsl_ran_rayleigh_tail_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::landau_pdf x<label|gsl::ran::landau-pdf>>implements
    <verbatim|gsl_ran_landau_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::gamma_pdf x a b<label|gsl::ran::gamma-pdf>>implements
    <verbatim|gsl_ran_gamma_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::flat_pdf x a b<label|gsl::ran::flat-pdf>>implements
    <verbatim|gsl_ran_flat_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::lognormal_pdf x zeta
    sigma<label|gsl::ran::lognormal-pdf>>implements
    <verbatim|gsl_ran_lognormal_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::chisq_pdf x nu<label|gsl::ran::chisq-pdf>>implements
    <verbatim|gsl_ran_chisq_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::fdist_pdf x nu1 nu2<label|gsl::ran::fdist-pdf>>implements
    <verbatim|gsl_ran_fdist_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::tdist_pdf x nu<label|gsl::ran::tdist-pdf>>implements
    <verbatim|gsl_ran_tdist_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::beta_pdf x a b<label|gsl::ran::beta-pdf>>implements
    <verbatim|gsl_ran_beta_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::logistic_pdf x a<label|gsl::ran::logistic-pdf>>implements
    <verbatim|gsl_ran_logistic_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::pareto_pdf x a b<label|gsl::ran::pareto-pdf>>implements
    <verbatim|gsl_ran_pareto_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::weibull_pdf x a b<label|gsl::ran::weibull-pdf>>implements
    <verbatim|gsl_ran_weibull_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::gumbel1_pdf x a b<label|gsl::ran::gumbel1-pdf>>implements
    <verbatim|gsl_ran_gumbel1_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::gumbel2_pdf x a b<label|gsl::ran::gumbel2-pdf>>implements
    <verbatim|gsl_ran_gumbel2_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::dirichlet_pdf alpha::matrix
    theta::matrix<label|gsl::ran::dirichlet-pdf>>implements
    <verbatim|gsl_ran_dirichlet_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::dirichlet_lnpdf alpha::matrix
    theta::matrix<label|gsl::ran::dirichlet-lnpdf>>implements
    <verbatim|gsl_ran_dirichlet_lnpdf>.
  </description>

  <\description>
    <item*|gsl::ran::discrete_preproc p::matrix<label|gsl::ran::discrete-preproc>>implements
    <verbatim|gsl_ran_discrete_preproc> without the <verbatim|K> parameter.
  </description>

  <\description>
    <item*|gsl::ran::discrete_pdf k::int p::pointer<label|gsl::ran::discrete-pdf>>implements
    <verbatim|gsl_ran_discrete_pdf> without the <verbatim|K> parameter.
  </description>

  <\description>
    <item*|gsl::ran::discrete_free p::pointer<label|gsl::ran::discrete-free>>implements
    <verbatim|gsl_ran_discrete_free>
  </description>

  <\description>
    <item*|gsl::ran::poisson_pdf k::int mu<label|gsl::ran::poisson-pdf>>implements
    <verbatim|gsl_ran_poisson_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::bernoulli_pdf k::int
    p<label|gsl::ran::bernoulli-pdf>>implements
    <verbatim|gsl_ran_bernoulli_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::binomial_pdf k::int p
    n::int<label|gsl::ran::binomial-pdf>>implements
    <verbatim|gsl_ran_binomial_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::multinomial_pdf p::matrix
    n::matrix<label|gsl::ran::multinomial-pdf>>implements
    <verbatim|gsl_ran_multinomial_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::multinomial_lnpdf p::matrix
    n::matrix<label|gsl::ran::multinomial-lnpdf>>implements
    <verbatim|gsl_ran_multinomial_lnpdf>.
  </description>

  <\description>
    <item*|gsl::ran::negative_binomial_pdf k::int p
    n<label|gsl::ran::negative-binomial-pdf>>implements
    <verbatim|gsl_ran_negative_binomial_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::pascal_pdf k::int p n::int<label|gsl::ran::pascal-pdf>>implements
    <verbatim|gsl_ran_pascal_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::geometric_pdf k::int
    p<label|gsl::ran::geometric-pdf>>implements
    <verbatim|gsl_ran_geometric_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::hypergeometric_pdf k::int n1::int n2::int
    t::int<label|gsl::ran::hypergeometric-pdf>>implements
    <verbatim|gsl_ran_hypergeometric_pdf>.
  </description>

  <\description>
    <item*|gsl::ran::logarithmic_pdf k::int
    p<label|gsl::ran::logarithmic-pdf>>implements
    <verbatim|gsl_ran_logarithmic_pdf>.
  </description>

  <\description>
    <item*|gsl::cdf::ugaussian_P x<label|gsl::cdf::ugaussian-P>>implements
    <verbatim|gsl_cdf_ugaussian_P>.
  </description>

  <\description>
    <item*|gsl::cdf::ugaussian_Q x<label|gsl::cdf::ugaussian-Q>>implements
    <verbatim|gsl_cdf_ugaussian_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::ugaussian_Pinv p<label|gsl::cdf::ugaussian-Pinv>>implements
    <verbatim|gsl_cdf_ugaussian_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::ugaussian_Qinv q<label|gsl::cdf::ugaussian-Qinv>>implements
    <verbatim|gsl_cdf_ugaussian_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::gaussian_P x sigma<label|gsl::cdf::gaussian-P>>implements
    <verbatim|gsl_cdf_gaussian_P>.
  </description>

  <\description>
    <item*|gsl::cdf::gaussian_Q x sigma<label|gsl::cdf::gaussian-Q>>implements
    <verbatim|gsl_cdf_gaussian_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::gaussian_Pinv p sigma<label|gsl::cdf::gaussian-Pinv>>implements
    <verbatim|gsl_cdf_gaussian_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::guassian_Qinv q sigma<label|gsl::cdf::guassian-Qinv>>implements
    <verbatim|gsl_cdf_gaussian_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::exponential_P x mu<label|gsl::cdf::exponential-P>>implements
    <verbatim|gsl_cdf_exponential_P>.
  </description>

  <\description>
    <item*|gsl::cdf::exponential_Q x mu<label|gsl::cdf::exponential-Q>>implements
    <verbatim|gsl_cdf_exponential_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::exponential_Pinv p mu<label|gsl::cdf::exponential-Pinv>>implements
    <verbatim|gsl_cdf_exponential_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::exponential_Qinv q mu<label|gsl::cdf::exponential-Qinv>>implements
    <verbatim|gsl_cdf_exponential_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::laplace_P x a<label|gsl::cdf::laplace-P>>implements
    <verbatim|gsl_cdf_laplace_P>.
  </description>

  <\description>
    <item*|gsl::cdf::laplace_Q x a<label|gsl::cdf::laplace-Q>>implements
    <verbatim|gsl_cdf_laplace_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::laplace_Pinv p a<label|gsl::cdf::laplace-Pinv>>implements
    <verbatim|gsl_cdf_laplace_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::laplace_Qinv q a<label|gsl::cdf::laplace-Qinv>>implements
    <verbatim|gsl_cdf_laplace_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::exppow_P x a b<label|gsl::cdf::exppow-P>>implements
    <verbatim|gsl_cdf_exppow_P>.
  </description>

  <\description>
    <item*|gsl::cdf::exppow_Q x a b<label|gsl::cdf::exppow-Q>>implements
    <verbatim|gsl_cdf_exppow_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::cauchy_P x a<label|gsl::cdf::cauchy-P>>implements
    <verbatim|gsl_cdf_cauchy_P>.
  </description>

  <\description>
    <item*|gsl::cdf::cauchy_Q x a<label|gsl::cdf::cauchy-Q>>implements
    <verbatim|gsl_cdf_cauchy_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::cauchy_Pinv p a<label|gsl::cdf::cauchy-Pinv>>implements
    <verbatim|gsl_cdf_cauchy_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::cauchy_Qinv q a<label|gsl::cdf::cauchy-Qinv>>implements
    <verbatim|gsl_cdf_cauchy_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::rayleigh_P x sigma<label|gsl::cdf::rayleigh-P>>implements
    <verbatim|gsl_cdf_rayleigh_P>.
  </description>

  <\description>
    <item*|gsl::cdf::rayleigh_Q x sigma<label|gsl::cdf::rayleigh-Q>>implements
    <verbatim|gsl_cdf_rayleigh_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::rayleigh_Pinv p sigma<label|gsl::cdf::rayleigh-Pinv>>implements
    <verbatim|gsl_cdf_rayleigh_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::rayleigh_Qinv q sigma<label|gsl::cdf::rayleigh-Qinv>>implements
    <verbatim|gsl_cdf_rayleigh_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::gamma_P x a b<label|gsl::cdf::gamma-P>>implements
    <verbatim|gsl_cdf_gamma_P>.
  </description>

  <\description>
    <item*|gsl::cdf::gamma_Q x a b<label|gsl::cdf::gamma-Q>>implements
    <verbatim|gsl_cdf_gamMa_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::gamma_Pinv p a b<label|gsl::cdf::gamma-Pinv>>implements
    <verbatim|gsl_cdf_gamma_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::gamma_Qinv q a b<label|gsl::cdf::gamma-Qinv>>implements
    <verbatim|gsl_cdf_gamma_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::flat_P x a b<label|gsl::cdf::flat-P>>implements
    <verbatim|gsl_cdf_flat_P>.
  </description>

  <\description>
    <item*|gsl::cdf::flat_Q x a b<label|gsl::cdf::flat-Q>>implements
    <verbatim|gsl_cdf_flat_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::flat_Pinv p a b<label|gsl::cdf::flat-Pinv>>implements
    <verbatim|gsl_cdf_flat_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::flat_Qinv q a b<label|gsl::cdf::flat-Qinv>>implements
    <verbatim|gsl_cdf_flat_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::lognormal_P x zeta sigma<label|gsl::cdf::lognormal-P>>implements
    <verbatim|gsl_cdf_lognormal_P>.
  </description>

  <\description>
    <item*|gsl::cdf::lognormal_Q x zeta sigma<label|gsl::cdf::lognormal-Q>>implements
    <verbatim|gsl_cdf_lognormal_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::lognormal_Pinv p zeta
    sigma<label|gsl::cdf::lognormal-Pinv>>implements
    <verbatim|gsl_cdf_lognormal_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::lognormal_Qinv q zeta
    sigma<label|gsl::cdf::lognormal-Qinv>>implements
    <verbatim|gsl_cdf_lognormal_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::chisq_P x nu<label|gsl::cdf::chisq-P>>implements
    <verbatim|gsl_cdf_chisq_P>.
  </description>

  <\description>
    <item*|gsl::cdf::chisq_Q x nu<label|gsl::cdf::chisq-Q>>implements
    <verbatim|gsl_cdf_chisq_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::chisq_Pinv p nu<label|gsl::cdf::chisq-Pinv>>implements
    <verbatim|gsl_cdf_chisq_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::chisq_Qinv q nu<label|gsl::cdf::chisq-Qinv>>implements
    <verbatim|gsl_cdf_chisq_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::fdist_P x nu1 nu2<label|gsl::cdf::fdist-P>>implements
    <verbatim|gsl_cdf_fdist_P>.
  </description>

  <\description>
    <item*|gsl::cdf::fdist_Q x nu1 nu2<label|gsl::cdf::fdist-Q>>implements
    <verbatim|gsl_cdf_fdist_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::fdist_Pinv p nu1 nu2<label|gsl::cdf::fdist-Pinv>>implements
    <verbatim|gsl_cdf_fdist_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::fdist_Qinv q nu1 nu2<label|gsl::cdf::fdist-Qinv>>implements
    <verbatim|gsl_cdf_fdist_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::tdist_P x nu<label|gsl::cdf::tdist-P>>implements
    <verbatim|gsl_cdf_tdist_P>.
  </description>

  <\description>
    <item*|gsl::cdf::tdist_Q x nu<label|gsl::cdf::tdist-Q>>implements
    <verbatim|gsl_cdf_tdist_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::tdist_Pinv p nu<label|gsl::cdf::tdist-Pinv>>implements
    <verbatim|gsl_cdf_tdist_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::tdist_Qinv q nu<label|gsl::cdf::tdist-Qinv>>implements
    <verbatim|gsl_cdf_tdist_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::beta_P x a b<label|gsl::cdf::beta-P>>implements
    <verbatim|gsl_cdf_beta_P>.
  </description>

  <\description>
    <item*|gsl::cdf::beta_Q x a b<label|gsl::cdf::beta-Q>>implements
    <verbatim|gsl_cdf_beta_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::beta_Pinv p a b<label|gsl::cdf::beta-Pinv>>implements
    <verbatim|gsl_cdf_beta_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::beta_Qinv q a b<label|gsl::cdf::beta-Qinv>>implements
    <verbatim|gsl_cdf_beta_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::logistic_P x a<label|gsl::cdf::logistic-P>>implements
    <verbatim|gsl_cdf_logistic_P>.
  </description>

  <\description>
    <item*|gsl::cdf::logistic_Q x a<label|gsl::cdf::logistic-Q>>implements
    <verbatim|gsl_cdf_logistic_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::logistic_Pinv p a<label|gsl::cdf::logistic-Pinv>>implements
    <verbatim|gsl_cdf_logistic_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::logistic_Qinv q a<label|gsl::cdf::logistic-Qinv>>implements
    <verbatim|gsl_cdf_logistic_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::pareto_P x a b<label|gsl::cdf::pareto-P>>implements
    <verbatim|gsl_cdf_pareto_P>.
  </description>

  <\description>
    <item*|gsl::cdf::pareto_Q x a b<label|gsl::cdf::pareto-Q>>implements
    <verbatim|gsl_cdf_pareto_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::pareto_Pinv p a b<label|gsl::cdf::pareto-Pinv>>implements
    <verbatim|gsl_cdf_pareto_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::pareto_Qinv q a b<label|gsl::cdf::pareto-Qinv>>implements
    <verbatim|gsl_cdf_pareto_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::weibull_P x a b<label|gsl::cdf::weibull-P>>implements
    <verbatim|gsl_cdf_weibull_P>.
  </description>

  <\description>
    <item*|gsl::cdf::weibull_Q x a b<label|gsl::cdf::weibull-Q>>implements
    <verbatim|gsl_cdf_weibull_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::weibull_Pinv p a b<label|gsl::cdf::weibull-Pinv>>implements
    <verbatim|gsl_cdf_weibull_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::weibull_Qinv q a b<label|gsl::cdf::weibull-Qinv>>implements
    <verbatim|gsl_cdf_weibull_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::gumbel1_P x a b<label|gsl::cdf::gumbel1-P>>implements
    <verbatim|gsl_cdf_gumbel1_P>.
  </description>

  <\description>
    <item*|gsl::cdf::gumbel1_Q x a b<label|gsl::cdf::gumbel1-Q>>implements
    <verbatim|gsl_cdf_gumbel1_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::gumbel1_Pinv p a b<label|gsl::cdf::gumbel1-Pinv>>implements
    <verbatim|gsl_cdf_gumbel1_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::gumbel1_Qinv q a b<label|gsl::cdf::gumbel1-Qinv>>implements
    <verbatim|gsl_cdf_gumbel1_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::gumbel2_P x a b<label|gsl::cdf::gumbel2-P>>implements
    <verbatim|gsl_cdf_gumbel2_P>.
  </description>

  <\description>
    <item*|gsl::cdf::gumbel2_Q x a b<label|gsl::cdf::gumbel2-Q>>implements
    <verbatim|gsl_cdf_gumbel2_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::gumbel2_Pinv p a b<label|gsl::cdf::gumbel2-Pinv>>implements
    <verbatim|gsl_cdf_gumbel2_Pinv>.
  </description>

  <\description>
    <item*|gsl::cdf::gumbel2_Qinv q a b<label|gsl::cdf::gumbel2-Qinv>>implements
    <verbatim|gsl_cdf_gumbel2_Qinv>.
  </description>

  <\description>
    <item*|gsl::cdf::poisson_P k::int mu<label|gsl::cdf::poisson-P>>implements
    <verbatim|gsl_cdf_poisson_P>.
  </description>

  <\description>
    <item*|gsl::cdf::poisson_Q k::int mu<label|gsl::cdf::poisson-Q>>implements
    <verbatim|gsl_cdf_poisson_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::binomial_P k::int p n::int<label|gsl::cdf::binomial-P>>implements
    <verbatim|gsl_cdf_binomial_P>.
  </description>

  <\description>
    <item*|gsl::cdf::binomial_Q k::int q n::int<label|gsl::cdf::binomial-Q>>implements
    <verbatim|gsl_cdf_binomial_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::negative_binomial_P k::int p
    n<label|gsl::cdf::negative-binomial-P>>implements
    <verbatim|gsl_cdf_negative_binomial_P>.
  </description>

  <\description>
    <item*|gsl::cdf::negative_binomial_Q k::int p
    n<label|gsl::cdf::negative-binomial-Q>>implements
    <verbatim|gsl_cdf_negative_binomial_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::pascal_P k::int p n::int<label|gsl::cdf::pascal-P>>implements
    <verbatim|gsl_cdf_pascal_P>.
  </description>

  <\description>
    <item*|gsl::cdf::pascal_Q k::int p n::int<label|gsl::cdf::pascal-Q>>implements
    <verbatim|gsl_cdf_pascal_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::geometric_P k::int p<label|gsl::cdf::geometric-P>>implements
    <verbatim|gsl_cdf_geometric_P>.
  </description>

  <\description>
    <item*|gsl::cdf::geometric_Q k::int p<label|gsl::cdf::geometric-Q>>implements
    <verbatim|gsl_cdf_geometric_Q>.
  </description>

  <\description>
    <item*|gsl::cdf::hypergeometric_P k::int n1::int n2::int
    t::int<label|gsl::cdf::hypergeometric-P>>implements
    <verbatim|gsl_cdf_hypergeometric_P>.
  </description>

  <\description>
    <item*|gsl::cdf::hypergeometric_Q k::int n1::int n2::int
    t::int<label|gsl::cdf::hypergeometric-Q>>implements
    <verbatim|gsl_cdf_hypergeometric_Q>.
  </description>

  <subsubsection|Examples>

  The following illustrates the use of each function in the
  <verbatim|randist> module. The pdf functions are illustrated first.

  <\verbatim>
    \;

    \<gtr\> using gsl::stats;

    \<gtr\> using namespace gsl::ran;

    \<gtr\> ugaussian_pdf 1.2;

    0.194186054983213

    \<gtr\> gaussian_pdf (-1.3) 1.5;

    0.182690978264686

    \<gtr\> gaussian_tail_pdf 2.0 1.0 1.5;

    0.433042698395299

    \<gtr\> ugaussian_tail_pdf 2.0 1.0;

    0.34030367841782

    \<gtr\> bivariate_gaussian_pdf 1.2 0.9 1.0 1.0 0.95;

    0.184646843689817

    \<gtr\> exponential_pdf 1.0 0.5;

    0.270670566473225

    \<gtr\> laplace_pdf 1.5 2.0;

    0.118091638185254

    \<gtr\> exppow_pdf 0.0 1.0 1.5;

    0.553866083716236

    \<gtr\> cauchy_pdf (-1.0) 1.0;

    0.159154943091895

    \<gtr\> rayleigh_pdf 2.5 1.0;

    0.109842334058519

    \<gtr\> rayleigh_tail_pdf 1.5 1.0 1.0;

    0.802892142778485

    \<gtr\> landau_pdf 1.1;

    0.140968737919623

    \<gtr\> gamma_pdf 1.0 1.0 1.5;

    0.342278079355061

    \<gtr\> flat_pdf 1.0 0.5 2.5;

    0.5

    \<gtr\> lognormal_pdf 0.01 0.0 1.0;

    0.000990238664959182

    \<gtr\> chisq_pdf 1.0 2.0;

    0.303265329856317

    \<gtr\> fdist_pdf 0.5 3.0 2.0;

    0.480970043785452

    \<gtr\> tdist_pdf 0.1 10.0;

    0.386975225815181

    \<gtr\> beta_pdf 0.5 4.0 1.0;

    0.499999999999999

    \<gtr\> logistic_pdf (-1.0) 2.0;

    0.117501856100797

    \<gtr\> pareto_pdf 0.01 3.0 2.0;

    0.0

    \<gtr\> weibull_pdf \ 0.01 1.0 1.0;

    0.990049833749168

    \<gtr\> gumbel1_pdf 0.01 1.0 1.0;

    0.367861108816436

    \<gtr\> gumbel2_pdf 0.01 1.0 1.0;

    3.72007597602084e-40

    \<gtr\> dirichlet_pdf {0.1,0.2,0.8} {2.0,2.0,2.0};

    0.00501316294425874

    \<gtr\> dirichlet_lnpdf {0.1,0.2,0.8} {2.0,2.0,2.0};

    -5.29568823688856

    \<gtr\> poisson_pdf 4 0.4;

    0.000715008049104682

    \<gtr\> bernoulli_pdf 1 0.7;

    0.7

    \<gtr\> binomial_pdf 3 0.5 9;

    0.1640625

    \<gtr\> multinomial_pdf {0.1,0.2,0.7} {2,2,2};

    0.0

    \<gtr\> multinomial_lnpdf {0.1,0.2,0.7} {2,2,2};

    -1728120799.71174

    \<gtr\> negative_binomial_pdf 10 0.5 3.5;

    0.0122430486923836

    \<gtr\> pascal_pdf 10 0.5 3;

    0.00805664062499999

    \<gtr\> geometric_pdf 5 0.4;

    0.05184

    \<gtr\> hypergeometric_pdf 1 5 20 3;

    0.413043478260872

    \<gtr\> logarithmic_pdf 10 0.7;

    0.00234619293712492

    \<gtr\> test_discrete

    \<gtr\> \ \ = v

    \<gtr\> \ \ \ \ when

    \<gtr\> \ \ \ \ \ \ px = discrete_preproc {0.1,0.3,0.4};

    \<gtr\> \ \ \ \ \ \ v = discrete_pdf 0 px +

    \<gtr\> \ \ \ \ \ \ \ \ \ \ discrete_pdf 1 px +

    \<gtr\> \ \ \ \ \ \ \ \ \ \ discrete_pdf 2 px;

    \<gtr\> \ \ \ \ \ \ _ = discrete_free px

    \<gtr\> \ \ \ \ end;

    \<gtr\> test_discrete;

    1.0

    \;
  </verbatim>

  The cumulative distribution functions are shown.

  <\verbatim>
    \;

    \<gtr\> using namespace gsl::cdf;

    \<gtr\> ugaussian_P \ (-1.3);

    0.0968004845856103

    \<gtr\> ugaussian_Q \ (-1.3);

    0.90319951541439

    \<gtr\> ugaussian_Pinv \ 0.84;

    0.994457883209753

    \<gtr\> ugaussian_Qinv \ 0.84;

    -0.994457883209753

    \<gtr\> gaussian_P \ (1.3) \ 1.5;

    0.806937662858093

    \<gtr\> gaussian_Q \ (1.3) \ 1.5;

    0.193062337141907

    \<gtr\> gaussian_Pinv \ 0.4 \ 5.0;

    -1.266735515679

    \<gtr\> gaussian_Qinv \ 0.4 5.0;

    1.266735515679

    \<gtr\> exponential_P \ 1.0 \ 0.5;

    0.864664716763387

    \<gtr\> exponential_Q \ 1.0 \ 0.5;

    0.135335283236613

    \<gtr\> exponential_Pinv \ 0.6 \ 0.5;

    0.458145365937077

    \<gtr\> exponential_Qinv \ 0.6 \ 0.5;

    0.255412811882995

    \<gtr\> laplace_P \ 1.5 \ 2.0;

    0.763816723629493

    \<gtr\> laplace_Q \ 1.5 \ 2.0;

    0.236183276370507

    \<gtr\> laplace_Pinv \ 0.6 \ 2.0;

    0.446287102628419

    \<gtr\> laplace_Qinv \ 0.4 \ 2.0;

    0.446287102628419

    \<gtr\> exppow_P \ 0.0 \ 1.0 \ 2.5;

    0.5

    \<gtr\> exppow_Q \ 0.0 \ 1.0 \ 0.5;

    0.5

    \<gtr\> cauchy_P \ (-1.0) \ 1.0;

    0.25

    \<gtr\> cauchy_Q \ (-1.0) \ 1.0;

    0.75

    \<gtr\> cauchy_Pinv \ 0.75 \ 1.0;

    1.0

    \<gtr\> cauchy_Qinv \ 0.25 \ 1.0;

    1.0

    \<gtr\> rayleigh_P \ 1.5 \ 2.0;

    0.245160398010993

    \<gtr\> rayleigh_Q \ 0.5 \ 1.0;

    0.882496902584595

    \<gtr\> rayleigh_Pinv \ 0.5 \ 1.0;

    1.17741002251547

    \<gtr\> rayleigh_Qinv \ 0.5 \ 1.0;

    1.17741002251547

    \<gtr\> gamma_P \ 1.0 \ 1.0 \ 3.0;

    0.283468689426211

    \<gtr\> gamma_Q \ 1.0 \ 1.0 \ 3.0;

    0.716531310573789

    \<gtr\> gamma_Pinv \ 0.5 \ 1.0 \ 1.0;

    0.693147180559945

    \<gtr\> gamma_Qinv \ 0.5 \ 1.0 \ 1.0;

    0.693147180559945

    \<gtr\> flat_P \ 2.0 \ 1.2 \ 4.8;

    0.222222222222222

    \<gtr\> flat_Q \ 2.0 \ 1.2 \ 4.8;

    0.777777777777778

    \<gtr\> flat_Pinv \ 0.2 \ 0.5 \ 2.5;

    0.9

    \<gtr\> flat_Qinv \ 0.2 \ 0.5 \ 2.5;

    2.1

    \<gtr\> lognormal_P \ 0.01 \ 0.0 \ 1.0;

    2.06064339597172e-06

    \<gtr\> lognormal_Q \ 0.01 \ 0.0 \ 1.0;

    0.999997939356604

    \<gtr\> lognormal_Pinv \ 0.1 \ 0.0 \ 1.0;

    0.27760624185201

    \<gtr\> lognormal_Qinv \ 0.1 \ 0.0 \ 1.0;

    3.60222447927916

    \<gtr\> chisq_P \ 1.0 \ 2.0;

    0.393469340287367

    \<gtr\> chisq_Q \ 1.0 \ 2.0;

    0.606530659712633

    \<gtr\> chisq_Pinv \ 0.5 \ 2.0;

    0.221199216928595

    \<gtr\> chisq_Qinv \ 0.5 \ 2.0;

    1.38629436111989

    \<gtr\> fdist_P \ 1.0 \ 3.0 \ 2.0;

    0.46475800154489

    \<gtr\> fdist_Q \ 1.0 \ 3.0 \ 2.0;

    0.53524199845511

    \<gtr\> fdist_Pinv \ 0.5 \ 3.0 \ 2.0;

    1.13494292261288

    \<gtr\> fdist_Qinv \ 0.5 \ 3.0 \ 2.0;

    1.13494292261288

    \<gtr\> tdist_P \ 2.1 \ 10.0;

    0.968961377898891

    \<gtr\> tdist_Q \ (-2.1) \ 10.0;

    0.968961377898891

    \<gtr\> tdist_Pinv \ 0.68 \ 10.0;

    0.482264205919689

    \<gtr\> tdist_Qinv \ 0.68 \ 10.0;

    -0.482264205919689

    \<gtr\> beta_P \ 0.75 \ 2.0 \ 2.0;

    0.84375

    \<gtr\> beta_Q \ 0.75 \ 2.0 \ 2.0;

    0.15625

    \<gtr\> beta_Pinv \ 0.75 \ 2.0 \ 2.0;

    0.673648177666931

    \<gtr\> beta_Qinv \ 0.25 \ 2.0 \ 2.0;

    0.673648177666931

    \<gtr\> logistic_P \ (-1.0) \ 2.0;

    1

    \<gtr\> logistic_Q \ (-1.0) \ 2.0;

    0.622459331201855

    \<gtr\> logistic_Pinv \ 0.75 \ 1.0;

    1.09861228866811

    \<gtr\> logistic_Qinv \ 0.25 \ 1.0;

    1.09861228866811

    \<gtr\> pareto_P \ 2.01 \ 3.0 \ 2.0;

    0.0148512406901899

    \<gtr\> pareto_Q \ 2.01 \ 3.0 \ 2.0;

    0.98514875930981

    \<gtr\> pareto_Pinv \ 0.1 \ 3.0 \ 2.0;

    2.07148833730257

    \<gtr\> pareto_Qinv \ 0.1 \ 3.0 \ 2.0;

    4.30886938006377

    \<gtr\> weibull_P \ 1.01 \ 1.0 \ 2.0;

    0.639441117518024

    \<gtr\> weibull_Q \ 1.01 \ 2.0 \ 3.0;

    0.879160657465162

    \<gtr\> weibull_Pinv \ 0.1 \ 1.0 \ 2.0;

    0.324592845974501

    \<gtr\> weibull_Qinv \ 0.1 \ 1.0 \ 2.0;

    1.51742712938515

    \<gtr\> gumbel1_P \ 1.01 \ 1.0 \ 1.0;

    0.694739044426344

    \<gtr\> gumbel1_Q \ 1.01 \ 1.0 \ 1.0;

    0.305260955573656

    \<gtr\> gumbel1_Pinv \ 0.1 \ 1.0 \ 1.0;

    -0.834032445247956

    \<gtr\> gumbel1_Qinv \ 0.1 \ 1.0 \ 1.0;

    2.25036732731245

    \<gtr\> gumbel2_P \ 1.01 \ 1.0 \ 1.0;

    0.371539903071873

    \<gtr\> gumbel2_Q \ 1.01 \ 1.0 \ 1.0;

    0.628460096928127

    \<gtr\> gumbel2_Pinv \ 0.1 \ 1.0 \ 1.0;

    0.434294481903252

    \<gtr\> gumbel2_Qinv \ 0.1 \ 1.0 \ 1.0;

    9.4912215810299

    \<gtr\> poisson_P \ 4 \ 0.4;

    0.999938756672898

    \<gtr\> poisson_Q \ 4 \ 0.6;

    0.000394486018340255

    \<gtr\> binomial_P \ 3 \ 0.5 \ 10;

    0.171874999999999

    \<gtr\> binomial_Q \ 3 \ 0.5 \ 10;

    0.828125000000001

    \<gtr\> negative_binomial_P \ 10 \ 0.5 \ 3.0;

    0.98876953125

    \<gtr\> negative_binomial_Q \ 10 \ 0.5 \ 3.0;

    0.01123046875

    \<gtr\> pascal_P \ 10 \ 0.5 \ 3;

    0.98876953125

    \<gtr\> pascal_Q \ 10 \ 0.5 \ 3;

    0.01123046875

    \<gtr\> geometric_P \ 5 \ 0.4;

    0.92224

    \<gtr\> geometric_Q \ 5 \ 0.6;

    0.01024

    \<gtr\> hypergeometric_P \ 1 \ 5 \ 20 \ 3;

    0.908695652173913

    \<gtr\> hypergeometric_Q \ 1 \ 5 \ 20 \ 3;

    0.0913043478260873

    \;
  </verbatim>

  <subsection|Sorting><label|module-gsl::sort>

  This module is loaded via the command <verbatim|using> <verbatim|gsl::sort>
  and provides Pure wrappers for the GSL sorting routines found in Chapter 11
  of the GSL manual,

  <hlink|http://www.gnu.org/software/gsl/manual/html_node/Sorting.html|http://www.gnu.org/software/gsl/manual/html-node/Sorting.html>.

  <subsubsection|Routines>

  <\description>
    <item*|gsl::sort_vector m::matrix<label|gsl::sort-vector>>implements
    <verbatim|gsl_sort> and <verbatim|gsl_sort_int> without <verbatim|stride>
    and <verbatim|n> parameters.
  </description>

  <\description>
    <item*|gsl::sort_vector_index m::matrix<label|gsl::sort-vector-index>>implements
    <verbatim|gsl_sort_index> and <verbatim|gsl_sort_int_index> without
    <verbatim|stride> and <verbatim|n> parameters.
  </description>

  <subsubsection|Examples>

  Usage of each library routine is illustrated below.

  <\verbatim>
    \;

    \<gtr\> using gsl::sort;

    \<gtr\> using namespace gsl;

    \<gtr\> sort_vector {0,3,2,4,5};

    {0,2,3,4,5}

    \<gtr\> sort_vector_index {0.0,1.0,5.0,2.0,8.0,0.0};

    {5,0,1,3,2,4}

    \;
  </verbatim>

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-gsl-toc>

  <\itemize>
    <item><hlink|pure-gsl - GNU Scientific Library Interface for Pure|#>

    <\itemize>
      <item><hlink|Polynomials|#module-gsl::poly>

      <\itemize>
        <item><hlink|Routines|#routines>

        <item><hlink|Examples|#examples>
      </itemize>

      <item><hlink|Special Functions|#module-gsl::sf>

      <\itemize>
        <item><hlink|Airy Functions|#airy-functions>

        <item>Examples

        <item><hlink|Bessel Functions|#bessel-functions>

        <item>Examples

        <item><hlink|Clausen Functions|#clausen-functions>

        <item>Examples

        <item><hlink|Colomb Functions|#colomb-functions>

        <item>Examples

        <item><hlink|Coupling Coefficients|#coupling-coefficients>

        <item>Examples

        <item><hlink|Dawson Function|#dawson-function>

        <item>Examples

        <item><hlink|Debye Functions|#debye-functions>

        <item>Examples

        <item><hlink|Dilogarithm|#dilogarithm>

        <item>Examples

        <item>Examples
      </itemize>

      <item><hlink|Matrices|#module-gsl::matrix>

      <\itemize>
        <item><hlink|Matrix Creation|#matrix-creation>

        <item><hlink|Matrix Operators and
        Functions|#matrix-operators-and-functions>

        <item><hlink|Singular Value Decomposition|#singular-value-decomposition>
      </itemize>

      <item><hlink|Least-Squares Fitting|#module-gsl::fit>

      <\itemize>
        <item>Routines

        <item>Examples
      </itemize>

      <item><hlink|Statistics|#module-gsl::stats>

      <\itemize>
        <item>Routines

        <item>Examples
      </itemize>

      <item><hlink|Random Number Distributions|#module-gsl::randist>

      <\itemize>
        <item>Routines

        <item>Examples
      </itemize>

      <item><hlink|Sorting|#module-gsl::sort>

      <\itemize>
        <item>Routines

        <item>Examples
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Gnuplot bindings|pure-gplot.tm>

  Next topic

  <hlink|pure-mpfr|pure-mpfr.tm>

  <hlink|toc|#pure-gsl-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-mpfr.tm> \|
  <hlink|previous|pure-gplot.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2020, Albert Gräf et al. Last updated on May
  13, 2020. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
