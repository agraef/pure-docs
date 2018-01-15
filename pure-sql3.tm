<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-sql3-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-xml.tm> \|
  <hlink|previous|pure-odbc.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Pure-Sql3><label|module-sql3>

  Version 0.5, January 13, 2018

  Peter Summerland \<less\><hlink|p.summerland@gmail.com|mailto:p.summerland@gmail.com>\<gtr\>

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  This document describes <with|font-series|bold|Sql3>, a
  <hlink|SQLite|http://www.sqlite.org> module for the
  <hlink|Pure|http://purelang.bitbucket.org> programming language.

  <subsection|Introduction><label|introduction>

  SQLite is a software library that implements an easy to use,
  self-contained, serverless, zero-configuration, transactional SQL database
  engine. SQLite is not intended to be an enterprise database engine like
  Oracle or PostgreSQL. Instead, SQLite strives to be small, fast, reliable,
  and above all simple. See <hlink|Appropriate Uses For
  SQLite|http://www.sqlite.org/whentouse.html>.

  Sql3 is a wrapper around SQLite's C interface that provides Pure
  programmers access to almost all of SQLite's features, including many that
  are not available through Pure's generic ODBC interface.

  <subsubsection|Simple Example><label|simple-example>

  Here is a simple example that opens a database file \Preadme.db\Q (creating
  it if it does not exist), adds a table \PRM\Q, populates \PRM\Q and
  executes a query.

  <\verbatim>
    \;

    pure-sql3$\<gtr\> pure -q

    \<gtr\>

    \;

    \<gtr\> using sql3; using namespace sql3;

    \;

    \<gtr\> let dbp = open "readme.db";

    \;

    \<gtr\> exec dbp "create table if not exists RM (name text, age
    integer)";

    \;

    \<gtr\> exec dbp "delete from RM";

    \;

    \<gtr\> let sp1 = prep dbp "ci" "insert into RM values (?,?)";

    \;

    \<gtr\> exec sp1 ("Sam",20);

    \;

    \<gtr\> exec sp1 ("Fred",22);

    \;

    \<gtr\> let sp2 = prep dbp "ci:i" "select * from RM where age \<gtr\> ?";

    \;

    \<gtr\> exec sp2 18;

    [["Sam",20],["Fred",22]]

    \;
  </verbatim>

  The Sql3 functions, <hlink|<with|font-family|tt|open>|#sql3::open>,
  <hlink|<with|font-family|tt|prep>|#sql3::prep> and
  <hlink|<with|font-family|tt|exec>|#sql3::exec> encapsulate the core
  functionality of SQLite, and in many cases are all you need to use SQLite
  effectively.

  <subsubsection|More Examples><label|more-examples>

  The examples subdirectory of pure-Sql3 contains several files that further
  illustrate basic usage as well as some of Sql3's more sophisticated
  features. These include readme.pure, a short file that contains the
  examples included herein. If you are using emacs pure-mode you can load
  readme.pure into a buffer and execute the examples line by line (pressing
  C-c C-c) (as well as experiment as you go).

  <subsubsection|SQLite Documentation><label|sqlite-documentation>

  SQLite's home page provides excellent documentation regarding its SQL
  dialect as well as its C interface. Comments in this document regarding
  SQLite are not meant to be a substitute for the actual documentation and
  should not be relied upon, other than as general observations which may or
  may not be accurate. The best way to use Sql3 is to get familiar with
  SQLite and its C interface and go directly to the <hlink|SQLite Site
  Map|http://www.sqlite.org/sitemap.html> for authoritative answers to any
  specific questions that you might have.

  In the rest of this document, it is assumed the reader has some familiarity
  with SQLite and has read <hlink|An Introduction To The SQLite C/C++
  Interface|http://www.sqlite.org/cintro.html>.

  <subsubsection|Sqlite3 - The SQLite Command-Line
  Utility><label|sqlite3-the-sqlite-command-line-utility>

  The SQLite library includes a really nice command-line utility named
  sqlite3 (or sqlite3.exe on Windows) that allows the user to manually enter
  and execute SQL statements against a SQLite database (and much more).

  This tool is an invaluable aid when working with SQLite in general and with
  Sql3 in the Pure interpreter in particular. For example, after entering the
  Pure statements from the Simple Example above, you could start a new
  terminal, cd to pure-sql3, type \Psqlite3 readme.db\Q at the prompt, and
  see the effect the Pure statements had on the database:

  <\verbatim>
    \;

    pure-sql3$\<gtr\> sqlite3 readme.db

    SQLite version 3.6.16

    Enter ".help" for instructions

    Enter SQL statements terminated with a ";"

    \;

    sqlite\<gtr\> select * from RM;

    Sam\|20

    Fred\|22

    \;
  </verbatim>

  For bottom up REPL development, sqlite3 and Pure are an excellent
  combination.

  <subsection|Copying><label|copying>

  Copyright (c) 2010 by Peter Summerland \<less\><hlink|p.summerland@gmail.com|mailto:p.summerland@gmail.com>\<gtr\>.

  Copyright (c) 2010 by Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>.

  All rights reserved.

  Sql3 is free software: you can redistribute it and/or modify it under the
  terms of the New BSD License, often referred to as the 3 clause BSD
  license. Sql3 is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE.

  Please see the COPYING file for the actual license applicable to Sql3.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-sql3-0.5.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-sql3-0.5.tar.gz>.

  Unless you already have them on your machine, download SQLite and sqlite3
  from the SQLite website and install as indicated. To install Sql3, cd to
  the pure-sql3 directory, run <verbatim|make>, and then run <verbatim|sudo>
  <verbatim|make> <verbatim|install> (on Linux).

  <subsection|Data Structure><label|data-structure>

  From a client's perspective, the most important of SQLite's data structures
  are the database connection object \Psqlite3\Q and the prepared statement
  object \Psqlite3_stmt\Q. These are opaque data structures that are made
  available to users of SQLite's C interface via pointers, sqlite3* and
  sqlite3_stmt*. At appropriate times, Sql3 creates \Pcooked\Q versions of
  these pointers that can be used (with care) to call native C functions
  exposed by SQLite's C interface.

  Sql3 introduces two new data types, \Pdb_ptr\Q and \Pstmt_ptr\Q which refer
  to the cooked versions of sqlite3* and sqlite3_stmt*, respectively. These
  two new data types are defined using <verbatim|type>, and therefore can be
  used as type tags in rule patterns or as the first parameter passed to in
  the typep function. It follows that all db_ptrs are sqlite3* pointers and
  all stmt_ptrs are sqlite3_stmt* pointers. Thus, using dbp and sp1 from the
  introductory example:

  <\verbatim>
    \;

    \<gtr\> typep db_ptr dbp, pointer_type dbp;

    1, "sqlite3*"

    \;

    \<gtr\> typep stmt_ptr sp1, pointer_type sp1;

    1, "sqlite3_stmt*"

    \;
  </verbatim>

  The converse, of course, is not true, as SQLite knows nothing about Sql3,
  and db_ptrs and stmt_ptrs carry other information in addtion to the
  underlying pointers provided to them by SQLite.

  <subsection|Core Database Operations><label|core-database-operations>

  The core database operations are (a) opening and closing database
  connections and (b) preparing, executing and closing prepared statements.

  <subsubsection|Database Connections><label|database-connections>

  Generally speaking, the first step in accessing a database is to obtain a
  db_ptr that references a database connection object. Once the db_ptr is
  obtained, it can be used to construct prepared statements for updating and
  querying the underlying database. The last step is usually to close the
  database connection (although this is will be done automatically by Sql3
  when the db_ptr goes out of scope).

  <paragraph|Opening a Database Connection><label|opening-a-database-connection>

  In Sql3 <hlink|<with|font-family|tt|open>|#sql3::open> constructs a
  database connection and returns a db_ptr that refers to the connection.

  <\description>
    <item*|sql3::open (file_path::string [,access_mode::int[,custom_bindings]])<label|sql3::open>>opens
    a SQLite database file whose name is given by the file_path argument and
    returns a db_ptr for the associated database connection object created by
    SQLite.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> \ let dbp2 = open "abc.db"; dbp2;

    #\<less\>pointer 0x992dff8\<gtr\>

    \;
  </verbatim>

  If the filename is \Q:memory:\Q a private, temporary in-memory database is
  created for the connection.

  The basic access modes are:

  <\itemize>
    <item>SQLITE_OPEN_READONLY - the database is opened in read-only mode. If
    the database does not already exist, an error is returned.

    <item>SQLITE_OPEN_READWRITE - the database is opened for reading and
    writing if possible, or reading only if the file is write protected by
    the operating system. In either case the database must already exist,
    otherwise an error is returned.

    <item>SQLITE_OPEN_READWRITE \| SQLITE_OPEN_CREATE - the database is
    opened for reading and writing, and is creates it if it does not already
    exist. This is the default value that is used if the flags argument is
    omitted.

    <item>SQLITE_OPEN - an alias for SQLITE_OPEN_READWRITE \|
    SQLITE_OPEN_CREATE provided by Sql3.
  </itemize>

  These flags can be combined with SQLITE_OPEN_NOMUTEX SQLITE_OPEN_FULLMUTEX
  SQLITE_OPEN_SHAREDCACHE SQLITE_OPEN_PRIVATECACHE to control SQLite's
  threading and shared cache features. All of these flags are exported by
  Sql3.

  The optional custom_bindings argument allows the user to set up customized
  binding and fetching behavior for prepared statements associated with the
  returned db_ptr. (See <hlink|Custom Binding Types for Prepared
  Statements|#custom-binding-types-for-prepared-statements>)

  <paragraph|Failure to Open a Database Connection><label|failure-to-open-a-database-connection>

  If SQLite cannot open the connection, it still returns a pointer to a
  database connection object that must be closed. In this case,
  <hlink|<with|font-family|tt|open>|#sql3::open> automatically closes the the
  connection object and then throws an exception. E.g.,:

  <\verbatim>
    \;

    \<gtr\> catch error (open ("RM_zyx.db",SQLITE_OPEN_READONLY));

    error (sql3::db_error 14 "unable to open database file [open RM_zyx.db]")

    \;
  </verbatim>

  Apparently, SQLite does not verify that a file is a valid SQLite database
  when it opens a connection. However, if the file is corrupted SQLite will
  return an error when the connection is used.

  <paragraph|Testing a db_ptr><label|testing-a-db-ptr>

  You can test any object to see if it is a db_ptr using (typep db_ptr):

  <\description>
    <item*|typep db_ptr x<label|typep/sql3dbptr>>returns 1 if x is a db_ptr
    returned by open, and 0 if it is not.
  </description>

  You can also determine if a db_ptr's data connection is open.

  <\description>
    <item*|sql3::is_open dbp::db_ptr<label|sql3::is-open>>returns 1 if the
    database connection referenced by dbp is open.
  </description>

  <paragraph|Closing a Database Connection><label|closing-a-database-connection>

  When a database connection object is no longer needed, it should be closed
  so that SQLite can free the associated resources.

  <\description>
    <item*|sql3::close dbp::db_ptr<label|sql3::close>>if the database
    connection referenced by the db_ptr dbp is open, close it using
    sqlite3_close; otherwise do nothing.
  </description>

  Before calling <verbatim|sqlite3_close>,
  <hlink|<with|font-family|tt|close>|#sql3::close> finalizes all prepared
  statements associated with the connection being closed. Sql3 will detect
  and throw a db_error if an attempt is subsequently made to execute a
  statement associated with the closed database connection.

  <\verbatim>
    \;

    \<gtr\> let dbp2_sp = prep dbp2 "ci:" "select * from RM";

    \;

    \<gtr\> exec dbp2_sp ();

    [["Sam",20],["Fred",22]]

    \;

    \<gtr\> close dbp2;

    \;

    \<gtr\> catch error (exec dbp2_sp);

    error (sql3::db_error 0 "Attempt to exec on a closed db_ptr.")

    \;
  </verbatim>

  If a db_ptr goes out of scope, Sql3 will automatically call
  <verbatim|sqlite3_close> to close the referenced database connection, but
  only if the connection has not already been closed by
  <hlink|<with|font-family|tt|close>|#sql3::close>. Thus, for example, it is
  not necessary to use a catch statement to ensure that Sqlite3 resources are
  properly finalized when a db_ptr is passed into code that could throw an
  exception.

  When debugging, this activity can be observed by editing sql3.pure,
  changing \Pconst SHOW_OPEN_CLOSE = 0;\Q to \Pconst SHOW_OPEN_CLOSE = 1;\Q
  and running sudo make install in the pure-sql3 directory. This will cause a
  message to be printed whenever a db_ptr or stmt_ptr is created or
  finalized.

  N.B. You should never call the native C interface function\Psqlite3_close\P
  with a db_ptr. If the referenced database connection is closed by such a
  call, a subsequent call to <hlink|<with|font-family|tt|close>|#sql3::close>
  on this db_ptr (including the call that will automatically occur when the
  db_ptr goes out of scope) will cause a seg fault.

  <subsubsection|Prepared Statements><label|prepared-statements>

  The native SQLite C interface provides five core functions needed to
  execute a SQL statement.

  <\itemize>
    <item>sqlite3_prepare_v2

    <item>sqlite3_bind

    <item>sqlite3_step

    <item>sqlite3_column

    <item>sqlite3_finalize
  </itemize>

  Using the C interface, the basic procedure is to prepare a statement using
  <verbatim|sqlite3_prepare_v2>, bind its parameters using
  <verbatim|sqlite3_bind>, step it using <verbatim|sqlite3_step> one or more
  times until it is done and then finalize it using
  <verbatim|sqlite3_finalize>. Each time <verbatim|sqlite3_step> returns
  SQLITE_ROW, use <verbatim|sqlite3_column> to fetch the row's values. Here
  <verbatim|sqlite3_bind> and <verbatim|sqlite3_column> represent families of
  bind and column functions, rather than actual functions, with one member
  for each of the basic data types recognized by SQLite. Thus, for example,
  <verbatim|sqlite_bind_double> is the function one would use to bind a
  prepared statement with an argument of type double.

  Sql3 encapsulates these procedures in four functions:
  <hlink|<with|font-family|tt|prep>|#sql3::prep>,
  <hlink|<with|font-family|tt|exec>|#sql3::exec>,
  <hlink|<with|font-family|tt|lexec>|#sql3::lexec> and
  <hlink|<with|font-family|tt|finalize>|#sql3::finalize>.

  <paragraph|Constructing Prepared Statements><label|constructing-prepared-statements>

  In Sql3 you can use <hlink|<with|font-family|tt|prep>|#sql3::prep> to
  construct a prepared statement and obtain a stmt_ptr that refers to it.

  <\description>
    <item*|sql3::prep dbp::db_ptr binding_string::string
    sql_statement::string<label|sql3::prep>>constructs a prepared statement
    object and returns a stmt_ptr that references it. <verbatim|dbp> must be
    a db_ptr or the rule will not match. <verbatim|sql_statement> is the SQL
    statement that will be executed when the prepared statement is passed to
    <hlink|<with|font-family|tt|exec>|#sql3::exec>.
  </description>

  Basically, <hlink|<with|font-family|tt|prep>|#sql3::prep> just passes
  <verbatim|dbp> and <verbatim|sql_statement> on to
  <verbatim|sqlite3_prepare_v2> and returns a sentry guarded version of the
  sqlite3_stmt* it receives back from <verbatim|sqlite3_prepare_v2>. SQL
  statements passed to <hlink|<with|font-family|tt|prep>|#sql3::prep> (and
  <verbatim|sqlite3_prepare_v2>) can have argument placeholders, indicated by
  \Q?\Q, \Q?nnn\Q, \Q:AAA\Q, etc, in which case the argument placeholders
  must be bound to values using <verbatim|sqlite_bind> before the prepared
  statement is passed to <verbatim|sqlite3_step>. Hence the
  <verbatim|binding_string>, which is used by Sql3 to determine how to bind
  the prepared statement's argument placeholders, if any. The binding string
  also tells Sql3 how to fetch values in the <verbatim|sqlite3_column> phase
  of the basic prepare, bind, step, fetch, finalize cycle dictated by the
  SQlite C interface.

  In the following two examples, the \Pc\Q and \Pi\Q in the binding strings
  indicate that (a) a string and an int will be used to bind
  <verbatim|sp1>,(b) an int will be used to bind <verbatim|sp2> and (c)
  <verbatim|sp2>, when executed, will return a result set in the form of a
  list of sublists each of which contains a string and an int.

  <\verbatim>
    \;

    \<gtr\> let sp1 = prep dbp "ci" "insert into RM values (?,?)";

    \;

    \<gtr\> let sp2 = prep dbp "ci:i" "select * from RM where age \<gtr\> ?";

    \;
  </verbatim>

  In general, the characters in the type string before the \Q:\Q, if any,
  indicate the types in the result set. Those that occur after the \Q:\Q, if
  any, indicate the types of the arguments used to bind the prepared
  statement object. If the type string does not contain a \Q:\Q, the
  characters in the type string, if any, are the types of binding arguments.

  Sql3 provides the following set of \Pcore\Q binding types:

  <tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|3|3|cell-halign|l>|<cwith|1|-1|3|3|cell-rborder|0ln>|<cwith|1|-1|1|-1|cell-valign|c>|<cwith|1|1|1|-1|cell-bborder|1ln>|<table|<row|<cell|Type>|<cell|Pure
  Argument>|<cell|SQLite Type>>|<row|<cell|b>|<cell|(int,
  pointer)>|<cell|blob>>|<row|<cell|c>|<cell|string>|<cell|text
  (utf8)>>|<row|<cell|d>|<cell|double>|<cell|float>>|<row|<cell|i>|<cell|int>|<cell|int>>|<row|<cell|k>|<cell|int
  or bigint>|<cell|int64>>|<row|<cell|l>|<cell|bigint>|<cell|blob>>|<row|<cell|n>|<cell|Sql3::SQLNULL>|<cell|NULL>>|<row|<cell|x>|<cell|expression>|<cell|blob>>|<row|<cell|v>|<cell|variant>|<cell|variant>>>>>

  The \P<with|font-series|bold|b>\Q or blob type is different from the rest
  in that the Pure argument is specified as a pair. The first element of the
  pair indicates the length in bytes of the object to be stored and the
  second element indicates its location in memory. The
  \P<with|font-series|bold|c>\Q type stands for string (as in \Pchar*\Q),
  \P<with|font-series|bold|d>\Q stands for double and
  \P<with|font-series|bold|i>\Q stands for int. The
  \P<with|font-series|bold|k>\Q type stands for \Pkey\Q and maps Pure ints
  and bigints (within the range of int64) to int64 values in the database.
  This type is useful when dealing with SQLite's \Pinteger primary keys\Q and
  \Prowids\Q both of which are int64. The \P<with|font-series|bold|l>\Q type,
  in contrast applies to all bigints (and not to ints) and it maps bigints
  onto blobs, which are generally meaningless in SQL math expressions. The
  \P<with|font-series|bold|n>\Q type can only appear on the binding side of a
  type string. The \P<with|font-series|bold|v>\Q type stands for any of
  \Pb\Q, \Pc\Q, \Pd\Q, \Pi\Q or \Pn\Q, based on the type of the binding
  argument. A \Pv\Q type will be fetched from SQLite according to the native
  SQLite column type of the corresponding column. The
  \P<with|font-series|bold|x>\Q type is used to store and reconstruct Pure
  expressions as binary objects, using the
  <hlink|<with|font-family|tt|val>|purelib.tm#val/blob> and
  <hlink|<with|font-family|tt|blob>|purelib.tm#blob> functions provided by
  the Pure prelude.

  Users can define custom binding types and pass them as a third parameter to
  <hlink|<with|font-family|tt|open>|#sql3::open>. The resulting db_ptr can be
  used with the custom binding types to construct prepared statements using
  <hlink|<with|font-family|tt|prep>|#sql3::prep>.

  <paragraph|Testing a stmt_ptr><label|testing-a-stmt-ptr>

  You can determine if a given expression is a stmt_ptr using typep.

  <\description>
    <item*|typep stmt_ptr x<label|typep/sql3stmtptr>>returns 1 if
    <verbatim|x> is a stmt_ptr, otherwise returns 0.
  </description>

  <paragraph|Executing Prepared Statements><label|executing-prepared-statements>

  In Sql3, the bind, step, column, step, column ... cycle is encapsulated in
  the <hlink|<with|font-family|tt|exec>|#sql3::exec> and
  <hlink|<with|font-family|tt|lexec>|#sql3::lexec> functions.

  <\description>
    <item*|sql3::exec sp::stmt_ptr args<label|sql3::exec>>use <verbatim|args>
    to bind the prepared statement referenced by <verbatim|sp>, execute it
    and return the result set as a list. The first parameter, <verbatim|sp>
    must be a valid stmt_ptr or the rule will fail.
  </description>

  The second parameter, <verbatim|args>, is a tuple or list of arguments
  whose number and type correspond to the bind parameter types specified in
  the call to <hlink|<with|font-family|tt|prep>|#sql3::prep> that produced
  the first parameter <verbatim|sp>.

  Thus, using sp1 and sp2 defined in the introductory example:

  <\verbatim>
    \;

    \<gtr\> exec sp1 ("Tom",30); \ //insert Tom

    []

    \;

    \<gtr\> exec sp2 19; \ \ \ \ \ \ \ \ \ //select age \<gtr\> 19

    [["Sam",20],["Fred",22],["Tom",30]]

    \;
  </verbatim>

  An error is thrown if the args do not correspond to the specified types.

  <\verbatim>
    \;

    \<gtr\> catch error (exec sp2 "a");

    error (sql3::db_error 0 "\\"a\\" does not have type int")

    \;
  </verbatim>

  If a prepared statement does not have any binding parameters, the call to
  <hlink|<with|font-family|tt|exec>|#sql3::exec> should use <verbatim|()> as
  the binding argument.

  <\verbatim>
    \;

    \<gtr\> let sp3 = prep dbp "c:" "select name from RM";

    \;

    \<gtr\> exec sp3 ();

    [["Sam"],["Fred"],["Tom"]]

    \;
  </verbatim>

  Extra care is required when executing prepared statements that take a blob
  argument because it must be a pair. In order to preserve the tuple as a
  pair, binding arguments that include a blob should passed to exec as a
  list. If passed as a member of a larger tuple, it will be treated as two
  arguments due to the nature of tuples.

  <\verbatim>
    \;

    \<gtr\> let blb = (100,ptr);

    \;

    \<gtr\> (a,blb,c);

    a,100,ptr,c

    \;

    \<gtr\> [a,blb,c];

    [a,(100,ptr),c]

    \;
  </verbatim>

  Thus something like \P<verbatim|exec> <verbatim|stpx>
  <verbatim|[a,blb,c]>\Q would work fine, while \P<verbatim|exec>
  <verbatim|stpx> <verbatim|(a,blb,c)>\Q would produce a Sql3 binding
  exception.

  <paragraph|Executing Lazily><label|executing-lazily>

  The <hlink|<with|font-family|tt|exec>|#sql3::exec> function returns result
  sets as eager lists which can sometimes be inefficient or simply not
  feasible for large result sets. In such cases it is preferable to use
  <hlink|<with|font-family|tt|lexec>|#sql3::lexec> instead of
  <hlink|<with|font-family|tt|exec>|#sql3::exec>.

  <\description>
    <item*|sql3::lexec stmp::stmt_ptr args<label|sql3::lexec>>same as
    <hlink|<with|font-family|tt|exec>|#sql3::exec> except that it returns a
    lazy list.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> lexec sp2 19;

    ["Sam",20]:#\<less\>thunk 0xb6475ab0\<gtr\>

    \;
  </verbatim>

  Note that no changes to <verbatim|sp2> were required. In addition, for most
  purposes the lazy list returned by <hlink|<with|font-family|tt|lexec>|#sql3::lexec>
  can be processed by the same code that processed the eager list returned by
  <hlink|<with|font-family|tt|exec>|#sql3::exec>.

  <paragraph|Executing Directly on a db_ptr><label|executing-directly-on-a-db-ptr>

  For statements that have no parameters and which do not return results,
  <hlink|<with|font-family|tt|exec>|#sql3::exec> can be applied to a db_ptr.

  <\description>
    <item*|sql3::exec dbp::db_ptr sql_statement::string>constructs a
    temporary prepared statement using <verbatim|sql_statement>. The SQL
    statement cannot contain argument placeholders and cannot be a select
    statement.
  </description>

  Example:

  <\verbatim>
    \;

    \<gtr\> exec dbp "create table if not exists RM (name varchar, age
    integer)";

    \;
  </verbatim>

  <paragraph|Executing Against a Busy Database><label|executing-against-a-busy-database>

  SQLite allows multiple processes to concurrently read a single database,
  but when any process wants to write, it locks the entire database file for
  the duration of its update.

  When the native SQLite C interface function <verbatim|sqlite3_step> (used
  by <verbatim|exec>) tries to access a file that is locked by another
  process, it treats the database as \Pbusy\Q and returns the SQLITE_BUSY
  error code. If this happens in a call to
  <hlink|<with|font-family|tt|exec>|#sql3::exec> or
  <hlink|<with|font-family|tt|lexec>|#sql3::lexec>, a
  <hlink|<with|font-family|tt|db_busy>|#sql3::db-busy> exception will be
  thrown.

  You can adjust SQLite's behavior using <verbatim|sqlite3_busy_handler> or
  <verbatim|sqlite3_busy_timeout>.

  If the statement is a COMMIT or occurs outside of an explicit transaction,
  then you can retry the statement. If the statement is not a COMMIT and
  occurs within a explicit transaction then you should rollback the
  transaction before continuing.

  <paragraph|Grouping Execution with Transactions><label|grouping-execution-with-transactions>

  No changes can be made to a SQLite database file except within a
  transaction. Transactions can be started manually by executing a BEGIN
  statement (i.e., exec dbp \PBEGIN\Q). Manually started transactions persist
  until the next COMMIT or ROLLBACK statement is executed. Transactions are
  also ended if an error occurs before the transaction is manually ended
  using a COMMIT or ROLLBACK statement. This behavior provides the means make
  a series of changes \Patomically.\Q

  By default, SQLite operates in autocommit mode. In autocommit mode, any SQL
  statement that changes the database (basically, anything other than SELECT)
  will automatically start a transaction if one is not already in effect. As
  opposed to manually started transactions, automatically started
  transactions are committed as soon as the execution of the related
  statement completes.

  The upshot of this, in Sql3 terms, is that unless a transaction is started
  manually, the database will be updated each time
  <hlink|<with|font-family|tt|exec>|#sql3::exec> is called. For a long series
  of updates or inserts this a can be very slow. The way to avoid this
  problem is to manually begin and end transactions manually.

  Sql3 provides the following convenience functions all of which simply call
  <hlink|<with|font-family|tt|exec>|#sql3::exec> with the appropriate
  statement. For example <verbatim|begin> <verbatim|dbp> is exactly the same
  as <verbatim|exec> <verbatim|dbp> <verbatim|"BEGIN">.

  <\description>
    <item*|sql3::begin dbp::db_ptr<label|sql3::begin>>
  </description>

  <\description>
    <item*|sql3::begin_exclusive dbp::db_ptr<label|sql3::begin-exclusive>>
  </description>

  <\description>
    <item*|sql3::begin_immediate dbp::db_ptr<label|sql3::begin-immediate>>
  </description>

  <\description>
    <item*|sql3::commit dbp::db_ptr<label|sql3::commit>>
  </description>

  <\description>
    <item*|sql3::rollback dbp::db_ptr<label|sql3::rollback>>
  </description>

  <\description>
    <item*|sql3::savepoint dbp::db_ptr save_point::string<label|sql3::savepoint>>
  </description>

  <\description>
    <item*|sql3::release dbp::db_ptr save_point::string<label|sql3::release>>
  </description>

  <\description>
    <item*|sql3::rollback_to dbp::db_ptr save_point::string<label|sql3::rollback-to>>
  </description>

  Note that transactions created using <hlink|<with|font-family|tt|begin>|#sql3::begin>
  and <hlink|<with|font-family|tt|commit>|#sql3::commit> do not nest. For
  nested transactions, use <hlink|<with|font-family|tt|savepoint>|#sql3::savepoint>
  and <hlink|<with|font-family|tt|release>|#sql3::release>.

  <paragraph|Finalizing Prepared Statements><label|finalizing-prepared-statements>

  When a prepared statement is no longer needed it should be finalized so
  that SQLite can free the associated resources.

  <\description>
    <item*|sql3::finalize sp::stmt_ptr<label|sql3::finalize>>finalize the
    prepared statement referenced by <verbatim|sp>, which must be a stmt_ptr
    previously returned by <hlink|<with|font-family|tt|prep>|#sql3::prep>.
  </description>

  Often there is no need to call <hlink|<with|font-family|tt|finalize>|#sql3::finalize>
  for a given stmt_ptr because it will be automatically called when the
  stmt_ptr goes out of scope.

  If the stmt_ptr is associated with a database connection that has been
  closed (which would have caused an exception to be thrown), an attempt to
  finalize it, including the automatic finalization can occur when stmt_ptr
  goes out of scope, will cause an exception to be thrown.

  <\verbatim>
    \;

    \<gtr\> catch error (finalize dbp2_sp);

    error (sql3::db_error 0 "finalize: STMT attached to a closed db_ptr.")

    \;
  </verbatim>

  Multiple calls to <hlink|<with|font-family|tt|finalize>|#sql3::finalize>
  are fine. In contrast, the corresponding native C interface function,
  <verbatim|sqlite3_finalize> will cause a seg fault if called with a pointer
  to a finalized prepared statement object. This is the main reason why you
  should never call <verbatim|sqlite3_finalize> with a stmt_ptr. If the
  prepared statement referenced by the stmt_ptr is finalized by such a call,
  a subsequent call to <hlink|<with|font-family|tt|finalize>|#sql3::finalize>
  with the stmt_ptr (including the call that will automatically occur when
  the stmt_ptr goes out of scope) will cause a seg fault.

  <subsubsection|Exceptions><label|exceptions>

  Sql3 throws two types of exceptions, one for outright errors and one for
  database \Pbusy\Q conditions.

  <\description>
    <item*|<em|constructor> sql3::db_error ec msg<label|sql3::db-error>>When
    a Sql3 function detects an error it throws an exception of the form
    \P<verbatim|db_error> <verbatim|ec> <verbatim|msg>\Q where ec is an error
    code and msg is the corresponding error message. If ec\<gtr\>0, the error
    was detected by SQLite itself, and ec and msg are those returned by
    SQLite. If ec==0, the error was detected by Sql3 and msg is a Sql3
    specific description of the error. E.g.,

    <\verbatim>
      \;

      \<gtr\> db_error_handler (db_error ec msg) = ()

      \<gtr\> when

      \<gtr\> \ \ source = if ec \<gtr\> 0 then "SQLite" else "Sql3";

      \<gtr\> \ \ printf "%s db_error: ec %d, %s\\n" (source,ec,msg);

      \<gtr\> end;

      \<gtr\> db_error_handler x = throw x;

      \;

      \<gtr\> catch db_error_handler (exec dbp "select * from NO_TABLE");

      SQLite db_error: ec 1, no such table: NO_TABLE

      \;
    </verbatim>
  </description>

  <\description>
    <item*|<em|constructor> sql3::db_busy dbp<label|sql3::db-busy>>Sql3
    functions <hlink|<with|font-family|tt|exec>|#sql3::exec> and
    <hlink|<with|font-family|tt|lexec>|#sql3::lexec> throw exceptions of the
    form \P<verbatim|db_busy> <verbatim|dbp>\Q, where <verbatim|dbp> is a
    db_ptr, if they are prevented from executing successfully because the
    database referenced by <verbatim|dbp> is locked (See <hlink|Executing
    Against a Busy Database|#executing-against-a-busy-database>).
  </description>

  <paragraph|SQLite Error Codes><label|sqlite-error-codes>

  Here is a list, as of January 31, 2011, of SQLite's error codes.

  <\verbatim>
    \;

    SQLITE_ERROR \ \ \ \ \ \ \ 1 \ \ /* SQL error or missing database */

    SQLITE_INTERNAL \ \ \ \ 2 \ \ /* Internal logic error in SQLite */

    SQLITE_PERM \ \ \ \ \ \ \ \ 3 \ \ /* Access permission denied */

    SQLITE_ABORT \ \ \ \ \ \ \ 4 \ \ /* Callback routine requested an abort
    */

    SQLITE_BUSY \ \ \ \ \ \ \ \ 5 \ \ /* The database file is locked */

    SQLITE_LOCKED \ \ \ \ \ \ 6 \ \ /* A table in the database is locked */

    SQLITE_NOMEM \ \ \ \ \ \ \ 7 \ \ /* A malloc() failed */

    SQLITE_READONLY \ \ \ \ 8 \ \ /* Attempt to write a readonly database */

    SQLITE_INTERRUPT \ \ \ 9 \ \ /* Operation terminated by
    sqlite3_interrupt()*/

    SQLITE_IOERR \ \ \ \ \ \ 10 \ \ /* Some kind of disk I/O error occurred
    */

    SQLITE_CORRUPT \ \ \ \ 11 \ \ /* The database disk image is malformed */

    SQLITE_NOTFOUND \ \ \ 12 \ \ /* NOT USED. Table or record not found */

    SQLITE_FULL \ \ \ \ \ \ \ 13 \ \ /* Insertion failed because database is
    full */

    SQLITE_CANTOPEN \ \ \ 14 \ \ /* Unable to open the database file */

    SQLITE_PROTOCOL \ \ \ 15 \ \ /* NOT USED. Database lock protocol error */

    SQLITE_EMPTY \ \ \ \ \ \ 16 \ \ /* Database is empty */

    SQLITE_SCHEMA \ \ \ \ \ 17 \ \ /* The database schema changed */

    SQLITE_TOOBIG \ \ \ \ \ 18 \ \ /* String or BLOB exceeds size limit */

    SQLITE_CONSTRAINT \ 19 \ \ /* Abort due to constraint violation */

    SQLITE_MISMATCH \ \ \ 20 \ \ /* Data type mismatch */

    SQLITE_MISUSE \ \ \ \ \ 21 \ \ /* Library used incorrectly */

    SQLITE_NOLFS \ \ \ \ \ \ 22 \ \ /* Uses OS features not supported on host
    */

    SQLITE_AUTH \ \ \ \ \ \ \ 23 \ \ /* Authorization denied */

    SQLITE_FORMAT \ \ \ \ \ 24 \ \ /* Auxiliary database format error */

    SQLITE_RANGE \ \ \ \ \ \ 25 \ \ /* 2nd parameter to sqlite3_bind out of
    range */

    SQLITE_NOTADB \ \ \ \ \ 26 \ \ /* File opened that is not a database file
    */

    \;
  </verbatim>

  New error codes may be added in future versions of SQLite. Note that the
  SQLite names of the error codes are not exported by the Sql3 module.

  <subsection|Advanced Features><label|advanced-features>

  Sql3's advanced features include the ability to implement SQL functions in
  Pure, convenient access to the SQLite C interface and custom binding types.

  <subsubsection|Custom SQL Functions><label|custom-sql-functions>

  An extremely powerful (albeit complex) feature of the SQLite C interface is
  the ability to add new SQL scalar or aggregate functions. The new functions
  can be used in SQL statements the in same way as SQLites's prepackaged
  functions. Sql3 hides the complexity and seamlessly integrates all of this
  functionality, :), into Pure via <hlink|<with|font-family|tt|create_function>|#sql3::create-function>.
  This function is used to register both scalar SQL functions and aggregate
  SQL functions with SQlite.

  <paragraph|Scalar SQL Functions><label|scalar-sql-functions>

  You can add a custom SQL scalar function to SQLite by passing a single Pure
  function to <hlink|<with|font-family|tt|create_function>|#sql3::create-function>.

  <\description>
    <item*|sql3::create_function dbp::db_ptr name::string nargs::int
    pure_fun<label|sql3::create-function>>registers a new SQL scalar function
    of <verbatim|nargs> arguments that can be called, as <verbatim|name>, in
    SQL statements prepared with respect to <verbatim|dbp>, a db_ptr. When
    the SQL function is called in a SQL statement, control is passed to
    <verbatim|pure_fun>, a function written in Pure. If <verbatim|nargs> is
    <verbatim|(-1)>, the SQL function <verbatim|name> is variadic, and the
    arguments will be passed to <verbatim|pure_fun> as a single list.
  </description>

  Note that <hlink|<with|font-family|tt|create_function>|#sql3::create-function>
  can also register aggregate functions (see <hlink|Aggregate SQL
  Functions|#aggregate-sql-functions>).

  Here is an example of a scalar function that takes two parameters. Note
  that any kind of Pure \Pfunction\Q can be passed here; local functions,
  global functions, lambdas or partial applications all work.

  <\verbatim>
    \;

    \<gtr\> create_function dbp::dbp "p_fn" 2 plus with plus x y = x + y;
    end;

    \;

    \<gtr\> let sp4 = prep dbp "cii:"

    \<gtr\> \ \ \ \ \ \ \ \ \ \ "select p_fn('Hi ',name), age, p_fn(age,10)
    from RM";

    \;

    \<gtr\> exec sp4 ();

    [["Hi Sam",20,30],["Hi Fred",22,32]]

    \;
  </verbatim>

  Here is an example of a variadic function:

  <\verbatim>
    \;

    \<gtr\> create_function dbp "p_qm" (-1) quasimodo with

    \<gtr\> \ \ quasimodo xs = "quasimodo: "+join ":" [str x \| x=xs];

    \<gtr\> end;

    \;
  </verbatim>

  If the SQL function takes no arguments, the corresponding Pure function
  must, for technical reasons in Pure, take a single dummy argument. E.g.,

  <\verbatim>
    \;

    \<gtr\> create_function dbp "p_count" 0 counter with

    \<gtr\> \ \ counter () = put r (get r+1);

    \<gtr\> end when r = ref 0 end;

    \;
  </verbatim>

  Here is how <verbatim|count> and <verbatim|quasimodo> might be used:

  <\verbatim>
    \;

    \<gtr\> let sp5 = prep dbp "ic:" "select p_count(), p_qm(name,age) from
    RM";

    \;

    \<gtr\> exec sp5 ();

    [[1,"quasimodo: \\"Sam\\":20"],[2,"quasimodo: \\"Fred\\":22"]]

    \;

    \<gtr\> exec sp5 ();

    [[3,"quasimodo: \\"Sam\\":20"],[4,"quasimodo: \\"Fred\\":22"]]

    \;
  </verbatim>

  Multiple SQL functions can be registered with the same name if they have
  differing numbers of arguments. Built-in SQL functions may be overloaded or
  replaced by new application-defined functions.

  Generally, a custom function is permitted to call other Sql3 and native
  SQLite C interface functions. However, such calls must not close the
  database connection nor finalize or reset the prepared statement in which
  the function is running.

  <paragraph|Aggregate SQL Functions><label|aggregate-sql-functions>

  You can use <hlink|<with|font-family|tt|create_function>|#sql3::create-function>
  to register an aggregate SQL function with SQLite by passing a triple
  consisting of two Pure functions and a start value, in lieu of a single
  Pure function.

  <\description>
    <item*|sql3::create_function dbp::db_ptr name::string nargs::int
    (step,final,start)>registers a new SQL aggregate function of
    <verbatim|nargs> arguments that can be called, as <verbatim|name> in SQL
    statements prepared with respect to <verbatim|dbp>, a db_ptr.
    <verbatim|step> and <verbatim|final> are curried Pure functions and
    <verbatim|start> is the initial value for the aggregation. The
    <verbatim|step> function is called repeatedly to accumulate values from
    the database, starting from the given <verbatim|start> value, and finally
    the <verbatim|final> function is applied to the accumulated result.
  </description>

  Note that for a single-argument step function, this works exactly as if the
  functions were invoked as \P<verbatim|final> <verbatim|(foldl>
  <verbatim|step> <verbatim|start> <verbatim|values)>\Q, where
  <verbatim|values> is the list of aggregated values from the database.

  <\verbatim>
    \;

    \<gtr\> create_function dbp "p_avg" 1 (step,final,(0,0.0)) with

    \<gtr\> \ \ step (n,a) x = n+1, a+x;

    \<gtr\> \ \ final (n,a) = a/n;

    \<gtr\> end;

    \;

    \<gtr\> let sp6 = prep dbp "id:" "select count(name), p_avg(age) from
    RM";

    \;

    \<gtr\> exec sp6 ();

    [[2,21.0]]

    \;
  </verbatim>

  <subsubsection|Accessing the Rest of SQLite's C
  Interface><label|accessing-the-rest-of-sqlite-s-c-interface>

  The db_ptrs returned by <hlink|<with|font-family|tt|open>|#sql3::open> and
  stmt_ptrs returned by <hlink|<with|font-family|tt|prep>|#sql3::prep> are
  sentry guarded versions of the actual pointers to the data base connection
  objects and prepared statement objects returned by their corresponding
  native C interface functions <verbatim|sqlite3_open_v2> and
  <verbatim|sqlite3_prepare_v2>. This makes it easy to call almost any
  external function in SQLite's C interface directly, passing it the same
  db_ptr or stmt_ptr that is passed to Sql3's functions, such as
  <hlink|<with|font-family|tt|prep>|#sql3::prep> or
  <hlink|<with|font-family|tt|exec>|#sql3::exec>.

  For example, you can override SQLite's default behavior with respect to a
  busy database as follows:

  <\verbatim>
    \;

    \<gtr\> extern int sqlite3_busy_timeout(sqlite3*, int);

    \;

    \<gtr\> sqlite3_busy_timeout dbp 10;

    \;
  </verbatim>

  This sets a busy handler that will \Psleep and retry\Q multiple times until
  at least 10 milliseconds of sleeping have accumulated. Calling this routine
  with an argument less than or equal to zero turns off all busy handlers.

  Another example is to query the number of database rows that were changed,
  inserted or deleted by the most recently completed SQL statement executed
  on a given database connection:

  <\verbatim>
    \;

    \<gtr\> extern int sqlite3_changes(sqlite3*);

    \;

    \<gtr\> exec sp1 ("Harvey",30);

    \;

    \<gtr\> sqlite3_changes dbp;

    1

    \;
  </verbatim>

  As a final example, in this case using a stmt_ptr, you can determine name
  assigned to a column in a result using <verbatim|sqlite3_column_name>:

  <\verbatim>
    \;

    \<gtr\> extern char *sqlite3_column_name(sqlite3_stmt*, int);

    \;

    \<gtr\> exec sp2 29;

    [["Harvey",30]]

    \;

    \<gtr\> sqlite3_column_name sp2 1;

    "age"

    \;
  </verbatim>

  In order to call a native C function you must first make it accessible
  using an extern statement.

  Please note also that directly calling a function provided by the SQLite C
  interface can be dangerous, as is the case with any call from Pure code to
  an external C function. Sql3 users should be especially careful in this
  regard because using a db_ptr or a stmt_ptr in calls to certain native C
  interface functions, including in particular <verbatim|sqlite3_close> and
  <verbatim|sqlite3_finalize>, will corrupt data held by the db_ptr or
  stmt_ptr, leading to undefined behavior. The reason for this restriction is
  that Sql3 uses sentries to insure that the resources associated with a
  db_ptr or a stmt_ptr are automatically finalized by SQLite when they go out
  of scope. In addition, the sentries carry internal information used by Sql3
  for other purposes.

  <subsubsection|Custom Binding Types for Prepared
  Statements><label|custom-binding-types-for-prepared-statements>

  You can add your own binding types for preparing and executing prepared
  statements by specifying a third argument to
  <hlink|<with|font-family|tt|open>|#sql3::open>. The third argument must be
  a list of \Phash rocket pairs\Q in which the left side is a character for
  the custom binding type and the right side is a list with three members.
  The second and third members of the list are functions that map objects
  from the new type to one of the Sql3 core types and back, respectively. The
  first member of the list is the character for the Sql3 core types
  referenced by the mapping functions.

  The file sql3_user_bind_types.pure in the examples subdirectory shows how
  this might be done for a couple of user defined types. The example script
  deals with dates and certain Pure expressions as bigints and native Pure
  expressions, while the database stores these as utf-8 text. The following
  snippets show parts of the script that are relevant to this discussion:

  <\verbatim>
    \;

    const custom_binds = [

    \ \ "t"=\<gtr\>["c",day_to_str,str_to_day],

    \ \ "s"=\<gtr\>["c",str,eval]

    ];

    \;

    d1 = str_to_day "2010-03-22";

    \;

    db = open ("abc.db", SQLITE_OPEN, custom_binds);

    stm1 = prep db "cts" "insert into TC values(?,?,?)";

    exec stm1 ["Manny", d1, s_expr];

    stm3a = sql3::prep db "t:" "select t_date from TC";

    stm3b = sql3::prep db "c:" "select t_date from TC";

    \;
  </verbatim>

  Executing stm3a and stm3b from the interpreter shows that TC's date field
  is stored as a string, but returned to the Pure script as a bigint.

  <\verbatim>
    \;

    \<gtr\> sql3::exec stm3a ());

    [[14691L]]

    \;

    \<gtr\> sql3::exec stm3b ());

    [["2010-03-22"]]

    \;
  </verbatim>

  The character designating the custom type must not be one of the letters
  used to designate Sql3 core binding types.

  <subsection|Threading Modes><label|threading-modes>

  SQLite supports three different threading modes:

  <\enumerate>
    <item>Single-thread. In this mode, all mutexes are disabled and SQLite is
    unsafe to use in more than a single thread at once.

    <item>Multi-thread. In this mode, SQLite can be safely used by multiple
    threads provided that no single database connection is used
    simultaneously in two or more threads.

    <item>Serialized. In serialized mode, SQLite can be safely used by
    multiple threads with no restriction.
  </enumerate>

  SQLite can be compiled with or without support for multithreading and the
  default is to support it.

  In many cases, single-thread mode might be appropriate if only because it
  is measurably faster. This might be the case, for example, if you are using
  SQLite as the on-disk file format for a desktop application.

  If your version of SQLite was compiled with support for multithreading, you
  can switch to single-thread mode at runtime by calling sqlite3_config()
  with the verb SQLITE_CONFIG_SINGLETHREAD.

  If you must use threads, it is anticipated that Sql3 probably will not
  impose an additional burden. Hopefully, you will be fine if you apply the
  same precautions to a db_ptr or stmt_ptr that you would apply to the
  underlying sqlite* and sqlite_stmt*s if you were not using Sql3. It is
  strongly advised however that you look at the underlying Sql3 code to
  verify that this will work. Since everything that is imposed between the
  raw pointers returned by the SQlite interface and the corresponding db_ptr
  and stmt_ptrs is written in Pure, it should be relatively easy to determine
  how Sql3 and your multithreading strategy will interact. See <hlink|Is
  SQLite threadsafe?|http://www.sqlite.org/faq.html#q6> , <hlink|Opening A
  New Database Connection|http://www.sqlite.org/c3ref/open.html> and
  <hlink|Test To See If The Library Is Threadsafe|http://www.sqlite.org/c3ref/threadsafe.html>.

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-sql3-toc>

  <\itemize>
    <item><hlink|Pure-Sql3|#>

    <\itemize>
      <item><hlink|Introduction|#introduction>

      <\itemize>
        <item><hlink|Simple Example|#simple-example>

        <item><hlink|More Examples|#more-examples>

        <item><hlink|SQLite Documentation|#sqlite-documentation>

        <item><hlink|Sqlite3 - The SQLite Command-Line
        Utility|#sqlite3-the-sqlite-command-line-utility>
      </itemize>

      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Data Structure|#data-structure>

      <item><hlink|Core Database Operations|#core-database-operations>

      <\itemize>
        <item><hlink|Database Connections|#database-connections>

        <\itemize>
          <item><hlink|Opening a Database
          Connection|#opening-a-database-connection>

          <item><hlink|Failure to Open a Database
          Connection|#failure-to-open-a-database-connection>

          <item><hlink|Testing a db_ptr|#testing-a-db-ptr>

          <item><hlink|Closing a Database
          Connection|#closing-a-database-connection>
        </itemize>

        <item><hlink|Prepared Statements|#prepared-statements>

        <\itemize>
          <item><hlink|Constructing Prepared
          Statements|#constructing-prepared-statements>

          <item><hlink|Testing a stmt_ptr|#testing-a-stmt-ptr>

          <item><hlink|Executing Prepared
          Statements|#executing-prepared-statements>

          <item><hlink|Executing Lazily|#executing-lazily>

          <item><hlink|Executing Directly on a
          db_ptr|#executing-directly-on-a-db-ptr>

          <item><hlink|Executing Against a Busy
          Database|#executing-against-a-busy-database>

          <item><hlink|Grouping Execution with
          Transactions|#grouping-execution-with-transactions>

          <item><hlink|Finalizing Prepared
          Statements|#finalizing-prepared-statements>
        </itemize>

        <item><hlink|Exceptions|#exceptions>

        <\itemize>
          <item><hlink|SQLite Error Codes|#sqlite-error-codes>
        </itemize>
      </itemize>

      <item><hlink|Advanced Features|#advanced-features>

      <\itemize>
        <item><hlink|Custom SQL Functions|#custom-sql-functions>

        <\itemize>
          <item><hlink|Scalar SQL Functions|#scalar-sql-functions>

          <item><hlink|Aggregate SQL Functions|#aggregate-sql-functions>
        </itemize>

        <item><hlink|Accessing the Rest of SQLite's C
        Interface|#accessing-the-rest-of-sqlite-s-c-interface>

        <item><hlink|Custom Binding Types for Prepared
        Statements|#custom-binding-types-for-prepared-statements>
      </itemize>

      <item><hlink|Threading Modes|#threading-modes>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Pure-ODBC - ODBC interface for the Pure programming
  language|pure-odbc.tm>

  Next topic

  <hlink|Pure-XML - XML/XSLT interface|pure-xml.tm>

  <hlink|toc|#pure-sql3-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-xml.tm> \|
  <hlink|previous|pure-odbc.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Jan
  13, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
