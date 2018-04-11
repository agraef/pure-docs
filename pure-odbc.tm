<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-odbc-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-sql3.tm> \|
  <hlink|previous|pure-fastcgi.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Pure-ODBC - ODBC interface for the Pure programming
  language><label|module-odbc>

  Version 0.10, April 11, 2018

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  Jiri Spitz \<less\><hlink|jiri.spitz@bluetone.cz|mailto:jiri.spitz@bluetone.cz>\<gtr\>

  This module provides a simple ODBC interface for the Pure programming
  language, which lets you access a large variety of open source and
  commercial database systems from Pure. ODBC a.k.a. \POpen Database
  Connectivity\Q was originally developed by Microsoft for Windows, but is
  now available on many different platforms, and two open source
  implementations exist for Unix-like systems: iODBC
  (<hlink|http://www.iodbc.org|http://www.iodbc.org>) and unixODBC
  (<hlink|http://www.unixodbc.org|http://www.unixodbc.org>).

  ODBC has become the industry standard for portable and vendor independent
  database access. Most modern relational databases provide an ODBC interface
  so that they can be used with this module. This includes the popular open
  source DBMSs MySQL (<hlink|http://www.mysql.com|http://www.mysql.com>) and
  PostgreSQL (<hlink|http://www.postgresql.org|http://www.postgresql.org>).
  The module provides the necessary operations to connect to an ODBC data
  source and retrieve or modify data using SQL statements.

  To make this module work, you must have an ODBC installation on your
  system, as well as the driver backend for the DBMS you want to use (and, of
  course, the DBMS itself). You also have to configure the DBMS as a data
  source for the ODBC system. On Windows this is done with the ODBC applet in
  the system control panel. For iODBC and unixODBC you can either edit the
  corresponding configuration files (/etc/odbc.ini and/or
  <math|\<sim\>>/.odbc.ini) by hand, or use one of the available graphical
  setup tools. More information about the setup process can be found on the
  iODBC and unixODBC websites.

  <subsection|Copying><label|copying>

  Copyright (c) 2009 by Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>.

  Copyright (c) 2009 by Jiri Spitz \<less\><hlink|jiri.spitz@bluetone.cz|mailto:jiri.spitz@bluetone.cz>\<gtr\>.

  pure-odbc is free software: you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-odbc is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
  for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-odbc-0.10.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-odbc-0.10.tar.gz>.

  Run <verbatim|make> to compile the module and <verbatim|make>
  <verbatim|install> (as root) to install it in the Pure library directory.
  This requires GNU make, and of course you need to have Pure installed. The
  only other dependency is the GNU Multiprecision Library (GMP).

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix, and <verbatim|make>
  <verbatim|PIC=-fPIC> or some similar flag might be needed for compilation
  on 64 bit systems. The variable <verbatim|ODBCLIB> specifies the ODBC
  library to be linked with. The default value is <verbatim|ODBCLIB=-lodbc>.
  Please see the Makefile for details.

  <subsection|Opening and Closing a Data Source><label|opening-and-closing-a-data-source>

  To open an ODBC connection, you have to specify a \Pconnect string\Q which
  names the data source to be used with the <verbatim|odbc::connect>
  function. A list of available data sources can be obtained with the
  <verbatim|odbc::sources> function. For instance, on my Linux system running
  MySQL and PostgreSQL it shows the following:

  <\verbatim>
    \;

    \<gtr\> odbc::sources;

    [("myodbc","MySQL ODBC 2.50"),("psqlodbc","PostgreSQL ODBC")]

    \;
  </verbatim>

  The first component in each entry of the list is the name of the data
  source, which can be used as the value of the <verbatim|DSN> option in the
  connect string, the second component provides a short description of the
  data source.

  Likewise, the list of ODBC drivers available on your system can be obtained
  with the <verbatim|odbc::drivers> function which returns a list of pairs of
  driver names and attributes. (Older ODBC implementations on Unix lacked
  this feature, but it seems to be properly supported in recent unixODBC
  implementations at least.) This function can be used to determine a legal
  value for the <verbatim|DRIVER> attribute in the connect string, see below.

  The <verbatim|odbc::connect> function is invoked with a single parameter,
  the connect string, which is used to describe the data source and various
  other parameters such as user id and password. For instance, on my system I
  can connect to the local <verbatim|myodbc> data source from above as
  follows:

  <\verbatim>
    \;

    \<gtr\> let db = odbc::connect "DSN=myodbc";

    \;
  </verbatim>

  The <verbatim|odbc::connect> function returns a pointer to an
  <verbatim|ODBCHandle> object which is used to refer to the database
  connection in the other routines provided by this module. An
  <verbatim|ODBCHandle> object is closed automatically when it is no longer
  accessible. You can also close it explicitly with a call to the
  <verbatim|odbc::disconnect> function:

  <\verbatim>
    \;

    \<gtr\> odbc::disconnect db;

    \;
  </verbatim>

  After <verbatim|odbc::disconnect> has been invoked on a handle, any further
  operations on it will fail.

  <verbatim|odbc::connect> allows a number of attributes to be passed to the
  ODBC driver when opening the database connection. E.g., here's how to
  specify a username and password; note that the different attributes are
  separated with a semicolon:

  <\verbatim>
    \;

    \<gtr\> let db = odbc::connect "DSN=myodbc;UID=root;PWD=guess";

    \;
  </verbatim>

  The precise set of attributes in the connect string depends on your ODBC
  driver, but at least the following options should be available on most
  systems. (Case is insignificant in the attribute names, so e.g. the
  <verbatim|DATABASE> attribute may be specified as either
  <verbatim|DATABASE>, <verbatim|Database> or <verbatim|database>.)

  <\itemize>
    <item>DSN=\<less\>data source name\<gtr\>

    <item>DRIVER=\<less\>driver name\<gtr\>

    <item>HOST=\<less\>server host name\<gtr\>

    <item>DATABASE=\<less\>database path\<gtr\>

    <item>UID=\<less\>user name\<gtr\>

    <item>PWD=\<less\>password\<gtr\>
  </itemize>

  The following attributes appear to be Windows-specific:

  <\itemize>
    <item>FILEDSN=\<less\>DSN file name\<gtr\>

    <item>DBQ=\<less\>database file name\<gtr\>
  </itemize>

  Using the <verbatim|FILEDSN> option you can establish a connection to a
  data source described in a .dsn file on Windows, as follows:

  <\verbatim>
    \;

    \<gtr\> odbc::connect "FILEDSN=test.dsn";

    \;
  </verbatim>

  Usually it is also possible to directly connect to a driver and name a
  database file as the data source. For instance, using the MS Access ODBC
  driver you can connect to a database file test.mdb as follows:

  <\verbatim>
    \;

    \<gtr\> odbc::connect "DRIVER=Microsoft Access Driver
    (*.mdb);DBQ=test.mdb";

    \;
  </verbatim>

  SQLite (<hlink|http://www.sqlite.org|http://www.sqlite.org>) provides
  another way to get a database up and running quickly. For that you need the
  SQLite library and the SQLite ODBC driver available at
  <hlink|http://www.ch-werner.de/sqliteodbc|http://www.ch-werner.de/sqliteodbc>.
  Then you can open an SQLite database as follows (the database file is named
  with the <verbatim|DATABASE> attribute and is created automatically if it
  doesn't exist):

  <\verbatim>
    \;

    \<gtr\> odbc::connect "DRIVER=SQLite3;Database=test.db";

    \;
  </verbatim>

  SQLite generally performs very well if you avoid some pitfalls (in
  particular, big batches of updates/inserts should be done within a
  transaction, otherwise they will take forever). It is certainly good enough
  for smaller databases and very easy to set up. Basically, after installing
  SQLite and its ODBC driver you're ready to go immediately. This makes it a
  very convenient alternative if you don't want to go through the tedium of
  setting up one of the big hulking DBMS.

  <subsection|Getting Information about a Data
  Source><label|getting-information-about-a-data-source>

  You can get general information about an open database connection with the
  <verbatim|odbc::info> function. This function returns a tuple of strings
  with the following items (see the description of the SQLGetInfo() function
  in the ODBC API reference for more information):

  <\itemize>
    <item>DATA_SOURCE_NAME: the data source name

    <item>DATABASE_NAME: the default database

    <item>DBMS_NAME: the host DBMS name

    <item>DBMS_VER: the host DBMS version

    <item>DRIVER_NAME: the name of the ODBC driver

    <item>DRIVER_VER: the version of the ODBC driver

    <item>DRIVER_ODBC_VER: the ODBC version supported by the driver

    <item>ODBC_VER: the ODBC version of the driver manager
  </itemize>

  E.g., here is what the connection to MySQL shows on my Linux system:

  <\verbatim>
    \;

    \<gtr\> odbc::info db;

    "myodbc","test","MySQL","5.0.18","myodbc3.dll","03.51.12","03.51","03.52"

    \;
  </verbatim>

  The odbc module also provides a number of operations to retrieve a bunch of
  additional meta information about the given database connection. In
  particular, the <verbatim|odbc::getinfo> function provides a direct
  interface to the SQLGetInfo() routine. The result of
  <verbatim|odbc::getinfo> is a pointer which can be converted to an integer
  or string value, depending on the type of information requested. For
  instance:

  <\verbatim>
    \;

    \<gtr\> get_short $ odbc::getinfo db odbc::SQL_MAX_TABLES_IN_SELECT;

    31

    \;

    \<gtr\> cstring_dup $ odbc::getinfo db odbc::SQL_IDENTIFIER_QUOTE_CHAR;

    "`"

    \;
  </verbatim>

  Information about supported SQL data types is available with the
  <verbatim|odbc::typeinfo> routine (this returns a lot of data, see
  odbc.pure for an explanation):

  <\verbatim>
    \;

    \<gtr\> odbc::typeinfo db odbc::SQL_ALL_TYPES;

    \;
  </verbatim>

  Moreover, information about the tables in the current database, as well as
  the structure of the tables and their primary and foreign keys can be
  retrieved with the <verbatim|odbc::tables>, <verbatim|odbc::columns>,
  <verbatim|odbc::primary_keys> and <verbatim|odbc::foreign_keys> functions:

  <\verbatim>
    \;

    \<gtr\> odbc::tables db;

    [("event","TABLE"),("pet","TABLE")]

    \;

    \<gtr\> odbc::columns db "pet";

    [("name","varchar","NO","''"),("owner","varchar","YES",odbc::SQLNULL),

    ("species","varchar","YES",odbc::SQLNULL),("sex","char","YES",odbc::SQLNULL),

    ("birth","date","YES",odbc::SQLNULL),("death","date","YES",odbc::SQLNULL)]

    \;

    \<gtr\> odbc::primary_keys db "pet";

    ["name"]

    \;

    \<gtr\> odbc::foreign_keys db "event";

    [("name","pet","name")]

    \;
  </verbatim>

  This often provides a convenient and portable means to retrieve basic
  information about table structures, at least on RDBMS which properly
  implement the corresponding ODBC calls. Also note that while this
  information is also available through special system catalogs in most
  databases, the details of accessing these vary a lot among implementations.

  <subsection|Executing SQL Queries><label|executing-sql-queries>

  As soon as a database connection has been opened, you can execute SQL
  queries on it using the <verbatim|sql> function which executes a query and
  collects the results in a list. Note that SQL queries generally come in two
  different flavours: queries returning data (so-called <em|result sets>),
  and statements modifying the data (which have as their result the number of
  affected rows). The <verbatim|sql> function returns a nonempty list of
  lists (where the first list denotes the column titles, and each subsequent
  list corresponds to a single row of the result set) in the former, and the
  row count in the latter case.

  For instance, here is how you can select some entries from a table. (The
  following examples assume the sample \Pmenagerie\Q tables from the MySQL
  documentation. The <verbatim|initdb> function in the
  examples/menagerie.pure script can be used to create these tables in your
  default database.)

  <\verbatim>
    \;

    \<gtr\> odbc::sql db "select name,species from pet where owner='Harold'"
    [];

    [["name","species"],["Fluffy","cat"],["Buffy","dog"]]

    \;
  </verbatim>

  Often the third parameter of <verbatim|sql>, as above, is just the empty
  list, indicating a parameterless query. Queries involving marked input
  parameters can be executed by specifying the parameter values in the third
  argument of the <verbatim|sql> call. For instance:

  <\verbatim>
    \;

    \<gtr\> odbc::sql db "select name,species from pet where owner=?"
    ["Harold"];

    [["name","species"],["Fluffy","cat"],["Buffy","dog"]]

    \;
  </verbatim>

  Multiple parameters are specified as a list:

  <\verbatim>
    \;

    \<gtr\> odbc::sql db "select name,species from pet where owner=? and
    species=?"

    \<gtr\> ["Harold","cat"];

    [["name","species"],["Fluffy","cat"]]

    \;
  </verbatim>

  Parameterized queries are particularly useful for the purpose of inserting
  data into a table:

  <\verbatim>
    \;

    \<gtr\> odbc::sql db "insert into pet values (?,?,?,?,?,?)"

    \<gtr\> ["Puffball","Diane","hamster","f","1999-03-30",odbc::SQLNULL];

    1

    \;
  </verbatim>

  In this case we could also have hard-coded the data to be inserted right
  into the SQL statement, but a parameterized query like the one above can
  easily be applied to a whole collection of data rows, e.g., as follows:

  <\verbatim>
    \;

    \<gtr\> do (odbc::sql db "insert into pet values (?,?,?,?,?,?)") data;

    \;
  </verbatim>

  Parameterized queries also let you insert data which cannot be specified
  easily inside an SQL query, such as long strings or binary data.

  The following SQL types of result and parameter values are recognized and
  converted to/from the corresponding Pure types:

  <tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|2|2|cell-rborder|0ln>|<cwith|1|-1|1|-1|cell-valign|c>|<cwith|1|1|1|-1|cell-bborder|1ln>|<table|<row|<cell|SQL
  value/type>|<cell|Pure value/type>>|<row|<cell|SQL NULL (no
  value)>|<cell|<verbatim|odbc::SQLNULL>>>|<row|<cell|integer types (INTEGER
  and friends)>|<cell|<verbatim|int>>>|<row|<cell|64-bit
  integers>|<cell|<verbatim|bigint>>>|<row|<cell|floating point types (REAL,
  FLOAT and friends)>|<cell|<verbatim|double>>>|<row|<cell|binary data
  (BINARY, BLOB, etc.)>|<cell|<verbatim|(size,>
  <verbatim|data)>>>|<row|<cell|character strings (CHAR, VARCHAR, TEXT,
  etc.)>|<cell|<verbatim|string>>>>>>

  Note the special constant (nonfix symbol) <verbatim|odbc::SQLNULL> which is
  used to represent SQL NULL values.

  Also note that binary data is specified as a pair <verbatim|(size,>
  <verbatim|data)> consisting of an int or bigint <verbatim|size> which
  denotes the size of the data in bytes, and a pointer <verbatim|data> (which
  must not be a null pointer unless <verbatim|size> is 0 as well) pointing to
  the binary data itself.

  All other SQL data (including, e.g., TIME, DATE and TIMESTAMP) is
  represented in Pure using its character representation, encoded as a Pure
  string.

  Some databases also allow special types of queries (e.g., \Pbatch\Q queries
  consisting of multiple SQL statements) which may return multiple result
  sets and/or row counts. The <verbatim|sql> function only returns the first
  result set, which is appropriate in most cases. If you need to determine
  all result sets returned by a query, the <verbatim|msql> function must be
  used. This function is invoked in exactly the same way as the
  <verbatim|sql> function, but returns a list with all the result sets and/or
  row counts of the query.

  Example:

  <\verbatim>
    \;

    \<gtr\> odbc::msql db "select * from pet; select * from event" [];

    \;
  </verbatim>

  This will return a list with two result sets, one for each query.

  <subsection|Low-Level Operations><label|low-level-operations>

  The <verbatim|sql> and <verbatim|msql> operations are in fact just ordinary
  Pure functions which are implemented in terms of the low-level operations
  <verbatim|sql_exec>, <verbatim|sql_fetch>, <verbatim|sql_more> and
  <verbatim|sql_close>. You can also invoke these functions directly if
  necessary. The <verbatim|sql_exec> function starts executing a query and
  returns either a row count or the column names of the first result set as a
  tuple of strings. After that you can use <verbatim|sql_fetch> to obtain the
  results in the set one by one. When all rows have been delivered,
  <verbatim|sql_fetch> fails. The <verbatim|sql_more> function can then be
  used to check for additional result sets. If there are further results,
  <verbatim|sql_more> returns either the next row count, or a tuple of column
  names, after which you can invoke <verbatim|sql_fetch> again to obtain the
  data rows in the second set, etc. When the last result set has been
  processed, <verbatim|sql_more> fails.

  Example:

  <\verbatim>
    \;

    \<gtr\> odbc::sql_exec db "select name,species from pet where
    owner='Harold'" [];

    ["name","species"]

    \<gtr\> odbc::sql_fetch db; // get the 1st row

    ["Fluffy","cat"]

    \<gtr\> odbc::sql_fetch db; // get the 2nd row

    ["Buffy","dog"]

    \<gtr\> odbc::sql_fetch db; // no more results

    odbc::sql_fetch #\<less\>pointer 0x24753e0\<gtr\>

    \<gtr\> odbc::sql_more db; // no more result sets

    odbc::sql_more #\<less\>pointer 0x24753e0\<gtr\>

    \;
  </verbatim>

  Moreover, the <verbatim|sql_close> function can be called at any time to
  terminate an SQL query, after which subsequent calls to
  <verbatim|sql_fetch> and <verbatim|sql_more> will fail:

  <\verbatim>
    \;

    \<gtr\> odbc::sql_close db; // terminate query

    ()

    \;
  </verbatim>

  This is not strictly necessary (it will be done automatically as soon as
  the next SQL query is invoked), but it is useful in order to release all
  resources associated with the query, such as parameter values which have to
  be cached so that they remain accessible to the SQL server. Since these
  parameters in some cases may use a lot of memory it is better to call
  <verbatim|sql_close> as soon as you are finished with a query. This is also
  done automatically by the <verbatim|sql> and <verbatim|msql> functions.

  Also note that only a single query can be in progress per database
  connection at any one time. That is, if you invoke <verbatim|sql_exec> to
  initiate a new query, a previous query will be terminated automatically.
  (However, it is possible to execute multiple queries on the same database
  simultaneously, if you process them through different connections to that
  database.)

  The low-level operations are useful when you have to deal with large result
  sets where you want to avoid to build the complete list of results in main
  memory. Instead, these functions allow you to process the individual
  elements immediately as they are delivered by the <verbatim|sql_fetch>
  function. (An alternative method which combines the space efficiency of
  immediate processing with the convenience of the list representation is
  discussed in the following section.) Using the low-level operations you can
  also build your own specialized query engines; take the definitions of
  <verbatim|sql> or <verbatim|msql> as a start and change them according to
  your needs.

  <subsection|Lazy Processing><label|lazy-processing>

  As an experimental feature, the odbc module also provides two operations
  <verbatim|odbc::lsql> and <verbatim|odbc::lmsql> which work like
  <verbatim|odbc::sql> and <verbatim|odbc::msql> (see <hlink|Executing SQL
  Queries|#executing-sql-queries> above), but return lazy lists (streams)
  instead. This offers the convenience of a list-based representation without
  the overhead of keeping entire result sets in memory, which can be
  prohibitive when working with large amounts of data.

  These functions are invoked just like <verbatim|odbc::sql> and
  <verbatim|odbc::msql>, but they return a lazy list of rows (or a lazy list
  of lazy lists of rows in the case of <verbatim|lmsql>). For instance:

  <\verbatim>
    \;

    \<gtr\> odbc::lsql db "select * from pet" [];

    ["name","owner","species","sex","birth","death"]:#\<less\>thunk
    0x7ffbb9aa2eb8\<gtr\>

    \;
  </verbatim>

  Note that the tail of the result list is \Pthunked\Q and will only be
  produced on demand, as you traverse the list. As a simple example, suppose
  that we just want to print the <verbatim|name> field of each data row:

  <\verbatim>
    \;

    \<gtr\> using system;

    \<gtr\> do (\\(name:_)-\<gtr\>puts name) $ tail $ odbc::lsql db "select *
    from pet" [];

    Fluffy

    Claws

    Buffy

    Fang

    Bowser

    Chirpy

    Whistler

    Slim

    ()

    \;
  </verbatim>

  Here only one row is in memory at any time while the <verbatim|do> function
  is in progress. This keeps memory requirements much lower than when using
  the <verbatim|odbc::sql> function which first loads the entire result set
  into memory. Another advantage is that only those data rows are fetched
  from the database which are actually needed in the course of the
  computation. This can speed up the processing significantly if only a part
  of the result set is needed. For instance, in the following example we only
  look at the first two data rows until the desired row is found, so the
  remaining rows are never fetched from the database:

  <\verbatim>
    \;

    \<gtr\> head [row \| row@(name:_) = tail $ odbc::lsql db "select * from
    pet" [];

    \<gtr\> \ \ \ \ \ \ \ \ \ \ \ \ name == "Claws"];

    ["Claws","Gwen","cat","m","1994-03-17",odbc::SQLNULL]

    \;
  </verbatim>

  On the other hand, <verbatim|lsql>/<verbatim|lmsql> will usually be
  somewhat slower than <verbatim|sql>/<verbatim|msql> if the entire result
  set is being processed. So you should always consider the time/space
  tradeoffs when deciding which functions to use in a given situation.

  Also note that when using <verbatim|lsql>/<verbatim|lmsql>, the query
  remains in progress as long as the result list is still being processed.
  (This is different from <verbatim|sql>/<verbatim|msql> which load the
  complete result set(s) at once after which the query is terminated
  immediately.) Since only one query can be executed per database connection,
  this means that only one lazy result set can be processed per database
  connection at any time. However, as with the lowlevel operations it is
  possible to do several lazy queries simultaneously if you assign them to
  different database connections.

  <subsection|Error Handling><label|error-handling>

  When one of the above operations fails because the SQL server reports an
  error, an error term of the form <verbatim|odbc::error> <verbatim|msg>
  <verbatim|state> will be returned, which specifies an error message and the
  corresponding SQL state (i.e., error code). A detailed explanation of the
  state codes can be found in the ODBC documentation. For instance, a
  reference to a non-existent table will cause a report like the following:

  <\verbatim>
    \;

    \<gtr\> odbc::sql db "select * from pets" [];

    odbc::error "[TCX][MyODBC]Table 'test.pets' doesn't exist" "S1000"

    \;
  </verbatim>

  You can check for such return values and take some appropriate action. By
  redefining odbc::error accordingly, you can also have it generate
  exceptions or print an error message. For instance:

  <\verbatim>
    \;

    odbc::error msg state = fprintf stderr "%s (%s)\\n" (msg,state) $$ ();

    \;
  </verbatim>

  <with|font-series|bold|Note:> When redefining <verbatim|odbc::error> in
  this manner, you should be aware that the return value of
  <verbatim|odbc::error> is what will be returned by the other operations of
  this module in case of an error condition. These return values are checked
  by other functions such as <verbatim|sql>. Thus the return value should
  still indicate that an error has happened, and not be something that might
  be interpreted as a legal return value, such as an integer or a nonempty
  tuple. It is usually safe to have <verbatim|odbc::error> return an empty
  tuple or throw an exception, but other types of return values should be
  avoided.

  <subsection|Caveats and Bugs><label|caveats-and-bugs>

  Be warned that multiple result sets are not supported by all databases. I
  also found that some ODBC drivers do not properly implement this feature,
  even though the database supports it. So you better stay away from this if
  you want your application to be portable. You can easily implement batched
  queries using a sequence of single queries instead.

  Note that since the exact numeric SQL data types (NUMERIC, DECIMAL) are
  mapped to Pure double values (which are double precision floating point
  numbers), there might be a loss of precision in extreme cases. If this is a
  problem you should explicitly convert these values to strings in your
  query, which can be done using the SQL CAST function, as in
  <verbatim|select> <verbatim|cast(1234.56> <verbatim|as> <verbatim|char)>.

  <subsection|Further Information and Examples><label|further-information-and-examples>

  For further details about the operations provided by this module please see
  the odbc.pure file. A sample script illustrating the usage of the module
  can be found in the examples directory.

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-odbc-toc>

  <\itemize>
    <item><hlink|Pure-ODBC - ODBC interface for the Pure programming
    language|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Opening and Closing a Data
      Source|#opening-and-closing-a-data-source>

      <item><hlink|Getting Information about a Data
      Source|#getting-information-about-a-data-source>

      <item><hlink|Executing SQL Queries|#executing-sql-queries>

      <item><hlink|Low-Level Operations|#low-level-operations>

      <item><hlink|Lazy Processing|#lazy-processing>

      <item><hlink|Error Handling|#error-handling>

      <item><hlink|Caveats and Bugs|#caveats-and-bugs>

      <item><hlink|Further Information and
      Examples|#further-information-and-examples>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-fastcgi: FastCGI module for Pure|pure-fastcgi.tm>

  Next topic

  <hlink|Pure-Sql3|pure-sql3.tm>

  <hlink|toc|#pure-odbc-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-sql3.tm> \|
  <hlink|previous|pure-fastcgi.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Apr
  11, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
