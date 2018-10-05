<TeXmacs|1.99.7>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-csv-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-fastcgi.tm> \|
  <hlink|previous|pure-reduce.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Pure-CSV - Comma Separated Value Interface for the Pure
  Programming Language><label|pure-csv-comma-separated-value-interface-for-the-pure-programming-language>

  Version 1.6, April 11, 2018

  Eddie Rucker \<less\><hlink|erucker@bmc.edu|mailto:erucker@bmc.edu>\<gtr\>

  The CSV library provides an interface for reading and writing comma
  separated value files. The module is very loosely based on Python's CSV
  module (<hlink|http://docs.python.org/lib/module-csv.html|http://docs.python.org/lib/module-csv.html>).

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-csv-1.6.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-csv-1.6.tar.gz>.

  Run <verbatim|make> to compile the module and <verbatim|make>
  <verbatim|install> (as root) to install it in the Pure library directory.
  This requires GNU make. The <verbatim|make> <verbatim|install> step is only
  necessary for system-wide installation.

  The <verbatim|make> utility tries to guess your Pure installation directory
  and platform-specific setup. If it gets this wrong, you can set some
  variables manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix, and <verbatim|make>
  <verbatim|PIC=-fPIC> or some similar flag might be needed for compilation
  on 64 bit systems. Please see the Makefile for details.

  <subsection|Usage><label|usage>

  Data records are represented as vectors or lists of any Pure values. Values
  are converted as necessary and written as a group of strings, integers, or
  doubles separated by a delimiter. Three predefined dialects are provided;
  <verbatim|DEFAULT> (record terminator= <verbatim|<n>> ), <verbatim|RFC4180>
  (record terminator= <verbatim|<r\\n>> ), and <verbatim|Excel>. Procedures
  are provided to create other CSV dialects. See
  (<hlink|http://www.ietf.org/rfc/rfc4180.txt|http://www.ietf.org/rfc/rfc4180.txt>)
  for more details about the RFC4180 standard.

  <subsubsection|Handling Errors><label|handling-errors>

  <\description>
    <item*|<with|font-family|tt|error> <with|font-family|tt|msg><label|error>>is
    an error handling term. Operations resulting in parse errors, memory
    errors, or read/write errors produce a special <verbatim|csv::error>
    <verbatim|msg> term, where <verbatim|msg> is a string describing the
    particular error. Your application should either check for these or have
    <verbatim|csv::error> defined to directly handle errors in some way
    (e.g., provide a default value, or raise an exception).
  </description>

  <subsubsection|Creating Dialects><label|creating-dialects>

  <\description>
    <item*|<with|font-family|tt|dialect> <with|font-family|tt|record><label|dialect>>creates
    a dialect from a record of dialect option pairs. The dialect object is
    freed automatically when exiting the pure script. The list of possible
    options and option values are presented below.

    <\itemize>
      <item><verbatim|delimiter> - Character used to separate fields.

      <\itemize>
        <item>Value - any string.

        <item>Default - <verbatim|",">.
      </itemize>

      <item><verbatim|escape> - Embedded escape character used to embed a
      delimiter, escape, or terminator into unquoted fields. If the escape
      character is not null, then the quote character is ignored.

      <\itemize>
        <item>Value - any string.

        <item>Default - <verbatim|"">.

        <item>Reading - The escape character is dropped and the next char is
        inserted into the field.

        <item>Writing - The escape character is written into the output
        stream before the delimiter, escape, or return character.
      </itemize>

      <item><verbatim|quote> - Quotes are used to embed delimiters, quotes,
      or terminators into a field.

      <\itemize>
        <item>Value - any string.

        <item>Default - <verbatim|"\\"">.

        <item>Notes - Embedded quotes are doubled. The <verbatim|escape>
        option must be the null string.
      </itemize>

      <item><verbatim|terminator> - Record termination string.

      <\itemize>
        <item>Value - any string.

        <item>Reading - Either a user specified string or if not specivied
        the file is sniffed for a <verbatim|<r>>, <verbatim|<r\\n>>, or
        <verbatim|<n>>.

        <item>Writing - Either a user specified string, <verbatim|<r\\n>> for
        Windows platforms, or <verbatim|<n>> for everything else.
      </itemize>

      <item><verbatim|quote_flag> - Sets the quoting style of strings and/or
      numbers.

      <\itemize>
        <item>Value - One of {<verbatim|ALL>, <verbatim|STRINGS>,
        <verbatim|MINIMAL>}.

        <item>Default - <verbatim|ALL>.

        <item>Reading -

        <\enumerate>
          <item><verbatim|ALL> - Every field is read as a string.

          <item><verbatim|STRING>, <verbatim|MINIMAL> - Fields within quotes
          and fields that cannot be converted to integers or doubles are read
          as strings.
        </enumerate>

        <item>Writing -

        <\enumerate>
          <item><verbatim|ALL> - Every field is written within quotes.

          <item><verbatim|STRING> - Only fields of type <verbatim|string> are
          quoted.

          <item><verbatim|MINIMAL> - Only fields containing embedded quotes,
          terminators, or delimiters are written within quotes.
        </enumerate>
      </itemize>

      <item><verbatim|space_around_quoted_field> - Determines how white space
      between quotes and delimiters should be treated.

      <\itemize>
        <item>Value - One of {<verbatim|NO>, <verbatim|LEFT>,
        <verbatim|RIGHT>, <verbatim|BOTH>}.

        <item>Default - <verbatim|NO>.

        <item>Reading -

        <\enumerate>
          <item><verbatim|NO> - Follows RFC4180 rules.

          <item><verbatim|LEFT> - Allows space before a quoted field.

          <item><verbatim|RIGHT> - Allows space between a quoted field and a
          delimiter.

          <item><verbatim|BOTH> - Allows space before and after a quoted
          field.
        </enumerate>

        <item>Writing - fields are never written with space before a quoted
        field or between a quoted field and a delimiter.

        <item>Notes this option does not affect space within quotes or fields
        written using the <verbatim|escape> string option.
      </itemize>

      <item><verbatim|trim_space> - trim white space before or after field
      contents.

      <\itemize>
        <item>Value - One of {<verbatim|NO>, <verbatim|LEFT>,
        <verbatim|RIGHT>, <verbatim|BOTH>}.

        <item>Default - <verbatim|NO>.

        <item>Reading -

        <\enumerate>
          <item><verbatim|NO> - Reading follows RFC4180 rules.

          <item><verbatim|LEFT>, <verbatim|RIGHT>, or <verbatim|BOTH> - The
          field is trimmed accordingly. Use <em|caution> because trimming may
          allow automatic conversion of numbers if the <verbatim|quote_flag>
          is set to <verbatim|MINIMAL>.
        </enumerate>

        <item>Writing -

        <\enumerate>
          <item><verbatim|NO> - Reading follows RFC4180 rules

          <item><verbatim|LEFT>, <verbatim|RIGHT>, or <verbatim|BOTH> -
          Trimming space is probably a bad idea since leading or trailing
          space may be significant for other applications.
        </enumerate>
      </itemize>
    </itemize>

    The following example illustrates the construction of a dialect for
    reading tab delimited files without quoted strings.
  </description>

  <label|example-dialect>

  Example

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let d = dialect {delimiter=\<gtr\>"\\t",
    quote_flag=\<gtr\>STRING};

    \<gtr\>

    \;
  </verbatim>

  <subsubsection|Opening CSV Files><label|opening-csv-files>

  <\description>
    <item*|<with|font-family|tt|open> <with|font-family|tt|name::string><label|open>>opens
    a CSV file for reading using the default dialect. If the file does not
    exist, the <verbatim|error> <verbatim|msg> rule is invoked.

    <item*|<with|font-family|tt|open> <with|font-family|tt|(name::string,>
    <with|font-family|tt|rw_flag::string)>>opens a CSV file for reading,
    writing, or appending using the default dialect. Valid <verbatim|rw_flag>
    values are <verbatim|"r"> for reading, <verbatim|"w"> for writing, and
    <verbatim|"a"> for appending. If the file does not exist when opened for
    reading, the <verbatim|error> <verbatim|msg> rule is invoked. When a file
    is opened for writing and the file exists, the old file is overwritten.
    If the file does not exist, a new empty file is created. When a file is
    opened for appending and the file exists, new records are appended to the
    end of the file, otherwise a new empty file is created.

    <item*|<with|font-family|tt|open> <with|font-family|tt|(name::string,>
    <with|font-family|tt|rw_flag::string,>
    <with|font-family|tt|d::matrix)>>exactly as above except reading/writing
    is done according to a user defined dialect <verbatim|d>.

    <item*|<with|font-family|tt|open> <with|font-family|tt|(name::string,>
    <with|font-family|tt|rw_flag::string,> <with|font-family|tt|d::matrix,>
    <with|font-family|tt|opts@(_:_))>>exactly as above except allows for list
    output or header options when reading.

    <\enumerate>
      <item>If <verbatim|opts> contains <verbatim|LIST>, the output of
      <verbatim|getr>, <verbatim|fgetr>, and <verbatim|fgetr_lazy> is a list
      instead of a vector.

      <item>If <verbatim|opts> contains <verbatim|HEADER>, the first line of
      the file is automatically read and parsed as a record where entries are
      <verbatim|key=\>position> pairs where <verbatim|key> is a string and
      <verbatim|position> is an integer denoting the location of a field
      within the record. The header record may be accessed by
      <verbatim|header>.
    </enumerate>
  </description>

  <label|examples-open>

  Examples

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let d = dialect {delimiter=\<gtr\>"\\t"};

    \<gtr\> let f = open ("junk.csv", "w", d);

    \<gtr\> putr f {"hello",123,"",3+:4,world};

    ()

    \<gtr\> close f;

    ()

    \<gtr\> let f = open ("junk.csv", "r", d);

    \<gtr\> getr f;

    {"hello","123","","3+:4","world"}

    \<gtr\>

    \;
  </verbatim>

  Suppose our file \Ptest.csv\Q is as presented below.

  <\verbatim>
    \;

    ir$ more test.csv

    NAME,TEST1,TEST2

    "HOPE, BOB",90,95

    "JONES, SALLY",88,72

    "RED, FEEFEE",45,52

    \;
  </verbatim>

  Notice how the <verbatim|LIST> option affects the return of <verbatim|getr>
  and how the <verbatim|HEADER> option may be used to index records.

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let d = dialect {quote_flag=\<gtr\>MINIMAL};

    \<gtr\> let f = open ("test.csv", "r", d, [LIST,HEADER]);

    \<gtr\> let r = getr f;

    \<gtr\> r!0;

    "HOPE, BOB"

    \<gtr\> let k = header f;

    \<gtr\> k;

    {"NAME"=\<gtr\>0,"TEST1"=\<gtr\>1,"TEST2"=\<gtr\>2}

    \<gtr\> r!(k!"NAME");

    "HOPE, BOB"

    \<gtr\> r!!(k!!["NAME","TEST1"]);

    ["HOPE, BOB",90]

    \<gtr\>

    \;
  </verbatim>

  <subsubsection|File Reading Functions><label|file-reading-functions>

  <\description>
    <item*|<with|font-family|tt|header> <with|font-family|tt|csv_file::pointer><label|header>>returns
    the record of <verbatim|key=\>position> pairs when opened by
    <verbatim|csv::open> using the header option. If the file was opened
    without the <verbatim|HEADER> option, <verbatim|{}> is returned.
  </description>

  <\description>
    <item*|<with|font-family|tt|getr> <with|font-family|tt|csv_file::pointer><label|getr>>reads
    from a <verbatim|csv_file> opened by <verbatim|csv::open> and returns a
    record represented as a row matrix. Reading from a file opened for
    writing or appending invokes the <verbatim|error> <verbatim|msg> rule.
  </description>

  <\description>
    <item*|<with|font-family|tt|fgetr> <with|font-family|tt|csv_file::pointer><label|fgetr>>reads
    a whole file and returns a list of records. This procedure should only be
    used on data files that are small enough to fit in the computer's primary
    memory. Reading from a file opened for writing or appending invokes the
    <verbatim|error> <verbatim|msg> rule.

    <item*|<with|font-family|tt|fgetr_lazy>
    <with|font-family|tt|csv_file::pointer>>Lazy version of <verbatim|fgetr>.
  </description>

  <subsubsection|File Writing Functions><label|file-writing-functions>

  When modifying CSV files that will be imported into Microsoft Excel, fields
  with significant leading 0s should be written using a
  <verbatim|"=""0..."""> formatting scheme. This same technique will work for
  preserving leading space too. Again, this quirk should only be necessary
  for files to be imported into MS Excel.

  <\description>
    <item*|<with|font-family|tt|putr> <with|font-family|tt|csv_file::pointer>
    <with|font-family|tt|rec::matrix><label|putr>>writes a record in row
    matrix format to <verbatim|csv_file>. Writing to a file opened for
    reading invokes the <verbatim|error> <verbatim|msg> rule.
  </description>

  <\description>
    <item*|<with|font-family|tt|fputr> <with|font-family|tt|csv_file::pointer>
    <with|font-family|tt|l@(_:_)><label|fputr>>writes a list of records where
    each record is a row matrix to <verbatim|csv_file>. Writing to a file
    opened for reading invokes the <verbatim|error> <verbatim|msg> rule.
  </description>

  <subsubsection|Examples><label|examples>

  The first example shows how to write and read a default CSV file.

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let f = open ("testing.csv", "w");

    \<gtr\> fputr f [{"bob",3.9,"",-2},{"fred",-11.8,"",0},{"mary",2.3,"$",11}];

    ()

    \<gtr\> close f;

    ()

    \<gtr\> let f = open "testing.csv";

    \<gtr\> fgetr f;

    [{"bob","3.9","","-2"},{"fred","-11.8","","0"},{"mary","2.3","$","11"}]

    \<gtr\> close f;

    \<gtr\>

    \;
  </verbatim>

  The second example illustrates how to write and read a CSV file using
  automatic conversions.

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let d = dialect {quote_flag=\<gtr\>MINIMAL};

    \<gtr\> let f = open ("test.csv", "w", d);

    \<gtr\> putr f {"I","",-4,1.2,2%4,like};

    ()

    \<gtr\> putr f {"playing","the",0,-0.2,1+:4,drums};

    ()

    \<gtr\> close f;

    ()

    \<gtr\> let f = open ("test.csv", "r", d);

    \<gtr\> fgetr f;

    [{"I","",-4,1.2,"2%4","like"},{"playing","the",0,-0.2,"1+:4","drums"}]

    \<gtr\> close f;

    ()

    \<gtr\>

    \;
  </verbatim>

  Records containing quotes, delimiters, and line breaks are also properly
  handled.

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let d = dialect {quote_flag=\<gtr\>STRING};

    \<gtr\> let f = open ("test.csv", "w", d);

    \<gtr\> fputr f [{"this\\nis\\n",1},{"a \\"test\\"",2}];

    ()

    \<gtr\> close f;

    ()

    \<gtr\> let f = open ("test.csv", "r", d);

    \<gtr\> fgetr f;

    [{"this\\nis\\n",1},{"a \\"test\\"",2}]

    \<gtr\> close f;

    ()

    \<gtr\>

    \;
  </verbatim>

  Consider the following hand written CSV file. According to RFC4180, this is
  not a valid CSV file. However, by using the
  <verbatim|space_around_quoted_field>, the file can still be read.

  <\verbatim>
    \;

    erucker:$ more test.csv

    \ \ "this", \ \ "is", \ "not", "valid"

    \;
  </verbatim>

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let f = open "test.csv";

    \<gtr\> getr f;

    csv::error "parse error at line 1"

    \<gtr\> let d = dialect {space_around_quoted_field=\<gtr\>BOTH};

    \<gtr\> let f = open ("test.csv", "r", d);

    \<gtr\> getr f;

    {"this","is","not","valid"}

    \<gtr\>

    \;
  </verbatim>

  The <verbatim|trim_space> flag should be used with caution. A field with
  space in front of a number should be interpreted as a string, but consider
  the following file.

  <\verbatim>
    \;

    erucker:$ more test.csv

    " \ this \ \ ", 45 ,23, \ hello

    \;
  </verbatim>

  Now observe the differences for the two dialects below.

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let d = dialect {trim_space=\<gtr\>BOTH};

    \<gtr\> let f = open ("test.csv","r",d);

    \<gtr\> getr f;

    {"this","45","23","hello"}

    \<gtr\> let d = dialect {trim_space=\<gtr\>BOTH,
    quote_flag=\<gtr\>MINIMAL};

    \<gtr\> let f = open ("test.csv", "r", d);

    \<gtr\> getr f;

    {"this",45,23,"hello"}

    \<gtr\>

    \;
  </verbatim>

  The <verbatim|trim_space> flag also affects writing.

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let d = dialect {trim_space=\<gtr\>BOTH};

    \<gtr\> let f = open ("test.csv", "w", d);

    \<gtr\> putr f {" \ \ this \ \ "," \ \ 45 "};

    ()

    \<gtr\> close f;

    ()

    \<gtr\> quit

    \;

    erucker:$ more test.csv

    "this","45"

    \;
  </verbatim>

  For the last example a tab delimiter is used, automatic conversions is on,
  and records are represented as lists. Files are automatically closed when
  the script is finished.

  <\verbatim>
    \;

    \<gtr\> using csv;

    \<gtr\> using namespace csv;

    \<gtr\> let d = dialect {quote_flag=\<gtr\>MINIMAL,
    delimiter=\<gtr\>"\\t"};

    \<gtr\> let f = open ("test.csv", "w", d, [LIST]);

    \<gtr\> fputr f [["a","b",-4.5,""],["c","d",2.3,"-"]];

    ()

    \<gtr\> close f;

    ()

    \<gtr\> let f = open ("test.csv", "r", d, [LIST]);

    \<gtr\> fgetr f;

    [["a","b",-4.5,""],["c","d",2.3,"-"]]

    \<gtr\> quit

    \;
  </verbatim>

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-csv-toc>

  <\itemize>
    <item><hlink|Pure-CSV - Comma Separated Value Interface for the Pure
    Programming Language|#>

    <\itemize>
      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <\itemize>
        <item><hlink|Handling Errors|#handling-errors>

        <item><hlink|Creating Dialects|#creating-dialects>

        <item><hlink|Opening CSV Files|#opening-csv-files>

        <item><hlink|File Reading Functions|#file-reading-functions>

        <item><hlink|File Writing Functions|#file-writing-functions>

        <item><hlink|Examples|#examples>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Computer Algebra with Pure: A Reduce Interface|pure-reduce.tm>

  Next topic

  <hlink|pure-fastcgi: FastCGI module for Pure|pure-fastcgi.tm>

  <hlink|toc|#pure-csv-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-fastcgi.tm> \|
  <hlink|previous|pure-reduce.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Oct
  05, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
