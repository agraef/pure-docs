<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-sockets-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-stldict.tm> \|
  <hlink|previous|pure-readline.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-sockets: Pure Sockets Interface><label|module-sockets>

  Version 0.7, July 07, 2016

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  This is an interface to the Berkeley socket functions. It provides most of
  the core functionality, so you can create sockets for both stream and
  datagram based protocols and use these to transmit messages. Unix-style
  file sockets are also available if the host system supports them.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-sockets-0.7.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-sockets-0.7.tar.gz>.

  Run <verbatim|make> to compile the module and <verbatim|sudo>
  <verbatim|make> <verbatim|install> to install it in the Pure library
  directory. To uninstall the module, use <verbatim|sudo> <verbatim|make>
  <verbatim|uninstall>. There are a number of other targets (mostly for
  maintainers), please see the Makefile for details.

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix, and <verbatim|make>
  <verbatim|PIC=-fPIC> or some similar flag might be needed for compilation
  on 64 bit systems. You can also set custom compilation options with the
  CFLAGS variable, e.g.: <verbatim|make> <verbatim|CFLAGS=-O3>. Again, please
  see the Makefile for details.

  <subsection|Usage><label|usage>

  To use the operations of this module, put the following in your Pure
  script:

  <\verbatim>
    \;

    using sockets;

    \;
  </verbatim>

  With the <hlink|<with|font-family|tt|sockets>|#module-sockets> module
  loaded, all the standard socket functions are available and work pretty
  much like in C. The only real difference is that, for convenience,
  functions taking socket addresses as parameters
  (<verbatim|struct_sockaddr*> pointers in Pure), are called without the
  <verbatim|addrlen> parameter; the size of the socket address structure will
  be inferred automatically and passed to the underlying C functions. Also,
  there are some convenience functions which act as wrappers around
  <verbatim|getaddrinfo> and <verbatim|getnameinfo> to create socket
  addresses from symbolic information (hostname or ip, port names or numbers)
  and return information about existing address pointers, see <hlink|Creating
  and Inspecting Socket Addresses|#creating-and-inspecting-socket-addresses>
  below.

  Below is a list of the provided functions. Please see the corresponding
  manual pages for details, and check the Pure scripts in the examples
  subdirectory for some examples.

  <subsubsection|Creating and Inspecting Socket
  Addresses><label|creating-and-inspecting-socket-addresses>

  These functions are Pure-specific. The created socket addresses are
  malloc'ed and free themselves automatically when garbage-collected.

  <\description>
    <item*|sockaddr ()<label|sockaddr>>Create a pointer to an empty socket
    address suitable to hold the socket address result of routines like
    <hlink|<with|font-family|tt|accept>|#accept>,
    <hlink|<with|font-family|tt|getsockname>|#getsockname>,
    <hlink|<with|font-family|tt|recvfrom>|#recvfrom>, etc. which return a
    socket address.
  </description>

  <\description>
    <item*|sockaddr ([int family,] char *path)>Create a local (a.k.a. file)
    socket address for the given pathname. The <verbatim|family> parameter,
    if specified, must be <verbatim|AF_UNIX> here. Please note that
    <verbatim|AF_UNIX> is not supported on all platforms. You can check for
    this by testing the <verbatim|HAVE_AF_UNIX> constant, which is a truth
    value specifying whether <verbatim|AF_UNIX> is available on your system.
  </description>

  <\description>
    <item*|sockaddr ([int family,] char *host, char *port)>

    <item*|sockaddr ([int family,] char *host, int port)>This uses
    <verbatim|getaddrinfo> to retrieve an <verbatim|AF_INET> or
    <verbatim|AF_INET6> address for the given hostname (or numeric IP address
    in string form) and port (specified either as an int or a string). If
    <verbatim|family> is omitted, it defaults to <verbatim|AF_UNSPEC> which
    matches both <verbatim|AF_INET> and <verbatim|AF_INET6> addresses.
  </description>

  <\description>
    <item*|sockaddrs ([int family,] char *host, char *port)<label|sockaddrs>>

    <item*|sockaddrs ([int family,] char *host, int port)>This works like
    <hlink|<with|font-family|tt|sockaddr>|#sockaddr> above, but returns a
    list with <em|all> matching addresses.
  </description>

  <\description>
    <item*|sockaddr_family addr<label|sockaddr-family>>Returns the address
    family of the given address.
  </description>

  <\description>
    <item*|sockaddr_path addr<label|sockaddr-path>>Returns the pathname for
    <verbatim|AF_UNIX> addresses.
  </description>

  <\description>
    <item*|sockaddr_hostname addr<label|sockaddr-hostname>>Returns the
    hostname if available, the IP address otherwise.
  </description>

  <\description>
    <item*|sockaddr_ip addr<label|sockaddr-ip>>Returns the IP address.
  </description>

  <\description>
    <item*|sockaddr_service addr<label|sockaddr-service>>Returns the service
    (a.k.a. port) name.
  </description>

  <\description>
    <item*|sockaddr_port addr<label|sockaddr-port>>Returns the port number.
  </description>

  <\description>
    <item*|sockaddr_info addr<label|sockaddr-info>>Returns a readable
    description of a socket address, as a <verbatim|(family,hostname,port)>
    tuple. You should be able to pass this into
    <hlink|<with|font-family|tt|sockaddr>|#sockaddr> again to get the
    original address.
  </description>

  <subsubsection|Creating and Closing Sockets><label|creating-and-closing-sockets>

  <\description>
    <item*|socket domain type protocol<label|socket>>Creates a socket for the
    given protocol family (<verbatim|AF_UNIX>, <verbatim|AF_INET> or
    <verbatim|AF_INET6>), socket type (<verbatim|SOCK_STREAM>,
    <verbatim|SOCK_DGRAM>, etc.) and protocol. Note that on Linux we also
    support the <verbatim|SOCK_NONBLOCK> (non-blocking) and
    <verbatim|SOCK_CLOEXEC> (close-on-exec) flags which can be or'ed with the
    socket type to get sockets with the corresponding features. The protocol
    number is usually 0, denoting the default protocol, but it can also be
    any of the prescribed <verbatim|IPPROTO> constants (a few common ones are
    predefined by this module, try <verbatim|show> <verbatim|-g>
    <verbatim|IPPROTO_*> for a list of those).
  </description>

  <\description>
    <item*|socketpair domain type protocol sv<label|socketpair>>Create a pair
    of sockets. The descriptors are returned in the integer vector
    <verbatim|sv> passed in the last argument.
  </description>

  <\description>
    <item*|shutdown fd how<label|shutdown>>Perform shutdown on a socket. The
    second argument should be one of <verbatim|SHUT_RD>, <verbatim|SHUT_WR>
    and <verbatim|SHUT_RDWR>.
  </description>

  <\description>
    <item*|closesocket fd<label|closesocket>>This is provided for Windows
    compatibility. On POSIX systems this is just <verbatim|close>.
  </description>

  <subsubsection|Establishing Connections><label|establishing-connections>

  <\description>
    <item*|accept sockfd addr<label|accept>>
  </description>

  <\description>
    <item*|bind sockfd addr<label|bind>>
  </description>

  <\description>
    <item*|connect sockfd addr<label|connect>>
  </description>

  <\description>
    <item*|listen sockfd backlog<label|listen>>
  </description>

  <subsubsection|Socket I/O><label|socket-i-o>

  <\description>
    <item*|recv fd buf len flags<label|recv>>
  </description>

  <\description>
    <item*|send fd buf len flags<label|send>>
  </description>

  <\description>
    <item*|recvfrom fd buf len flags addr<label|recvfrom>>
  </description>

  <\description>
    <item*|sendto fd buf len flags addr<label|sendto>>
  </description>

  The usual <hlink|<with|font-family|tt|send>|#send>/<hlink|<with|font-family|tt|recv>|#recv>
  flags specified by POSIX (<verbatim|MSG_EOR>, <verbatim|MSG_OOB>,
  <verbatim|MSG_PEEK>, <verbatim|MSG_WAITALL>) are provided. On Linux we also
  support <verbatim|MSG_DONTWAIT>. Note that on POSIX systems you can also
  just <hlink|<with|font-family|tt|fdopen>|purelib.tm#fdopen> the socket
  descriptor and use the standard file I/O operations from the
  <hlink|<with|font-family|tt|system>|purelib.tm#module-system> module
  instead.

  <subsubsection|Socket Information><label|socket-information>

  <\description>
    <item*|getsockname fd addr<label|getsockname>>
  </description>

  <\description>
    <item*|getpeername fd addr<label|getpeername>>
  </description>

  <\description>
    <item*|getsockopt fd level name val len<label|getsockopt>>
  </description>

  <\description>
    <item*|setsockopt fd level name val len<label|setsockopt>>
  </description>

  For <hlink|<with|font-family|tt|getsockopt>|#getsockopt> and
  <hlink|<with|font-family|tt|setsockopt>|#setsockopt>, currently only the
  <verbatim|SOL_SOCKET> level is defined (<verbatim|level> argument) along
  with the available POSIX socket options (<verbatim|name> argument). Try
  <verbatim|show> <verbatim|-g> <verbatim|SO_*> to get a list of those. Also
  note that for most socket level options the <verbatim|val> argument is
  actually an <verbatim|int*>, so you can pass a Pure int vector (with
  <verbatim|len> <verbatim|=> <verbatim|SIZEOF_INT>) for that parameter.

  <subsection|Example><label|example>

  Here is a fairly minimal example using Unix stream sockets. To keep things
  simple, this does no error checking whatsoever and just keeps sending
  strings back and forth. More elaborate examples can be found in the
  examples directory in the sources.

  <\verbatim>
    \;

    using sockets, system;

    \;

    const path = "server_socket";

    extern int unlink(char *name);

    \;

    server = loop with

    \ \ loop = loop if ~null s && ~response fp s when

    \ \ \ \ // Connect to a client.

    \ \ \ \ cfd = accept fd $ sockaddr ();

    \ \ \ \ // Open the client socket as a FILE* and read a request.

    \ \ \ \ fp = fdopen cfd "r+"; s = fgets fp;

    \ \ end;

    \ \ loop = puts "server is exiting" $$ closesocket fd $$

    \ \ \ \ \ \ \ \ \ unlink path $$ () otherwise;

    \ \ response fp s::string = s=="quit\\n" when

    \ \ \ \ // Process the request. (Here we just print the received

    \ \ \ \ // message and echo it back to the client.)

    \ \ \ \ printf "server\<gtr\> %s" s;

    \ \ \ \ fputs s fp;

    \ \ end;

    end when

    \ \ // Create the server socket and start listening.

    \ \ unlink path;

    \ \ fd = socket AF_UNIX SOCK_STREAM 0;

    \ \ bind fd (sockaddr path); listen fd 5;

    \ \ printf "server listening at '%s'\\n" path;

    end;

    \;

    client = loop with

    \ \ // Keep reading requests from stdin.

    \ \ loop = loop if ~null s && ~request s when

    \ \ \ \ fputs "client\<gtr\> " stdout; s = fgets stdin;

    \ \ end;

    \ \ loop = puts "client is exiting" $$ () otherwise;

    \ \ request s::string = s=="quit\\n" when

    \ \ \ \ fd = socket AF_UNIX SOCK_STREAM 0;

    \ \ \ \ connect fd (sockaddr path);

    \ \ \ \ // Send the request to the server.

    \ \ \ \ fp = fdopen fd "r+"; fputs s fp;

    \ \ \ \ // Get the reply.

    \ \ \ \ s = fgets fp;

    \ \ end;

    end;

    \;
  </verbatim>

  To use this example, run the <verbatim|server> function in one instance of
  the Pure interpreter and the <verbatim|client> function in another. Enter a
  line when the client prompts you for input; it will be printed by the
  server. Behind the scenes, the server also sends the line back to the
  client. After receiving the reply, the client prompts for the next input
  line. Entering end-of-file at the client prompt terminates the client but
  keeps the server running, so that you can start another client and
  reconnect to the server. Entering just <verbatim|quit> in the client
  terminates both server and client. Here is how a typical interaction may
  look like:

  <\verbatim>
    \;

    \<gtr\> client;

    client\<gtr\> 1+1

    client\<gtr\> foo bar

    client\<gtr\> quit

    client is exiting

    ()

    \;

    \<gtr\> server;

    server listening at 'server_socket'

    server\<gtr\> 1+1

    server\<gtr\> foo bar

    server\<gtr\> quit

    server is exiting

    ()

    \;
  </verbatim>

  Note that while the server processes requests sequentially, it accepts
  connections from a new client after each request, so that you can run as
  many clients as you like.

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-sockets-toc>

  <\itemize>
    <item><hlink|pure-sockets: Pure Sockets Interface|#>

    <\itemize>
      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <\itemize>
        <item><hlink|Creating and Inspecting Socket
        Addresses|#creating-and-inspecting-socket-addresses>

        <item><hlink|Creating and Closing
        Sockets|#creating-and-closing-sockets>

        <item><hlink|Establishing Connections|#establishing-connections>

        <item><hlink|Socket I/O|#socket-i-o>

        <item><hlink|Socket Information|#socket-information>
      </itemize>

      <item><hlink|Example|#example>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-readline|pure-readline.tm>

  Next topic

  <hlink|pure-stldict|pure-stldict.tm>

  <hlink|toc|#pure-sockets-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-stldict.tm> \|
  <hlink|previous|pure-readline.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2016, Albert Gräf et al. Last updated on Dec
  20, 2016. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
