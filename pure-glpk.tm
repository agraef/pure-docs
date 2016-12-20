<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-glpk-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gplot.tm> \|
  <hlink|previous|gnumeric-pure.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Pure-GLPK - GLPK interface for the Pure programming
  language><label|pure-glpk-glpk-interface-for-the-pure-programming-language>

  Version 0.5, July 07, 2016

  Jiri Spitz \<less\><hlink|jiri.spitz@bluetone.cz|mailto:jiri.spitz@bluetone.cz>\<gtr\>

  This module provides a feature complete GLPK interface for the Pure
  programming language, which lets you use all capabilities of the GNU Linear
  Programming Kit (GLPK) directly from Pure.

  GLPK (see <hlink|http://www.gnu.org/software/glpk|http://www.gnu.org/software/glpk>)
  contains an efficient simplex LP solver, a simplex LP solver in exact
  arithmetics, an interior-point solver, a branch-and-cut solver for mixed
  integer programming and some specialized algorithms for net/grid problems.
  Using this interface you can build, modify and solve the problem, retrieve
  the solution, load and save the problem and solution data in standard
  formats and use any of advanced GLPK features.

  The interface uses native Pure data types - lists and tuples - so that you
  need not perform any data conversions to/from GLPK internal data
  structures.

  To make this module work, you must have a GLPK installation on your system,
  the version 4.42 or higher is required.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-glpk-0.5.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-glpk-0.5.tar.gz>.

  Run <verbatim|make> to compile the module and <verbatim|make>
  <verbatim|install> (as root) to install it in the Pure library directory.
  This requires GNU make, and of course you need to have Pure installed.

  The default make options suppose that GLPK was configured with the
  following options: <verbatim|--enable-dl> <verbatim|--enable-odbc>
  <verbatim|--enable-mysql> <verbatim|--with-zlib> <verbatim|--with-gmp>

  The zlib library is a part of the GLPK source distribution from the version
  4.46 onwards, so the the configure options for newer GLPK versions are:
  <verbatim|--enable-dl> <verbatim|--enable-odbc> <verbatim|--enable-mysql>
  <verbatim|--with-gmp>

  Using the given options the depndencies are:

  <\itemize>
    <item>GNU Multiprecision Library (GMP) - serves for the exact simplex
    solver. When disabled, the exact solver still works but it is much
    slower.

    <item>ODBC library - serves for reading data directly from database
    tables within the GNU MathProg language translator through the ODBC
    interface.

    <item>MySQL client library - serves for reading data directly from MySQL
    tables within the GNU MathProg language translator.

    <item>zlib compression library - enables reading and writing gzip
    compressed problem and solution files.

    <item>ltdl dlopen library - must be enabled together with any of ODBC or
    MySQL (or zlib for GLPK versions 4.45 and earlier).
  </itemize>

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix, and <verbatim|make>
  <verbatim|PIC=-fPIC> or some similar flag might be needed for compilation
  on 64 bit systems. The variable <verbatim|ODBCLIB> specifies the ODBC
  library to be linked with. The default value is <verbatim|ODBCLIB=-lodbc>.
  Please see the Makefile for details.

  <subsection|Error Handling><label|error-handling>

  When an error condition occurs, the GLPK library itself prints an error
  mesage and terminates the application. This behaviour is not pleasant when
  working within an interpreter. Therefore, the Pure - GLPK bindings catches
  at least the most common errors like indices out of bounds. On such an
  error an appropriate message is returned to the interpreter. The less
  common errors are still trapped by the GLPK library.

  When one of the most common errors occurs, an error term of the form
  <verbatim|glp::error> <verbatim|message> will be returned, which specifies
  what kind of error happend. For instance, an index out of boundsd will
  cause a report like the following:

  <verbatim|glp::error> <verbatim|"[Pure> <verbatim|GLPK> <verbatim|error]>
  <verbatim|row> <verbatim|index> <verbatim|out> <verbatim|of>
  <verbatim|bounds">

  You can check for such return values and take some appropriate action. By
  redefining <verbatim|glp::error> accordingly, you can also have it generate
  exceptions or print an error message. For instance:

  <verbatim|glp::error> <verbatim|message> <verbatim|=> <verbatim|fprintf>
  <verbatim|stderr> <verbatim|"%s\\n"> <verbatim|message> <verbatim|$$>
  <verbatim|();>

  <with|font-series|bold|NOTE:> When redefining <verbatim|glp::error> in this
  manner, you should be aware that the return value of <verbatim|glp::error>
  is what will be returned by the other operations of this module in case of
  an error condition. These return values are checked by other functions.
  Thus the return value should still indicate that an error has happened, and
  not be something that might be interpreted as a legal return value, such as
  an integer or a nonempty tuple. It is usually safe to have
  <verbatim|glp::error> return an empty tuple or throw an exception, but
  other types of return values should be avoided.

  <with|font-series|bold|IMPORTANT:> It is really good to define a
  <verbatim|glp::error> function, otherwise the errors might remain
  unnoticed.

  <subsection|Further Information and Examples><label|further-information-and-examples>

  For further details about the operations provided by this module please see
  the GLPK Reference Manual. Sample scripts illustrating the usage of the
  module can be found in the examples directory.

  <subsection|Interface description><label|interface-description>

  Most GLPK functions and symbols live in the namespace <verbatim|glp>. There
  are a few functions and symbols in the namespace <verbatim|lpx>. These
  functions and symbols are likely to be removed and replaced by new ones in
  the future.

  In general, when you replace the <verbatim|glp_> prefix from the GLPK
  Reference Manual with the namespace specification <verbatim|glp::> then you
  receive the function name in this module. The same is valid for
  <verbatim|lpx_> and <verbatim|lpx::>. The symbolic constants are converted
  into lower case in this module, again obeying the same prefix rules.

  <subsection|Descriptions of interface functions><label|descriptions-of-interface-functions>

  <subsubsection|Basic API routines><label|basic-api-routines>

  <paragraph|Problem creating and modifying
  routines><label|problem-creating-and-modifying-routines>

  <paragraph|Create the GLPK problem object><label|create-the-glpk-problem-object>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::create_prob

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    none
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> let lp = glp::create_prob;

    \<gtr\> lp;

    #\<less\>pointer 0x9de7168\<gtr\>

    \;
  </verbatim>

  <paragraph|Set the problem name><label|set-the-problem-name>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_prob_name lp name

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object name: problem name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_prob_name lp "Testing problem";

    ()

    \;
  </verbatim>

  <paragraph|Set objective name><label|set-objective-name>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_obj_name lp name

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object name: objective name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_obj_name lp "Total costs";

    ()

    \;
  </verbatim>

  <paragraph|Set the objective direction><label|set-the-objective-direction>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_obj_dir lp direction

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    direction: one of the following:

    glp::min: minimize glp::max: maximize
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_obj_dir lp glp::min;

    ()

    \;
  </verbatim>

  <paragraph|Add new rows to the problem><label|add-new-rows-to-the-problem>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::add_rows lp count

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object count: number of rows to add
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    index of the first row added
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> let first_added_row = glp_add_rows lp 3;

    \<gtr\> first_added_row;

    6

    \;
  </verbatim>

  <paragraph|Add new columns to the problem><label|add-new-columns-to-the-problem>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::add_cols lp count

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object count: number of columns to add
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    index of the first column added
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> let first_added_col = glp_add_cols lp 3;

    \<gtr\> first_added_col;

    5

    \;
  </verbatim>

  <paragraph|Set the row name><label|set-the-row-name>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_row_name lp (rowindex, rowname)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index rowname: row
    name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_row_name lp (3, "The third row");

    ()

    \;
  </verbatim>

  <paragraph|Set the column name><label|set-the-column-name>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_col_name lp (colindex, colname)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index colname:
    column name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_col_name lp (3, "The third column");

    ()

    \;
  </verbatim>

  <paragraph|Set (change) row bounds><label|set-change-row-bounds>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_row_bnds lp (rowindex, rowtype, lowerbound, upperbound)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    rowindex: row index

    rowtype: one of the following:

    glp::fr: free variable (both bounds are ignored) glp::lo: variable with
    lower bound (upper bound is ignored) glp::up: variable with upper bound
    (lower bound is ignored) glp::db: double bounded variable glp::fx: fixed
    variable (lower bound applies, upper bound is ignored) lowerbound: lower
    row bound

    upperbound: upper row bound
  </quote-env>

  <\description>
    <item*|<with|font-series|bold|Returns>><verbatim|()>

    <item*|<with|font-series|bold|Example>::><verbatim|glp::set_row_bnds>
    <verbatim|lp> <verbatim|(3,> <verbatim|glp::up,> <verbatim|0.0,>
    <verbatim|150.0);>
  </description>

  <paragraph|Set (change) column bounds><label|set-change-column-bounds>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_col_bnds lp (colindex, coltype, lowerbound, upperbound)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    colindex: column index

    coltype: one of the following:

    glp::fr: free variable (both bounds are ignored) glp::lo: variable with
    lower bound (upper bound is ignored) glp::up: variable with upper bound
    (lower bound is ignored) glp::db: double bounded variable glp::fx: fixed
    variable (lower bound applies, upper bound is ignored) lowerbound: lower
    column bound

    upperbound: upper column bound
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_col_bnds lp (3, glp::db, 100.0, 150.0);

    ()

    \;
  </verbatim>

  <paragraph|Set (change) objective coefficient or constant
  term><label|set-change-objective-coefficient-or-constant-term>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_obj_coef lp (colindex, coefficient)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index, zero index
    denotes the constant term (objective shift)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_obj_coef lp (3, 15.8);

    ()

    \;
  </verbatim>

  <paragraph|Load or replace matrix row><label|load-or-replace-matrix-row>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_mat_row lp (rowindex, rowvector)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index rowvector: list
    of tuples (colindex, coefficient); only non-zero coefficients have to be
    specified, the order of column indices is not important, duplicates are
    <with|font-series|bold|not> allowed
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_mat_row lp (3, [(1, 3.0), (4, 5.2)]);

    ()

    \;
  </verbatim>

  <paragraph|Load or replace matrix column><label|load-or-replace-matrix-column>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_mat_col lp (colindex, colvector)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index colvector:
    list of tuples (rowindex, coefficient); only non-zero coefficients have
    to be specified, the order of row indices is not important, duplicates
    are <with|font-series|bold|not> allowed
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_mat_col lp (2, [(4, 2.0), (2, 1.5)]);

    ()

    \;
  </verbatim>

  <paragraph|Load or replace the whole problem
  matrix><label|load-or-replace-the-whole-problem-matrix>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::load_matrix lp matrix

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object matrix: list of tuples (rowindex,
    colindex, coefficient); only non-zero coefficients have to be specified,
    the order of indices is not important, duplicates are
    <with|font-series|bold|not> allowed
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::load_matrix lp [(1, 3, 5.0), (2, 2, 3.5), (3, 1, -2.0), (3,
    2, 1.0)];

    ()

    \;
  </verbatim>

  <paragraph|Check for duplicate elements in sparse
  matrix><label|check-for-duplicate-elements-in-sparse-matrix>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::check_dup numrows numcols indices

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    numrows: number of rows numcols: number of columns indices: list of
    tuples (rowindex, colindex); indices of only non-zero coefficients have
    to be specified, the order of indices is not important
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    returns one of the following:

    <quote-env|0: the matrix has no duplicate elements -k: rowindex or
    colindex of the k-th element in indices is out of range +k: the k-th
    element in indices is duplicate>
  </quote-env>

  <with|font-series|bold|Remark:>

  <\quote-env>
    Notice, that <verbatim|k> counts from 1, whereas list members are counted
    from 0.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::check_dup 3 3 \ [(1, 3), (2, 2), (3, 1), (2, 2)];

    4

    \;
  </verbatim>

  <paragraph|Sort elements of the constraint
  matrix><label|sort-elements-of-the-constraint-matrix>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::sort_matrix lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::sort_matrix lp;

    ()

    \;
  </verbatim>

  <paragraph|Delete rows from the matrix><label|delete-rows-from-the-matrix>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::del_rows lp rows

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rows: list of indices of rows to be
    deleted; the order of indices is not important, duplicates are
    <with|font-series|bold|not> allowed
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Remark:>

  <\quote-env>
    Deleting rows involves changing ordinal numbers of other rows remaining
    in the problem object. New ordinal numbers of the remaining rows are
    assigned under the assumption that the original order of rows is not
    changed.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::del_rows lp [3, 4, 7];

    ()

    \;
  </verbatim>

  <paragraph|Delete columns from the matrix><label|delete-columns-from-the-matrix>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::del_cols lp cols

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object cols: list of indices of columns to
    be deleted; the order of indices is not important, duplicates are
    <with|font-series|bold|not> allowed
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Remark:>

  <\quote-env>
    Deleting columns involves changing ordinal numbers of other columns
    remaining in the problem object. New ordinal numbers of the remaining
    columns are assigned under the assumption that the original order of
    columns is not changed.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::del_cols lp [6, 4, 5];

    ()

    \;
  </verbatim>

  <paragraph|Copy the whole content of the GLPK problem object to another
  one><label|copy-the-whole-content-of-the-glpk-problem-object-to-another-one>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::copy_prob destination source names

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    destination: pointer to the destination LP problem object (must already
    exist)

    source: pointer to the source LP problem object

    names: one of the following:

    glp::on: copy all symbolic names as well glp::off: do not copy the
    symbolic names
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::copy_prob lp_dest lp_src glp::on;

    ()

    \;
  </verbatim>

  <paragraph|Erase all data from the GLPK problem
  object><label|erase-all-data-from-the-glpk-problem-object>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::erase_prob lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object, it remains still valid after the
    function call
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::erase_prob lp;

    ()

    \;
  </verbatim>

  <paragraph|Delete the GLPK problem object><label|delete-the-glpk-problem-object>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::delete_prob lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object, it is not valid any more after the
    function call
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::delete_prob lp;

    ()

    \;
  </verbatim>

  <paragraph|Problem retrieving routines><label|problem-retrieving-routines>

  <paragraph|Get the problem name><label|get-the-problem-name>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_prob_name lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    name of the problem
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_prob_name lp;

    "Testing problem"

    \;
  </verbatim>

  <paragraph|Get the objective name><label|get-the-objective-name>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_obj_name lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    name of the objective
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_obj_name lp;

    "Total costs"

    \;
  </verbatim>

  <paragraph|Get the objective direction><label|get-the-objective-direction>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_obj_dir lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    returns one of the following:

    <quote-env|glp::min: minimize glp::max: maximize>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_obj_dir lp;

    glp::min

    \;
  </verbatim>

  <paragraph|Get number of rows><label|get-number-of-rows>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_num_rows lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    number of rows (constraints)
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_num_rows lp;

    58

    \;
  </verbatim>

  <paragraph|Get number of columns><label|get-number-of-columns>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_num_cols lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    number of columns (structural variables)
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_num_cols lp;

    65

    \;
  </verbatim>

  <paragraph|Get name of a row><label|get-name-of-a-row>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_row_name lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    name of the given row
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_row_name lp 3;

    "The third row"

    \;
  </verbatim>

  <paragraph|Get name of a column><label|get-name-of-a-column>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_col_name lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    name of the given column
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_col_name lp 2;

    "The second column"

    \;
  </verbatim>

  <paragraph|Get row type><label|get-row-type>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_row_type lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    returns one of the following:

    <quote-env|glp::fr: free variable glp::lo: variable with lower bound
    glp::up: variable with upper bound glp::db: double bounded variable
    glp::fx: fixed variable>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_row_type lp 3;

    glp::db

    \;
  </verbatim>

  <paragraph|Get row lower bound><label|get-row-lower-bound>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_row_lb lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    the row lower bound; if the row has no lower bound then it returns the
    smallest double number
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_row_lb lp 3;

    50.0

    \;
  </verbatim>

  <paragraph|Get row upper bound><label|get-row-upper-bound>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_row_ub lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    the row upper bound; if the row has no upper bound then it returns the
    biggest double number
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_row_ub lp 3;

    150.0

    \;
  </verbatim>

  <paragraph|Get column type><label|get-column-type>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_col_type lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    returns one of the following:

    <quote-env|glp::fr: free variable glp::lo: variable with lower bound
    glp::up: variable with upper bound glp::db: double bounded variable
    glp::fx: fixed variable>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_col_type lp 2;

    glp::up

    \;
  </verbatim>

  <paragraph|Get column lower bound><label|get-column-lower-bound>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_col_lb lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    the column lower bound; if the column has no lower bound then it returns
    the smallest double number
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_col_lb lp 3;

    -1.79769313486232e+308

    \;
  </verbatim>

  <paragraph|Get column upper bound><label|get-column-upper-bound>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_col_ub lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    the column upper bound; if the column has no upper bound then it returns
    the biggest double number
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_col_lb lp 3;

    150.0

    \;
  </verbatim>

  <paragraph|Get objective coefficient><label|get-objective-coefficient>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_obj_coef lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index; zero index
    denotes the constant term (objective shift)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    the coefficient of given column in the objective
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_obj_coef lp 3;

    5.8

    \;
  </verbatim>

  <paragraph|Get number of nonzero coefficients><label|get-number-of-nonzero-coefficients>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_num_nz lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    number of non-zero coefficients in the problem matrix
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_num_nz lp;

    158

    \;
  </verbatim>

  <paragraph|Retrive a row from the problem
  matrix><label|retrive-a-row-from-the-problem-matrix>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_mat_row lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    non-zero coefficients of the given row in a list form of tuples
    (colindex, coefficient)
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> get_mat_row lp 3;

    [(3,6.0),(2,2.0),(1,2.0)]

    \;
  </verbatim>

  <paragraph|Retrive a column from the problem
  matrix><label|retrive-a-column-from-the-problem-matrix>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_mat_col lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    non-zero coefficients of the given column in a list form of tuples
    (rowindex, coefficient)
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> get_mat_col lp 2;

    [(3,2.0),(2,4.0),(1,1.0)]

    \;
  </verbatim>

  <paragraph|Row and column searching routines><label|row-and-column-searching-routines>

  <paragraph|Create index for searching rows and columns by their
  names><label|create-index-for-searching-rows-and-columns-by-their-names>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::create_index lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::create_index lp;

    ()

    \;
  </verbatim>

  <paragraph|Find a row number by name><label|find-a-row-number-by-name>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::find_row lp rowname

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowname: row name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ordinal number (index) of the row
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    The search index is automatically created if it does not already exists.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::find_row lp "The third row";

    3

    \;
  </verbatim>

  <paragraph|Find a column number by name><label|find-a-column-number-by-name>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::find_col lp colname

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colname: column name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ordinal number (index) of the column
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    The search index is automatically created if it does not already exists.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::find_col lp "The second row";

    2

    \;
  </verbatim>

  <paragraph|Delete index for searching rows and columns by their
  names><label|delete-index-for-searching-rows-and-columns-by-their-names>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::delete_index lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::delete:index lp;

    ()

    \;
  </verbatim>

  <paragraph|Problem scaling routines><label|problem-scaling-routines>

  <paragraph|Set the row scale factor><label|set-the-row-scale-factor>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_rii lp (rowindex, coefficient)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index coefficient:
    scaling coefficient
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_rii lp (3, 258.6);

    ()

    \;
  </verbatim>

  <paragraph|Set the column scale factor><label|set-the-column-scale-factor>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_sjj lp (colindex, coefficient)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index coefficient:
    scaling coefficient
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_sjj lp (2, 12.8);

    ()

    \;
  </verbatim>

  <paragraph|Retrieve the row scale factor><label|retrieve-the-row-scale-factor>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_rii lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    scaling coefficient of given row
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_rii lp 3;

    258.6

    \;
  </verbatim>

  <paragraph|Retrieve the column scale factor><label|retrieve-the-column-scale-factor>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_sjj lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    scaling coefficient of given column
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_sjj lp 2;

    12.8

    \;
  </verbatim>

  <paragraph|Scale the problem data according to supplied
  flags><label|scale-the-problem-data-according-to-supplied-flags>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::scale_prob lp flags

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    flags: symbolic integer constants which can be combined together by
    arithmetic <with|font-series|bold|or>; the possible constants are:

    glp::sf_gm: perform geometric mean scaling glp::sf_eq: perform
    equilibration scaling glp::sf_2n: round scale factors to power of two
    glp::sf_skip: skip if problem is well scaled glp::sf_auto: choose scaling
    options automatically
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::scale_prob lp (glp::sf_gm \|\| glp::sf_2n);

    ()

    \;
  </verbatim>

  <paragraph|Unscale the problem data><label|unscale-the-problem-data>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::unscale_prob lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::unscale_prob lp;

    ()

    \;
  </verbatim>

  <paragraph|LP basis constructing routines><label|lp-basis-constructing-routines>

  <paragraph|Set the row status><label|set-the-row-status>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_row_stat lp (rowindex, status)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    rowindex: row index

    status: one of the following:

    glp::bs: make the row basic (make the constraint inactive) glp::nl: make
    the row non-basic (make the constraint active) glp::nu: make the row
    non-basic and set it to the upper bound; if the row is not
    double-bounded, this status is equivalent to glp::nl (only in the case of
    this routine) glp::nf: the same as glp::nl (only in the case of this
    routine) glp::ns: the same as glp::nl (only in the case of this routine)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_row_stat lp (3, glp::nu);

    ()

    \;
  </verbatim>

  <paragraph|Set the column status><label|set-the-column-status>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_col_stat lp (colindex, status)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    colindex: column index

    status: one of the following:

    glp::bs: make the column basic glp::nl: make the column non-basic
    glp::nu: make the column non-basic and set it to the upper bound; if the
    column is not double-bounded, this status is equivalent to glp::nl (only
    in the case of this routine) glp::nf: the same as glp::nl (only in the
    case of this routine) glp::ns: the same as glp::nl (only in the case of
    this routine)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_col_stat lp (2, glp::bs);

    ()

    \;
  </verbatim>

  <paragraph|Construct standard problem basis><label|construct-standard-problem-basis>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::std_basis lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::std_basis lp;

    ()

    \;
  </verbatim>

  <paragraph|Construct advanced problem basis><label|construct-advanced-problem-basis>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::adv_basis lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::adv_basis lp;

    ()

    \;
  </verbatim>

  <paragraph|Construct Bixby's problem basis><label|construct-bixby-s-problem-basis>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::cpx_basis lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::cpx_basis lp;

    ()

    \;
  </verbatim>

  <paragraph|Simplex method routines><label|simplex-method-routines>

  <paragraph|Solve the LP problem using simplex
  method><label|solve-the-lp-problem-using-simplex-method>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::simplex lp options

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    options: list of solver options in the form of tuples (option_name,
    value):

    glp::msg_lev:

    <\description>
      <item*|(default: glp::msg_all) - message level for>terminal output:
    </description>

    <with|font-series|bold|glp::msg_off:> no output

    <with|font-series|bold|glp::msg_err:> error and warning messages only

    <with|font-series|bold|glp::msg_on:> normal output;

    <with|font-series|bold|glp::msg_all:> full output (including
    informational messages) glp::meth: (default: glp::primal) - simplex
    method option

    <with|font-series|bold|glp::primal:> use two-phase primal simplex

    <with|font-series|bold|glp::dual:> use two-phase dual simplex;

    <with|font-series|bold|glp::dualp:> use two-phase dual simplex, and if it
    fails, switch to the primal simplex glp::pricing: (default: glp::pt_pse)
    - pricing technique

    <with|font-series|bold|glp::pt_std:> standard (textbook)

    <with|font-series|bold|glp::pt_pse:> projected steepest edge glp::r_test:
    (default: glp::rt_har) - ratio test technique

    <with|font-series|bold|glp::rt_std:> standard (textbook)

    <with|font-series|bold|glp::rt_har:> Harris' two-pass ratio test
    glp::tol_bnd: (default: 1e-7) - tolerance used to check if the basic
    solution is primal feasible

    glp::tol_dj: (default: 1e-7) - tolerance used to check if the basic
    solution is dual feasible

    glp::tol_piv: (default: 1e-10) - tolerance used to choose eligble pivotal
    elements of the simplex table

    glp::obj_ll: (default: -DBL_MAX) - lower limit of the objective function
    - if the objective function reaches this limit and continues decreasing,
    the solver terminates the search - used in the dual simplex only

    glp::obj_ul: (default: +DBL_MAX) - upper limit of the objective function.
    If the objective function reaches this limit and continues increasing,
    the solver terminates the search - used in the dual simplex only

    glp::it_lim: (default: INT_MAX) - simplex iteration limit

    glp::tm lim: (default: INT_MAX) - searching time limit, in milliseconds

    glp::out_frq: (default: 200) - output frequency, in iterations - this
    parameter specifies how frequently the solver sends information about the
    solution process to the terminal

    glp::out_dly: (default: 0) - output delay, in milliseconds - this
    parameter specifies how long the solver should delay sending information
    about the solution process to the terminal

    glp::presolve: (default: glp::off) - LP presolver option:

    <with|font-series|bold|glp::on:> enable using the LP presolver

    <with|font-series|bold|glp::off:> disable using the LP presolver
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::ok: the LP problem instance has been successfully solved; this code
    does not necessarily mean that the solver has found optimal solution, it
    only means that the solution process was successful glp::ebadb: unable to
    start the search, because the initial basis specified in the problem
    object is invalid - the number of basic (auxiliary and structural)
    variables is not the same as the number of rows in the problem object
    glp::esing: unable to start the search, because the basis matrix
    corresponding to the initial basis is singular within the working
    precision glp::econd: unable to start the search, because the basis
    matrix corresponding to the initial basis is ill-conditioned, i.e. its
    condition number is too large glp::ebound: unable to start the search,
    because some double-bounded (auxiliary or structural) variables have
    incorrect bounds glp::efail: the search was prematurely terminated due to
    the solver failure glp::eobjll: the search was prematurely terminated,
    because the objective function being maximized has reached its lower
    limit and continues decreasing (the dual simplex only) glp::eobjul: the
    search was prematurely terminated, because the objective function being
    minimized has reached its upper limit and continues increasing (the dual
    simplex only) glp::eitlim: the search was prematurely terminated, because
    the simplex iteration limit has been exceeded glp::etmlim: the search was
    prematurely terminated, because the time limit has been exceeded
    glp::enopfs: the LP problem instance has no primal feasible solution
    (only if the LP presolver is used) glp::enodfs: the LP problem instance
    has no dual feasible solution (only if the LP presolver is used) When the
    list of options contains some bad option(s) then a list of bad options is
    returned instead.
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    Options not mentioned in the option list are set to their default values.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::simplex lp [(glp::presolve, glp::on), (glp::msg_lev,
    glp::msg_all)];

    glp_simplex: original LP has 3 rows, 3 columns, 9 non-zeros

    glp_simplex: presolved LP has 3 rows, 3 columns, 9 non-zeros

    Scaling...

    \ A: min\|aij\| = 1,000e+000 \ max\|aij\| = 1,000e+001 \ ratio =
    1,000e+001

    Problem data seem to be well scaled

    Crashing...

    Size of triangular part = 3

    * \ \ \ \ 0: obj = \ 0,000000000e+000 \ infeas = 0,000e+000 (0)

    * \ \ \ \ 2: obj = \ 7,333333333e+002 \ infeas = 0,000e+000 (0)

    OPTIMAL SOLUTION FOUND

    glp::ok

    \;
  </verbatim>

  <paragraph|Solve the LP problem using simplex method in exact
  arithmetics><label|solve-the-lp-problem-using-simplex-method-in-exact-arithmetics>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::exact lp options

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    options: list of solver options in the form of tuples (option_name,
    value):

    glp::it_lim: (default: INT_MAX) - simplex iteration limit glp::tm lim:
    (default: INT_MAX) - searching time limit, in milliseconds
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::ok: the LP problem instance has been successfully solved; this code
    does not necessarily mean that the solver has found optimal solution, it
    only means that the solution process was successful glp::ebadb: unable to
    start the search, because the initial basis specified in the problem
    object is invalid - the number of basic (auxiliary and structural)
    variables is not the same as the number of rows in the problem object
    glp::esing: unable to start the search, because the basis matrix
    corresponding to the initial basis is singular within the working
    precision glp::ebound: unable to start the search, because some
    double-bounded (auxiliary or structural) variables have incorrect bounds
    glp::efail: the search was prematurely terminated due to the solver
    failure glp::eitlim: the search was prematurely terminated, because the
    simplex iteration limit has been exceeded glp::etmlim: the search was
    prematurely terminated, because the time limit has been exceeded When the
    list of options contains some bad option(s) then a list of bad options is
    returned instead.
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    Options not mentioned in the option list are set to their default values.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::exact lp [];

    glp_exact: 3 rows, 3 columns, 9 non-zeros

    GNU MP bignum library is being used

    * \ \ \ \ 2: \ \ objval = \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 0
    \ \ (0)

    * \ \ \ \ 4: \ \ objval = \ \ \ \ \ \ 733,333333333333 \ \ (0)

    OPTIMAL SOLUTION FOUND

    glp::ok

    \;
  </verbatim>

  <paragraph|Retrieve generic status of basic
  solution><label|retrieve-generic-status-of-basic-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_status lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::undef: solution is undefined glp::feas: solution is feasible
    glp::infeas: solution is infeasible glp::nofeas: no feasible solution
    exists glp::opt: solution is optimal glp::unbnd: solution is unbounded
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_status lp;

    glp::opt

    \;
  </verbatim>

  <paragraph|Retrieve generic status of primal
  solution><label|retrieve-generic-status-of-primal-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_prim_stat lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::undef: primal solution is undefined glp::feas: primal solution is
    feasible glp::infeas: primal solution is infeasible glp::nofeas: no
    primal feasible solution exists
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_prim_stat lp;

    glp::feas

    \;
  </verbatim>

  <paragraph|Retrieve generic status of dual
  solution><label|retrieve-generic-status-of-dual-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_dual_stat lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::undef: dual solution is undefined glp::feas: dual solution is
    feasible glp::infeas: dual solution is infeasible glp::nofeas: no dual
    feasible solution exists
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_dual_stat lp;

    glp::feas

    \;
  </verbatim>

  <paragraph|Retrieve value of the objective
  function><label|retrieve-value-of-the-objective-function>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_obj_val lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    value of the objective function
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_obj_val lp

    733.333333333333

    \;
  </verbatim>

  <paragraph|Retrieve generic status of a row
  variable><label|retrieve-generic-status-of-a-row-variable>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_row_stat lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::bs: basic variable glp::nl: non-basic variable on its lower bound
    glp::nu: non-basic variable on its upper bound glp::nf: non-basic free
    (unbounded) variable glp::ns: non-basic fixed variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_row_stat lp 3;

    glp::bs

    \;
  </verbatim>

  <paragraph|Retrieve row primal value><label|retrieve-row-primal-value>

  <\description>
    <item*|<with|font-series|bold|Synopsis>::>glp::get_row_prim lp rowindex
  </description>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    primal value of the row (auxiliary) variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_row_prim lp 3;

    200.0

    \;
  </verbatim>

  <paragraph|Retrieve row dual value><label|retrieve-row-dual-value>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_row_dual lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    dual value of the row (auxiliary) variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_row_dual lp 3;

    0.0

    \;
  </verbatim>

  <paragraph|Retrieve generic status of a column
  variable><label|retrieve-generic-status-of-a-column-variable>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_col_stat lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::bs: basic variable glp::nl: non-basic variable on its lower bound
    glp::nu: non-basic variable on its upper bound glp::nf: non-basic free
    (unbounded) variable glp::ns: non-basic fixed variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_col_stat lp 2;

    glp::bs

    \;
  </verbatim>

  <paragraph|Retrieve column primal value><label|retrieve-column-primal-value>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_col_prim lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    primal value of the column (structural) variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_col_prim lp 2;

    66.6666666666667

    \;
  </verbatim>

  <paragraph|Retrieve column dual value><label|retrieve-column-dual-value>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_col_dual lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    dual value of the column (structural) variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_col_dual lp 2;

    0.0

    \;
  </verbatim>

  <paragraph|Determine variable causing unboundedness><label|determine-variable-causing-unboundedness>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_unbnd_ray lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine glp_get_unbnd_ray returns the number k of a variable, which
    causes primal or dual unboundedness. If 1 \<less\>= k \<less\>= m, it is
    k-th auxiliary variable, and if m + 1 \<less\>= k \<less\>= m + n, it is
    (k - m)-th structural variable, where m is the number of rows, n is the
    number of columns in the problem object. If such variable is not defined,
    the routine returns 0.
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    If it is not exactly known which version of the simplex solver detected
    unboundedness, i.e. whether the unboundedness is primal or dual, it is
    sufficient to check the status of the variable with the routine
    glp::get_row_stat or glp::get_col_stat. If the variable is non-basic, the
    unboundedness is primal, otherwise, if the variable is basic, the
    unboundedness is dual (the latter case means that the problem has no
    primal feasible dolution).
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_unbnd_ray lp;

    0

    \;
  </verbatim>

  <paragraph|Interior-point method routines><label|interior-point-method-routines>

  <paragraph|Solve the LP problem using interior-point
  method><label|solve-the-lp-problem-using-interior-point-method>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::interior lp options

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    options: list of solver options in the form of tuples (option_name,
    value):

    glp::msg_lev:

    <\description>
      <item*|(default: glp::msg_all) - message level for>terminal output:
    </description>

    <with|font-series|bold|glp::msg_off:> no output

    <with|font-series|bold|glp::msg_err:> error and warning messages only

    <with|font-series|bold|glp::msg_on:> normal output;

    <with|font-series|bold|glp::msg_all:> full output (including
    informational messages) glp::ord_alg: (default: glp::ord_amd) - ordering
    algorithm option

    <with|font-series|bold|glp::ord_none:> use natural (original) ordering

    <with|font-series|bold|glp::ord_qmd:> quotient minimum degree (QMD)

    <with|font-series|bold|glp::ord_amd:> approximate minimum degree (AMD)

    <with|font-series|bold|glp::ord_sysamd:> approximate minimum degree
    (SYSAMD)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::ok: the LP problem instance has been successfully solved; this code
    does not necessarily mean that the solver has found optimal solution, it
    only means that the solution process was successful glp::efail: the
    problem has no rows/columns glp::enocvg: very slow convergence or
    divergence glp::eitlim: iteration limit exceeded glp::einstab: numerical
    instability on solving Newtonian system
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::interior lp [(glp::ord_alg, glp::ord_amd)];

    Original LP has 3 row(s), 3 column(s), and 9 non-zero(s)

    Working LP has 3 row(s), 6 column(s), and 12 non-zero(s)

    Matrix A has 12 non-zeros

    Matrix S = A*A' has 6 non-zeros (upper triangle)

    Approximate minimum degree ordering (AMD)...

    Computing Cholesky factorization S = L*L'...

    Matrix L has 6 non-zeros

    Guessing initial point...

    Optimization begins...

    \ \ 0: obj = -8,218489503e+002; rpi = 3,6e-001; rdi = 6,8e-001; gap =
    2,5e-001

    \ \ 1: obj = -6,719060895e+002; rpi = 3,6e-002; rdi = 1,9e-001; gap =
    1,4e-002

    \ \ 2: obj = -6,917210389e+002; rpi = 3,6e-003; rdi = 9,3e-002; gap =
    3,0e-002

    \ \ 3: obj = -7,267557732e+002; rpi = 2,1e-003; rdi = 9,3e-003; gap =
    4,4e-002

    \ \ 4: obj = -7,323038146e+002; rpi = 2,1e-004; rdi = 1,1e-003; gap =
    4,8e-003

    \ \ 5: obj = -7,332295932e+002; rpi = 2,1e-005; rdi = 1,1e-004; gap =
    4,8e-004

    \ \ 6: obj = -7,333229585e+002; rpi = 2,1e-006; rdi = 1,1e-005; gap =
    4,8e-005

    \ \ 7: obj = -7,333322959e+002; rpi = 2,1e-007; rdi = 1,1e-006; gap =
    4,8e-006

    \ \ 8: obj = -7,333332296e+002; rpi = 2,1e-008; rdi = 1,1e-007; gap =
    4,8e-007

    \ \ 9: obj = -7,333333230e+002; rpi = 2,1e-009; rdi = 1,1e-008; gap =
    4,8e-008

    \ 10: obj = -7,333333323e+002; rpi = 2,1e-010; rdi = 1,1e-009; gap =
    4,8e-009

    OPTIMAL SOLUTION FOUND

    glp::ok

    \;
  </verbatim>

  <paragraph|Retrieve status of interior-point
  solution><label|retrieve-status-of-interior-point-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ipt_status lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following

    glp::undef: interior-point solution is undefined glp::opt: interior-point
    solution is optimal glp::infeas: interior-point solution is infeasible
    glp::nofeas: no feasible primal-dual solution exists
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ipt_status lp;

    glp::opt

    \;
  </verbatim>

  <paragraph|Retrieve the objective function value of interior-point
  solution><label|retrieve-the-objective-function-value-of-interior-point-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ipt_obj_val lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    objective function value of interior-point solution
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ipt_obj_val lp;

    733.333332295849

    \;
  </verbatim>

  <paragraph|Retrieve row primal value of interior-point
  solution><label|retrieve-row-primal-value-of-interior-point-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ipt_row_prim lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    primal value of the row (auxiliary) variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ipt_row_prim lp 3;

    200.000000920688

    \;
  </verbatim>

  <paragraph|Retrieve row dual value of interior-point
  solution><label|retrieve-row-dual-value-of-interior-point-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ipt_row_dual lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    dual value of the row (auxiliary) variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ipt_row_dual lp 3;

    2.50607466186742e-008

    \;
  </verbatim>

  <paragraph|Retrieve column primal value of interior-point
  solution><label|retrieve-column-primal-value-of-interior-point-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ipt_col_prim lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    primal value of the column (structural) variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ipt_col_prim lp 2;

    66.666666406779

    \;
  </verbatim>

  <paragraph|Retrieve column dual value of interior-point
  solution><label|retrieve-column-dual-value-of-interior-point-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ipt_col_dual lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    dual value of the column (structural) variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ipt_col_dual lp 2;

    2.00019467655466e-009

    \;
  </verbatim>

  <paragraph|Mixed integer programming routines><label|mixed-integer-programming-routines>

  <paragraph|Set column kind><label|set-column-kind>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_col_kind lp (colindex, colkind)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    colindex: column index

    colkind: column kind - one of the following:

    glp::cv: continuous variable glp::iv: integer variable glp::bv: binary
    variable
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_col_kind lp (1, glp::iv);

    ()

    \;
  </verbatim>

  <paragraph|Retrieve column kind><label|retrieve-column-kind>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_col_kind lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::cv: continuous variable glp::iv: integer variable glp::bv: binary
    variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_col_kind lp 1;

    glp::iv

    \;
  </verbatim>

  <paragraph|Retrieve number of integer columns><label|retrieve-number-of-integer-columns>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_num_int lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    number of integer columns (including binary columns)
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp_get_num_int lp;

    1

    \;
  </verbatim>

  <paragraph|Retrieve number of binary columns><label|retrieve-number-of-binary-columns>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_num_bin lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    number of binary columns
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_num_bin lp

    0

    \;
  </verbatim>

  <paragraph|Solve the MIP problem using branch-and-cut
  method><label|solve-the-mip-problem-using-branch-and-cut-method>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::intopt lp options

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    options: list of solver options in the form of tuples (option_name,
    value):

    glp::msg_lev:

    <\description>
      <item*|(default: glp::msg_all) - message level for>terminal output:
    </description>

    <with|font-series|bold|glp::msg_off:> no output

    <with|font-series|bold|glp::msg_err:> error and warning messages only

    <with|font-series|bold|glp::msg_on:> normal output;

    <with|font-series|bold|glp::msg_all:> full output (including
    informational messages) glp::br_tech: (default: glp::bt::blb) - branching
    technique

    <with|font-series|bold|glp::br_ffv:> first fractional variable

    <with|font-series|bold|glp::br_lfv:> last fractional variable

    <with|font-series|bold|glp::br_mfv:> most fractional variable

    <with|font-series|bold|glp::br_dth:> heuristic by Driebeck and Tomlin

    <with|font-series|bold|glp::br_pch:> hybrid pseudocost heuristic
    glp::bt_tech: (default: glp::pt_pse) - backtracking technique

    <with|font-series|bold|glp::bt_dfs:> depth first search;

    <with|font-series|bold|glp::bt_bfs:> breadth first search;

    <with|font-series|bold|glp::bt_blb:> best local bound;

    <with|font-series|bold|glp::bt_bph:> best projection heuristic.
    glp::pp_tech: (default: glp::pp_all) - preprocessing technique

    <with|font-series|bold|glp::pp_none:> disable preprocessing;

    <with|font-series|bold|glp::pp_root:> perform preprocessing only on the
    root level

    <with|font-series|bold|glp::pp_all:> perform preprocessing on all levels
    glp::fp_heur: (default: glp::off) - feasibility pump heuristic:

    <with|font-series|bold|glp::on:> enable applying the feasibility pump
    heuristic

    <with|font-series|bold|glp::off:> disable applying the feasibility pump
    heuristic glp::gmi_cuts:

    <\description>
      <item*|(default: glp::off) - Gomory's mixed integer>cuts:
    </description>

    <with|font-series|bold|glp::on:> enable generating Gomory's cuts;

    <with|font-series|bold|glp::off:> disable generating Gomory's cuts.
    glp::mir_cuts:

    <\description>
      <item*|(default: glp::off) - mixed integer rounding>(MIR) cuts:
    </description>

    <with|font-series|bold|glp::on:> enable generating MIR cuts;

    <with|font-series|bold|glp::off:> disable generating MIR cuts.
    glp::cov_cuts: (default: glp::off) - mixed cover cuts:

    <with|font-series|bold|glp::on:> enable generating mixed cover cuts;

    <with|font-series|bold|glp::off:> disable generating mixed cover cuts.
    glp::clq_cuts (default: <nbsp> glp::off) - clique cuts:

    <with|font-series|bold|glp::on:> enable generating clique cuts;

    <with|font-series|bold|glp::off:> disable generating clique cuts.
    glp::tol_int: (default: 1e-5) - absolute tolerance used to check if
    optimal solution to the current LP relaxation is integer feasible

    glp::tol_obj: (default: 1e-7) - relative tolerance used to check if the
    objective value in optimal solution to the current LP relaxation is not
    better than in the best known integer feasible solution

    glp::mip_gap: (default: 0.0) - the relative mip gap tolerance; if the
    relative mip gap for currently known best integer feasible solution falls
    below this tolerance, the solver terminates the search - this allows
    obtainig suboptimal integer feasible solutions if solving the problem to
    optimality takes too long time

    glp::tm lim: (default: INT_MAX) - searching time limit, in milliseconds

    glp::out_frq: (default: 5000) - output frequency, in miliseconds - this
    parameter specifies how frequently the solver sends information about the
    solution process to the terminal

    glp::out_dly: (default: 10000) - output delay, in milliseconds - this
    parameter specifies how long the solver should delay sending information
    about the solution of the current LP relaxation with the simplex method
    to the terminal

    glp::cb_func:

    <\description>
      <item*|(default: glp::off) - specifies whether to use>the user-defined
      callback routine
    </description>

    <with|font-series|bold|glp::on:> use user-defined callback function - the
    function <verbatim|glp::mip_cb> <verbatim|tree> <verbatim|info>
    <with|font-series|bold|must> be defined by the user
    <with|font-series|bold|glp::off:> do not use user-defined callback
    function glp::cb_info: (default: NULL) - transit pointer passed to the
    routine <verbatim|glp::mip_cb> <verbatim|tree> <verbatim|info> (see
    above)

    glp::cb_size: (default: 0) - the number of extra (up to 256) bytes
    allocated for each node of the branch-and-bound tree to store
    application-specific data - on creating a node these bytes are
    initialized by binary zeros

    glp::presolve: (default: glp::off) - LP presolver option:

    <with|font-series|bold|glp::on:> enable using the MIP presolver

    <with|font-series|bold|glp::off:> disable using the MIP presolver
    glp::binarize:

    <\description>
      <item*|(default: glp::off) - binarization (used only if>the presolver
      is enabled):
    </description>

    <with|font-series|bold|glp::on:> replace general integer variables by
    binary ones

    <with|font-series|bold|glp::off:> do not use binarization
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::ok: the MIP problem instance has been successfully solved; this code
    does not necessarily mean that the solver has found optimal solution, it
    only means that the solution process was successful glp::ebound: unable
    to start the search, because some double-bounded (auxiliary or
    structural) variables have incorrect bounds or some integer variables
    have non-integer (fractional) bounds glp::eroot: unable to start the
    search, because optimal basis for initial LP relaxation is not provided -
    this code may appear only if the presolver is disabled glp::enopfs:
    unable to start the search, because LP relaxation of the MIP problem
    instance has no primal feasible solution - this code may appear only if
    the presolver is enabled glp::enodfs: unable to start the search, because
    LP relaxation of the MIP problem instance has no dual feasible solution;
    in other word, this code means that if the LP relaxation has at least one
    primal feasible solution, its optimal solution is unbounded, so if the
    MIP problem has at least one integer feasible solution, its (integer)
    optimal solution is also unbounded - this code may appear only if the
    presolver is enabled glp::efail: the search was prematurely terminated
    due to the solver failure glp::emipgap: the search was prematurely
    terminated, because the relative mip gap tolerance has been reached
    glp::etmlim: the search was prematurely terminated, because the time
    limit has been exceeded glp::estop: the search was prematurely terminated
    by application - this code may appear only if the advanced solver
    interface is used When the list of options contains some bad option(s)
    then a list of bad options is returned instead.
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    Options not mentioned in the option list are set to their default values.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::intopt lp [(glp::presolve, glp::on)];

    ipp_basic_tech: \ 0 row(s) and 0 column(s) removed

    ipp_reduce_bnds: 2 pass(es) made, 3 bound(s) reduced

    ipp_basic_tech: \ 0 row(s) and 0 column(s) removed

    ipp_reduce_coef: 1 pass(es) made, 0 coefficient(s) reduced

    glp_intopt: presolved MIP has 3 rows, 3 columns, 9 non-zeros

    glp_intopt: 3 integer columns, none of which are binary

    Scaling...

    \ A: min\|aij\| = \ 1,000e+00 \ max\|aij\| = \ 1,000e+01 \ ratio =
    \ 1,000e+01

    Problem data seem to be well scaled

    Crashing...

    Size of triangular part = 3

    Solving LP relaxation...

    * \ \ \ \ 2: obj = \ \ 0,000000000e+00 \ infeas = \ 0,000e+00 (0)

    * \ \ \ \ 5: obj = \ \ 7,333333333e+02 \ infeas = \ 0,000e+00 (0)

    OPTIMAL SOLUTION FOUND

    Integer optimization begins...

    + \ \ \ \ 5: mip = \ \ \ \ not found yet \<less\>=
    \ \ \ \ \ \ \ \ \ \ \ \ \ +inf \ \ \ \ \ \ \ (1; 0)

    + \ \ \ \ 6: \<gtr\>\<gtr\>\<gtr\>\<gtr\>\<gtr\> \ \ 7,320000000e+02
    \<less\>= \ \ 7,320000000e+02 \ \ 0.0% (2; 0)

    + \ \ \ \ 6: mip = \ \ 7,320000000e+02 \<less\>= \ \ \ \ tree is empty
    \ \ 0.0% (0; 3)

    INTEGER OPTIMAL SOLUTION FOUND

    glp::ok

    \;
  </verbatim>

  <paragraph|Retrieve status of mip solution><label|retrieve-status-of-mip-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mip_status lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::undef: MIP solution is undefined glp::opt: MIP solution is integer
    optimal glp::feas: MIP solution is integer feasible, however, its
    optimality (or non-optimality) has not been proven, perhaps due to
    premature termination of the search glp::nofeas: problem has no integer
    feasible solution (proven by the solver)
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mip_status lp;

    glp::opt

    \;
  </verbatim>

  <paragraph|Retrieve the objective function value of mip
  solution><label|retrieve-the-objective-function-value-of-mip-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mip_obj_val lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    objective function value of mip solution
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mip_obj_val lp;

    732.0

    \;
  </verbatim>

  <paragraph|Retrieve row value of mip solution><label|retrieve-row-value-of-mip-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mip_row_val lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    row value (value of auxiliary variable)
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mip_row_val lp 3;

    200.0

    \;
  </verbatim>

  <paragraph|Retrieve column value of mip
  solution><label|retrieve-column-value-of-mip-solution>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mip_col_val lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    column value (value of structural variable)
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mip_col_val lp 2;

    67.0

    \;
  </verbatim>

  <paragraph|Additional routines><label|additional-routines>

  <paragraph|Check Karush-Kuhn-Tucker conditions><label|check-karush-kuhn-tucker-conditions>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::check_kkt lp solution condition

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    solution: one of the following

    glp::sol: check basic solution glp::ipt: check interior-point solution
    glp::mip: check mixed integer solution condition: one of the following

    glp::kkt_pe: check primal equality constraints glp::kkt_pb: check primal
    bound constraints glp::kkt_de: check dual equality constraints (not
    available for MIP) glp::kkt_db: check dual bound constraints (not
    available for MIP)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    tuple with four members (ae_max, ae_ind, re_max, re_ind) where the
    variables indicate:

    ae_max: largest absolute error ae_ind: number of row (kkt_pe), column
    (kkt_de), or variable (kkt_pb, kkt_db) with the largest absolute error
    re_max: largest relative error re_ind: number of row (kkt_pe), column
    (kkt_de), or variable (kkt_pb, kkt_db) with the largest relative error
    where the variable index is (1 \<less\>= k \<less\>= m) for auxiliary
    variable and (m+1 \<less\>= k \<less\>= m+n) for structural variable
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::check_kkt lp glp::sol glp::kkt_pe;

    0.0,0,0.0,0

    \<gtr\> glp::check_kkt lp glp::mip glp::kkt_pe;

    2.23517417907715e-008,1,7.50126764193079e-016,34169

    \<gtr\>

    \;
  </verbatim>

  <subsubsection|Utility API routines><label|utility-api-routines>

  <paragraph|Problem data reading/writing
  routines><label|problem-data-reading-writing-routines>

  <paragraph|Read LP problem data from a MPS
  file><label|read-lp-problem-data-from-a-mps-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::read_mps lp format filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    format: one of the following

    glp::mps_deck: fixed (ancient) MPS file format glp::mps_file: free
    (modern) MPS file format filename: file name - if the file name ends with
    suffix <with|font-series|bold|.gz>, the file is assumed to be compressed,
    in which case the routine glp::read_mps decompresses it ``on the fly''
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::read_mps lp glp::mps_deck "examples/plan.mps";

    Reading problem data from `examples/plan.mps'...

    Problem PLAN

    Objective R0000000

    8 rows, 7 columns, 55 non-zeros

    63 records were read

    0

    \;
  </verbatim>

  <paragraph|Write LP problem data into a MPS
  file><label|write-lp-problem-data-into-a-mps-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::write_mps lp format filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    format: one of the following

    glp::mps_deck: fixed (ancient) MPS file format glp::mps_file: free
    (modern) MPS file format filename: file name - if the file name ends with
    suffix <with|font-series|bold|.gz>, the file is assumed to be compressed,
    in which case the routine glp_write_mps performs automatic compression on
    writing it
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::write_mps lp glp::mps_file "examples/plan1.mps";

    Writing problem data to `examples/plan1.mps'...

    63 records were written

    0

    \;
  </verbatim>

  <paragraph|Read LP problem data from a CPLEX
  file><label|read-lp-problem-data-from-a-cplex-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::read_lp lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name - if the file
    name ends with suffix <with|font-series|bold|.gz>, the file is assumed to
    be compressed, in which case the routine glp::read_lp decompresses it
    ``on the fly''
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::read_lp lp "examples/plan.lp";

    reading problem data from `examples/plan.lp'...

    8 rows, 7 columns, 48 non-zeros

    39 lines were read

    0

    \;
  </verbatim>

  <paragraph|Write LP problem data into a CPLEX
  file><label|write-lp-problem-data-into-a-cplex-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::write_lp lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name - if the file
    name ends with suffix <with|font-series|bold|.gz>, the file is assumed to
    be compressed, in which case the routine glp::write_lp performs automatic
    compression on writing it
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::write_lp lp "examples/plan1.lp";

    writing problem data to `examples/plan1.lp'...

    29 lines were written

    0

    \;
  </verbatim>

  <paragraph|Read LP problem data in GLPK
  format><label|read-lp-problem-data-in-glpk-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::read_prob lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name - if the file
    name ends with suffix <with|font-series|bold|.gz>, the file is assumed to
    be compressed, in which case the routine glp::read_prob decompresses it
    ``on the fly''
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::read_prob lp "examples/plan.glpk";

    reading problem data from `examples/plan.glpk'...

    8 rows, 7 columns, 48 non-zeros

    86 lines were read

    0

    \;
  </verbatim>

  <paragraph|Write LP problem data in GLPK
  format><label|write-lp-problem-data-in-glpk-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::write_prob lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name - if the file
    name ends with suffix <with|font-series|bold|.gz>, the file is assumed to
    be compressed, in which case the routine glp::write_prob performs
    automatic compression on writing it
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::write_prob lp "examples/plan1.glpk";

    writing problem data to `examples/plan1.glpk'...

    86 lines were written

    0

    \;
  </verbatim>

  <paragraph|Routines for MathProg models><label|routines-for-mathprog-models>

  <paragraph|Create the MathProg translator
  object><label|create-the-mathprog-translator-object>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mpl_alloc_wksp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    none
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    pointer to the MathProg translator object
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> let mpt = glp::mpl_alloc_wksp;

    \<gtr\> mpt;

    #\<less\>pointer 0xa0d0180\<gtr\>

    \;
  </verbatim>

  <paragraph|Read and translate model section><label|read-and-translate-model-section>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mpl_read_model tranobject filename skip

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tranobject: pointer to the MathProg translator object filename: file name
    skip: if <with|font-series|bold|0> then the data section from the model
    file is read; if non-zero, the data section in the data model is skipped
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> mpl_read_model mpt "examples/sudoku.mod" 1;

    Reading model section from examples/sudoku.mod...

    examples/sudoku.mod:69: warning: data section ignored

    69 lines were read

    0

    \;
  </verbatim>

  <paragraph|Read and translate data section><label|read-and-translate-data-section>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mpl_read_data tranobject filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tranobject: pointer to the MathProg translator object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mpl_read_data mpt "examples/sudoku.dat";

    Reading data section from examples/sudoku.dat...

    16 lines were read

    0

    \;
  </verbatim>

  <paragraph|Generate the model><label|generate-the-model>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mpl_generate tranobject filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tranobject: pointer to the MathProg translator object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if generating went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mpl_generate mpt "examples/sudoku.lst";

    Generating fa...

    Generating fb...

    Generating fc...

    Generating fd...

    Generating fe...

    Model has been successfully generated

    0

    \;
  </verbatim>

  <paragraph|Build problem instance from the
  model><label|build-problem-instance-from-the-model>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mpl_build_prob tranobject lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tranobject: pointer to the MathProg translator object lp: pointer to the
    LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mpl_build_prob mpt lp;

    ()

    \;
  </verbatim>

  <paragraph|Postsolve the model><label|postsolve-the-model>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mpl_postsolve tran lp solution

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tranobject: pointer to the MathProg translator object

    lp: pointer to the LP problem object

    solution: one of the following:

    glp::sol: use the basic solution glp::ipt: use the interior-point
    solution glp::mip: use mixed integer solution
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if postsolve went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mpl_postsolve mpt lp glp::sol;

    Model has been successfully processed

    0

    \;
  </verbatim>

  <paragraph|Delete the MathProg translator
  object><label|delete-the-mathprog-translator-object>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mpl_free_wksp tranobject

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tranobject: pointer to the MathProg translator object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mpl_free_wksp mpt;

    ()

    \;
  </verbatim>

  <paragraph|Problem solution reading/writing
  routines><label|problem-solution-reading-writing-routines>

  <paragraph|Write basic solution in printable
  format><label|write-basic-solution-in-printable-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::print_sol lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::print_sol lp "examples/test.txt";

    Writing basic solution to `examples/test.txt'...

    0

    \;
  </verbatim>

  <paragraph|Read basic solution from a text
  file><label|read-basic-solution-from-a-text-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::read_sol lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::read_sol lp "examples/test.txt";

    Reading basic solution from `examples/test.txt'...

    1235 lines were read

    0

    \;
  </verbatim>

  <paragraph|Write basic solution into a text
  file><label|write-basic-solution-into-a-text-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::write_sol lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::write_sol lp "examples/test.txt";

    Writing basic solution to `examples/test.txt'...

    1235 lines were written

    0

    \;
  </verbatim>

  <paragraph|Print sensitivity analysis report><label|print-sensitivity-analysis-report>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::print_ranges lp indices filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object indices: list indices k of of rows
    and columns to be included in the report. If 1 <math|\<leq\>> k
    <math|\<leq\>> m, the basic variable is k-th auxiliary variable, and if m
    + 1 <math|\<leq\>> k <math|\<leq\>> m + n, the non-basic variable is (k -
    m)-th structural variable, where m is the number of rows and n is the
    number of columns in the specified problem object. An empty lists means
    printing report for all rows and columns. filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    0: if the operation was successful non-zero: if the operation failed
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::print_ranges lp [] "sensitivity.rpt";

    Write sensitivity analysis report to `sensitivity.rpt'...

    0

    \;
  </verbatim>

  <paragraph|Write interior-point solution in printable
  format><label|write-interior-point-solution-in-printable-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::print_ipt lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::print_ipt lp "examples/test.txt";

    Writing interior-point solution to `examples/test.txt'...

    0

    \;
  </verbatim>

  <paragraph|Read interior-point solution from a text
  file><label|read-interior-point-solution-from-a-text-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::read_ipt lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::read_ipt lp "examples/test.txt";

    Reading interior-point solution from `examples/test.txt'...

    1235 lines were read

    0

    \;
  </verbatim>

  <paragraph|Write interior-point solution into a text
  file><label|write-interior-point-solution-into-a-text-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::write_ipt lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::write_ipt lp "examples/test.txt";

    Writing interior-point solution to `examples/test.txt'...

    1235 lines were written

    0

    \;
  </verbatim>

  <paragraph|Write MIP solution in printable
  format><label|write-mip-solution-in-printable-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::print_mip lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::print_mip lp "examples/test.txt";

    Writing MIP solution to `examples/test.txt'...

    0

    \;
  </verbatim>

  <paragraph|Read MIP solution from a text
  file><label|read-mip-solution-from-a-text-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::read_mip lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::read_mip lp "examples/test.txt";

    Reading MIP solution from `examples/test.txt'...

    1235 lines were read

    0

    \;
  </verbatim>

  <paragraph|Write MIP solution into a text
  file><label|write-mip-solution-into-a-text-file>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::write_mip lp filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if writing went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::write_mip lp "examples/test.txt";

    Writing MIP solution to `examples/test.txt'...

    1235 lines were written

    0

    \;
  </verbatim>

  <subsubsection|Advanced API routines><label|advanced-api-routines>

  <paragraph|LP basis routines><label|lp-basis-routines>

  <paragraph|Check whether basis factorization
  exists><label|check-whether-basis-factorization-exists>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::bf_exists lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    non-zero: the basis factorization exists and can be used for calculations
    0: the basis factorization does not exist
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::bf:exists lp;

    1

    \;
  </verbatim>

  <paragraph|Compute the basis factorization><label|compute-the-basis-factorization>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::factorize lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::ok: the basis factorization has been successfully computed
    glp::ebadb: the basis matrix is invalid, because the number of basic
    (auxiliary and structural) variables is not the same as the number of
    rows in the problem object glp::esing: the basis matrix is singular
    within the working precision glp::exond: the basis matrix is
    ill-conditioned, i.e. its condition number is too large
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::factorize lp;

    glp::ok

    \;
  </verbatim>

  <paragraph|Check whether basis factorization has been
  updated><label|check-whether-basis-factorization-has-been-updated>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::bf_updated lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    0: if the basis factorization has been just computed from ``scratch''
    non-zero: if the factorization has been updated at least once
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::bf_updated lp;

    0

    \;
  </verbatim>

  <paragraph|Get basis factorization parameters><label|get-basis-factorization-parameters>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_bfcp lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    complete list of options in a form of tuples (option_name, value):

    glp::fact_type: basis factorization type:

    glp::bf_ft: LU + Forrest\UTomlin update glp::bf_bg: LU + Schur complement
    + Bartels\UGolub update glp::bf_gr: LU + Schur complement + Givens
    rotation update glp::lu_size: the initial size of the Sparse Vector Area,
    in non-zeros, used on computing LU-factorization of the basis matrix for
    the first time - if this parameter is set to 0, the initial SVA size is
    determined automatically

    glp::piv_tol: threshold pivoting (Markowitz) tolerance, 0 \<less\>
    piv_tol \<less\> 1, used on computing LU-factorization of the basis
    matrix

    glp::piv_lim: this parameter is used on computing LU-factorization of the
    basis matrix and specifies how many pivot candidates needs to be
    considered on choosing a pivot element, piv_lim \<geq\> 1

    glp::suhl: this parameter is used on computing LU-factorization of the
    basis matrix

    glp::on: enables applying the heuristic proposed by Uwe Suhl glp::off:
    disables this heuristic glp::eps_tol: epsilon tolerance, eps_tol \<geq\>
    0, used on computing LU-factorization of the basis matrix

    glp::max_gro: maximal growth of elements of factor U, max_gro \<geq\> 1,
    allowable on computing LU-factorization of the basis matrix

    glp::nfs_max: maximal number of additional row-like factors (entries of
    the eta file), nfs_max \<geq\> 1, which can be added to LU-factorization
    of the basis matrix on updating it with the Forrest\UTomlin technique

    glp::upd_tol: update tolerance, 0 \<less\> upd_tol \<less\> 1, used on
    updating LU-factorization of the basis matrix with the Forrest\UTomlin
    technique

    glp::nrs_max: maximal number of additional rows and columns, nrs_max
    \<geq\> 1, which can be added to LU-factorization of the basis matrix on
    updating it with the Schur complement technique

    glp::rs_size: the initial size of the Sparse Vector Area, in non-zeros,
    used to store non-zero elements of additional rows and columns introduced
    on updating LU-factorization of the basis matrix with the Schur
    complement technique - if this parameter is set to 0, the initial SVA
    size is determined automatically
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_bfcp lp;

    [(glp::fact_type,glp::bf_ft),(glp::lu_size,0),(glp::piv_tol,0.1),

    (glp::piv_lim,4),(glp::suhl,glp::on),(glp::eps_tol,1e-15),

    (glp::max_gro,10000000000.0),(glp::nfs_max,50),(glp::upd_tol,1e-06),

    (glp::nrs_max,50),(glp::rs_size,0)]

    \;
  </verbatim>

  <paragraph|Change basis factorization parameters><label|change-basis-factorization-parameters>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_bfcp lp options

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    options: list of options in a form of tuples (option_name, value):

    glp::fact_type: (default: glp::bf_ft) - basis factorization type:

    glp::bf_ft: LU + Forrest\UTomlin update glp::bf_bg: LU + Schur complement
    + Bartels\UGolub update glp::bf_gr: LU + Schur complement + Givens
    rotation update glp::lu_size: (default: 0) - the initial size of the
    Sparse Vector Area, in non-zeros, used on computing LU-factorization of
    the basis matrix for the first time - if this parameter is set to 0, the
    initial SVA size is determined automatically

    glp::piv_tol: (default: 0.10) - threshold pivoting (Markowitz) tolerance,
    0 \<less\> piv_tol \<less\> 1, used on computing LU-factorization of the
    basis matrix.

    glp::piv_lim: (default: 4) - this parameter is used on computing
    LU-factorization of the basis matrix and specifies how many pivot
    candidates needs to be considered on choosing a pivot element, piv_lim
    \<geq\> 1

    glp::suhl: (default: glp::on) - this parameter is used on computing
    LU-factorization of the basis matrix.

    glp::on: enables applying the heuristic proposed by Uwe Suhl glp::off:
    disables this heuristic glp::eps_tol: (default: 1e-15) - epsilon
    tolerance, eps_tol \<geq\> 0, used on computing LU -factorization of the
    basis matrix.

    glp::max_gro: (default: 1e+10) - maximal growth of elements of factor U,
    max_gro \<geq\> 1, allowable on computing LU-factorization of the basis
    matrix.

    glp::nfs_max: (default: 50) - maximal number of additional row-like
    factors (entries of the eta file), nfs_max \<geq\> 1, which can be added
    to LU-factorization of the basis matrix on updating it with the
    Forrest\UTomlin technique.

    glp::upd_tol: (default: 1e-6) - update tolerance, 0 \<less\> upd_tol
    \<less\> 1, used on updating LU -factorization of the basis matrix with
    the Forrest\UTomlin technique.

    glp::nrs_max: (default: 50) - maximal number of additional rows and
    columns, nrs_max \<geq\> 1, which can be added to LU-factorization of the
    basis matrix on updating it with the Schur complement technique.

    glp::rs_size: (default: 0) - the initial size of the Sparse Vector Area,
    in non-zeros, used to store non-zero elements of additional rows and
    columns introduced on updating LU-factorization of the basis matrix with
    the Schur complement technique - if this parameter is set to 0, the
    initial SVA size is determined automatically
  </quote-env>

  <with|font-series|bold|Remarks>:

  <\quote-env>
    Options not mentioned in the option list are left unchanged.

    All options will be reset to their default values when an empty option
    list is supplied.
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()> if all options are OK, otherwise returns a list of bad
    options
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp_set_bfcp lp [(glp::fact_type, glp::bf_ft), (glp::piv_tol,
    0.15)];

    ()

    \;
  </verbatim>

  <paragraph|Retrieve the basis header information><label|retrieve-the-basis-header-information>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_bhead lp k

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object k: variable index in the basis
    matrix
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    If basic variable (xB )k , 1 <math|\<leq\>> k <math|\<leq\>> m, is i-th
    auxiliary variable (1 <math|\<leq\>> i <math|\<leq\>> m), the routine
    returns i. Otherwise, if (xB )k is j-th structural variable (1
    <math|\<leq\>> j <math|\<leq\>> n), the routine returns m+j. Here m is
    the number of rows and n is the number of columns in the problem object.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_bhead lp 3;

    5

    \;
  </verbatim>

  <paragraph|Retrieve row index in the basis
  header><label|retrieve-row-index-in-the-basis-header>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_row_bind lp rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    This routine returns the index k of basic variable (xB )k, 1
    <math|\<leq\>> k <math|\<leq\>> m, which is i-th auxiliary variable (that
    is, the auxiliary variable corresponding to i-th row), 1 <math|\<leq\>> i
    <math|\<leq\>> m, in the current basis associated with the specified
    problem object, where m is the number of rows. However, if i-th auxiliary
    variable is non-basic, the routine returns zero.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_row_bind lp 3;

    1

    \;
  </verbatim>

  <paragraph|Retrieve column index in the basis
  header><label|retrieve-column-index-in-the-basis-header>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::get_col_bind lp colindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colindex: column index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    This routine returns the index k of basic variable (xB )k, 1
    <math|\<leq\>> k <math|\<leq\>> m, which is j-th structural variable
    (that is, the structural variable corresponding to j-th column), 1
    <math|\<leq\>> j <math|\<leq\>> n, in the current basis associated with
    the specified problem object, where m is the number of rows, n is the
    number of columns. However, if j-th structural variable is non-basic, the
    routine returns zero.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::get_col_bind lp 2;

    3

    \;
  </verbatim>

  <paragraph|Perform forward transformation><label|perform-forward-transformation>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ftran lp vector

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object vector: vector to be transformed - a
    dense vector in a form of a list of double numbers has to be supplied and
    the number of its members must exactly correspond to the number of LP
    problem constraints
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    the transformed vector in the same format
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ftran lp [1.5, 3.2, 4.8];

    [1.8,0.466666666666667,-1.96666666666667]

    \;
  </verbatim>

  <paragraph|Perform backward transformation><label|perform-backward-transformation>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::btran lp vector

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object vector: vector to be transformed - a
    dense vector in a form of a list of double numbers has to be supplied and
    the number of its members must exactly correspond to the number of LP
    problem constraints
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    the transformed vector in the same format
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::btran lp [1.5, 3.2, 4.8];

    [-8.86666666666667,0.266666666666667,1.5]

    \;
  </verbatim>

  <paragraph|Warm up LP basis><label|warm-up-lp-basis>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::warm_up lp

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::ok: the LP basis has been successfully ``warmed up'' glp::ebadb: the
    LP basis is invalid, because the number of basic variables is not the
    same as the number of rows glp::esing: the basis matrix is singular
    within the working precision glp::econd: the basis matrix is
    ill-conditioned, i.e. its condition number is too large
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::warm_up lp;

    glp::e_ok

    \;
  </verbatim>

  <paragraph|Simplex tableau routines><label|simplex-tableau-routines>

  <paragraph|Compute row of the tableau><label|compute-row-of-the-tableau>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::eval_tab_row lp k

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object k: variable index such that it
    corresponds to some basic variable: if 1 <math|\<leq\>> k <math|\<leq\>>
    m, the basic variable is k-th auxiliary variable, and if m + 1
    <math|\<leq\>> k <math|\<leq\>> m + n, the basic variable is (k - m)-th
    structural variable, where m is the number of rows and n is the number of
    columns in the specified problem object (the basis factorization must
    exist)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    simplex tableau row in a sparse form as a list of tuples (index, value),
    where index has the same meaning as k in parameters
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::eval_tab_row lp 3;

    [(1,2.0),(6,4.0)]

    \;
  </verbatim>

  <paragraph|Compute column of the tableau><label|compute-column-of-the-tableau>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::eval_tab_col lp k

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object k: variable index such that it
    corresponds to some non-basic variable: if 1 <math|\<leq\>> k
    <math|\<leq\>> m, the non-basic variable is k-th auxiliary variable, and
    if m + 1 <math|\<leq\>> k <math|\<leq\>> m + n, the non-basic variable is
    (k - m)-th structural variable, where m is the number of rows and n is
    the number of columns in the specified problem object (the basis
    factorization must exist)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    simplex tableau column in a sparse form as a list of tuples (index,
    value), where index has the same meaning as k in parameters
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::eval_tab_col lp 1;

    [(3,2.0),(4,-0.666666666666667),(5,1.66666666666667)]

    \;
  </verbatim>

  <paragraph|Transform explicitly specified
  row><label|transform-explicitly-specified-row>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::transform_row lp rowvector

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowvector: row vector to be
    transformed in a sparse form as a list of tuples (k, value): if 1
    <math|\<leq\>> k <math|\<leq\>> m, the non-basic variable is k-th
    auxiliary variable, and if m + 1 <math|\<leq\>> k <math|\<leq\>> m + n,
    the non-basic variable is (k - m)-th structural variable, where m is the
    number of rows and n is the number of columns in the specified problem
    object (the basis factorization must exist)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    the transformed row in a sparse form as a list of tuples (index, value),
    where index has the same meaning as k in parameters
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::transform_row lp [(1, 3.0), (2, 3.5)];

    [(1,3.83333333333333),(2,-0.0833333333333333),(6,-3.41666666666667)]

    \;
  </verbatim>

  <paragraph|Transform explicitly specified
  column><label|transform-explicitly-specified-column>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::transform_col lp colvector

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colvector: column vector to be
    transformed in a sparse form as a list of tuples (k, value): if 1
    <math|\<leq\>> k <math|\<leq\>> m, the non-basic variable is k-th
    auxiliary variable, and if m + 1 <math|\<leq\>> k <math|\<leq\>> m + n,
    the non-basic variable is (k - m)-th structural variable, where m is the
    number of rows and n is the number of columns in the specified problem
    object (the basis factorization must exist)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    the transformed column in a sparse form as a list of tuples (index,
    value), where index has the same meaning as k in parameters
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::transform_col lp [(2, 1.0), (3, 2.3)];

    [(3,2.3),(4,-0.166666666666667),(5,0.166666666666667)]

    \;
  </verbatim>

  <paragraph|Perform primal ratio test><label|perform-primal-ratio-test>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::prim_rtest lp colvector dir eps

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object colvector: simplex tableau column in
    a sparse form as a list of tuples (k, value): if 1 <math|\<leq\>> k
    <math|\<leq\>> m, the basic variable is k-th auxiliary variable, and if m
    + 1 <math|\<leq\>> k <math|\<leq\>> m + n, the basic variable is (k -
    m)-th structural variable, where m is the number of rows and n is the
    number of columns in the specified problem object (the basis
    factorization must exist and the primal solution must be feasible) dir:
    specifies in which direction the variable y changes on entering the
    basis: +1 means increasing, -1 means decreasing eps: relative tolerance
    (small positive number) used to skip small values in the column
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the index, piv, in the colvector corresponding to the
    pivot element chosen, 1 <math|\<leq\>> piv <math|\<leq\>> len. If the
    adjacent basic solution is primal unbounded, and therefore the choice
    cannot be made, the routine returns zero.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::prim_rtest lp [(3, 2.5), (5, 7.0)] 1 1.0e-5;

    3

    \;
  </verbatim>

  <paragraph|Perform dual ratio test><label|perform-dual-ratio-test>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::dual_rtest lp rowvector dir eps

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object rowvector: simplex tableau row in a
    sparse form as a list of tuples (k, value): if 1 <math|\<leq\>> k
    <math|\<leq\>> m, the non-basic variable is k-th auxiliary variable, and
    if m + 1 <math|\<leq\>> k <math|\<leq\>> m + n, the non-basic variable is
    (k - m)-th structural variable, where m is the number of rows and n is
    the number of columns in the specified problem object (the basis
    factorization must exist and the dual solution must be feasible) dir:
    specifies in which direction the variable y changes on leaving the basis:
    +1 means increasing, -1 means decreasing eps: relative tolerance (small
    positive number) used to skip small values in the row
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the index, piv, in the rowvector corresponding to the
    pivot element chosen, 1 <math|\<leq\>> piv <math|\<leq\>> len. If the
    adjacent basic solution is dual unbounded, and therefore the choice
    cannot be made, the routine returns zero.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::dual_rtest lp [(1, 1.5), (6, 4.0)] 1 1.0e-5;

    6

    \;
  </verbatim>

  <paragraph|Analyze active bound of non-basic
  variable><label|analyze-active-bound-of-non-basic-variable>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::analyze_bound lp k

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object k: if 1 <math|\<leq\>> k
    <math|\<leq\>> m, the non-basic variable is k-th auxiliary variable, and
    if m + 1 <math|\<leq\>> k <math|\<leq\>> m + n, the non-basic variable is
    (k - m)-th structural variable, where m is the number of rows and n is
    the number of columns in the specified problem object (the basis
    factorization must exist and the solution must be optimal)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns a tuple (limit1, var1, limit2 var2) where:

    value1: the minimal value of the active bound, at which the basis still
    remains primal feasible and thus optimal. -DBL_MAX means that the active
    bound has no lower limit. var1: the ordinal number of an auxiliary (1 to
    m) or structural (m + 1 to m + n) basic variable, which reaches its bound
    first and thereby limits further decreasing the active bound being
    analyzed. If value1 = -DBL_MAX, var1 is set to 0. value2: the maximal
    value of the active bound, at which the basis still remains primal
    feasible and thus optimal. +DBL_MAX means that the active bound has no
    upper limit. var2: the ordinal number of an auxiliary (1 to m) or
    structural (m + 1 to m + n) basic variable, which reaches its bound first
    and thereby limits further increasing the active bound being analyzed. If
    value2 = +DBL_MAX, var2 is set to 0.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> analyze_bound lp 2;

    1995.06864446899,12,2014.03478832467,4

    \;
  </verbatim>

  <paragraph|Analyze objective coefficient at basic
  variable><label|analyze-objective-coefficient-at-basic-variable>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::analyze_coef lp k

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object k: if 1 <math|\<leq\>> k
    <math|\<leq\>> m, the basic variable is k-th auxiliary variable, and if m
    + 1 <math|\<leq\>> k <math|\<leq\>> m + n, the non-basic variable is (k -
    m)-th structural variable, where m is the number of rows and n is the
    number of columns in the specified problem object (the basis
    factorization must exist and the solution must be optimal)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns a tuple (coef1, var1, value1, coef2 var2, value2)
    where:

    coef1: the minimal value of the objective coefficient, at which the basis
    still remains dual feasible and thus optimal. -DBL_MAX means that the
    objective coefficient has no lower limit. var1: is the ordinal number of
    an auxiliary (1 to m) or structural (m + 1 to m + n) non-basic variable,
    whose reduced cost reaches its zero bound first and thereby limits
    further decreasing the objective coefficient being analyzed. If coef1 =
    -DBL_MAX, var1 is set to 0. value1: value of the basic variable being
    analyzed in an adjacent basis, which is defined as follows. Let the
    objective coefficient reaches its minimal value (coef1) and continues
    decreasing. Then the reduced cost of the limiting non-basic variable
    (var1) becomes dual infeasible and the current basis becomes non-optimal
    that forces the limiting non-basic variable to enter the basis replacing
    there some basic variable that leaves the basis to keep primal
    feasibility. Should note that on determining the adjacent basis current
    bounds of the basic variable being analyzed are ignored as if it were
    free (unbounded) variable, so it cannot leave the basis. It may happen
    that no dual feasible adjacent basis exists, in which case value1 is set
    to -DBL_MAX or +DBL_MAX. coef2: the maximal value of the objective
    coefficient, at which the basis still remains dual feasible and thus
    optimal. +DBL_MAX means that the objective coefficient has no upper
    limit. var2: the ordinal number of an auxiliary (1 to m) or structural (m
    + 1 to m + n) non-basic variable, whose reduced cost reaches its zero
    bound first and thereby limits further increasing the objective
    coefficient being analyzed. If coef2 = +DBL_MAX, var2 is set to 0.
    value2: value of the basic variable being analyzed in an adjacent basis,
    which is defined exactly in the same way as value1 above with exception
    that now the objective coefficient is increasing.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> analyze_coef lp 1;

    -1.0,3,306.771624713959,1.79769313486232e+308,0,296.216606498195

    \;
  </verbatim>

  <subsubsection|Branch-and-cut API routines><label|branch-and-cut-api-routines>

  <\quote-env>
    All branch-and-cut API routines are supposed to be called from the
    callback routine. They cannot be called directly.
  </quote-env>

  <paragraph|Basic routines><label|basic-routines>

  <paragraph|Determine reason for calling the callback
  routine><label|determine-reason-for-calling-the-callback-routine>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_reason tree

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    one of the following:

    glp::irowgen: request for row generation glp::ibingo: better integer
    solution found glp::iheur: request for heuristic solution glp::icutgen:
    request for cut generation glp::ibranch: request for branching
    glp::iselect: request for subproblem selection glp::iprepro: request for
    preprocessing
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    glp::ios:reason tree;

    \;
  </verbatim>

  <paragraph|Access the problem object><label|access-the-problem-object>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_get_prob tree

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns a pointer to the problem object used by the MIP
    solver.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    glp::ios_get_prob tree;

    \;
  </verbatim>

  <paragraph|Determine additional row attributes><label|determine-additional-row-attributes>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_row_attr tree rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree rowindex: row index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns a tuple consisting of three values (level, origin,
    klass):

    level: subproblem level at which the row was created

    origin: the row origin flag - one of the following:

    glp::rf_reg: regular constraint glp::rf_lazy: ``lazy'' constraint
    glp::rf_cut: cutting plane constraint klass: the row class descriptor,
    which is a number passed to the routine glp_ios_add_row as its third
    parameter - if the row is a cutting plane constraint generated by the
    solver, its class may be the following:

    glp::rf_gmi: Gomory's mixed integer cut glp::rf_mir: mixed integer
    rounding cut glp::rf_cov: mixed cover cut glp::rf_clq: clique cut
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    glp::ios_row_attr tree 3;

    \;
  </verbatim>

  <paragraph|Compute relative MIP gap><label|compute-relative-mip-gap>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_mip_gap tree

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the relative MIP gap.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_mip_gap tree;

    \;
  </verbatim>

  <paragraph|Access application-specific data><label|access-application-specific-data>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_node_data tree node

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine glp_ios_node_data returns a pointer to the memory block for
    the specified subproblem. Note that if cb_size = 0 was specified in the
    call of the <with|font-series|bold|intopt> function, the routine returns
    a null pointer.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_node_data tree 23;

    \;
  </verbatim>

  <paragraph|Select subproblem to continue the
  search><label|select-subproblem-to-continue-the-search>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_select_node tree node

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree node: reference number of
    the subproblem from which the search will continue
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_select_node tree 23;

    \;
  </verbatim>

  <paragraph|Provide solution found by heuristic><label|provide-solution-found-by-heuristic>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_heur_sol tree colvector

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree colvector: solution found
    by a primal heuristic. Primal values of all variables (columns) found by
    the heuristic should be placed in the list, i. e. the list must contain n
    numbers where n is the number of columns in the original problem object.
    Note that the routine does not check primal feasibility of the solution
    provided.
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    If the provided solution is accepted, the routine returns zero.
    Otherwise, if the provided solution is rejected, the routine returns
    non-zero.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_heur_sol tree [15.7, (-3.1), 2.2];

    \;
  </verbatim>

  <paragraph|Check whether can branch upon specified
  variable><label|check-whether-can-branch-upon-specified-variable>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_can_branch tree j

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree j: variable (column)
    index
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The function returns non-zero if j-th variable can be used for branching.
    Otherwise, it returns zero.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_can_branch tree 23;

    \;
  </verbatim>

  <paragraph|Choose variable to branch upon><label|choose-variable-to-branch-upon>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_branch_upon tree j selection

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree

    j: ordinal number of the selected branching variable

    selection: one of the following:

    glp::dn_brnch: select down-branch glp::up_brnch: select up-branch
    glp::no_brnch: use general selection technique
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_branch_upon tree 23 glp::up_brnch;

    \;
  </verbatim>

  <paragraph|Terminate the solution process><label|terminate-the-solution-process>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_terminate tree

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_terminate tree;

    \;
  </verbatim>

  <paragraph|The search tree exploring routines><label|the-search-tree-exploring-routines>

  <paragraph|Determine the search tree size><label|determine-the-search-tree-size>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_tree_size tree

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns a tuple (a_cnt, n_cnt, t_cnt), where

    a_cnt: the current number of active nodes n_cnt: the current number of
    all (active and inactive) nodes t_cnt: the total number of nodes
    including those which have been already removed from the tree. This count
    is increased whenever a new node appears in the tree and never decreased.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_tree_size tree;

    \;
  </verbatim>

  <paragraph|Determine current active subproblem><label|determine-current-active-subproblem>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_curr_node tree

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the reference number of the current active
    subproblem. If the current subproblem does not exist, the routine returns
    zero.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_curr_node tree;

    \;
  </verbatim>

  <paragraph|Determine next active subproblem><label|determine-next-active-subproblem>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_next_node tree node

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree node: reference number of
    an active subproblem or zero
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    If the parameter p is zero, the routine returns the reference number of
    the first active subproblem. If the tree is empty, zero is returned. If
    the parameter p is not zero, it must specify the reference number of some
    active subproblem, in which case the routine returns the reference number
    of the next active subproblem. If there is no next active subproblem in
    the list, zero is returned. All subproblems in the active list are
    ordered chronologically, i.e. subproblem A precedes subproblem B if A was
    created before B.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_next_node tree 23;

    \;
  </verbatim>

  <paragraph|Determine previous active subproblem><label|determine-previous-active-subproblem>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_prev_node tree node

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree node: reference number of
    an active subproblem or zero
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    If the parameter p is zero, the routine returns the reference number of
    the last active subproblem. If the tree is empty, zero is returned. If
    the parameter p is not zero, it must specify the reference number of some
    active subproblem, in which case the routine returns the reference number
    of the previous active subproblem. If there is no previous active
    subproblem in the list, zero is returned. All subproblems in the active
    list are ordered chronologically, i.e. subproblem A precedes subproblem B
    if A was created before B.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_prev_node tree 23;

    \;
  </verbatim>

  <paragraph|Determine parent active subproblem><label|determine-parent-active-subproblem>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_up_node tree node

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree node: reference number of
    an active or inactive subproblem
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the reference number of its parent subproblem. If the
    specified subproblem is the root of the tree, the routine returns zero.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_up_node tree 23;

    \;
  </verbatim>

  <paragraph|Determine subproblem level><label|determine-subproblem-level>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_node_level tree node

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree node: reference number of
    an active or inactive subproblem
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the level of the given subproblem in the
    branch-and-bound tree. (The root subproblem has level 0.)
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_node_level tree 23;

    \;
  </verbatim>

  <paragraph|Determine subproblem local bound><label|determine-subproblem-local-bound>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_node_bound tree node

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree node: reference number of
    an active or inactive subproblem
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the local bound for the given subproblem.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_node_bound tree 23;

    \;
  </verbatim>

  <paragraph|Find active subproblem with the best local
  bound><label|find-active-subproblem-with-the-best-local-bound>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_best_node tree

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the reference number of the active subproblem, whose
    local bound is best (i.e. smallest in case of minimization or largest in
    case of maximization). If the tree is empty, the routine returns zero.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_best_node tree;

    \;
  </verbatim>

  <paragraph|The cut pool routines><label|the-cut-pool-routines>

  <paragraph|Determine current size of the cut
  pool><label|determine-current-size-of-the-cut-pool>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_pool_size tree

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the current size of the cut pool, that is, the number
    of cutting plane constraints currently added to it.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_pool_size tree;

    \;
  </verbatim>

  <paragraph|Add constraint to the cut pool><label|add-constraint-to-the-cut-pool>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_add_row tree (name, klass, flags, row, rowtype, rhs)

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree

    name: symbolic name of the constraint

    klass: specifies the constraint class, which must be either zero or a
    number in the range from 101 to 200. The application may use this
    attribute to distinguish between cutting plane constraints of different
    classes.

    flags: currently is not used and must be zero

    row: list of pairs (colindex, coefficient)

    rowtype: one of the following:

    glp::lo: \<big-sum\>(aj.xj) \<geq\> RHS constraint glp::up:
    \<big-sum\>(aj.xj) <math|\<leq\>> RHS constraint rhs: right hand side of
    the constraint
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the ordinal number of the cutting plane constraint
    added, which is the new size of the cut pool.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_add_row tree ("new_constraint", 101, 0,

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ [(3, 15.0), (4, 6.7),
    (8, 1.25)], glp::up, 152.7);

    \;
  </verbatim>

  <paragraph|Remove constraint from the cut
  pool><label|remove-constraint-from-the-cut-pool>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_del_row tree rowindex

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree rowindex: index of row to
    be deleted from the cut pool
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    Note that deleting a constraint from the cut pool leads to changing
    ordinal numbers of other constraints remaining in the pool. New ordinal
    numbers of the remaining constraints are assigned under assumption that
    the original order of constraints is not changed.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_del_row tree 5;

    \;
  </verbatim>

  <paragraph|Remove all constraints from the cut
  pool><label|remove-all-constraints-from-the-cut-pool>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::ios_clear_pool tree

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    tree: pointer to the branch-and-cut search tree
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::ios_clear_pool tree;

    \;
  </verbatim>

  <subsubsection|Graph and network API routines><label|graph-and-network-api-routines>

  <paragraph|Basic graph routines><label|basic-graph-routines>

  <paragraph|Create the GLPK graph object><label|create-the-glpk-graph-object>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::create_graph v_size a_size

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    v_size: size of vertex data blocks, in bytes, 0 <math|\<leq\>> v size
    <math|\<leq\>> 256 a_size: size of arc data blocks, in bytes, 0
    <math|\<leq\>> a size <math|\<leq\>> 256.
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns a pointer to the graph created.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> let g = glp::create_graph 32 64;

    \<gtr\> g;

    #\<less\>pointer 0x9de7168\<gtr\>

    \;
  </verbatim>

  <paragraph|Set the graph name><label|set-the-graph-name>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::set_graph_name graph name

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object name: the graph name, an empty string
    erases the current name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::set_graph_name graph "MyGraph";

    ()

    \;
  </verbatim>

  <paragraph|Add vertices to a graph><label|add-vertices-to-a-graph>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::add_vertices graph count

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object count: number of vertices to add
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the ordinal number of the first new vertex added to
    the graph.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::add_vertices graph 5;

    18

    \;
  </verbatim>

  <paragraph|Add arc to a graph><label|add-arc-to-a-graph>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::add_arc graph i j

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object i: index of the tail vertex j: index
    of the head vertex
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::add_arc graph 7 12;

    ()

    \;
  </verbatim>

  <paragraph|Erase content of the GLPK graph
  object><label|erase-content-of-the-glpk-graph-object>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::erase_graph graph v_size a_size

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object v_size: size of vertex data blocks, in
    bytes, 0 <math|\<leq\>> v size <math|\<leq\>> 256 a_size: size of arc
    data blocks, in bytes, 0 <math|\<leq\>> a size <math|\<leq\>> 256.
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    The routine reinitialises the graph object. Its efect is equivalent to
    calling delete_graph followed by a call to create_graph.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::erase_graph graph 16 34;

    ()

    \;
  </verbatim>

  <paragraph|Delete the GLPK graph object><label|delete-the-glpk-graph-object>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::delete_graph graph

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    The routine destroys the graph object and invalidates the pointer. This
    is done automatically when the graph is not needed anymore, the routine
    need not be usually called.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::delete_graph graph

    ()

    \;
  </verbatim>

  <paragraph|Read graph in a plain text format><label|read-graph-in-a-plain-text-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::read_graph graph filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::read_graph graph "graph_data.txt";

    0

    \;
  </verbatim>

  <paragraph|Write graph in a plain text format><label|write-graph-in-a-plain-text-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::write_graph graph filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object filename: file name
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::write_graph graph "graph_data.txt";

    0

    \;
  </verbatim>

  <paragraph|Graph analysis routines><label|graph-analysis-routines>

  <paragraph|Find all weakly connected components of a
  graph><label|find-all-weakly-connected-components-of-a-graph>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::weak_comp graph v_num

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object v_num: offset of the field of type int
    in the vertex data block, to which the routine stores the number of a
    weakly connected component containing that vertex - if v_num \<less\> 0,
    no component numbers are stored
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The routine returns the total number of components found.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::weak_comp graph 16;

    3

    \;
  </verbatim>

  <paragraph|Find all strongly connected components of a
  graph><label|find-all-strongly-connected-components-of-a-graph>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::strong_comp graph v_num

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object v_num: offset of the field of type int
    in the vertex data block, to which the routine stores the number of a
    strongly connected component containing that vertex - if v_num \<less\>
    0, no component numbers are stored
  </quote-env>

  <with|font-series|bold|Returns>:

  The routine returns the total number of components found.

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::strong_comp graph 16;

    4

    \;
  </verbatim>

  <paragraph|Minimum cost flow problem><label|minimum-cost-flow-problem>

  <paragraph|Read minimum cost flow problem data in DIMACS
  format><label|read-minimum-cost-flow-problem-data-in-dimacs-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::read_mincost graph v_rhs a_low a_cap a_cost filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object v_rhs: offset of the field of type
    double in the vertex data block, to which the routine stores bi, the
    supply/demand value - if v_rhs \<less\> 0, the value is not stored a_low:
    offset of the field of type double in the arc data block, to which the
    routine stores lij, the lower bound to the arc flow - if a_low \<less\>
    0, the lower bound is not stored a_cap: offset of the field of type
    double in the arc data block, to which the routine stores uij, the upper
    bound to the arc flow (the arc capacity) - if a_cap \<less\> 0, the upper
    bound is not stored a_cost: offset of the field of type double in the arc
    data block, to which the routine stores cij, the per-unit cost of the arc
    flow - if a_cost \<less\> 0, the cost is not stored fname: the name of a
    text file to be read in - if the file name name ends with the suffix
    `.gz', the file is assumed to be compressed, in which case the routine
    decompresses it ``on the fly''
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::read_mincost graph 0 8 16 24 "graphdata.txt";

    0

    \;
  </verbatim>

  <paragraph|Write minimum cost flow problem data in DIMACS
  format><label|write-minimum-cost-flow-problem-data-in-dimacs-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::write_mincost graph v_rhs a_low a_cap a_cost fname

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object v_rhs: offset of the field of type
    double in the vertex data block, to which the routine stores bi, the
    supply/demand value - if v_rhs \<less\> 0, the value is not stored a_low:
    offset of the field of type double in the arc data block, to which the
    routine stores lij, the lower bound to the arc flow - if a_low \<less\>
    0, the lower bound is not stored a_cap: offset of the field of type
    double in the arc data block, to which the routine stores uij, the upper
    bound to the arc flow (the arc capacity) - if a_cap \<less\> 0, the upper
    bound is not stored a_cost: offset of the field of type double in the arc
    data block, to which the routine stores cij, the per-unit cost of the arc
    flow - if a_cost \<less\> 0, the cost is not stored fname: the name of a
    text file to be written out - if the file name name ends with the suffix
    `.gz', the file is assumed to be compressed, in which case the routine
    compresses it ``on the fly''
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if reading went OK; non-zero in case of an
    error
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::write_mincost graph 0 8 16 24 "graphdata.txt";

    0

    \;
  </verbatim>

  <paragraph|Convert minimum cost flow problem to
  LP><label|convert-minimum-cost-flow-problem-to-lp>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mincost_lp lp graph names v_rhs a_low a_cap a_cost

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    lp: pointer to the LP problem object

    graph: pointer to the graph object

    names: one of the following:

    glp::on: assign symbolic names of the graph object components to symbolic
    names of the LP problem object components glp::off: no symbolic names are
    assigned v_rhs: offset of the field of type double in the vertex data
    block, to which the routine stores bi, the supply/demand value - if v_rhs
    \<less\> 0, it is assumed bi = 0 for all nodes

    a_low: offset of the field of type double in the arc data block, to which
    the routine stores lij, the lower bound to the arc flow - if a_low
    \<less\> 0, it is assumed lij = 0 for all arcs

    a_cap: offset of the field of type double in the arc data block, to which
    the routine stores uij, the upper bound to the arc flow (the arc
    capacity) - if a_cap \<less\> 0,it is assumed uij = 1 for all arcs, value
    of DBL_MAX means an uncapacitated arc

    a_cost: offset of the field of type double in the arc data block, to
    which the routine stores cij, the per-unit cost of the arc flow - if
    a_cost \<less\> 0, it is assumed cij = 0 for all arcs
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    ()
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mincost_lp lp graph glp::on 0 8 16 24;

    ()

    \;
  </verbatim>

  <paragraph|Solve minimum cost flow problem with out-of-kilter
  algorithm><label|solve-minimum-cost-flow-problem-with-out-of-kilter-algorithm>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mincost_okalg graph v_rhs a_low a_cap a_cost a_x v_pi

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object v_rhs: offset of the field of type
    double in the vertex data block, to which the routine stores bi, the
    supply/demand value - if v_rhs \<less\> 0, it is assumed bi = 0 for all
    nodes a_low: offset of the field of type double in the arc data block, to
    which the routine stores lij, the lower bound to the arc flow - if a_low
    \<less\> 0, it is assumed lij = 0 for all arcs a_cap: offset of the field
    of type double in the arc data block, to which the routine stores uij,
    the upper bound to the arc flow (the arc capacity) - if a_cap \<less\>
    0,it is assumed uij = 1 for all arcs, value of DBL_MAX means an
    uncapacitated arc a_cost: offset of the field of type double in the arc
    data block, to which the routine stores cij, the per-unit cost of the arc
    flow - if a_cost \<less\> 0, it is assumed cij = 0 for all arcs a_x:
    offset of the field of type double in the arc data block, to which the
    routine stores xij, the arc flow found - if a_x \<less\> 0, the arc flow
    value is not stored v_pi: specifies an offset of the field of type double
    in the vertex data block, to which the routine stores pi, the node
    potential, which is the Lagrange multiplier for the corresponding flow
    conservation equality constraint
  </quote-env>

  <with|font-series|bold|Remark>:

  <\quote-env>
    Note that all solution components (the objective value, arc flows, and
    node potentials) computed by the routine are always integer-valued.
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    The function returns a tuple in the form <with|font-series|bold|(code,
    obj)>, where <with|font-series|bold|code> is one of the following

    glp::ok: optimal solution found glp::enopfs: no (primal) feasible
    solution exists glp::edata: unable to start the search, because some
    problem data are either not integer-valued or out of range; this code is
    also returned if the total supply, which is the sum of bi over all source
    nodes (nodes with bi \<gtr\> 0), exceeds INT_MAX glp::erange: the search
    was prematurely terminated because of integer overflow glp::efail: an
    error has been detected in the program logic - if this code is returned
    for your problem instance, please report to
    \<less\><hlink|bug-glpk@gnu.org|mailto:bug-glpk@gnu.org>\<gtr\> and
    <with|font-series|bold|obj> is value of the objective function.
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mincost_okalg graph 0 8 16 24 32 40;

    (glp::ok, 15)

    \;
  </verbatim>

  <paragraph|Klingman's network problem generator><label|klingman-s-network-problem-generator>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::netgen graph v_rhs a_cap a_cost parameters

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object

    v_rhs: offset of the field of type double in the vertex data block, to
    which the routine stores bi, the supply/demand value - if v_rhs \<less\>
    0, it is assumed bi = 0 for all nodes

    a_cap: offset of the field of type double in the arc data block, to which
    the routine stores uij, the upper bound to the arc flow (the arc
    capacity) - if a_cap \<less\> 0,it is assumed uij = 1 for all arcs, value
    of DBL_MAX means an uncapacitated arc

    a_cost: offset of the field of type double in the arc data block, to
    which the routine stores cij, the per-unit cost of the arc flow - if
    a_cost \<less\> 0, it is assumed cij = 0 for all arcs

    parameters: tuple of exactly 15 integer numbers with the following
    meaning:

    parm[1]: iseed 8-digit positive random number seed parm[2]: nprob 8-digit
    problem id number parm[3]: nodes total number of nodes parm[4]: nsorc
    total number of source nodes (including transshipment nodes) parm[5]:
    nsink total number of sink nodes (including transshipment nodes) parm[6]:
    iarcs number of arc parm[7]: mincst minimum cost for arcs parm[8]: maxcst
    maximum cost for arcs parm[9]: itsup total supply parm[10]: ntsorc number
    of transshipment source nodes parm[11]: ntsink number of transshipment
    sink nodes parm[12]: iphic percentage of skeleton arcs to be given the
    maximum cost parm[13]: ipcap percentage of arcs to be capacitated
    parm[14]: mincap minimum upper bound for capacitated arcs parm[15]:
    maxcap maximum upper bound for capacitated arcs
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if the instance was successfully generated,
    nonzero otherwise
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::netgen graph 0 8 16 (12345678, 87654321, 20, 12, 8,

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 25, 5, 20, 300,
    6, 5, 15, 100, 1, 30);

    0

    \;
  </verbatim>

  <paragraph|Grid-like network problem generator><label|grid-like-network-problem-generator>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::gridgen graph v_rhs a_cap a_cost parameters

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object

    v_rhs: offset of the field of type double in the vertex data block, to
    which the routine stores bi, the supply/demand value - if v_rhs \<less\>
    0, it is assumed bi = 0 for all nodes

    a_cap: offset of the field of type double in the arc data block, to which
    the routine stores uij, the upper bound to the arc flow (the arc
    capacity) - if a_cap \<less\> 0,it is assumed uij = 1 for all arcs, value
    of DBL_MAX means an uncapacitated arc

    a_cost: offset of the field of type double in the arc data block, to
    which the routine stores cij, the per-unit cost of the arc flow - if
    a_cost \<less\> 0, it is assumed cij = 0 for all arcs

    parameters: tuple of exactly 14 integer numbers with the following
    meaning:

    parm[1]: two-ways arcs indicator:

    <with|font-series|bold|1:> if links in both direction should be generated

    <with|font-series|bold|0:> otherwise parm[2]: random number seed (a
    positive integer)

    parm[3]: number of nodes (the number of nodes generated might be slightly
    different to make the network a grid)

    parm[4]: grid width

    parm[5]: number of sources

    parm[6]: number of sinks

    parm[7]: average degree

    parm[8]: total flow

    parm[9]: distribution of arc costs:

    <with|font-series|bold|1:> uniform

    <with|font-series|bold|2:> exponential parm[10]: lower bound for arc cost
    (uniform), 100 lambda\K (exponential)

    parm[11]: upper bound for arc cost (uniform), not used (exponential)

    parm[12]: distribution of arc capacities:

    <with|font-series|bold|1:> uniform

    <with|font-series|bold|2:> exponential parm[13]: lower bound for arc
    capacity (uniform), 100 lambda (exponential)

    parm[14]: upper bound for arc capacity (uniform), not used (exponential)
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <with|font-series|bold|0> if the instance was successfully generated,
    nonzero otherwise
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::gridgen graph 0 8 16 (1, 123, 20, 4, 7, 5, 3, 300, 1, 1, 5,
    1, 5, 30);

    0

    \;
  </verbatim>

  <paragraph|Maximum flow problem><label|maximum-flow-problem>

  <paragraph|Read maximum cost flow problem data in DIMACS
  format><label|read-maximum-cost-flow-problem-data-in-dimacs-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::read_maxflow graph a_cap filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object
  </quote-env>

  <with|font-series|bold|Returns>:

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\>

    \;
  </verbatim>

  <paragraph|Write maximum cost flow problem data in DIMACS
  format><label|write-maximum-cost-flow-problem-data-in-dimacs-format>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::write_maxflow graph s t a_cap filename

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object
  </quote-env>

  <with|font-series|bold|Returns>:

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\>

    \;
  </verbatim>

  <paragraph|Convert maximum flow problem to
  LP><label|convert-maximum-flow-problem-to-lp>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::maxflow_lp lp graph names s t a_cap

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object
  </quote-env>

  <with|font-series|bold|Returns>:

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\>

    \;
  </verbatim>

  <paragraph|Solve maximum flow problem with Ford-Fulkerson
  algorithm><label|solve-maximum-flow-problem-with-ford-fulkerson-algorithm>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::maxflow_ffalg graph s t a_cap a_x v_cut

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object
  </quote-env>

  <with|font-series|bold|Returns>:

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\>

    \;
  </verbatim>

  <paragraph|Goldfarb's maximum flow problem
  generator><label|goldfarb-s-maximum-flow-problem-generator>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::rmfgen graph a_cap parameters

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    graph: pointer to the graph object
  </quote-env>

  <with|font-series|bold|Returns>:

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\>

    \;
  </verbatim>

  <subsubsection|Miscellaneous routines><label|miscellaneous-routines>

  <paragraph|Library environment routines><label|library-environment-routines>

  <paragraph|Determine library version><label|determine-library-version>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    `glp::version

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    none
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    GLPK library version
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::version;

    "4.38"

    \;
  </verbatim>

  <paragraph|Enable/disable terminal output><label|enable-disable-terminal-output>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::term_out switch

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    switch: one of the following:

    glp::on: enable terminal output from GLPK routines glp::off: disable
    terminal output from GLPK routines
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::term_out glp:off;

    ()

    \;
  </verbatim>

  <paragraph|Enable/disable the terminal hook
  routine><label|enable-disable-the-terminal-hook-routine>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::term_hook switch info

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    switch: one of the following:

    glp::on: use the terminal callback function glp::off: don't use the
    terminal callback function info: pointer to a memory block which can be
    used for passing additional information to the terminal callback function
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::term_hook glp::on NULL;

    ()

    \;
  </verbatim>

  <paragraph|Get memory usage information><label|get-memory-usage-information>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mem_usage

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    none
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    tuple consisting of four numbers:

    <\quote-env>
      <\itemize>
        <item><verbatim|count> (int) - the number of currently allocated
        memory blocks

        <item><verbatim|cpeak> (int) - the peak value of <verbatim|count>
        reached since the initialization of the GLPK library environment

        <item><verbatim|total> (bigint) - the total amount, in bytes, of
        currently allocated memory blocks

        <item><verbatim|tpeak> (bigint) - the peak value of <verbatim|total>
        reached since the initialization of the GLPK library envirionment
      </itemize>
    </quote-env>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mem_usage;

    7,84,10172L,45304L

    \;
  </verbatim>

  <paragraph|Set memory usage limit><label|set-memory-usage-limit>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::mem_limit limit

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    limit: memory limit in megabytes
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp::mem_limit 200;

    ()

    \;
  </verbatim>

  <paragraph|Free GLPK library environment><label|free-glpk-library-environment>

  <with|font-series|bold|Synopsis>:

  <\verbatim>
    \;

    glp::free_env

    \;
  </verbatim>

  <with|font-series|bold|Parameters>:

  <\quote-env>
    none
  </quote-env>

  <with|font-series|bold|Returns>:

  <\quote-env>
    <verbatim|()>
  </quote-env>

  <with|font-series|bold|Example>:

  <\verbatim>
    \;

    \<gtr\> glp_free_env;

    ()

    \;
  </verbatim>

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-glpk-toc>

  <\itemize>
    <item><hlink|Pure-GLPK - GLPK interface for the Pure programming
    language|#>

    <\itemize>
      <item><hlink|Installation|#installation>

      <item><hlink|Error Handling|#error-handling>

      <item><hlink|Further Information and
      Examples|#further-information-and-examples>

      <item><hlink|Interface description|#interface-description>

      <item><hlink|Descriptions of interface
      functions|#descriptions-of-interface-functions>

      <\itemize>
        <item><hlink|Basic API routines|#basic-api-routines>

        <\itemize>
          <item><hlink|Problem creating and modifying
          routines|#problem-creating-and-modifying-routines>

          <\itemize>
            <item><hlink|Create the GLPK problem
            object|#create-the-glpk-problem-object>

            <item><hlink|Set the problem name|#set-the-problem-name>

            <item><hlink|Set objective name|#set-objective-name>

            <item><hlink|Set the objective
            direction|#set-the-objective-direction>

            <item><hlink|Add new rows to the
            problem|#add-new-rows-to-the-problem>

            <item><hlink|Add new columns to the
            problem|#add-new-columns-to-the-problem>

            <item><hlink|Set the row name|#set-the-row-name>

            <item><hlink|Set the column name|#set-the-column-name>

            <item><hlink|Set (change) row bounds|#set-change-row-bounds>

            <item><hlink|Set (change) column
            bounds|#set-change-column-bounds>

            <item><hlink|Set (change) objective coefficient or constant
            term|#set-change-objective-coefficient-or-constant-term>

            <item><hlink|Load or replace matrix
            row|#load-or-replace-matrix-row>

            <item><hlink|Load or replace matrix
            column|#load-or-replace-matrix-column>

            <item><hlink|Load or replace the whole problem
            matrix|#load-or-replace-the-whole-problem-matrix>

            <item><hlink|Check for duplicate elements in sparse
            matrix|#check-for-duplicate-elements-in-sparse-matrix>

            <item><hlink|Sort elements of the constraint
            matrix|#sort-elements-of-the-constraint-matrix>

            <item><hlink|Delete rows from the
            matrix|#delete-rows-from-the-matrix>

            <item><hlink|Delete columns from the
            matrix|#delete-columns-from-the-matrix>

            <item><hlink|Copy the whole content of the GLPK problem object to
            another one|#copy-the-whole-content-of-the-glpk-problem-object-to-another-one>

            <item><hlink|Erase all data from the GLPK problem
            object|#erase-all-data-from-the-glpk-problem-object>

            <item><hlink|Delete the GLPK problem
            object|#delete-the-glpk-problem-object>
          </itemize>

          <item><hlink|Problem retrieving
          routines|#problem-retrieving-routines>

          <\itemize>
            <item><hlink|Get the problem name|#get-the-problem-name>

            <item><hlink|Get the objective name|#get-the-objective-name>

            <item><hlink|Get the objective
            direction|#get-the-objective-direction>

            <item><hlink|Get number of rows|#get-number-of-rows>

            <item><hlink|Get number of columns|#get-number-of-columns>

            <item><hlink|Get name of a row|#get-name-of-a-row>

            <item><hlink|Get name of a column|#get-name-of-a-column>

            <item><hlink|Get row type|#get-row-type>

            <item><hlink|Get row lower bound|#get-row-lower-bound>

            <item><hlink|Get row upper bound|#get-row-upper-bound>

            <item><hlink|Get column type|#get-column-type>

            <item><hlink|Get column lower bound|#get-column-lower-bound>

            <item><hlink|Get column upper bound|#get-column-upper-bound>

            <item><hlink|Get objective coefficient|#get-objective-coefficient>

            <item><hlink|Get number of nonzero
            coefficients|#get-number-of-nonzero-coefficients>

            <item><hlink|Retrive a row from the problem
            matrix|#retrive-a-row-from-the-problem-matrix>

            <item><hlink|Retrive a column from the problem
            matrix|#retrive-a-column-from-the-problem-matrix>
          </itemize>

          <item><hlink|Row and column searching
          routines|#row-and-column-searching-routines>

          <\itemize>
            <item><hlink|Create index for searching rows and columns by their
            names|#create-index-for-searching-rows-and-columns-by-their-names>

            <item><hlink|Find a row number by
            name|#find-a-row-number-by-name>

            <item><hlink|Find a column number by
            name|#find-a-column-number-by-name>

            <item><hlink|Delete index for searching rows and columns by their
            names|#delete-index-for-searching-rows-and-columns-by-their-names>
          </itemize>

          <item><hlink|Problem scaling routines|#problem-scaling-routines>

          <\itemize>
            <item><hlink|Set the row scale factor|#set-the-row-scale-factor>

            <item><hlink|Set the column scale
            factor|#set-the-column-scale-factor>

            <item><hlink|Retrieve the row scale
            factor|#retrieve-the-row-scale-factor>

            <item><hlink|Retrieve the column scale
            factor|#retrieve-the-column-scale-factor>

            <item><hlink|Scale the problem data according to supplied
            flags|#scale-the-problem-data-according-to-supplied-flags>

            <item><hlink|Unscale the problem data|#unscale-the-problem-data>
          </itemize>

          <item><hlink|LP basis constructing
          routines|#lp-basis-constructing-routines>

          <\itemize>
            <item><hlink|Set the row status|#set-the-row-status>

            <item><hlink|Set the column status|#set-the-column-status>

            <item><hlink|Construct standard problem
            basis|#construct-standard-problem-basis>

            <item><hlink|Construct advanced problem
            basis|#construct-advanced-problem-basis>

            <item><hlink|Construct Bixby's problem
            basis|#construct-bixby-s-problem-basis>
          </itemize>

          <item><hlink|Simplex method routines|#simplex-method-routines>

          <\itemize>
            <item><hlink|Solve the LP problem using simplex
            method|#solve-the-lp-problem-using-simplex-method>

            <item><hlink|Solve the LP problem using simplex method in exact
            arithmetics|#solve-the-lp-problem-using-simplex-method-in-exact-arithmetics>

            <item><hlink|Retrieve generic status of basic
            solution|#retrieve-generic-status-of-basic-solution>

            <item><hlink|Retrieve generic status of primal
            solution|#retrieve-generic-status-of-primal-solution>

            <item><hlink|Retrieve generic status of dual
            solution|#retrieve-generic-status-of-dual-solution>

            <item><hlink|Retrieve value of the objective
            function|#retrieve-value-of-the-objective-function>

            <item><hlink|Retrieve generic status of a row
            variable|#retrieve-generic-status-of-a-row-variable>

            <item><hlink|Retrieve row primal
            value|#retrieve-row-primal-value>

            <item><hlink|Retrieve row dual value|#retrieve-row-dual-value>

            <item><hlink|Retrieve generic status of a column
            variable|#retrieve-generic-status-of-a-column-variable>

            <item><hlink|Retrieve column primal
            value|#retrieve-column-primal-value>

            <item><hlink|Retrieve column dual
            value|#retrieve-column-dual-value>

            <item><hlink|Determine variable causing
            unboundedness|#determine-variable-causing-unboundedness>
          </itemize>

          <item><hlink|Interior-point method
          routines|#interior-point-method-routines>

          <\itemize>
            <item><hlink|Solve the LP problem using interior-point
            method|#solve-the-lp-problem-using-interior-point-method>

            <item><hlink|Retrieve status of interior-point
            solution|#retrieve-status-of-interior-point-solution>

            <item><hlink|Retrieve the objective function value of
            interior-point solution|#retrieve-the-objective-function-value-of-interior-point-solution>

            <item><hlink|Retrieve row primal value of interior-point
            solution|#retrieve-row-primal-value-of-interior-point-solution>

            <item><hlink|Retrieve row dual value of interior-point
            solution|#retrieve-row-dual-value-of-interior-point-solution>

            <item><hlink|Retrieve column primal value of interior-point
            solution|#retrieve-column-primal-value-of-interior-point-solution>

            <item><hlink|Retrieve column dual value of interior-point
            solution|#retrieve-column-dual-value-of-interior-point-solution>
          </itemize>

          <item><hlink|Mixed integer programming
          routines|#mixed-integer-programming-routines>

          <\itemize>
            <item><hlink|Set column kind|#set-column-kind>

            <item><hlink|Retrieve column kind|#retrieve-column-kind>

            <item><hlink|Retrieve number of integer
            columns|#retrieve-number-of-integer-columns>

            <item><hlink|Retrieve number of binary
            columns|#retrieve-number-of-binary-columns>

            <item><hlink|Solve the MIP problem using branch-and-cut
            method|#solve-the-mip-problem-using-branch-and-cut-method>

            <item><hlink|Retrieve status of mip
            solution|#retrieve-status-of-mip-solution>

            <item><hlink|Retrieve the objective function value of mip
            solution|#retrieve-the-objective-function-value-of-mip-solution>

            <item><hlink|Retrieve row value of mip
            solution|#retrieve-row-value-of-mip-solution>

            <item><hlink|Retrieve column value of mip
            solution|#retrieve-column-value-of-mip-solution>
          </itemize>

          <item><hlink|Additional routines|#additional-routines>

          <\itemize>
            <item><hlink|Check Karush-Kuhn-Tucker
            conditions|#check-karush-kuhn-tucker-conditions>
          </itemize>
        </itemize>

        <item><hlink|Utility API routines|#utility-api-routines>

        <\itemize>
          <item><hlink|Problem data reading/writing
          routines|#problem-data-reading-writing-routines>

          <\itemize>
            <item><hlink|Read LP problem data from a MPS
            file|#read-lp-problem-data-from-a-mps-file>

            <item><hlink|Write LP problem data into a MPS
            file|#write-lp-problem-data-into-a-mps-file>

            <item><hlink|Read LP problem data from a CPLEX
            file|#read-lp-problem-data-from-a-cplex-file>

            <item><hlink|Write LP problem data into a CPLEX
            file|#write-lp-problem-data-into-a-cplex-file>

            <item><hlink|Read LP problem data in GLPK
            format|#read-lp-problem-data-in-glpk-format>

            <item><hlink|Write LP problem data in GLPK
            format|#write-lp-problem-data-in-glpk-format>
          </itemize>

          <item><hlink|Routines for MathProg
          models|#routines-for-mathprog-models>

          <\itemize>
            <item><hlink|Create the MathProg translator
            object|#create-the-mathprog-translator-object>

            <item><hlink|Read and translate model
            section|#read-and-translate-model-section>

            <item><hlink|Read and translate data
            section|#read-and-translate-data-section>

            <item><hlink|Generate the model|#generate-the-model>

            <item><hlink|Build problem instance from the
            model|#build-problem-instance-from-the-model>

            <item><hlink|Postsolve the model|#postsolve-the-model>

            <item><hlink|Delete the MathProg translator
            object|#delete-the-mathprog-translator-object>
          </itemize>

          <item><hlink|Problem solution reading/writing
          routines|#problem-solution-reading-writing-routines>

          <\itemize>
            <item><hlink|Write basic solution in printable
            format|#write-basic-solution-in-printable-format>

            <item><hlink|Read basic solution from a text
            file|#read-basic-solution-from-a-text-file>

            <item><hlink|Write basic solution into a text
            file|#write-basic-solution-into-a-text-file>

            <item><hlink|Print sensitivity analysis
            report|#print-sensitivity-analysis-report>

            <item><hlink|Write interior-point solution in printable
            format|#write-interior-point-solution-in-printable-format>

            <item><hlink|Read interior-point solution from a text
            file|#read-interior-point-solution-from-a-text-file>

            <item><hlink|Write interior-point solution into a text
            file|#write-interior-point-solution-into-a-text-file>

            <item><hlink|Write MIP solution in printable
            format|#write-mip-solution-in-printable-format>

            <item><hlink|Read MIP solution from a text
            file|#read-mip-solution-from-a-text-file>

            <item><hlink|Write MIP solution into a text
            file|#write-mip-solution-into-a-text-file>
          </itemize>
        </itemize>

        <item><hlink|Advanced API routines|#advanced-api-routines>

        <\itemize>
          <item><hlink|LP basis routines|#lp-basis-routines>

          <\itemize>
            <item><hlink|Check whether basis factorization
            exists|#check-whether-basis-factorization-exists>

            <item><hlink|Compute the basis
            factorization|#compute-the-basis-factorization>

            <item><hlink|Check whether basis factorization has been
            updated|#check-whether-basis-factorization-has-been-updated>

            <item><hlink|Get basis factorization
            parameters|#get-basis-factorization-parameters>

            <item><hlink|Change basis factorization
            parameters|#change-basis-factorization-parameters>

            <item><hlink|Retrieve the basis header
            information|#retrieve-the-basis-header-information>

            <item><hlink|Retrieve row index in the basis
            header|#retrieve-row-index-in-the-basis-header>

            <item><hlink|Retrieve column index in the basis
            header|#retrieve-column-index-in-the-basis-header>

            <item><hlink|Perform forward transformation|#perform-forward-transformation>

            <item><hlink|Perform backward
            transformation|#perform-backward-transformation>

            <item><hlink|Warm up LP basis|#warm-up-lp-basis>
          </itemize>

          <item><hlink|Simplex tableau routines|#simplex-tableau-routines>

          <\itemize>
            <item><hlink|Compute row of the
            tableau|#compute-row-of-the-tableau>

            <item><hlink|Compute column of the
            tableau|#compute-column-of-the-tableau>

            <item><hlink|Transform explicitly specified
            row|#transform-explicitly-specified-row>

            <item><hlink|Transform explicitly specified
            column|#transform-explicitly-specified-column>

            <item><hlink|Perform primal ratio
            test|#perform-primal-ratio-test>

            <item><hlink|Perform dual ratio test|#perform-dual-ratio-test>

            <item><hlink|Analyze active bound of non-basic
            variable|#analyze-active-bound-of-non-basic-variable>

            <item><hlink|Analyze objective coefficient at basic
            variable|#analyze-objective-coefficient-at-basic-variable>
          </itemize>
        </itemize>

        <item><hlink|Branch-and-cut API routines|#branch-and-cut-api-routines>

        <\itemize>
          <item><hlink|Basic routines|#basic-routines>

          <\itemize>
            <item><hlink|Determine reason for calling the callback
            routine|#determine-reason-for-calling-the-callback-routine>

            <item><hlink|Access the problem
            object|#access-the-problem-object>

            <item><hlink|Determine additional row
            attributes|#determine-additional-row-attributes>

            <item><hlink|Compute relative MIP gap|#compute-relative-mip-gap>

            <item><hlink|Access application-specific
            data|#access-application-specific-data>

            <item><hlink|Select subproblem to continue the
            search|#select-subproblem-to-continue-the-search>

            <item><hlink|Provide solution found by
            heuristic|#provide-solution-found-by-heuristic>

            <item><hlink|Check whether can branch upon specified
            variable|#check-whether-can-branch-upon-specified-variable>

            <item><hlink|Choose variable to branch
            upon|#choose-variable-to-branch-upon>

            <item><hlink|Terminate the solution
            process|#terminate-the-solution-process>
          </itemize>

          <item><hlink|The search tree exploring
          routines|#the-search-tree-exploring-routines>

          <\itemize>
            <item><hlink|Determine the search tree
            size|#determine-the-search-tree-size>

            <item><hlink|Determine current active
            subproblem|#determine-current-active-subproblem>

            <item><hlink|Determine next active
            subproblem|#determine-next-active-subproblem>

            <item><hlink|Determine previous active
            subproblem|#determine-previous-active-subproblem>

            <item><hlink|Determine parent active
            subproblem|#determine-parent-active-subproblem>

            <item><hlink|Determine subproblem
            level|#determine-subproblem-level>

            <item><hlink|Determine subproblem local
            bound|#determine-subproblem-local-bound>

            <item><hlink|Find active subproblem with the best local
            bound|#find-active-subproblem-with-the-best-local-bound>
          </itemize>

          <item><hlink|The cut pool routines|#the-cut-pool-routines>

          <\itemize>
            <item><hlink|Determine current size of the cut
            pool|#determine-current-size-of-the-cut-pool>

            <item><hlink|Add constraint to the cut
            pool|#add-constraint-to-the-cut-pool>

            <item><hlink|Remove constraint from the cut
            pool|#remove-constraint-from-the-cut-pool>

            <item><hlink|Remove all constraints from the cut
            pool|#remove-all-constraints-from-the-cut-pool>
          </itemize>
        </itemize>

        <item><hlink|Graph and network API
        routines|#graph-and-network-api-routines>

        <\itemize>
          <item><hlink|Basic graph routines|#basic-graph-routines>

          <\itemize>
            <item><hlink|Create the GLPK graph
            object|#create-the-glpk-graph-object>

            <item><hlink|Set the graph name|#set-the-graph-name>

            <item><hlink|Add vertices to a graph|#add-vertices-to-a-graph>

            <item><hlink|Add arc to a graph|#add-arc-to-a-graph>

            <item><hlink|Erase content of the GLPK graph
            object|#erase-content-of-the-glpk-graph-object>

            <item><hlink|Delete the GLPK graph
            object|#delete-the-glpk-graph-object>

            <item><hlink|Read graph in a plain text
            format|#read-graph-in-a-plain-text-format>

            <item><hlink|Write graph in a plain text
            format|#write-graph-in-a-plain-text-format>
          </itemize>

          <item><hlink|Graph analysis routines|#graph-analysis-routines>

          <\itemize>
            <item><hlink|Find all weakly connected components of a
            graph|#find-all-weakly-connected-components-of-a-graph>

            <item><hlink|Find all strongly connected components of a
            graph|#find-all-strongly-connected-components-of-a-graph>
          </itemize>

          <item><hlink|Minimum cost flow problem|#minimum-cost-flow-problem>

          <\itemize>
            <item><hlink|Read minimum cost flow problem data in DIMACS
            format|#read-minimum-cost-flow-problem-data-in-dimacs-format>

            <item><hlink|Write minimum cost flow problem data in DIMACS
            format|#write-minimum-cost-flow-problem-data-in-dimacs-format>

            <item><hlink|Convert minimum cost flow problem to
            LP|#convert-minimum-cost-flow-problem-to-lp>

            <item><hlink|Solve minimum cost flow problem with out-of-kilter
            algorithm|#solve-minimum-cost-flow-problem-with-out-of-kilter-algorithm>

            <item><hlink|Klingman's network problem
            generator|#klingman-s-network-problem-generator>

            <item><hlink|Grid-like network problem
            generator|#grid-like-network-problem-generator>
          </itemize>

          <item><hlink|Maximum flow problem|#maximum-flow-problem>

          <\itemize>
            <item><hlink|Read maximum cost flow problem data in DIMACS
            format|#read-maximum-cost-flow-problem-data-in-dimacs-format>

            <item><hlink|Write maximum cost flow problem data in DIMACS
            format|#write-maximum-cost-flow-problem-data-in-dimacs-format>

            <item><hlink|Convert maximum flow problem to
            LP|#convert-maximum-flow-problem-to-lp>

            <item><hlink|Solve maximum flow problem with Ford-Fulkerson
            algorithm|#solve-maximum-flow-problem-with-ford-fulkerson-algorithm>

            <item><hlink|Goldfarb's maximum flow problem
            generator|#goldfarb-s-maximum-flow-problem-generator>
          </itemize>
        </itemize>

        <item><hlink|Miscellaneous routines|#miscellaneous-routines>

        <\itemize>
          <item><hlink|Library environment
          routines|#library-environment-routines>

          <\itemize>
            <item><hlink|Determine library
            version|#determine-library-version>

            <item><hlink|Enable/disable terminal
            output|#enable-disable-terminal-output>

            <item><hlink|Enable/disable the terminal hook
            routine|#enable-disable-the-terminal-hook-routine>

            <item><hlink|Get memory usage
            information|#get-memory-usage-information>

            <item><hlink|Set memory usage limit|#set-memory-usage-limit>

            <item><hlink|Free GLPK library
            environment|#free-glpk-library-environment>
          </itemize>
        </itemize>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Gnumeric/Pure: A Pure Plugin for Gnumeric|gnumeric-pure.tm>

  Next topic

  <hlink|Gnuplot bindings|pure-gplot.tm>

  <hlink|toc|#pure-glpk-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gplot.tm> \|
  <hlink|previous|gnumeric-pure.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2016, Albert Gräf et al. Last updated on Dec
  20, 2016. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
