<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pd-pure-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-audio.tm> \|
  <hlink|previous|pd-faust.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pd-pure: Pd loader for Pure scripts><label|pd-pure-pd-loader-for-pure-scripts>

  Version 0.25, March 18, 2018

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  This is a <hlink|Pure|https://agraef.github.io/pure-lang/> \Ploader
  plugin\Q for <hlink|Pd|http://puredata.info/>, Miller Puckette's graphical
  dataflow programming system for realtime multimedia applications. If you
  are a Pd user, it lets you write external Pd objects in Pure, which is
  generally much more convenient and a lot more fun than having to code Pd
  externals in a comparatively low-level language such as C or C++. If you
  are a Pure user, it provides you with an alternative way to develop and run
  your Pure scripts in one of the best graphical dataflow environments
  available today.

  Pure certainly has its own learning curve, but once mastered, it makes
  programming many kinds of Pd objects a walk in the park. Its Pd interface
  is convenient to use and has livecoding support, i.e., the ability to
  reload Pure externals at any time while your Pd patch keeps running. Pure
  also offers a comprehensive library and many interfaces to third-party
  software useful for implementing Pd objects, such as
  <hlink|Octave|http://www.octave.org/> and Grame's
  <hlink|Faust|http://faust.grame.fr/>.

  But pd-pure isn't limited to just computer music and realtime multimedia
  programming, which are Pd's hallmark applications. It also allows you to
  employ Pd as a graphical dataflow environment for developing and testing
  your Pure programs, leveraging Pd's built-in facilities for creating
  graphical user interfaces for your application, while getting Pd's
  sophisticated realtime multimedia capabilities for free.

  <with|font-series|bold|Note:> Pure is a <em|JIT> (\Pjust in time\Q)
  <em|compiled> language which means that there may be some noticeable
  latencies when the embedded Pure runtime first loads your Pure scripts and
  compiles them on the fly. This shouldn't be much of an issue on most
  contemporary hardware any more, and once the scripts <em|have> been loaded,
  they are executed very efficiently. Nevertheless, as a remedy it is also
  possible to <em|precompile> a collection of Pure objects to a binary
  external library which can be loaded quickly at startup with Pd's
  <verbatim|-lib> option. In addition, pd-pure 0.24+ offers the ability to
  preload Pure <em|source> scripts with the <verbatim|-lib> option at
  startup, so that they don't cause any more hiccups when the objects are
  instantiated later.

  <subsection|Copying><label|copying>

  Copyright (c) 2009-2017 by Albert Graef. pd-pure is distributed under a
  3-clause BSD-style license, please see the included COPYING file for
  details.

  <subsection|Installation><label|installation>

  You'll need Pure 0.50+ and Pd 0.43+. We recommend using Pd versions 0.47.0
  and above, since these offer substantial improvements in Pd's \Ploader\Q
  functionality which pd-pure hooks into to provide Pure object creation.

  Get the latest source from <hlink|https://github.com/agraef/pure-lang/releases/download/pd-pure-0.25/pd-pure-0.25.tar.gz|https://github.com/agraef/pure-lang/releases/download/pd-pure-0.25/pd-pure-0.25.tar.gz>.

  Usually, <verbatim|make> <verbatim|&&> <verbatim|sudo> <verbatim|make>
  <verbatim|install> should do the trick. This will compile the external (you
  need to have GNU make, Pd and Pure installed to do that) and install it in
  the lib/pd/extra/pure directory.

  The Makefile tries to guess the installation prefix under which Pd is
  installed. If it guesses wrong, you can tell it the right prefix with
  <verbatim|make> <verbatim|prefix=/some/path>. Or you can specify the exact
  path of the lib/pd directory with <verbatim|make>
  <verbatim|pdlibdir=/some/path>; by default the Makefile assumes
  <verbatim|$(prefix)/lib/pd>.

  It is also possible to specify an alternative flavor of Pd when building
  and installing the module, by adding a definition like
  <verbatim|PD=pd-extended> to the <verbatim|make> command line. This is
  known to work with <hlink|pd-extended|http://puredata.info/downloads/pd-extended>
  and <hlink|pd-l2ork|http://l2ork.music.vt.edu/main/?page-id=56>, two
  popular alternative Pd distributions available on the web, as well as
  <hlink|pd-l2ork|http://l2ork.music.vt.edu/main/?page-id=56>`s latest
  cross-platform version <hlink|purr-data|https://agraef.github.io/purr-data-intro/>.
  (If you're going with one of these, we recommend using
  <hlink|purr-data|https://agraef.github.io/purr-data-intro/> since it has
  all the latest loader improvements.)

  The Makefile also tries to guess the host system type and Pure version, and
  set up some platform-specific things accordingly. If this doesn't work for
  your system then you'll have to edit the Makefile accordingly.

  MS Windows users please note that there's a binary package available at the
  Pure website, please check the <hlink|Pure on
  Windows|https://github.com/agraef/pure-lang/wiki/PureOnWindows#pd-and-friends>
  wiki page for details. In addition, you will also need an installation of
  the Pure interpreter itself; a corresponding Windows installer can be found
  in the <hlink|download section|https://github.com/agraef/pure-lang/releases>
  of the Pure website as well (look for the latest pure msi package).

  Mac users can find pd-pure and all its dependencies in
  <hlink|MacPorts|http://www.macports.org/>. Please also check the
  <hlink|Pure on Mac OS X|https://github.com/agraef/pure-lang/wiki/PureOnMacOSX#pd-and-friends>
  wiki page for details.

  <subsection|Usage><label|usage>

  After installation, you still have to tell Pd to load the Pure external at
  startup, either with the <verbatim|-lib> option (<verbatim|pd>
  <verbatim|-lib> <verbatim|pure>), or by specifying <verbatim|pure> in Pd's
  startup options. This setting can be saved so that the Pure loader is
  always available when you run Pd. Once the Pure loader has been activated,
  you should see a sign-on message like the following in the Pd main window,
  indicating that the external has been successfully loaded:

  <\verbatim>
    \;

    pd-pure 0.24 (pure-0.64) (c) 2009-2017 Albert Graef
    \<less\>aggraef@gmail.com\<gtr\>

    pd-pure: compiled for pd-0.47 on Feb 21 2017

    \;
  </verbatim>

  Since version 0.12 pd-pure supports the definition of both control and
  signal objects in Pure. The latter are also known as \Ptilde\Q or \Pdsp
  objects\Q in Pd parlance; pd-pure follows the Pd convention in that these
  objects have a trailing tilde in their name. Signal objects are used
  primarily for processing audio signals, whereas control objects are
  employed for asynchronous message processing.

  Simple \Pone-off\Q control objects can be created with the
  <verbatim|[pure]> class which takes the function to be evaluated as its
  argument. For instance:

  <\verbatim>
    \;

    [pure (+5)]

    \;
  </verbatim>

  This object takes numbers as inputs on its single inlet, adds 5 to them and
  outputs the result on its single outlet.

  Similarly, signal objects can be created with <verbatim|[pure~]>. For
  instance, the following object processes incoming vectors of samples,
  multiplying each sample with 2:

  <\verbatim>
    \;

    [pure~ map (*2)]

    \;
  </verbatim>

  Note that in this case the object has actually two inlet/outlet pairs. The
  leftmost inlet/outlet pair is reserved for the processing of control
  messages (not used in this example), while the actual signal input and
  output can be found on the right.

  (Pure objects can also be configured to adjust the number of inlets and
  outlets. This will be described later.)

  The argument of <verbatim|[pure]> and <verbatim|[pure~]> can be any Pure
  expression (including local functions and variables, conditionals, etc.).
  We also refer to these as anonymous Pure objects. If an object is quite
  complicated or used several times in a patch, it is more convenient to
  implement it as a named object instead. To these ends, the object function
  is stored in a corresponding Pure script named after the object. For
  instance, we might put the following <verbatim|add> function into a script
  named add.pure:

  <\verbatim>
    \;

    add x y = x+y;

    \;
  </verbatim>

  Now we can use the following object in a Pd patch:

  <\verbatim>
    \;

    [add 5]

    \;
  </verbatim>

  The Pure loader then recognizes <verbatim|add> as an instance of the object
  implemented by the add.pure file and loads the script into the Pure
  interpreter. The creation parameter <verbatim|5> is passed as the first
  argument <verbatim|x> of the <verbatim|add> function in this example, while
  the <verbatim|y> argument comes from the object's inlet. The function
  performed by this object is thus the same as with <verbatim|[pure>
  <verbatim|(+5)]> above.

  More examples can be found in the pure-help.pd and
  pure<math|\<sim\>>-help.pd patches. These can also be accessed in Pd by
  right-clicking on any Pure object and selecting the <verbatim|Help> option.
  (Recent pd-pure versions also allow you to right-click and select
  <verbatim|Open> to open the script of a named Pure object in a text editor,
  provided that your Pd version supports the <verbatim|menu-open> command.
  Most reasonably recent Pd versions and flavors do.)

  In the following section, we first discuss in detail how <hlink|control
  objects|#control-objects> are defined and used. After that, the necessary
  adjustments for implementing <hlink|signal objects|#signal-objects> are
  explained. Some advanced uses of pd-pure are described under
  <hlink|Advanced Features|#advanced-features>.

  <subsection|Control Objects><label|control-objects>

  Basically, to implement a Pd control object named <verbatim|foo>, all you
  have to do is supply a Pure script named foo.pure which defines a function
  <verbatim|foo> (and anything else that you might need to define the
  function). This function is also called the object function. You can put
  the script containing the object function either in the same directory as
  the Pd patch in which you want to use the <verbatim|foo> object, or
  anywhere on Pd's search path. (The latter is useful if the object is to be
  used in several patches located in different subdirectories. Also note that
  the former requires that you already <em|saved> the Pd patch in the
  directory containing the foo.pure script <em|before> you create a
  <verbatim|foo> object in it, so that the Pure loader finds the script.)

  The script will be executed once, at the time the first object with the
  given name is created, and will be executed in the directory where it is
  located. Thus, if the script needs to import other Pure scripts or load
  some data files, you can put these into the same directory so that the
  object script can find them.

  The <verbatim|foo> function gets evaluated at object creation time,
  receiving any additional parameters the object is created with. The
  resulting Pure expression should be another function which is executed at
  runtime, passing Pd messages from the inlets as parameters, and routing the
  function results to the outlets of the object. This two-stage definition
  process is useful because it allows special processing (such as
  initialization of required data structures) to be done at object creation
  time. However, the result of evaluating <verbatim|foo> can also just be
  <verbatim|foo> itself if no such special processing is needed. If we need
  to distinguish these two stages, we also call the two functions the
  creation and the runtime function of the object, respectively.

  Pd messages are translated to corresponding Pure expressions and vice versa
  in a straightforward fashion. Special support is provided for converting
  between the natural Pd and Pure representations of floating point numbers,
  symbols and lists. The following table summarizes the available
  conversions.

  <tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|3|3|cell-halign|l>|<cwith|1|-1|3|3|cell-rborder|0ln>|<cwith|1|-1|1|-1|cell-valign|c>|<cwith|1|1|1|-1|cell-bborder|1ln>|<table|<row|<cell|Message
  Type>|<cell|Pd>|<cell|Pure>>|<row|<cell|symbol>|<cell|<verbatim|foo>>|<cell|<verbatim|foo>>>|<row|<cell|string>|<cell|<verbatim|a&b>>|<cell|<verbatim|"a&b">>>|<row|<cell|float>|<cell|<verbatim|float>
  <verbatim|1.23>>|<cell|<verbatim|1.23>>>|<row|<cell|list>|<cell|<verbatim|list>
  <verbatim|1> <verbatim|2> <verbatim|3>>|<cell|<verbatim|[1.0,2.0,3.0]>>>|<row|<cell|other>|<cell|<verbatim|foo>
  <verbatim|a> <verbatim|2> <verbatim|3>>|<cell|<verbatim|foo> <verbatim|a>
  <verbatim|2.0> <verbatim|3.0>>>>>>

  Note that Pd symbols which are no valid Pure symbols become strings in
  Pure. Conversely, both symbols and strings in Pure are mapped to
  corresponding Pd symbols. Pure (machine) integers and floating point values
  both become <verbatim|float> messages in Pd. Pd list messages are
  translated to Pure list values, while other aggregate messages are mapped
  to Pure applications (and vice versa).

  <subsubsection|Simple Objects><label|simple-objects>

  By default, a Pure object has just one inlet and one outlet and thus acts
  like a simple function with no internal state. For instance, the following
  object accepts Pd <verbatim|float> messages and adds 5 to each received
  value:

  <\verbatim>
    \;

    add5 x = x+5;

    \;
  </verbatim>

  In the Pd patch each <verbatim|[add5]> object then has a single inlet
  supplying parameters and a single outlet for results of the add5 function.

  <subsubsection|Creation Arguments><label|creation-arguments>

  You can parameterize an object with creation arguments, which are passed to
  the Pure function at object creation time. For instance:

  <\verbatim>
    \;

    add x y = x+y;

    \;
  </verbatim>

  This object can then be invoked, e.g., as <verbatim|[add> <verbatim|5]> in
  the Pd patch to supply the needed creation argument <verbatim|x>. Please
  note that only a fixed number of creation arguments can be processed this
  way. However, the Pure loader also provides a mechanism to handle a
  variable number of creation arguments, see <hlink|Variadic Creation
  Functions|#variadic-creation-functions> below.

  <subsubsection|The [pure] Object><label|the-pure-object>

  For simple kinds of objects like the above, the Pure loader provides the
  generic <verbatim|[pure]> object as a quick means to create Pure control
  objects without actually preparing a script file. The creation parameter of
  <verbatim|[pure]> is the object function. This can be a predefined Pure
  function, or you can define it on the fly in a <verbatim|with> clause. You
  can also just load additional script files defining the functions you use
  with <verbatim|[pure]>; see <hlink|Controlling the
  Runtime|#controlling-the-runtime> and <hlink|Loading Script Files at
  Startup|#loading-script-files-at-startup> for details.

  For instance, <verbatim|[pure> <verbatim|succ]> uses the predefined Pure
  function <verbatim|succ> which adds 1 to its input, while the object
  <verbatim|[pure> <verbatim|add> <verbatim|5> <verbatim|with> <verbatim|add>
  <verbatim|x> <verbatim|y> <verbatim|=> <verbatim|x+y> <verbatim|end]>
  produces the same results as the <verbatim|[add> <verbatim|5]> object
  defined using a separate add.pure script in the previous section. You can
  also generate constant values that way. E.g., the object <verbatim|[pure>
  <verbatim|cst> <verbatim|1.618]> responds to any message (such as
  <verbatim|bang>) by producing the constant value 1.618, while the object
  <verbatim|[pure> <verbatim|cst> <verbatim|[1..10]]> yields the constant
  list containing the numbers 1..10.

  <subsubsection|Configuring Inlets and Outlets><label|configuring-inlets-and-outlets>

  To create an object with multiple inlets and outlets for control messages,
  the object creation function must return the desired numbers of inlets and
  outlets, along with a second function to be applied at runtime, as a tuple
  <verbatim|n,m,foo>. The input arguments to the runtime function as well as
  the corresponding function results are then encoded as pairs
  <verbatim|k,val> where <verbatim|k> denotes the inlet or outlet index.
  (Note that the <verbatim|k> index is provided only if there actually is
  more than one inlet. Also, the outlet index is assumed to be zero if none
  is specified, so that it can be omitted if there's only one outlet.)

  For instance, the following object, invoked as <verbatim|[cross]> in the Pd
  patch, has two inlets and two outlets and routes messages from the left
  inlet to the right outlet and vice versa:

  <\verbatim>
    \;

    cross = 2,2,cross with cross (k,x) = (1-k,x) end;

    \;
  </verbatim>

  You can also emit multiple messages, possibly to different outlets, in one
  go. These must be encoded as Pure vectors (or matrices) of values or
  <verbatim|index,value> pairs, which are emitted in the order in which they
  are written. E.g., the following <verbatim|[fan]> object implements an
  \Pn-fan\Q which routes its input to <verbatim|n> outlets simultaneously:

  <\verbatim>
    \;

    fan n = 1,n,fan with fan x = reverse {k,x \| k = 0..n-1} end;

    \;
  </verbatim>

  (Note that, because of the use of <verbatim|reverse>, the <verbatim|n>
  outlets are served in right-to-left order here. This is not strictly
  necessary, but matches the Pd convention.)

  Another example is the following <verbatim|[dup]> object with a single
  inlet and outlet, which just sends out each received message twice:

  <\verbatim>
    \;

    dup x = {x,x};

    \;
  </verbatim>

  Note that this is different from the following, which outputs a list value
  to the outlet instead:

  <\verbatim>
    \;

    dup2 x = [x,x];

    \;
  </verbatim>

  (Also, please note that this behaviour is new in pd-pure 0.14. Previously,
  a list return value by itself would output multiple values instead.
  However, this made it very awkward to deal with Pd list values in pd-pure,
  and so as of pd-pure 0.14 Pure matrices must now be used to output multiple
  values.)

  An object can also just \Pswallow\Q messages and generate no output at all.
  To these ends, make the object return either an empty vector <verbatim|{}>
  or the empty tuple <verbatim|()>. (Note that, in contrast, returning the
  empty list <verbatim|[]> does send a value back to Pd, namely an empty list
  value.) For instance, the following object <verbatim|[echo]> implements a
  sink which just prints received messages on standard output, which is
  useful for debugging purposes:

  <\verbatim>
    \;

    using system;

    echo x = () when puts (str x) end;

    \;
  </verbatim>

  You could also implement this object as follows, by just removing the
  superflous outlet (in this case all return values from the function will be
  ignored anyway):

  <\verbatim>
    \;

    using system;

    echo = 1,0,puts.str;

    \;
  </verbatim>

  <subsubsection|Variadic Creation Functions><label|variadic-creation-functions>

  Sometimes you may wish to implement an object which accepts a variable
  number of creation arguments. To these ends, the creation function
  <verbatim|foo> may return an application of the form <verbatim|varargs>
  <verbatim|bar>. In this case, the function <verbatim|bar> becomes the
  actual object creation function which is applied to a single argument, the
  list of all supplied creation arguments. For instance, if you invoke
  <verbatim|foo> through an object like <verbatim|[foo> <verbatim|a>
  <verbatim|b> <verbatim|c]> in a patch, the loader would then create the
  object by calling <verbatim|bar> <verbatim|[a,b,c]> instead. Likewise, if
  the object gets created without any arguments at all, i.e.,
  <verbatim|[foo]>, then <verbatim|bar> would be called as <verbatim|bar>
  <verbatim|[]>. The function <verbatim|bar> may then be used as the runtime
  function of the object, or it may yield the object function to be used,
  along with the desired number of inlets and outlets, as described in the
  previous subsection. This makes it possible to configure the inlets and
  outlets of the object according to the number and values of the supplied
  creation arguments, pretty much like some of the built-in Pd objects do,
  such as <verbatim|pack> and <verbatim|sel>.

  For instance, here is how you could implement something like Pd's built-in
  <verbatim|sel> object in Pure. The object compares its input against a
  number of values given as creation arguments, and bangs the corresponding
  outlet if it is found, or passes on the input on the rightmost outlet
  otherwise:

  <\verbatim>
    \;

    mysel = varargs mysel with

    \ \ mysel xs = 1,#xs+1,mysel with

    \ \ \ \ mysel x = i,bang if i\<less\>#xs when i = #takewhile (~==x) xs
    end;

    \ \ \ \ \ \ \ \ \ \ \ \ = #xs,x otherwise;

    \ \ end;

    end;

    \;
  </verbatim>

  Note that the runtime function is the innermost local <verbatim|mysel>
  function (at line 3 in the example). The outermost local <verbatim|mysel>
  function (at line 2) is the actual creation function which gets invoked by
  the loader on the list of all creation arguments; here it yields the number
  of inlets and outlets (where the latter depends on the number of creation
  arguments) along with the runtime function. You can invoke this object as,
  e.g., <verbatim|[mysel> <verbatim|a> <verbatim|b> <verbatim|c]>, in which
  case there will be four outlets, one for each given value and one for the
  rightmost \Pdefault\Q outlet.

  <subsubsection|Local State><label|local-state>

  Local state can be kept in Pure reference values. For instance, the
  following <verbatim|[mycounter]> object produces the next counter value
  when receiving a <verbatim|bang> message:

  <\verbatim>
    \;

    nonfix bang;

    mycounter = next (ref 0) with

    \ \ next r bang = put r (get r+1);

    \ \ next _ _ \ \ \ = () otherwise;

    end;

    \;
  </verbatim>

  Note that the state is kept as an additional first parameter to the local
  function <verbatim|next> here. Alternatively, you can also make the state a
  local variable of <verbatim|mycounter>:

  <\verbatim>
    \;

    nonfix bang;

    mycounter = next with

    \ \ next bang = put r (get r+1);

    \ \ next _ \ \ \ = () otherwise;

    end when r = ref 0 end;

    \;
  </verbatim>

  <subsection|Signal Objects><label|signal-objects>

  If the name of a Pure object (i.e., the basename of the corresponding Pure
  script) ends with the <verbatim|~> character, pd-pure assumes that it
  denotes a signal object whose primary purpose is to process sample data.
  The basic setup is similar to the case of control objects, with the
  following differences:

  <\itemize>
    <item>The object function for a signal object <verbatim|xyz~> is named
    <verbatim|xyz_dsp> (rather than <verbatim|xyz>). The function is defined
    in the <verbatim|xyz~.pure> script file, which must be located in the
    same directory as the Pd patch or anywhere on Pd's search path.

    <item>To keep things simple, a Pure signal object is always equipped with
    exactly one control inlet and one control outlet, which are the leftmost
    inlet and outlet of the object. These can be used to process control
    messages in the usual fashion, in addition to the audio processing
    performed by the object.

    <item>Any additional inlets and outlets of the object are signal inlets
    and outlets. By default, one signal inlet/outlet pair will be provided.
    Configuring a custom number of signal inlets and outlets works as with
    control objects. In this case the object creation function must return a
    triple <verbatim|n,m,foo> where <verbatim|n> and <verbatim|m> are the
    desired number of signal inlets and outlets, respectively, and
    <verbatim|foo> is the actual processing function to be invoked at
    runtime.
  </itemize>

  <with|font-series|bold|Note:> pd-pure's convention of placing the control
  inlet/outlet pair of a signal object on the left is somewhat at odds with
  most other signal objects in Pd, which typically have a (main) signal
  inlet/outlet on the left and the control inlets and outlets on the right.
  However, we think that this kind of setup makes the most sense for Pure
  signal objects, since the control inlet/outlet pair will always be there in
  the same position, whereas the signal inlets and outlets may vary (and
  might actually not be present at all, e.g., if the sole purpose of a signal
  object is to have some code executed for each \Pdsp tick\Q).

  Whenever Pd has audio processing enabled, the object function is invoked
  with one block of sample data for each iteration of Pd's audio loop. The
  sample data is encoded as a double matrix which has one row for each signal
  inlet of the object; row 0 holds the sample data for the first signal
  inlet, row 1 the sample data for the second signal inlet, etc. The row size
  corresponds to Pd's block size which indicates how many samples per signal
  connection is processed in one go for each iteration of the audio loop.
  (Usually the default block size is 64, but this can be changed with Pd's
  <verbatim|-blocksize> option and also on a per-window basis using the
  <verbatim|block~> object, see the Pd documentation for details.) Note that
  the input matrix will have zero rows if the object has zero signal inlets,
  in which case the row size of the matrix (as reported by the
  <hlink|<with|font-family|tt|dim>|purelib.tm#dim> function) still indicates
  the block size.

  When invoked with a signal matrix as argument, the object function should
  return another double matrix with the resulting sample data for the signal
  outlets of the object, which normally has one row per outlet and the same
  row size as the input matrix. (A lack or surplus of samples in the output
  matrix is handled gracefully, however. Missing samples are filled with
  zeros, while extra samples are silently ignored.)

  For instance, here's a simple object with the default single signal
  inlet/outlet pair (in addition to the leftmost control inlet/outlet pair,
  which isn't used in this example). This object just multiplies its input
  signal by 2:

  <\verbatim>
    \;

    mul2_dsp x::matrix = map (*2) x;

    \;
  </verbatim>

  This code would then be placed into a script file named
  <verbatim|mul2~.dsp> and invoked in Pd as an object of the form
  <verbatim|[mul2~]>.

  As with control objects, there's a shortcut to create simple objects like
  these without preparing a script file, using the built-in
  <verbatim|[pure~]> object. Thus the dsp function in the previous example
  could also be implemented using an object of the form <verbatim|[pure~>
  <verbatim|map> <verbatim|(*2)]> (which uses the same function, albeit in
  curried form).

  Creation parameters can also be used in the same way as with control
  objects. The following object is to be invoked in Pd as <verbatim|[mul~>
  <verbatim|f]> where <verbatim|f> is the desired gain factor.

  <\verbatim>
    \;

    mul_dsp f::double x::matrix = map (*f) x;

    \;
  </verbatim>

  Next, let's try a custom number of signal inlets and outlets. The following
  object has two signal inlets and one signal outlet. Like Pd's built-in
  <verbatim|[*~]> object, it multiplies the two input signals, producing an
  amplitude (or ring) modulation effect:

  <\verbatim>
    \;

    sigmul_dsp = 2,1,sigmul with

    \ \ sigmul x::matrix = zipwith (*) (row x 0) (row x 1);

    end;

    \;
  </verbatim>

  Here's another example which takes no inputs and produces one output
  signal, a random wave (i.e., white noise). Note the use of the
  <hlink|<with|font-family|tt|dim>|purelib.tm#dim> function to determine the
  number of samples to be generated for each block.

  <\verbatim>
    \;

    extern double genrand_real1() = random1;

    randomwave1_dsp = 0,1,randomwave with

    \ \ randomwave in::matrix = {random \| i=1..n} when _,n = dim in end;

    \ \ random = random1*2-1;

    end;

    \;
  </verbatim>

  Control messages for the control outlet of the object may be added by
  returning a pair <verbatim|sig,msg> where <verbatim|sig> is the output
  signal matrix and <verbatim|msg> is a single control message or vector of
  such messages (using the same format as with control objects). The signal
  matrix can also be omitted if no signal output is needed (unless the
  control data takes the form of a double matrix, which would be interpreted
  as signal data; in such a case you'd have to specify an empty signal matrix
  instead). The object function may also return <verbatim|()> if neither
  signal nor control output is required. (This may be the case, e.g., for
  dsps which just analyze the incoming signal data and store the results
  somewhere for later retrieval.)

  Signal objects can also process control messages and generate responses on
  the leftmost inlet/outlet pair as usual. This is commonly used to set and
  retrieve various control parameters used or generated by the audio
  processing part of the object.

  For instance, here is a signal object which plays back a soundfile using
  the <verbatim|sndfile> module (cf. <hlink|<em|pure-audio>|pure-audio.tm>).
  The object function reads the entire file (whose name is passed as a
  creation argument) at creation time and turns over processing to the
  <verbatim|playsf> function which returns one block of samples from the file
  (along with the current position of the playback pointer) for each
  invocation with an (empty) input matrix. In addition, a <verbatim|bang>
  message is output when the end of the file is reached. The object also
  responds to floating point values in the range from 0 to 1 on the control
  inlet by adjusting the playback pointer accordingly.

  <\verbatim>
    \;

    using sndfile;

    \;

    nonfix bang;

    \;

    playsf_dsp name = 0,nchannels,playsf with

    \ \ // Play one block of samples. Also output a number in the range 0..1
    on the

    \ \ // control outlet to indicate the current position.

    \ \ playsf x::matrix = block,get pos/nsamples when

    \ \ \ \ _,n = dim x; block = submat buf (0,get pos) (nchannels,n);

    \ \ \ \ put pos (get pos+n);

    \ \ end if get pos\<gtr\>=0 && get pos\<less\>=nsamples;

    \ \ // Output a bang once to indicate that we're done.

    \ \ playsf x::matrix = bang when

    \ \ \ \ _,n = dim x; put pos (-1);

    \ \ end if get pos\<gtr\>=0;

    \ \ playsf _::matrix = ();

    \ \ // A number in the range 0..1 places the playback pointer
    accordingly.

    \ \ playsf x::double = put pos $ int $ round $ x*nsamples $$ ();

    end when

    \ \ // Open the audio file for reading.

    \ \ info = sf_info (); sf = sf_open name SFM_READ info;

    \ \ // Get some information about the file.

    \ \ nsamples,rate,nchannels,_ = sf_get_info info;

    \ \ nsamples = int nsamples;

    \ \ // Read the file into memory.

    \ \ buf = dmatrix (nsamples,nchannels);

    \ \ nsamples = int $ sf_readf_double sf buf nsamples;

    \ \ // Convert interleaved samples (nsamples x nchannels) to one channel
    per row

    \ \ // (nchannels x nsamples).

    \ \ buf = transpose buf;

    \ \ // Initialize the playback pointer:

    \ \ pos = ref 0;

    end;

    \;
  </verbatim>

  As another example, here's a complete stereo amplifier stage with bass,
  treble, gain and balance controls and a dB meter. The dsp part is
  implemented in <hlink|Faust|http://faust.grame.fr/>, Grame's functional dsp
  programming language. The Pure program just does the necessary interfacing
  to Pd, which includes processing of incoming control messages for setting
  the control parameters of the Faust dsp, and the generation of output
  control messages to send the dB meter values (also computed in the Faust
  dsp) to Pd. (To run this example, you need the \Pfaust2\Q branch of the
  Faust compiler so that the dsp can be inlined into the Pure program. Note
  that the entire section inside the <verbatim|%\<> <verbatim|%\>> braces is
  Faust code.)

  <\verbatim>
    \;

    %\<less\> -*- dsp:amp -*-

    \;

    import("math.lib");

    import("music.lib");

    \;

    /* Fixed bass and treble frequencies. You might want to tune these for
    your

    \ \ \ setup. */

    \;

    bass_freq \ \ \ \ \ \ = 300;

    treble_freq \ \ \ \ = 1200;

    \;

    /* Bass and treble gain controls in dB. The range of +/-20 corresponds to
    a

    \ \ \ boost/cut factor of 10. */

    \;

    bass_gain \ \ \ \ \ \ = nentry("bass", 0, -20, 20, 0.1);

    treble_gain \ \ \ \ = nentry("treble", 0, -20, 20, 0.1);

    \;

    /* Gain and balance controls. */

    \;

    gain \ \ \ \ \ \ \ \ \ \ \ = db2linear(nentry("gain", 0, -96, 96, 0.1));

    bal \ \ \ \ \ \ \ \ \ \ \ \ = hslider("balance", 0, -1, 1, 0.001);

    \;

    /* Balance a stereo signal by attenuating the left channel if balance is
    on

    \ \ \ the right and vice versa. I found that a linear control works best
    here. */

    \;

    balance \ \ \ \ \ \ \ \ = *(1-max(0,bal)), *(1-max(0,0-bal));

    \;

    /* Generic biquad filter. */

    \;

    filter(b0,b1,b2,a0,a1,a2) \ \ \ \ \ \ = f : (+ ~ g)

    with {

    \ \ \ \ \ \ \ \ f(x) \ \ \ = (b0/a0)*x+(b1/a0)*x'+(b2/a0)*x'';

    \ \ \ \ \ \ \ \ g(y) \ \ \ = 0-(a1/a0)*y-(a2/a0)*y';

    };

    \;

    /* Low and high shelf filters, straight from Robert Bristow-Johnson's
    "Audio

    \ \ \ EQ Cookbook", see http://www.musicdsp.org/files/Audio-EQ-Cookbook.txt.
    f0

    \ \ \ is the shelf midpoint frequency, g the desired gain in dB. S is the
    shelf

    \ \ \ slope parameter, we always set that to 1 here. */

    \;

    low_shelf(f0,g) \ \ \ \ \ \ \ \ = filter(b0,b1,b2,a0,a1,a2)

    with {

    \ \ \ \ \ \ \ \ S \ = 1;

    \ \ \ \ \ \ \ \ A \ = pow(10,g/40);

    \ \ \ \ \ \ \ \ w0 = 2*PI*f0/SR;

    \ \ \ \ \ \ \ \ alpha = sin(w0)/2 * sqrt( (A + 1/A)*(1/S - 1) + 2 );

    \;

    \ \ \ \ \ \ \ \ b0 = \ \ \ A*( (A+1) - (A-1)*cos(w0) + 2*sqrt(A)*alpha );

    \ \ \ \ \ \ \ \ b1 = \ 2*A*( (A-1) - (A+1)*cos(w0)
    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ );

    \ \ \ \ \ \ \ \ b2 = \ \ \ A*( (A+1) - (A-1)*cos(w0) - 2*sqrt(A)*alpha );

    \ \ \ \ \ \ \ \ a0 = \ \ \ \ \ \ \ (A+1) + (A-1)*cos(w0) +
    2*sqrt(A)*alpha;

    \ \ \ \ \ \ \ \ a1 = \ \ -2*( (A-1) + (A+1)*cos(w0)
    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ );

    \ \ \ \ \ \ \ \ a2 = \ \ \ \ \ \ \ (A+1) + (A-1)*cos(w0) -
    2*sqrt(A)*alpha;

    };

    \;

    high_shelf(f0,g) \ \ \ \ \ \ \ = filter(b0,b1,b2,a0,a1,a2)

    with {

    \ \ \ \ \ \ \ \ S \ = 1;

    \ \ \ \ \ \ \ \ A \ = pow(10,g/40);

    \ \ \ \ \ \ \ \ w0 = 2*PI*f0/SR;

    \ \ \ \ \ \ \ \ alpha = sin(w0)/2 * sqrt( (A + 1/A)*(1/S - 1) + 2 );

    \;

    \ \ \ \ \ \ \ \ b0 = \ \ \ A*( (A+1) + (A-1)*cos(w0) + 2*sqrt(A)*alpha );

    \ \ \ \ \ \ \ \ b1 = -2*A*( (A-1) + (A+1)*cos(w0)
    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ );

    \ \ \ \ \ \ \ \ b2 = \ \ \ A*( (A+1) + (A-1)*cos(w0) - 2*sqrt(A)*alpha );

    \ \ \ \ \ \ \ \ a0 = \ \ \ \ \ \ \ (A+1) - (A-1)*cos(w0) +
    2*sqrt(A)*alpha;

    \ \ \ \ \ \ \ \ a1 = \ \ \ 2*( (A-1) - (A+1)*cos(w0)
    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ );

    \ \ \ \ \ \ \ \ a2 = \ \ \ \ \ \ \ (A+1) - (A-1)*cos(w0) -
    2*sqrt(A)*alpha;

    };

    \;

    /* The tone control. We simply run a low and a high shelf in series here.
    */

    \;

    tone \ \ \ \ \ \ \ \ \ \ \ = low_shelf(bass_freq,bass_gain)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ : high_shelf(treble_freq,treble_gain);

    \;

    /* Envelop follower. This is basically a 1 pole LP with configurable
    attack/

    \ \ \ release time. The result is converted to dB. You have to set the
    desired

    \ \ \ attack/release time in seconds using the t parameter below. */

    \;

    t \ \ \ \ \ \ \ \ \ \ \ \ \ \ = 0.1; \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ //
    attack/release time in seconds

    g \ \ \ \ \ \ \ \ \ \ \ \ \ \ = exp(-1/(SR*t)); \ \ \ \ \ \ //
    corresponding gain factor

    \;

    env \ \ \ \ \ \ \ \ \ \ \ \ = abs : *(1-g) : + ~ *(g) : linear2db;

    \;

    /* Use this if you want the RMS instead. Note that this doesn't really

    \ \ \ calculate an RMS value (you'd need an FIR for that), but in
    practice our

    \ \ \ simple 1 pole IIR filter works just as well. */

    \;

    rms \ \ \ \ \ \ \ \ \ \ \ \ = sqr : *(1-g) : + ~ *(g) : sqrt : linear2db;

    sqr(x) \ \ \ \ \ \ \ \ \ = x*x;

    \;

    /* The dB meters for left and right channel. These are passive controls.
    */

    \;

    left_meter(x) \ \ = attach(x, env(x) : hbargraph("left", -96, 10));

    right_meter(x) \ = attach(x, env(x) : hbargraph("right", -96, 10));

    \;

    /* The main program of the Faust dsp. */

    \;

    process \ \ \ \ \ \ \ \ = (tone, tone) : (_*gain, _*gain) : balance

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ : (left_meter, right_meter);

    %\<gtr\>

    \;

    // These are provided by the Pd runtime.

    extern float sys_getsr(), int sys_getblksize();

    // Provide some reasonable default values in case the above are missing.

    sys_getsr = 48000; sys_getblksize = 64;

    \;

    // Get Pd's default sample rate and block size.

    const SR = int sys_getsr;

    const n = sys_getblksize;

    \;

    using faustui;

    \;

    amp_dsp = k,l,amp with

    \ \ // The dsp part. This also outputs the left and right dbmeter values
    for

    \ \ // each processed block of samples on the control outlet, using
    messages of

    \ \ // the form left \<less\>value\<gtr\> and right \<less\>value\<gtr\>,
    respectively.

    \ \ amp in::matrix = amp::compute dsp n in out $$

    \ \ \ \ out,{left (get_control left_meter),right (get_control
    right_meter)};

    \ \ // Respond to control messages of the form \<less\>control\<gtr\>
    \<less\>value\<gtr\>. \<less\>control\<gtr\> may

    \ \ // be any of the input controls supported by the Faust program (bass,

    \ \ // treble, gain, etc.).

    \ \ amp (c@_ x::double) = put_control (ui!str c) x $$ x;

    end when

    \ \ // Initialize the dsp.

    \ \ dsp = amp::newinit SR;

    \ \ // Get the number of inputs and outputs and the control variables.

    \ \ k,l,ui = amp::info dsp;

    \ \ ui = control_map $ controls ui;

    \ \ {left_meter,right_meter} = ui!!["left","right"];

    \ \ // Create a buffer large enough to hold the output from the dsp.

    \ \ out = dmatrix (l,n);

    end;

    \;
  </verbatim>

  Note that it is possible to load the above Faust program directly in Pd,
  using the facilities described in <hlink|<em|faust2pd: Pd Patch Generator
  for Faust>|faust2pd.tm>. This is also more efficient since it avoids the
  overhead of the extra Pure layer. However, invoking Faust dsps via Pure
  also offers some benefits. In particular, it enables you to add more
  sophisticated control processing, interface to other 3rd party software for
  additional pre- and postprocessing of the signal data, or do live editing
  of Faust programs using the facilities described in
  <hlink|Livecoding|#livecoding> below. An actual Pure implementation of a
  Faust external which does all this <em|and> provides the extra conveniences
  of faust2pd under one hood can be found in
  <hlink|<em|pd-faust>|pd-faust.tm>.

  <subsection|Advanced Features><label|advanced-features>

  This section discusses some advanced features of the Pd Pure loader. It
  explains the use of timer callbacks, \Pwireless\Q connections
  (send/receive), wave arrays, and the runtime control and livecoding
  facilities. We also give an overview of the API provided for pd-pure
  programmers.

  <subsubsection|Asynchronous Messages><label|asynchronous-messages>

  pd-pure provides a simple asynchronous messaging facility which allows a
  Pure object to schedule a message to be delivered to itself later. This is
  useful for implementing all kinds of delays and, more generally, any kind
  of object which, once triggered, does its own sequencing of control
  messages.

  To these ends, the object function may return a special message of the form
  <verbatim|pd_delay> <verbatim|t> <verbatim|msg> (either by itself or as an
  element of a result list) to indicate that the message <verbatim|msg>
  should be delivered to the object function after <verbatim|t> milliseconds
  (where <verbatim|t> is either a machine int or a double value). After the
  prescribed delay the object function will then be invoked on the given
  message, and the results of this call are processed as usual (routing
  messages to outlets and/or scheduling new timer events in response to
  further <verbatim|pd_delay> messages). Note that if the delay is zero or
  negative, the message is scheduled to be delivered immediately.

  For instance, a simple kind of delay object can be implemented in Pure as
  follows:

  <\verbatim>
    \;

    mydelay _ (alarm msg) = msg;

    mydelay t msg = pd_delay t (alarm msg) otherwise;

    \;
  </verbatim>

  The desired delay time is specified as a creation argument. The first
  equation handles messages of the form <verbatim|alarm> <verbatim|msg>; the
  action is to just output the delayed message given by the <verbatim|msg>
  argument. All other input messages are scheduled by the second equation,
  which wraps the message in an <verbatim|alarm> term so that it gets
  processed by the first equation when it is delivered.

  Note that pd-pure only allows you to schedule a single asynchronous event
  per call of the object function. Thus, if the <verbatim|mydelay> object
  above receives another message while it is still waiting for the previous
  one to be delivered, the old timer is cancelled and the new one is
  scheduled instead; this works like Pd's builtin <verbatim|delay> object.

  Moreover, scheduling a new event at an infinite (or <verbatim|nan>) time
  value cancels any existing timer. (Note that you still have to specify the
  <verbatim|msg> parameter, but it will be ignored in this case.) We can use
  this to equip our <verbatim|mydelay> object with a <verbatim|stop> message
  as follows:

  <\verbatim>
    \;

    nonfix stop;

    mydelay _ (alarm msg) = msg;

    mydelay _ stop = pd_delay inf ();

    mydelay t msg = pd_delay t (alarm msg) otherwise;

    \;
  </verbatim>

  More elaborate functionality can be built on top of the basic timer
  facility. The following example shows how to maintain a timed message queue
  in a Pure list, in order to implement a simple delay line similar to Pd's
  builtin <verbatim|pipe> object. Here we also employ the
  <hlink|<with|font-family|tt|pd_time()>|#pd-time> function, which is
  provided by the Pure loader so that Pure scripts can access the current
  logical Pd time in milliseconds (see <hlink|Programming
  Interface|#programming-interface> below). This is convenient if we need to
  deal with absolute time values, which we use in this example to keep track
  of the times at which messages in the queue are to be delivered:

  <\verbatim>
    \;

    extern double pd_time();

    mypipe t = process (ref []) with

    \ \ process q () = case dequeue q of

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ x,(t,_):_ = {x,pd_delay (t-pd_time)
    ()};

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ x,_ = x;

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ end;

    \ \ process q x \ = enqueue q x $$ pd_delay t () if null (get q);

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ = enqueue q x $$ () otherwise;

    \ \ enqueue q x \ = put q $ get q+[(pd_time+t,x)];

    \ \ dequeue q \ \ \ = x,put q xs when (_,x):xs = get q end;

    end;

    \;
  </verbatim>

  <subsubsection|Wireless Messaging><label|wireless-messaging>

  As of version 0.14, pd-pure offers some facilities for sending and
  receiving messages directly, without any wired connections to the inlets
  and outlets of an object (similar to what the Pd <verbatim|[send]> and
  <verbatim|[receive]> objects provide). See the description for the
  <hlink|<with|font-family|tt|pd_send()>|#pd-send> and
  <hlink|<with|font-family|tt|pd_receive()>|#pd-receive> routines in the
  <hlink|Programming Interface|#programming-interface> section.

  For instance, here's how you can use the <verbatim|pd_send> function to
  send messages to the Pd runtime:

  <\verbatim>
    \;

    pd_send "pd" (dsp 1); // turn on audio processing

    \;
  </verbatim>

  This function also enables you to perform dynamic patching, by sending the
  appropriate messages to patches (i.e., <verbatim|"pd-patch"> receivers,
  where <verbatim|patch> is the name of the target patch). Useful messages to
  patches are listed in the <hlink|Tips and
  Tricks|http://puredata.info/docs/tutorials/TipsAndTricks#patch-messages>
  section on the Pd community website, and some examples can be found
  <hlink|here|http://pure-data.svn.sourceforge.net/svnroot/pure-data/trunk/doc/additional/pd-msg/>.
  For instance, the following Pure object, when banged, inserts a few objects
  into a subpatch named <verbatim|test> and connects them to each other:

  <\verbatim>
    \;

    extern void pd_send(char*, expr*);

    \;

    pd_send_test _ = () when

    \ \ pd_send "pd-test" (obj 10 0 "osc~" 220);

    \ \ pd_send "pd-test" (obj 10 30 "*~" 0.1);

    \ \ pd_send "pd-test" (obj 10 60 "dac~");

    \ \ pd_send "pd-test" (connect 0 0 1 0);

    \ \ pd_send "pd-test" (connect 1 0 2 0);

    \ \ pd_send "pd-test" (connect 1 0 2 1);

    end;

    \;
  </verbatim>

  An object can also receive messages from any named source by means of the
  <verbatim|pd_receive> function. This function must be called either at
  object creation time or when one of the dsp or control processing methods
  of the object is invoked. For instance, the following object calls
  <verbatim|pd_receive> at creation time in order to receive messages sent to
  the <verbatim|left> and <verbatim|right> receivers, and outputs them on its
  left or right outlet, respectively:

  <\verbatim>
    \;

    extern void pd_receive(char*);

    \;

    pd_receive_test = 1,2,process with

    \ \ process (left x) = 0,x;

    \ \ process (right x) = 1,x;

    end when

    \ \ do pd_receive ["left","right"];

    end;

    \;
  </verbatim>

  Please note that <verbatim|pd_receive> itself doesn't return any message,
  it merely registers a receiver symbol so that messages sent to that symbol
  may be received later. The received messages are always delivered to the
  leftmost inlet when Pd does its control processing. Moreover, the symbol
  identifying the source of the message is applied to the message itself, so
  that the receiver can figure out where the message came from and adjust
  accordingly. This operation is useful, in particular, to provide
  communication channels between Pd GUI elements and Pure objects. Wireless
  connections are often preferred in such cases, to reduce display clutter.

  <subsubsection|Reading and Writing Audio
  Data><label|reading-and-writing-audio-data>

  Besides the realtime processing of audio data, Pd also provides a means to
  store sample data in arrays which can be displayed in a patch and modified
  interactively, see the section on numeric arrays in the Pd documentation
  for details. Arrays can be used, e.g., as running waveform displays, as
  wavetables which are played back in the audio loop, or as waveshaping
  functions used to implement distortion effects.

  Each array has a name (Pd symbol) under which it can be accessed from Pure
  code. pd-pure makes it possible to transfer audio data directly between Pd
  arrays and Pure double vectors by means of the
  <hlink|<with|font-family|tt|pd_getbuffer()>|#pd-getbuffer> and
  <hlink|<with|font-family|tt|pd_setbuffer()>|#pd-setbuffer> routines. Please
  see <hlink|Programming Interface|#programming-interface> below for a closer
  description of the provided routines.

  For instance, here is a <verbatim|randomwave> object which fills a Pd array
  (whose name is given as the creation argument) with random values in
  response to a <verbatim|bang> message:

  <\verbatim>
    \;

    extern double genrand_real1() = random1;

    \;

    extern int pd_getbuffersize(char *name);

    extern void pd_setbuffer(char *name, expr *x);

    \;

    nonfix bang;

    \;

    randomwave name = 1,0,process with

    \ \ process bang \ = pd_setbuffer name {random \| i = 1..nsamples};

    \ \ nsamples \ \ \ \ \ = pd_getbuffersize name;

    \ \ random \ \ \ \ \ \ \ = random1*2-1;

    end;

    \;
  </verbatim>

  <subsubsection|Controlling the Runtime><label|controlling-the-runtime>

  pd-pure provides a predefined <verbatim|[pure-runtime]> object which makes
  it possible to control the embedded Pure interpreter in some ways. There
  can be any number of <verbatim|[pure-runtime]> objects in a patch, which
  all refer to the same instance of the Pure interpreter.

  First and foremost, the <verbatim|[pure-runtime]> object accepts some
  control messages which can be used to dynamically reload all loaded
  scripts, and to implement \Premote control\Q of a patch using the
  <with|font-series|bold|pdsend> program. This is described in more detail in
  the <hlink|Livecoding|#livecoding> subsection.

  The second use of <verbatim|[pure-runtime]> is to load additional Pure
  scripts. To these ends, <verbatim|[pure-runtime]> can be invoked with the
  names of scripts to be loaded at object creation time as arguments. The
  script names should be specified without the <verbatim|.pure> suffix; it
  will be added automatically. The scripts will be searched for in the
  directory of the patch containing the <verbatim|[pure-runtime]> object and
  on the Pd path. For instance, to load the scripts <verbatim|foo.pure> and
  <verbatim|bar.pure>, you can add the following object to your patch:

  <\verbatim>
    \;

    [pure-runtime foo bar]

    \;
  </verbatim>

  This facility can be used, in particular, to load any additional scripts
  needed for anonymous objects defined with <verbatim|[pure]> and
  <verbatim|[pure~]>. Note that you shouldn't use this to load named Pure
  objects, you should let the Pure loader handle these as it also keeps track
  of the scripts in <hlink|livecoding|#livecoding>. Another caveat is that
  you <em|must> ensure that the <verbatim|[pure-runtime]> object is inserted
  into the patch <em|before> any anonymous objects which depend on the loaded
  scripts. (Also note that the script loading facility of
  <verbatim|[pure-runtime]> is by and large considered a legacy feature now
  that <verbatim|[declare> <verbatim|-lib]>, discussed in the next
  subsection, offers a better way to load additional script files using Pd's
  built-in <verbatim|-lib> mechanism.)

  Last but not least, you can also specify <verbatim|-w> as an argument to
  <verbatim|[pure-runtime]> in order to enable warnings in the embedded Pure
  interpreter. This has the same effect as running <verbatim|pure>
  <verbatim|-w> on the command line. It causes the interpreter to produce
  additional warning messages for some dubious (albeit correct) constructs,
  which may be a useful aid, in particular, for Pure novices. This is a
  global option; once enabled, it applies to all subsequently loaded Pure
  scripts until the interpreter is restarted from scratch (see
  <hlink|Livecoding|#livecoding>). The <verbatim|-w> option can also be
  combined with names of scripts to be loaded, e.g.:

  <\verbatim>
    \;

    [pure-runtime -w foo bar]

    \;
  </verbatim>

  <subsubsection|Loading Script Files at Startup><label|loading-script-files-at-startup>

  As of version 0.24, pd-pure provides an easier and more familiar way to
  load additional Pure scripts using Pd's <verbatim|-lib> mechanism during
  Pd's startup or when a patch is loaded. Compared to the rather rudimentary
  script loading facility provided by the <verbatim|[pure-runtime]> object,
  this also offers two chief advantages:

  <\itemize>
    <item>It works with <em|both> named Pure objects and auxiliary library
    scripts defining functions to be used with the <verbatim|[pure]> and
    <verbatim|[pure~]> objects.

    <item>The Pure loader keeps track of the loaded scripts and allows them
    to be reloaded at any time using the <hlink|livecoding|#livecoding>
    facility.
  </itemize>

  Note that at present, this feature requires the latest incarnation of the
  Pd loader, which means that you should make sure that you're using Pd
  0.47.0 or later, or a compatible Pd flavor such as
  <hlink|purr-data|https://agraef.github.io/purr-data-intro/>.

  To load some script files at startup, just add the corresponding script
  names (without the <verbatim|.pure> suffix) to Pd's startup libraries, or
  invoke them from the command line using the <verbatim|-lib> option, just
  like you'd do with any other Pd externals and libraries. E.g.:

  <\verbatim>
    \;

    pd -lib foo -lib bar

    \;
  </verbatim>

  Note that these options <em|must> come after any options required to launch
  the Pure loader (see <hlink|Usage|#usage> above), otherwise Pd will
  <em|not> recognize the scripts as loadable libraries. You can also specify
  the relative or absolute path to the scripts if needed, for instance:

  <\verbatim>
    \;

    pd -lib ~/pd-pure-externals/foo -lib ~/pd-pure-externals/bar

    \;
  </verbatim>

  Or you can use Pd's <verbatim|-path> option (or Pd's search path
  configuration dialog) to specify where Pd should go looking for the script
  files:

  <\verbatim>
    \;

    pd -path ~/pd-pure-externals -lib foo -lib bar

    \;
  </verbatim>

  Note that no special search path will be needed if you just drop the Pure
  scripts to be loaded into one of the directories on Pd's default search
  path. E.g., on Linux this usually includes the <verbatim|~/pd-externals>
  folder (<verbatim|~/pd-l2ork-externals> when using
  <hlink|pd-l2ork|http://l2ork.music.vt.edu/main/?page-id=56> or
  <hlink|purr-data|https://agraef.github.io/purr-data-intro/>). The default
  path will be different depending on the platform and Pd flavor you use, so
  please check your local Pd documentation for details.

  The <verbatim|-lib> mechanism also works with Pd's <verbatim|[declare]>
  object, so that, like the <verbatim|[pure-runtime]> object, it can also be
  used in patches. For instance, you can invoke the <verbatim|foo> and
  <verbatim|bar> script files in a patch by inserting the following object
  (using the same <verbatim|-lib> and <verbatim|-path> options that you'd use
  on the command line):

  <\verbatim>
    \;

    [declare -lib foo -lib bar]

    \;
  </verbatim>

  The scripts will then be loaded automagically as soon as you open the patch
  in Pd. (Note that, as with the <verbatim|[pure-runtime]> object, the
  <verbatim|[declare]> object needs to be inserted <em|before> any objects
  which depend on the loaded scripts.) This facility is most useful with
  anonymous objects, since named objects will be loaded anyway if needed, if
  you just type their name into an object box. But it works with named
  objects, too, and it also allows you to mix and match named and anonymous
  objects in a single script file, <em|and> make sure that the script gets
  loaded (and reloaded when livecoding) even if the patch doesn't contain any
  instance of the named object at all.

  <subsubsection|Livecoding><label|livecoding>

  Livecoding means changing Pure objects on the fly while a patch is running.
  A simple, but rather limited way to do this is to just edit the boxes
  containing Pure objects interactively, as you can do with any kind of Pd
  object. In this case, the changes take effect immediately after you finish
  editing a box. However, for more elaborate changes, you may have to edit
  the underlying Pure scripts and notify the Pure interpreter so that it
  reloads the scripts. The Pure loader provides the special
  <verbatim|[pure-runtime]> object to do this.

  Please note that <verbatim|[pure-runtime]> is a rather primitive way of
  doing these things, so pd-pure also provides a more convenient
  <verbatim|[pure-remote]> helper abstraction which takes care of all the
  gory details and also provides a useful \Premote control\Q feature. We
  <em|really> recommend using that instead of fiddling around with
  <verbatim|[pure-runtime]>, but since <verbatim|[pure-remote]> is
  implemented using <verbatim|[pure-runtime]>, it may be useful to know how
  all this works at the most basic level, which is what we explain below. (If
  you don't care about the nitty-gritty stuff then you may just skip ahead to
  the <hlink|Remote Control|#remote-control> section now.)

  Sending a <verbatim|bang> to the <verbatim|[pure-runtime]> object tells the
  plugin to reload all object scripts and update the Pure objects in your
  patch accordingly. The object also provides two outlets to deal with the
  inevitable latencies caused by the compilation process. The right outlet is
  banged when the compilation starts and the left outlet gets a bang when the
  compilation is finished, so that a patch using this facility can respond to
  these events in the appropriate way (e.g., disabling output during
  compilation).

  The <verbatim|reload> message works similarly, but while the
  <verbatim|bang> message only reloads the object scripts, <verbatim|reload>
  restarts the Pure interpreter from scratch and reloads everything,
  including the prelude and imported modules. This will usually take much
  longer, but is only necessary if you edited imported library modules which
  won't be reloaded with the <verbatim|bang> message.

  While this facility is tremendously useful for interactive development,
  there are some limitations and corresponding workarounds that you should
  keep in mind.

  First, since the compilation is done in Pd's main thread, it may lead to
  undesirable pauses in Pd's audio and control processing. With the
  <verbatim|bang> message the delays will usually be small, but may still be
  noticeable. There's no way around this in the current implementation, but
  as a remedy you can try to keep the compilation times to a minimum. This
  can be achieved by putting all code which you don't plan to edit \Plive\Q
  into library modules which are imported in the object scripts. By these
  means, the number of definitions in the object scripts themselves can be
  kept small, resulting in faster compilation.

  Second, Pd doesn't allow objects to change their inlet/outlet configuration
  on the fly. If a code change in a Pure object involves any such
  modifications, the reloaded objects will still appear to have the same
  inlets and outlets as before (and often cease to function properly). The
  quickest way to force an update of all affected Pure objects in one go,
  while preserving the current object connections, is to select the
  corresponding part of the patch and use Pd's cut and paste commands to
  reinsert it (if there are a lot of Pure objects scattered out all over the
  patch then you might just want to select and reinsert the entire contents
  of the patch).

  Finally, note that the reloading of object scripts amounts to a \Pcold
  restart\Q of the Pure objects in your patches. If a Pure object keeps some
  <hlink|local state|#local-state>, it will be lost. As a remedy, the loader
  implements a simple protocol which allows Pure objects to record their
  internal state before a script gets reloaded, and restore it afterwards. To
  these ends, a Pure object may respond to the following two messages:

  <\itemize>
    <item>Before reloading, the Pure object will receive the
    <verbatim|pd_save> message. In response, the object should return a Pure
    expression encoding its internal state in a way which can be serialized
    (see the description of the <hlink|<with|font-family|tt|blob>|purelib.tm#blob>
    function in the <hlink|<em|Pure Library Manual>|purelib.tm> for details).
    Usually, it is sufficient to just pack up all state data in a tuple, list
    or some other aggregate and return that as the response to the
    <verbatim|pd_save> message.

    <item>After reloading, the Pure object will receive a
    <verbatim|pd_restore> <verbatim|state> message, where <verbatim|state> is
    the previously recorded state, as returned by the object in response to
    the <verbatim|pd_save> message. It should then restore its internal state
    from the saved data. (The return value of this message invocation is
    ignored.)
  </itemize>

  In order to participate in the <verbatim|pd_save>/<verbatim|pd_restore>
  protocol, an object must subscribe to it. This is done by setting
  <verbatim|pd_save> as a sentry on the object function (see the description
  of the <hlink|<with|font-family|tt|sentry>|purelib.tm#sentry> function in
  the <hlink|<em|Pure Library Manual>|purelib.tm> for details). For instance,
  here's the mycounter example from <hlink|Local State|#local-state> again,
  with the necessary additions to support the
  <verbatim|pd_save>/<verbatim|pd_restore> protocol:

  <\verbatim>
    \;

    nonfix bang pd_save;

    mycounter = sentry pd_save $ next (ref 0) with

    \ \ next r bang = put r (get r+1);

    \ \ next r pd_save = get r;

    \ \ next r (pd_restore n) = put r n;

    \ \ next _ _ = () otherwise;

    end;

    \;
  </verbatim>

  <subsubsection|Remote Control><label|remote-control>

  The distribution also includes an abstraction pure-remote.pd which you can
  include in your patch to enable live coding, as well as remote control of
  the patch through the <with|font-series|bold|pdsend> program. This
  abstraction is installed directly under Pd's <verbatim|extra> directory so
  that normally it should be available without any further ado. As already
  mentioned, <verbatim|[pure-remote]> provides a more convenient way to
  enable live coding in your patches, so you should normally use this
  abstraction instead of fiddling around with <verbatim|[pure-runtime]>
  itself.

  Sending a <verbatim|bang> or <verbatim|reload> to <verbatim|[pure-remote]>
  causes a reload of the object scripts, as described under
  <hlink|Livecoding|#livecoding> above. The former can also be triggered
  directly by clicking the bang control of the abstraction (which also
  provides visual feedback while a compilation is still in progress). Note
  that the single inlet of the abstraction actually gets routed to the
  embedded <verbatim|[pure-runtime]> object, and conversely its two outlets
  receive the output from that object, so that <verbatim|[pure-remote]> can
  also be operated basically in the same way as <verbatim|[pure-runtime]> if
  needed. But usually the abstraction's bang control should be all that you
  need to care about.

  For added convenience, <verbatim|[pure-remote]> also accepts any <em|other>
  message of the form <verbatim|receiver> <verbatim|message> and will route
  the given message to the given receiver. In addition it listens on a
  certain port (4711 by default, but you can change this inside the
  abstraction if needed) for messages coming in from other applications,
  typically via the <with|font-series|bold|pdsend> program. This is intended
  to provide remote control of the Pure runtime as well as various parameters
  in patches. For instance, by having <with|font-series|bold|pdsend> send a
  <verbatim|bang> to port 4711, you can trigger a reload of the Pure objects
  in your patches. Moreover, by sending a <verbatim|play> <verbatim|0> or
  <verbatim|play> <verbatim|1> message, one might implement a simple playback
  control, provided that your patch includes an appropriate receiver (often a
  GUI object). See the pure-help.pd patch for an example.

  To make these features available in <with|font-series|bold|emacs>, there's
  an accompanying elisp program (pure-remote.el) which contains some
  keybindings for the necessary <with|font-series|bold|pdsend> invocations,
  so that you can operate the pure-remote patch with simple keystrokes
  directly from the text editor. The same bindings are also available in
  Emacs Pure mode, but need to be enabled before you can use them; please see
  the pure-remote.el file for details. As shipped, pure-remote.el and Pure
  mode implement the following commands:

  <tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|3|3|cell-halign|l>|<cwith|1|-1|3|3|cell-rborder|0ln>|<cwith|1|-1|1|-1|cell-valign|c>|<table|<row|<cell|<verbatim|C-C>
  <verbatim|C-X>>|<cell|Quick Reload>|<cell|Sends a <verbatim|bang> message
  to reload object scripts.>>|<row|<cell|<verbatim|C-C>
  <verbatim|M-X>>|<cell|Full Reload>|<cell|Sends a <verbatim|reload> message
  to reload everything.>>|<row|<cell|<verbatim|C-C>
  <verbatim|C-M>>|<cell|Message>|<cell|Prompts for a message and sends it to
  pure-remote.>>|<row|<cell|<verbatim|C-C>
  <verbatim|C-S>>|<cell|Play>|<cell|Sends a <verbatim|play> <verbatim|1>
  message.>>|<row|<cell|<verbatim|C-C> <verbatim|C-T>>|<cell|Stop>|<cell|Sends
  a <verbatim|play> <verbatim|0> message.>>|<row|<cell|<verbatim|C-C>
  <verbatim|C-G>>|<cell|Restart>|<cell|Sends a <verbatim|play> <verbatim|0>
  message followed by <verbatim|play> <verbatim|1>.>>|<row|<cell|<verbatim|C-/>>|<cell|Dsp
  On>|<cell|Sends a <verbatim|pd> <verbatim|dsp> <verbatim|1> (enable audio
  processing).>>|<row|<cell|<verbatim|C-.>>|<cell|Dsp Off>|<cell|Sends a
  <verbatim|pd> <verbatim|dsp> <verbatim|0> (disable audio processing).>>>>>

  Of course you can easily add more like these, just have a look at how the
  keybindings are implemented in pure-remote.el or pure-mode.el and create
  your own in an analogous fashion. Together with Pure mode, this gives you a
  nice interactive environment for developing pd-pure applications.

  <subsubsection|Compiling Objects><label|compiling-objects>

  pd-pure's livecoding abilities require that objects are run from source
  code. As already mentioned, this needs some (in some cases, substantial)
  time at startup when the Pure interpreter is loaded and your Pure scripts
  are compiled to native code on the fly. This is wasted effort if you are
  finished developing your Pure objects and just want to run them as they
  are.

  Therefore pd-pure also supports compiling a collection of Pure objects to a
  binary which can be loaded with Pd's <verbatim|-lib> option just like any
  other external library of Pd objects. This basically involves using the
  Pure interpreter as a batch compiler to translate the Pure scripts
  implementing the objects to a shared library. You also have to link in a
  small amount of C code so that the shared module can be loaded by Pd and
  registers its Pd object classes with pd-pure. The examples/libexample
  folder contains a complete example showing how this is done.

  Note that even if you load all your pd-pure objects from such libraries,
  you still need to load the pd-pure module first, since it provides the
  basic infrastructure required to run any kind of pd-pure object (no matter
  whether it's implemented in compiled or source form).

  <subsubsection|Programming Interface><label|programming-interface>

  The Pure loader provides a number of interface routines which can be called
  by Pure scripts running in the Pd environment. We give a brief description
  of these functions below. These functions are all implemented in C, so in
  order to access them in your Pure scripts, you will need corresponding
  <verbatim|extern> declarations (see the \PC Interface\Q section in
  <hlink|<em|The Pure Manual>|pure.tm> for details). For your convenience,
  there's a <verbatim|pd.pure> script included in the distribution which
  already contains all the required <verbatim|extern> declarations, so you
  just need to import this script in your Pure scripts and you're set.

  The <verbatim|pd.pure> script will be installed in the <verbatim|lib>
  subfolder along with the Pd Pure loader external and the examples. The
  embedded Pure runtime has been set up so that it always has this directory
  in its search path, so that it's enough to include a declaration like the
  following in your Pure scripts if you want to call one of the interface
  routines:

  <\verbatim>
    \;

    using pd;

    \;
  </verbatim>

  (We mention in passing that, in the same fashion you can also put your own
  library scripts into the <verbatim|extra/pure/lib> folder to make them
  available to all your Pure object scripts.)

  <\description>
    <item*|extern char *pd_version_s()<label|pd-version-s>>Returns the Pd
    version number as a string. Note that this routine will only be available
    when a script is running inside Pd, so you can quickly check if that's
    the case as follows:

    <\verbatim>
      \;

      let ok = stringp $ eval "extern char *pd_version_s(); pd_version_s;";

      \;
    </verbatim>

    The <verbatim|ok> variable will then be true iff the script is running
    inside Pd.
  </description>

  <\description>
    <item*|extern expr *pd_path()<label|pd-path>>Returns the Pd path (set in
    Pd's <verbatim|Path> dialog or via the <verbatim|-path> command line
    option) as a list of directory names. This is useful if your Pure scripts
    need to locate files on the Pd search path.
  </description>

  <\description>
    <item*|extern char *pd_libdir()<label|pd-libdir>>Returns the Pd library
    dir (determined at runtime). This is useful if your Pure scripts need to
    access files in that directory.
  </description>

  <\description>
    <item*|extern expr *pd_getdir()<label|pd-getdir>>Returns the directory of
    the patch the current object is in. This is useful if a Pure object needs
    to access files in the patch directory. Please note that this function
    must be called during object creation or in the method calls of an
    object, so that it is clear what the current object is; otherwise the
    function will fail. Also note that the results may differ for different
    instances of the same object class, depending on which patches the
    objects are located in.
  </description>

  <\description>
    <item*|extern expr *pd_getfile()<label|pd-getfile>>Returns the name of
    the file that will be opened with the <verbatim|menu-open> action
    (accessible by right-clicking on a Pure object and selecting
    <verbatim|Open>). This is usually the Pure script of the object, if
    available, but this can be changed with
    <hlink|<with|font-family|tt|pd_setfile()>|#pd-setfile> below. The
    function must be called during object creation or in the method calls of
    an object, so that it is clear what the current object is; otherwise the
    function will fail.
  </description>

  <\description>
    <item*|extern void pd_setfile(char<em|<nbsp>*s>)<label|pd-setfile>>Sets
    the name of the file to be opened with the <verbatim|menu-open> action.
    By default, this is the Pure script of the object, if available; this
    function can be used to change the name of the file on a per-object
    basis. The function must be called during object creation or in the
    method calls of an object, so that it is clear what the current object
    is; otherwise the function will have no effect.
  </description>

  <\description>
    <item*|extern void pd_post(char<em|<nbsp>*s>)<label|pd-post>>Posts a
    message in the Pd main window. A trailing newline is added automatically.
    This is a convenience function which is equivalent to calling Pd's
    <verbatim|post()> (which is a varargs function) as <verbatim|post>
    <verbatim|"%s"> <verbatim|s>.
  </description>

  <\description>
    <item*|extern void pd_error_s(char<em|<nbsp>*s>)<label|pd-error-s>>Like
    <hlink|<with|font-family|tt|pd_post()>|#pd-post>, but prints an error
    message instead. If this routine is invoked from an object (i.e., during
    object creation or a method call) then Pd's <verbatim|pd_error()>
    function is called, which allows the object to be tracked down with Pd's
    <verbatim|Find> <verbatim|Last> <verbatim|Error> menu command. Otherwise
    (i.e., if the function is called at load time) Pd's <verbatim|error()>
    function is called which just outputs the message.
  </description>

  <\description>
    <item*|extern double pd_time()<label|pd-time>>Retrieves the current Pd
    time as a double value in milliseconds, which is useful, in particular,
    when used in conjunction with the asynchronous message facility described
    under <hlink|Asynchronous Messages|#asynchronous-messages>.
  </description>

  <\description>
    <item*|extern void pd_send(char<em|<nbsp>*sym>,
    expr<em|<nbsp>*x>)<label|pd-send>>Sends a message, specified as a Pure
    term <verbatim|x>, to the receiver given by the symbol <verbatim|sym>
    (specified as a string). This is a no-op if the receiver doesn't exist.
  </description>

  <\description>
    <item*|extern void pd_receive(char<em|<nbsp>*sym>)<label|pd-receive>>Prepares
    an object so that it can receive messages sent to the given symbol
    <verbatim|sym>. This function must be called during object creation or
    method calls. It can be called for different symbols, as many times as
    needed. The messages are always delivered to the leftmost inlet, and the
    given symbol is applied to the original message, so that the receiver can
    figure out where the message came from.
  </description>

  <\description>
    <item*|extern void pd_unreceive(char<em|<nbsp>*sym>)<label|pd-unreceive>>Switches
    off receiving messages for the given symbol <verbatim|sym>. Use this to
    undo the effects of a previous <verbatim|pd_receive> call.
  </description>

  <\description>
    <item*|extern expr *pd_getbuffer(char<em|<nbsp>*name>)<label|pd-getbuffer>>

    <item*|extern void pd_setbuffer(char<em|<nbsp>*name>,
    expr<em|<nbsp>*x>)<label|pd-setbuffer>>

    <item*|extern int pd_getbuffersize(char<em|<nbsp>*name>)<label|pd-getbuffersize>>

    <item*|extern void pd_setbuffersize(char<em|<nbsp>*name>,
    int<em|<nbsp>sz>)<label|pd-setbuffersize>>Routines to access the Pd array
    (sample buffer) with the given name. These functions can be used to
    transfer audio data between Pd and Pure scripts; see <hlink|Reading and
    Writing Audio Data|#reading-and-writing-audio-data> above for an example.

    <hlink|<with|font-family|tt|pd_getbuffersize()>|#pd-getbuffersize> and
    <hlink|<with|font-family|tt|pd_setbuffersize()>|#pd-setbuffersize> gets
    or sets the size of the given buffer, respectively.

    <hlink|<with|font-family|tt|pd_getbuffer()>|#pd-getbuffer> reads the
    contents of the buffer and returns it as a Pure vector (or fails if the
    array with the given name doesn't exist).

    <hlink|<with|font-family|tt|pd_setbuffer()>|#pd-setbuffer> sets the
    contents of the buffer from the given Pure vector <verbatim|x>. If the
    size of the vector exceeds the size of the buffer, the former is
    truncated. Conversely, if the size of the buffer exceeds the size of the
    Pure vector, the trailing samples are unaffected. <em|Note:> The second
    argument of <hlink|<with|font-family|tt|pd_setbuffer()>|#pd-setbuffer>
    can also be a pair <verbatim|(i,x)> denoting an offset <verbatim|i> into
    the array at which the sample data is to be written, so that this routine
    allows you to overwrite any part of the array.
  </description>

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pd-pure-toc>

  <\itemize>
    <item><hlink|pd-pure: Pd loader for Pure scripts|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <item><hlink|Control Objects|#control-objects>

      <\itemize>
        <item><hlink|Simple Objects|#simple-objects>

        <item><hlink|Creation Arguments|#creation-arguments>

        <item><hlink|The [pure] Object|#the-pure-object>

        <item><hlink|Configuring Inlets and
        Outlets|#configuring-inlets-and-outlets>

        <item><hlink|Variadic Creation Functions|#variadic-creation-functions>

        <item><hlink|Local State|#local-state>
      </itemize>

      <item><hlink|Signal Objects|#signal-objects>

      <item><hlink|Advanced Features|#advanced-features>

      <\itemize>
        <item><hlink|Asynchronous Messages|#asynchronous-messages>

        <item><hlink|Wireless Messaging|#wireless-messaging>

        <item><hlink|Reading and Writing Audio
        Data|#reading-and-writing-audio-data>

        <item><hlink|Controlling the Runtime|#controlling-the-runtime>

        <item><hlink|Loading Script Files at
        Startup|#loading-script-files-at-startup>

        <item><hlink|Livecoding|#livecoding>

        <item><hlink|Remote Control|#remote-control>

        <item><hlink|Compiling Objects|#compiling-objects>

        <item><hlink|Programming Interface|#programming-interface>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pd-faust|pd-faust.tm>

  Next topic

  <hlink|pure-audio|pure-audio.tm>

  <hlink|toc|#pd-pure-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-audio.tm> \|
  <hlink|previous|pd-faust.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Mar
  18, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
