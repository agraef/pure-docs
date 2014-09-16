<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-fastcgi-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-odbc.tm> \|
  <hlink|previous|pure-csv.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-fastcgi: FastCGI module for Pure<label|module-fastcgi>>

  Version 0.6, September 17, 2014

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  This module lets you write <hlink|FastCGI|http://www.fastcgi.com> scripts
  with Pure, to be run by web servers like
  <hlink|Apache|http://www.apache.org/>. Compared to normal CGI scripts, this
  has the advantage that the script keeps running and may process as many
  requests from the web server as you like, in order to reduce startup times
  and enable caching techniques. Most ordinary CGI scripts can be converted
  to use FastCGI with minimal changes.

  <subsection|Copying<label|copying>>

  Copyright (c) 2009 by Albert Graef. pure-fastcgi is distributed under a
  3-clause BSD-style license, please see the included COPYING file for
  details.

  <subsection|Installation<label|installation>>

  Besides Pure, you'll need to have the <hlink|FastCGI|http://www.fastcgi.com>
  library installed to compile this module. Also, to run FastCGI scripts,
  your web server must be configured accordingly; see the documentation of
  FastCGI and your web server for details.

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-fastcgi-0.6.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-fastcgi-0.6.tar.gz>.

  Running <verbatim|make> compiles the module, <verbatim|make>
  <verbatim|install> installs it in your Pure library directory. You might
  have to adjust the path to the fcgi_stdio.h header file in fastcgi.c and/or
  the option to link in the FastCGI library in the Makefile.

  The Makefile tries to guess the host system type and Pure version, and set
  up some platform-specific things accordingly. If this doesn't work for your
  system then you'll have to edit the Makefile accordingly.

  <subsection|Usage<label|usage>>

  pure-fastcgi provides the <verbatim|accept> function with which you tell
  the FastCGI server that your script is ready to accept another request.

  <\description>
    <item*|fastcgi::accept<label|fastcgi::accept>>Accept a FastCGI request.
  </description>

  The module also overrides a number of standard I/O functions so that they
  talk to the server instead. These routines are all in the
  <verbatim|fastcgi> namespace. In your Pure script, you can set up a simple
  loop to process requests as follows:

  <\verbatim>
    #!/usr/local/bin/pure -x

    \;

    using fastcgi;

    using namespace fastcgi;

    \;

    extern char *getenv(char*);

    \;

    main count = main count when

    \ \ count = count+1;

    \ \ printf "Content-type: text/html\\n\\n\\

    \<less\>title\<gtr\>FastCGI Hello! (Pure, fcgi_stdio
    library)\<less\>/title\<gtr\>\\

    \<less\>h1\<gtr\>FastCGI Hello! (Pure, fcgi_stdio
    library)\<less\>/h1\<gtr\>\\

    Request number %d running on host \<less\>i\<gtr\>%s\<less\>/i\<gtr\>\\n"

    \ \ (count,getenv "SERVER_NAME");

    end if accept \<gtr\>= 0;

    \;

    main 0;
  </verbatim>

  (You might have to adjust the ``shebang'' in the first line above, so that
  the shell finds the Pure interpreter. Also, remember to make the script
  executable. If you're worried about startup times, or if your operating
  system doesn't support shebangs, then you can also use the Pure interpreter
  to compile the script to a native executable instead.)

  This script keeps running until <hlink|<with|font-family|tt|accept>|#fastcgi::accept>
  returns <verbatim|-1> to indicate that the script should exit. Each call to
  <hlink|<with|font-family|tt|accept>|#fastcgi::accept> blocks until either a
  request is available or the FastCGI server detects an error or other kind
  of termination condition. As with ordinary CGI, additional information
  about the request is available through various environment variables. A
  list of commonly supported environment variables and their meaning can be
  found in <hlink|The Common Gateway Interface|http://hoohoo.ncsa.uiuc.edu/cgi/>
  specification.

  A number of other routines are provided to deal with data filters, finish a
  request and set an exit status for a request. These correspond to
  operations provided by the FastCGI library, see the FastCGI documentation
  and the FCGI_Accept(3), FCGI_StartFilterData(3), FCGI_Finish(3) and
  FCGI_SetExitStatus(3) manpages for details. An interface to the FCGI_ToFILE
  macro is also available. Note that in Pure these functions are called
  <verbatim|accept>, <verbatim|start_filter_data>, <verbatim|finish>,
  <verbatim|set_exit_status> and <verbatim|to_file>, respectively, and are
  all declared in the <verbatim|fastcgi> namespace. A detailed listing of all
  routines can be found in the fastcgi.pure module.

  Please see the examples subdirectory in the pure-fastcgi sources for some
  more elaborate examples.

  Note that to run your FastCGI scripts in a browser, your web server must
  have the FastCGI module loaded and must also be set up to execute the
  scripts. E.g., when using Apache, the following configuration file entry
  will set up a directory for FastCGI scripts:

  <\verbatim>
    ScriptAlias /fastcgi-bin/ "/srv/www/fastcgi-bin/"

    \<less\>Location /fastcgi-bin/\<gtr\>

    \ \ \ \ Options ExecCGI

    \ \ \ \ SetHandler fastcgi-script

    \ \ \ \ Order allow,deny

    \ \ \ \ Allow from all

    \<less\>/Location\<gtr\>
  </verbatim>

  (Replace <verbatim|fastcgi-script> with <verbatim|fcgid-script> if you're
  running <verbatim|mod_fcgid> rather than <verbatim|mod_fastcgi>.)

  Put this entry into http.conf or a similar file provided by your Apache
  installation (usually under /etc/apache2), and restart Apache. After that
  you can just throw your scripts into the <verbatim|fastcgi-bin> directory
  to have them executed via an URL like <href|http://localhost/fastcgi-bin/myscript>.

  You can also set up a handler for the <verbatim|.pure> filename extension
  as follows:

  <\verbatim>
    \<less\>IfModule mod_fastcgi.c\<gtr\>

    \<less\>FilesMatch "\\.pure$"\<gtr\>

    \ \ \ \ AddHandler fastcgi-script .pure

    \ \ \ \ Options +ExecCGI

    \<less\>/FilesMatch\<gtr\>

    \<less\>/IfModule\<gtr\>
  </verbatim>

  (Again, you'll have to adjust the <verbatim|IfModule> statement and replace
  <verbatim|fastcgi-script> with <verbatim|fcgid-script> if you're running
  <verbatim|mod_fcgid>.) After that you should be able to execute scripts
  with the proper extension anywhere under your server's document root.

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-fastcgi-toc>>

  <\itemize>
    <item><hlink|pure-fastcgi: FastCGI module for Pure|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Pure-CSV - Comma Separated Value Interface for the Pure Programming
  Language|pure-csv.tm>

  Next topic

  <hlink|Pure-ODBC - ODBC interface for the Pure programming
  language|pure-odbc.tm>

  <hlink|toc|#pure-fastcgi-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-odbc.tm> \|
  <hlink|previous|pure-csv.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Sep
  17, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
