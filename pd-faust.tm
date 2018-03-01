<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pd-faust-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pd-pure.tm> \|
  <hlink|previous|faust2pd.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pd-faust><label|pd-faust>

  Version 0.16, March 01, 2018

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  pd-faust is a dynamic environment for running Faust dsps in Pd. It is based
  on the author's <hlink|<em|faust2pd>|faust2pd.tm> script, but offers many
  small improvements and some major additional features:

  <\itemize>
    <item>Faust dsps are implemented by the <verbatim|faust~> external which
    provides the necessary infrastructure to run Faust instruments and effect
    units in Pd.

    <item>In contrast to faust2pd, the Pd GUI of Faust units is generated
    dynamically, inside Pd. While pd-faust supports the same global GUI
    layout options as faust2pd, it also provides various options to adjust
    the layout of individual control items.

    <item>pd-faust recognizes the <verbatim|midi> and <verbatim|osc>
    controller attributes in the Faust source and automatically provides
    corresponding MIDI and OSC controller mappings. OSC-based controller
    automation is also available through a separate helper abstraction.

    <item>Perhaps most importantly, Faust dsps can be reloaded at any time
    (even while the Pd patch is running), in which case the GUI and the
    controller mappings are regenerated automatically and on the fly as
    needed.
  </itemize>

  <subsection|Copying><label|copying>

  Copyright (c) 2011-2018 by Albert Graef

  pd-faust is distributed under the GNU LGPL v3+. Please see the included
  COPYING and COPYING.LESSER files for details.

  This package also includes the faust-stk instruments which are distributed
  under an MIT-style license, please check the examples/dsp/README-STK file
  and the dsp files for authorship information and licensing details
  pertaining to these. The original faust-stk sources can be found in the
  Faust distribution, cf. <hlink|http://faust.grame.fr/|http://faust.grame.fr/>.

  <subsection|Installation><label|installation>

  You'll need <hlink|Faust|http://faust.grame.fr/> and
  <hlink|Pd|http://puredata.info/>, obviously. Faust versions \<gtr\>= 0.9.46
  and 2.0.a3 and Pd version \<gtr\>= 0.43.1 have been tested and are known to
  work. Note that the examples still use the \Pold\Q a.k.a. \Plegacy\Q Faust
  library modules, so they should work out of the box with both \Pold\Q Faust
  versions (up to 0.9.85) and later ones featuring the \Pnew\Q Faust library
  (anything after 0.9.85, including current git sources).

  The pd-faust objects are written in the
  <hlink|Pure|https://agraef.github.io/pure-lang/> programming language, so
  you'll also need an installation of the Pure interpreter (0.51 or later),
  along with the following packages (minimum required versions are given in
  parentheses): <hlink|<em|pd-pure>|pd-pure.tm> (0.15),
  <hlink|<em|pure-faust>|pure-faust.tm> (0.8),
  <hlink|<em|pure-midi>|pure-midi.tm> (0.5) and
  <hlink|<em|pure-stldict>|pure-stldict.tm> (0.3).

  Finally, gcc and GNU make (or compatible) are required to compile the
  helper dsps and the example instruments; please check the Makefile for
  details.

  For a basic installation run <verbatim|make>, then <verbatim|sudo>
  <verbatim|make> <verbatim|install>. This will install the pd-faust objects
  in your lib/pd/extra/faust folder as a Pd object library which can be
  loaded with Pd's <verbatim|-lib> option. To complete the installation, you
  still have to make sure that the library is loaded automatically at
  startup. This is done most conveniently by adding <verbatim|faust/pdfaust>
  to your preloaded library modules in Pd's <verbatim|Preferences/Startup>
  dialog.

  <with|font-series|bold|Note:> The <verbatim|faust/pdfaust> module must come
  <em|after> the <verbatim|pure> entry which loads pd-pure, otherwise you'll
  get an error message. In any case the pd-pure loader will be required to
  run these objects, so it should be configured accordingly; please check the
  <hlink|<em|pd-pure>|pd-pure.tm> documentation for details.

  The <verbatim|make> command also compiles the Faust dsps included in the
  distribution, so that the provided examples will be ready to run afterwards
  well (see <hlink|Examples|#examples> below).

  The Makefile tries to guess the installation prefix under which Pd is
  installed. If it guesses wrong, you can tell it the right prefix with
  <verbatim|make> <verbatim|prefix=/some/path>. Or you can specify the exact
  path of the lib/pd directory with <verbatim|make>
  <verbatim|pdlibdir=/some/path>; by default the Makefile assumes
  <verbatim|$(prefix)/lib/pd>.

  It is also possible to specify an alternative flavour of Pd when building
  and installing the module, by adding a definition like
  <verbatim|PD=pd-extended> to the <verbatim|make> command line. This is
  known to work with <hlink|pd-extended|http://puredata.info/downloads/pd-extended>
  and <hlink|pd-l2ork|http://l2ork.music.vt.edu/main/?page-id=56>, two
  popular alternative Pd distributions available on the web, as well as
  <hlink|purr-data|https://git.purrdata.net/jwilkes/purr-data> (the new
  cross-platform version of <hlink|pd-l2ork|http://l2ork.music.vt.edu/main/?page-id=56>).

  Some further build options are described in the Makefile. In particular, it
  is possible to compile the Faust dsps to LLVM bitcode which can be loaded
  directly by the Pure interpreter. This requires a recent Faust version (2.0
  and later) and an LLVM-capable C/C++ compiler such as
  <hlink|clang|http://clang.llvm.org/> (please check the <hlink|Compiling
  Faust DSPs|#compiling-faust-dsps> section below for details). If you have
  the required tools then you can build the bitcode modules by running
  <verbatim|make> <verbatim|bitcode> after <verbatim|make>. If you run
  <verbatim|make> <verbatim|install> afterwards, the bitcode modules will be
  installed along with the \Pnormal\Q Faust plugins. In addition, a second
  object library called <verbatim|pdfaust2> will be built and installed,
  which can be used as a drop-in replacement for <verbatim|pdfaust> and lets
  you run the bitcode modules. (Note that in the present implementation it is
  not possible to load both <verbatim|pdfaust> and <verbatim|pdfaust2> in Pd,
  you'll have to pick one or the other.)

  <subsection|Usage><label|usage>

  Working with pd-faust basically involves adding a bunch of
  <verbatim|faust~> objects to a Pd patch along with the corresponding GUI
  subpatches, and wiring up the Faust units in some variation of a
  synth-effects chain which typically takes input from Pd's MIDI interface
  (<verbatim|notein>, <verbatim|ctlin>, etc.) and outputs the signals
  produced by the Faust units to Pd's audio interface (<verbatim|dac~>).

  For convenience, pd-faust also includes a few helper objects and
  abstractions to handle MIDI input and playback as well as OSC controller
  automation. For simple uses, the included <verbatim|midi-input> and
  <verbatim|midi-output> abstractions provide a way to encode and decode MIDI
  messages in the author's <hlink|SMMF|https://bitbucket.org/agraef/pd-smmf>
  format used by <verbatim|faust~> objects. For applications requiring more
  elaborate MIDI and OSC support, the <verbatim|midiseq> and
  <verbatim|oscseq> objects and a corresponding <verbatim|midiosc>
  abstraction can be used to handle MIDI input and playback as well as OSC
  controller automation. This is described in more detail under <hlink|MIDI
  and OSC Sequencing|#midi-and-osc-sequencing> below.

  pd-faust interprets MIDI, OSC and Faust dsp filenames relative to the
  hosting Pd patch by default. It will also search the <verbatim|midi>,
  <verbatim|osc> and <verbatim|dsp> subfolders, if they exist, for the
  corresponding types of files. Failing that, it finally searches the
  directories on the Pd library path (including their <verbatim|midi>,
  <verbatim|osc> and <verbatim|dsp> subfolders). To disable this search, just
  use absolute pathnames (or pathnames relative to the <verbatim|.> or
  <verbatim|..> directory) instead.

  Like pd-pure, pd-faust remaps Pd's <verbatim|menu-open> command so that it
  lets you edit the Faust source of a <verbatim|faust~> object by
  right-clicking on the object and choosing <verbatim|Open> from the context
  menu. (This requires that the <verbatim|.dsp> source file of the Faust
  module is available in the same directory as the binary module.) There's
  also special support for the Emacs editor which lets you quickly compile
  Faust programs and reload Faust dsps in Pd, see <hlink|Remote
  Control|#remote-control> for details.

  <subsubsection|Compiling Faust DSPs><label|compiling-faust-dsps>

  To run a Faust module (<verbatim|.dsp> file) inside Pd using the
  <verbatim|faust~> object, the Faust dsp must be compiled to a form which
  can be loaded in <em|Pure> (not Pd!), so the <verbatim|pure.cpp>
  architecture (included in the Faust distribution) is used to compile the
  dsp to a shared library object. It is of course possible to do this
  manually using the faust and gcc compilers, but for convenience there's a
  GNU Makefile in the examples/dsp subdirectory which provides all the build
  rules necessary to do this. This Makefile is self-contained, so you can
  just drop it into any directory with Faust dsp sources and run
  <verbatim|make> there to compile the modules to a format which is ready to
  be loaded with pd-faust.

  Another possibility is to use the <verbatim|faust2pure> script included in
  recent Faust versions and also in the examples subdirectory of the
  pure-faust package, see the <hlink|<em|pure-faust>|pure-faust.tm>
  documentation for details. E.g., to compile a Faust dsp
  <verbatim|organ.dsp> to a module loadable with pd-faust, simply use the
  following command:

  <\verbatim>
    \;

    faust2pure organ.dsp

    \;
  </verbatim>

  This will leave a shared library module <verbatim|organ.so>
  (<verbatim|organ.dylib> on macOS, <verbatim|organ.dll> on Windows) in the
  current directory which can then be loaded with pd-faust, by just inserting
  an object like <verbatim|faust~> <verbatim|organ> in your patch. Note that
  to make this work, pd-faust must be able to locate the object. To these
  ends, you should create the patch in the same directory that also contains
  the <verbatim|.dsp> and <verbatim|.so> files of the Faust dsp. (As
  mentioned earlier, it is also possible to put the <verbatim|.dsp> and
  <verbatim|.so> files into the <verbatim|dsp> subdirectory of the directory
  containing the patch, or just put them somewhere on Pd's library path.)

  If you're running a recent version of Faust, you can also compile to an
  LLVM bitcode file instead; pd-pure can load these directly using Pure's
  built-in Faust bitcode loader. As already mentioned, this requires Faust
  2.0 or later and that you build and install the alternative
  <verbatim|pdfaust2> library as described under
  <hlink|Installation|#installation> above. The main advantage of using
  bitcode modules is that compiling these is often much faster. The main
  disadvantage is that you'll need a special C compiler capable of producing
  LLVM bitcode (i.e., <hlink|clang|http://clang.llvm.org/>).

  The process of compiling Faust dsps to bitcode modules is pretty much the
  same as above, only that you have to run <verbatim|make> <verbatim|bitcode>
  with the provided Makefile, or use the faust2pure script with the
  <verbatim|-bitcode> option, e.g.:

  <\verbatim>
    \;

    faust2pure -bitcode organ.dsp

    \;
  </verbatim>

  This creates the <verbatim|organ.bc> module which can be loaded by the
  <verbatim|pdfaust2> library, pretty much like <verbatim|pdfaust> loads
  shared object modules. Otherwise there won't be much of a noticeable
  difference (gcc may produce better code in some cases, clang in others,
  which may result in some Faust dsps running with better performance as
  shared library modules, others in bitcode). Note, however, that in the
  current implementation <verbatim|pdfaust> and <verbatim|pdfaust2> can
  <em|not> be loaded at the same time in Pd, therefore you'll have to decide
  beforehand which of the two available interfaces you want to use.

  <subsubsection|The faust<math|\<sim\>> Object><label|the-faust-object>

  Starting with version 0.10, pd-faust offers the <verbatim|faust~> external
  which provides a uniform way to create both audio effects and synth
  (instrument) units, and also supplies reasonable defaults for most
  arguments. (While the underlying <verbatim|fdsp~> and <verbatim|fsynth~>
  objects of older pd-faust versions are still provided for backward
  compatibility, they are deprecated and shouldn't be invoked directly any
  more.)

  The <verbatim|faust~> object is invoked as follows:

  <\verbatim>
    \;

    faust~ dspname [instname] [channel] [numvoices]

    \;
  </verbatim>

  The creation arguments in square brackets are optional. Please note that
  since the <verbatim|faust~> object is written in Pure, the creation
  arguments should be specified in Pure syntax. In particular, both
  <verbatim|dspname> or <verbatim|instname> may either be Pure identifiers or
  double-quoted strings (the former will automatically be translated to the
  latter). Similarly, the <verbatim|channel> and <verbatim|numvoices>
  arguments must be integer constants in Pure syntax, which is pretty much
  like Pd syntax but also allows the integer to be specified in hexadecimal,
  octal or binary.

  The meaning of these arguments is as follows:

  <\itemize>
    <item><verbatim|dspname> denotes the name of the Faust dsp (usually this
    is just the name of the .dsp file with the extension stripped off).

    <item><verbatim|instname> denotes the name of the instance of the Faust
    unit. By default, this is the same as <verbatim|dspname>. Multiple
    instances of the same Faust dsp can be used in a Pd patch, but then they
    must all have different instance names. The instance name is also used to
    identify the GUI subpatch of the unit (see below) and to generate unique
    OSC addresses for the unit's control elements.

    <item><verbatim|channel> is the number of the MIDI channel the unit
    responds to. This can be 1..16, or 0 (the default) to specify \Pomni\Q
    operation (listen to MIDI messages on all channels).

    <item><verbatim|numvoices> denotes the number of voices of a synth unit.
    This determines the maximum number of notes which can be played
    simultaneously (i.e., the degree of polyphony). A <verbatim|numvoices>
    value of zero can be used to indicate an effect unit. If the
    <verbatim|numvoices> argument is omitted, the <verbatim|faust~> object
    checks the meta data of the Faust module to see whether the loaded Faust
    module is an effect or a synth, see below for details.
  </itemize>

  Note that if only a single number follows the <verbatim|dspname> or
  <verbatim|instname> argument then it is always interpreted as a channel
  number; thus, if you want to denote the <verbatim|numvoices> value in the
  creation arguments then you'll have to specify <em|both> <verbatim|channel>
  and <verbatim|numvoices>, in that order.

  Unless specified explicitly, the number of voices of an instrument is
  determined using the value of the <verbatim|nvoices> meta key declared in
  the dsp source. Thus, to turn a Faust dsp into a synth with 8 voices you
  can use a declaration like the following anywhere in the Faust program:

  <\verbatim>
    \;

    declare nvoices "8";

    \;
  </verbatim>

  The format of this declaration is the same as for the
  <hlink|faust-lv2|https://bitbucket.org/agraef/faust-lv2> and
  <hlink|faust-vst|https://bitbucket.org/agraef/faust-vst> plugin
  architectures.

  If the <verbatim|nvoices> declaration isn't present, the dsp is considered
  to be an effect unit by default. All default choices can be overridden by
  explicitly specifying the corresponding creation argument. In particular,
  you can specify the number of synth voices (overriding the
  <verbatim|nvoices> key in the dsp source), or use a <verbatim|numvoices>
  value of zero to force a synth to be loaded as an ordinary effect unit.
  Also, if there are multiple instances of the same dsp in a patch then you
  can (and should) explicitly specify different instance names using the
  <verbatim|instname> argument, and the default <verbatim|channel> value of
  zero (denoting omni input) can be overridden as needed if the unit should
  only listen on a specific MIDI channel.

  <subsubsection|Effect and Synth Units><label|effect-and-synth-units>

  A <verbatim|faust~> object with zero voices requires a Faust dsp which can
  work as an effect unit, processing audio input and producing audio output.
  The unit can have as many audio input and output channels as you like
  (including zero).

  A <verbatim|faust~> object with a non-zero number of voices works in a
  similar fashion, but requires a Faust dsp which can work as a (monophonic)
  synthesizer. This typically means that the unit has zero audio inputs and a
  nonzero number of audio outputs, although it is possible to have synths
  processing any number of audio input channels as well. (You can even have
  synths producing zero audio outputs, but this is generally not very
  useful.)

  In the synth case, pd-faust also assumes that the Faust unit provides three
  so-called \Pvoice controls\Q which indicate which note to play:

  <\itemize>
    <item><verbatim|freq> is the fundamental frequency of the note in Hz.

    <item><verbatim|gain> is the velocity of the note, as a normalized value
    between 0 and 1. This usually controls the volume of the output signal.

    <item><verbatim|gate> indicates whether a note is currently playing. This
    value is either 0 (no note to play) or 1 (play a note), and usually
    triggers the envelop function (ADSR or similar).
  </itemize>

  pd-faust doesn't care at which path inside the Faust dsp these controls are
  located, but they must all be there, and the basenames of the controls must
  be unique throughout the entire dsp. Otherwise the synth will not work as
  expected.

  Like <hlink|<em|faust2pd>|faust2pd.tm>, pd-faust implements the necessary
  logic to drive the given number of voices of a <verbatim|faust~> instrument
  object. That is, it will actually create a separate instance of the Faust
  dsp for each voice and handle polyphony by allocating voices from this pool
  in a round-robin fashion, performing the usual voice stealing if the number
  of simultaneous notes to play exceeds the number of voices. Also note that
  a <verbatim|faust~> instrument operated in omni mode (<verbatim|channel>
  <verbatim|=> <verbatim|0>) automatically filters out messages on channel 10
  which is reserved for percussion in the General MIDI standard.

  A <verbatim|faust~> object always responds to the following messages:

  <\itemize>
    <item><verbatim|bang> outputs the current control settings on the control
    outlet in OSC format.

    <item><verbatim|write> outputs the current control settings to special
    <verbatim|midiout> and <verbatim|oscout> receivers, so that they can be
    processed and/or sent to external MIDI and/or OSC devices. This message
    can also be invoked with a numeric argument to toggle the \Pwrite mode\Q
    of the unit; please see <hlink|External MIDI and OSC
    Controllers|#external-midi-and-osc-controllers> below for details.

    <item><verbatim|reload> reloads the Faust unit. This also reloads the
    shared library or bitcode file if the unit was recompiled since the
    object was last loaded. (Instead of feeding a <verbatim|reload> message
    to the control inlet of a Faust unit, you can also just send a
    <verbatim|bang> to the <verbatim|reload> receiver.)

    <item><verbatim|addr> <verbatim|value> changes the control indicated by
    the OSC address <verbatim|addr>. This is also used internally for
    communication with the Pd GUI and for controller automation.
  </itemize>

  The object also responds to MIDI controller messages of the form
  <verbatim|ctl> <verbatim|val> <verbatim|num> <verbatim|chan> and, in the
  case of instruments, note-related messages of the form <verbatim|note>
  <verbatim|num> <verbatim|vel> <verbatim|chan> (note on/off) and
  <verbatim|bend> <verbatim|val> <verbatim|chan> (pitch bend). It also
  provides the necessary logic to map controller and note-related messages to
  the corresponding control changes in the Faust unit.

  In addition, pd-faust 0.13 and later offer support for the MIDI Tuning
  Standard (MTS), so that instruments can be retuned using the corresponding
  sysex messages for octave-based tunings. To these ends, the
  <verbatim|faust~> object accepts messages of the form <verbatim|sysex>
  <verbatim|b1> <verbatim|b2> <verbatim|...> where <verbatim|b1>,
  <verbatim|b2>, ... are the individual data bytes of the message. A
  description of the MIDI Tuning Standard is beyond the scope of this manual.
  However, there are some tools which let you construct such messages from
  various input formats, such as the author's
  <hlink|sclsyx|https://bitbucket.org/agraef/sclsyx> program. You can then
  either include the tuning messages in a MIDI file or transmit them directly
  to Pd's MIDI input. There's also a version of sclsyx.pure included in the
  author's <hlink|pd-smmf|https://bitbucket.org/agraef/pd-smmf> package,
  which can be run as a Pd external to output tunings in the format
  understood by the <verbatim|faust~> object.

  <subsubsection|GUI Subpatches><label|gui-subpatches>

  For each <verbatim|faust~> object, the Pd patch may contain an (initially
  empty) \Pone-off\Q graph-on-parent subpatch with the same name as the
  instance name of the Faust unit:

  <\verbatim>
    \;

    pd instname

    \;
  </verbatim>

  You shouldn't insert anything into this subpatch, its contents (a bunch of
  Pd GUI elements corresponding to the control elements of the Faust unit)
  will be generated automatically by pd-faust when the corresponding
  <verbatim|faust~> object is created, and whenever the unit gets reloaded at
  runtime.

  As with faust2pd, the default appearance of the GUI can be adjusted in
  various ways; see <hlink|Tweaking the GUI Layout|#tweaking-the-gui-layout>
  below for details.

  The relative order in which you insert a <verbatim|faust~> object and its
  GUI subpatch into the main patch matters. Normally, the GUI subpatch should
  be inserted <em|first>, so that it will be updated automatically when its
  associated Faust unit is first created, and also when the main patch is
  saved and then reloaded later.

  However, in some situations it may be preferable to insert the GUI subpatch
  <em|after> its associated Faust unit. If you do this, the GUI will <em|not>
  be updated automatically when the main patch is loaded, so you'll have to
  reload the dsp manually (sending it a <verbatim|reload> message) to force
  an update of the GUI subpatch. This is useful, in particular, if you'd like
  to edit the GUI patch manually after it has been generated.

  In some cases it may even be desirable to completely \Plock down\Q the GUI
  subpatch. This can be done by simply <em|renaming> the GUI subpatch after
  it has been generated. When Pd saves the main patch, it saves the current
  status of the GUI subpatches along with it, so that the renamed subpatch
  will remain static and will <em|never> be updated, even if its associated
  Faust unit gets reloaded. This generally makes sense only if the control
  interface of the Faust unit isn't changed after locking down its GUI patch.
  To \Punlock\Q a GUI subpatch, you just rename it back to its original name.
  (In this case you might also want to reinsert the corresponding Faust unit
  afterwards, if you want to have the GUI generated automatically without an
  explicit <verbatim|reload> again.)

  <subsubsection|Examples><label|examples>

  The examples folder contains a few example patches which illustrate how
  this all works. Having compiled and installed pd-faust as described above,
  you can run these directly from the examples directory in the sources,
  e.g.: <verbatim|pd> <verbatim|test.pd>. (You can also run the examples
  without actually installing pd-faust if you invoke Pd from the main
  pd-faust source directory, e.g., as follows: <verbatim|pd> <verbatim|-lib>
  <verbatim|lib/pdfaust> <verbatim|examples/test.pd>.) The same collection of
  examples is also copied to <verbatim|$prefix/lib/pd/extra/faust> when
  running <verbatim|make> <verbatim|install> (where <verbatim|$prefix>
  denotes the prefix under which Pd is installed, usually <verbatim|/usr> or
  <verbatim|/usr/local>) so that you can also run them from there.

  Here are some of the examples that are currently available:

  <\itemize>
    <item>simple.pd: Minimalistic example which works without the
    <verbatim|midiosc> abstraction.

    <item>test.pd: Simple patch running a single Faust instrument.

    <item>synth.pd: Slightly more elaborate patch featuring a synth-effects
    chain.

    <item>bouree.pd: Full-featured example running various instruments.
  </itemize>

  For your convenience, related MIDI and OSC files as well as the Faust
  sources of the instruments and effects are contained in corresponding
  subdirectories (midi, osc, dsp) of the examples directory. A slightly
  modified version of the faust-stk instruments from the Faust distribution
  is also included, please check the examples/dsp/README-STK file for more
  information about these. The MIDI files are all in standard MIDI file
  format. (Some of these come from the faust-stk distribution, others can be
  found on the web.) The OSC files used by pd-faust for controller automation
  are plain ASCII files suitable for hand-editing if you know what you are
  doing; the format should be fairly self-explanatory.

  <subsubsection|Operating the Patches><label|operating-the-patches>

  The generated Pd GUI elements for the Faust dsps are pretty much the same
  as with <hlink|<em|faust2pd>|faust2pd.tm> (which see). The only obvious
  change is the addition of a \Precord\Q button (gray toggle in the upper
  right corner) which enables recording of OSC automation data. This requires
  the use of the <verbatim|midiosc> abstraction which serves as a little
  sequencer applet that enables you to control MIDI playback and OSC
  recording. The usage of this abstraction should be fairly obvious, but you
  can also find a brief description under <hlink|MIDI and OSC
  Sequencing|#midi-and-osc-sequencing> below.

  Note that the <verbatim|midiosc> abstraction, even though most of the
  distributed examples include it, is by no means required unless you really
  need the MIDI playback and OSC automation features it provides. In most
  simple use cases, you just insert <verbatim|faust~> objects (along with
  their corresponding GUI subpatches if needed/wanted) into your patch, wire
  them up as needed and be done with it. If you also need MIDI input
  (controller and note data), the <verbatim|midi-input> abstraction provides
  a simpler way to encode incoming MIDI messages from Pd's MIDI inputs in the
  SMMF format understood by <verbatim|faust~> objects. Simply connect the
  outlet of <verbatim|midi-input> to the leftmost inlet of any
  <verbatim|faust~> instrument or effect unit that you want to play or
  control through MIDI, make sure that the instrument (or last effect unit in
  the chain) is connected to Pd's audio output a.k.a. <verbatim|dac~>, and
  you should be set. MIDI output via the <verbatim|midiout> receiver (cf.
  <hlink|External MIDI and OSC Controllers|#external-midi-and-osc-controllers>)
  can be handled in a similar way using the <verbatim|midi-output>
  abstraction (see simple.pd for an example).

  <subsubsection|MIDI and OSC Sequencing><label|midi-and-osc-sequencing>

  <with|font-series|bold|Note:> If you use the <verbatim|midiosc> abstraction
  in your own patches, you should copy it to the directory containing your
  patch and other required files, so that MIDI and OSC files are properly
  located. Alternatively, you can also set up Pd's search path as described
  at the beginning of the <hlink|Usage|#usage> section.

  The first creation argument of <verbatim|midiosc> is the name of the MIDI
  file, either as a Pure identifier (in this case the .mid filename extension
  is supplied automatically) or as a double-quoted string. Similarly, the
  second argument specifies the name of the OSC file. Both arguments are
  optional; if the second argument is omitted, it defaults to the name of the
  MIDI file with new extension .osc. You can also omit both arguments if
  neither MIDI file playback nor saving recorded OSC data is required. Or you
  can leave the first parameter empty (specify <verbatim|""> or <verbatim|0>
  instead) to only set an OSC filename, if you don't need MIDI playback. The
  latter is useful, in particular, if you use <verbatim|midiosc> with an
  external MIDI sequencer (see below).

  The abstraction has a single control outlet through which it feeds the
  generated MIDI and other messages to the connected <verbatim|faust~>
  objects. Live MIDI input is also accepted and forwarded to the control
  outlet, after being translated to the format understood by
  <verbatim|faust~> objects. In addition, <verbatim|midiosc> can also be
  controlled through an external MIDI sequencer connected to Pd's MIDI input.
  To these ends, <hlink|MIDI Machine Control|http://en.wikipedia.org/wiki/MIDI-Machine-Control>
  (MMC) can be used to start and stop OSC playback and recording with the
  transport controls of the external sequencer program. To make this work,
  the external sequencer must be configured as an MMC master.

  At the bottom of the abstraction there is a little progress bar along with
  a time display which indicates the current song position. If playback is
  stopped, you can also use these to change the current position for
  playback, recording and a number of other operations as described below.
  Note that if you drive <verbatim|midiosc> from an external MIDI sequencer
  instead, then it is a good idea to load the same MIDI file in
  <verbatim|midiosc> anyway, so that it knows about the length of the MIDI
  sequence. This will make the progress bar display the proper position in
  the file.

  Here is a brief rundown of the available controls:

  <\itemize>
    <item>The <verbatim|start>, <verbatim|stop> and <verbatim|cont> controls
    in the <em|first> row of control elements start, stop and continue MIDI
    and OSC playback, respectively. The <verbatim|midi> toggle in this row
    causes played MIDI events to be printed in the Pd main window.

    <item>The gray \Precord\Q toggle in the upper right corner of the
    abstraction enables recording of OSC controller automation data. Note
    that this toggle merely <em|arms> the OSC recorder; you still have to
    actually start the recording with the <verbatim|start> button. However,
    you can also first start playback with <verbatim|start> and then switch
    recording on and off as needed at any point in the sequence (this is also
    known as \Ppunch in/out\Q recording). In either case, pushing the
    <verbatim|stop> button stores the recorded sequence for later playback.
    Also note that before you can start recording any OSC data, you first
    have to arm the Faust units that you want to record. This is done with
    the \Precord\Q toggle in the Pd GUI of each unit.

    <item>The \Pbang\Q button next to the \Precord\Q toggle lets you record a
    static snapshot of the current parameter settings of all armed units.
    This is also done automatically when starting a fresh recording. The
    \Pbang\Q button lets you change the starting defaults of parameters of an
    existing recording. It is also useful if you just want to record a static
    snapshot of the current parameter settings without recording any live
    parameter changes. Moreover, you can also set the parameters at any given
    point in the piece if you first position the progress bar or the time
    display accordingly; in this case you may first want to recall the
    parameter settings at the given point with the <verbatim|send> button
    described below. In either case, recording must be enabled and playback
    must be <em|off>. Then just arm the Faust units that you wish to record,
    set the playback position as needed, change the controls to what you want
    their values to be (maybe after recalling the current settings), and
    finally push the \Pbang\Q button.

    <item>There are some additional controls related to OSC recording in the
    <em|second> row: <verbatim|save> saves the currently recorded data in an
    OSC file for later use; <verbatim|abort> is like <verbatim|stop> in that
    it stops recording and playback, but also throws away the data recorded
    in this take (rather than keeping it for later playback); and
    <verbatim|clear> purges the entire recorded OSC sequence so that you can
    start a new one.

    <item>Once some automation data has been recorded, it will be played back
    along with the MIDI file. You can then just listen to it, or go on to
    record more automation data as needed. Use the <verbatim|osc> toggle in
    the second row to print the OSC messages as they are played back. If you
    save the automation data with the <verbatim|save> button, it will be
    reloaded from its OSC file next time the patch is opened.

    <item>The controls in the <em|third> row provide some additional ways to
    configure the playback process. The <verbatim|loop> button can be used to
    enable looping, which repeats the playback of the MIDI (and OSC) sequence
    ad infinitum. The <verbatim|thru> button, when switched on, routes the
    MIDI data during playback through Pd's MIDI output so that it can be used
    to drive an external MIDI device in addition to the Faust instruments.
    The <verbatim|write> button does the same with MIDI and OSC controller
    data generated either through automation data or by manually operating
    the control elements in the Pd GUI, see <hlink|External MIDI and OSC
    Controllers|#external-midi-and-osc-controllers> below for details.

    <item>There's one additional button in the third row, the <verbatim|send>
    button which recalls the recorded OSC parameter settings at a given point
    in the sequence. Playback must be off for this to work. After setting the
    playback position as desired, just push the <verbatim|send> button. This
    sets the controls to the current parameter values at the given point, for
    <em|all> parameters which have been recorded up to (and including) this
    point.
  </itemize>

  Please note that <verbatim|midiosc> is merely a prototypical implementation
  which should cover most common uses. It can also be used as a starting
  point for your own abstractions if you need more elaborate input/output
  interfacing than what <verbatim|midiosc> provides.

  <subsubsection|External MIDI and OSC Controllers><label|external-midi-and-osc-controllers>

  For instrument units, the <verbatim|faust~> object has built-in (and
  hard-wired) support for MIDI notes, pitch bend and MIDI controller 123 (all
  notes off). Other controller data received from external MIDI and OSC
  devices is interpreted according to the controller mappings defined in the
  Faust source (this is explained below), by updating the corresponding GUI
  elements and the control variables of the Faust dsp. (This only works with
  <em|active> Faust controls, i.e., dsp controls which are to be manipulated
  from the host environment, not the dsp's <em|passive> a.k.a. \Pbargraph\Q
  controls which return control values computed by the dsp.)

  A <verbatim|faust~> object can also be put in <em|write mode> by feeding a
  message of the form <verbatim|write> <verbatim|1> into its control inlet
  (the <verbatim|write> <verbatim|0> message disables write mode again). For
  convenience, the <verbatim|write> toggle in the <verbatim|midiosc>
  abstraction allows you to do this simultaneously for all Faust units
  connected to <verbatim|midiosc>`s control outlet.

  When an object is in write mode, it also <em|outputs> MIDI and OSC
  controller data in response to both automation data and the manual
  operation of the Pd GUI elements, again according to the controller
  mappings defined in the Faust source, so that it can drive an external
  device, e.g., in order to provide feedback to a MIDI fader box or a
  multitouch OSC controller. This works with both <em|active> and
  <em|passive> Faust controls.

  <with|font-series|bold|Note:> One pitfall in the current implementation is
  that, for better or worse, the output is <em|not> emitted directly on the
  object's control outlet, but instead goes to special <verbatim|midiout> and
  <verbatim|oscout> receivers provided by the <verbatim|midiosc> abstraction
  which then takes care of outputting the data. Thus, if you're <em|not>
  using <verbatim|midiosc>, you will have to provide these receivers yourself
  if you want to process the generated MIDI and/or OSC data in some way (the
  included simple.pd example shows how to do this for MIDI data).

  To configure MIDI controller assignments, the labels of the Faust control
  elements have to be marked up with the special <verbatim|midi> attribute in
  the Faust source. For instance, a pan control (MIDI controller 10) may be
  implemented in the Faust source as follows:

  <\verbatim>
    \;

    pan = hslider("pan [midi:ctrl 10]", 0, -1, 1, 0.01);

    \;
  </verbatim>

  pd-faust will then provide the necessary logic to handle MIDI input from
  controller 10 by changing the pan control in the Faust unit accordingly,
  mapping the controller values 0..127 to the range and step size given in
  the Faust source. Moreover, in write mode corresponding MIDI controller
  data will be generated and sent to the <verbatim|midiout> receiver as
  discussed above, on the MIDI channel specified in the creation arguments of
  the Faust unit (0 meaning \Pomni\Q, i.e., output on all MIDI channels).

  The same functionality is also available for external OSC devices,
  employing explicit OSC controller assignments in the Faust source by means
  of the <verbatim|osc> attribute. E.g., the following enables input and
  output of OSC messages for the OSC <verbatim|/pan> address:

  <\verbatim>
    \;

    pan = hslider("pan [osc:/pan]", 0, -1, 1, 0.01);

    \;
  </verbatim>

  <with|font-series|bold|Note:> In contrast to some other architectures
  included in the Faust distribution, at present pd-faust only allows literal
  OSC addresses (no glob-style patterns), and there is no way to specify an
  OSC value range (so the value ranges of the controls of an external OSC
  device must match the ranges of the corresponding controls in the Faust
  program).

  To actually connect with external OSC devices, you will also need some OSC
  input and output facilities. Older versions of vanilla Pd didn't offer
  these, and the built-in OSC facilities of the latest Pd versions still have
  some limitations, so pd-pure relies on 3rd party externals for that. We
  recommend Martin Peach's <hlink|OSC externals|http://puredata.info/Members/martinrp/OSCobjects>
  which are included in Hans-Christoph Steiner's Pd-extended distribution and
  derivatives such as Pd-l2ork and Purr-Data.

  pd-faust includes a version of the <verbatim|midiosc> abstraction named
  <verbatim|midiosc-mrpeach> which can be used as a drop-in replacement for
  <verbatim|midiosc> and implements OSC input and output using Martin Peach's
  objects. You most likely have to edit this abstraction to make it work for
  your local network setup; at least you'll probably have to change the
  network addresses in the abstraction so that it works with the OSC device
  or application that you use.

  Another useful abstraction is the <verbatim|oscbrowser> object available in
  the author's separate <hlink|pd-mdnsbrowser|https://bitbucket.org/agraef/pd-mdnsbrowser>
  package. It lets you discover and publish Zeroconf (Avahi/Bonjour) services
  in the local network, so that your Pd patches can establish OSC connections
  in an automatic fashion.

  <subsubsection|Tweaking the GUI Layout><label|tweaking-the-gui-layout>

  As already mentioned, pd-faust provides the same global GUI layout options
  as <hlink|<em|faust2pd>|faust2pd.tm>. Please check the faust2pd
  documentation for details. There are a few minor changes in the meaning of
  some of the options, though, which we consider notable improvements after
  some experience working with faust2pd. Here is a brief rundown of the
  available options, as they are implemented in pd-faust:

  <\itemize>
    <item><verbatim|width=wd>, <verbatim|height=ht>: Specify the maximum
    horizontal and/or vertical dimensions of the layout area. If one or both
    of these values are nonzero, pd-faust will try to make the GUI fit within
    this area.

    <item><verbatim|font-size=sz>: Specify the font size (default is 10).

    <item><verbatim|fake-buttons>: Render <verbatim|button> controls as Pd
    toggles rather than bangs.

    <item><verbatim|radio-sliders=max>: Render sliders with up to
    <verbatim|max> different values as Pd radio controls rather than Pd
    sliders. Note that in pd-faust this option not only applies to sliders,
    but also to numeric entries, i.e., <verbatim|nentry> in the Faust source.
    However, as with faust2pd's <verbatim|radio-sliders> option, the option
    is only applicable if the control is zero-based and has a stepsize of 1.

    <item><verbatim|slider-nums>: Add a number box to each slider control.
    Note that in pd-faust this is actually the default, which can be disabled
    with the <verbatim|no-slider-nums> option.

    <item><verbatim|exclude=pat,...>: Exclude the controls whose labels match
    the given glob patterns from the Pd GUI.
  </itemize>

  In pd-faust there is no way to specify the above options on the command
  line, so you'll have to put them as <verbatim|pd> attributes on the
  <em|main> group of your Faust program, as described in the faust2pd
  documentation. For instance:

  <\verbatim>
    \;

    process = vgroup("[pd:no-slider-nums][pd:font-size=12]", ...);

    \;
  </verbatim>

  In addition, the following options can be used to change the appearance of
  individual control items. If present, these options override the
  corresponding defaults. Each option can also be prefixed with
  \P<verbatim|no->\Q to negate the option value. (Thus, e.g.,
  <verbatim|no-hidden> makes items visible which would otherwise, by means of
  the global <verbatim|exclude> option, be removed from the GUI.)

  <\itemize>
    <item><verbatim|hidden>: Hides the corresponding control in the Pd GUI.
    This is the only option which can also be used for group controls, in
    which case <em|all> controls in the group will become invisible in the Pd
    GUI.

    <item><verbatim|fake-button>, <verbatim|radio-slider>,
    <verbatim|slider-num>: These have the same meaning as the corresponding
    global options, but apply to individual control items.
  </itemize>

  Again, these options are specified with the <verbatim|pd> attribute in the
  label of the corresponding Faust control. For instance, the following Faust
  code hides the controls in the <verbatim|aux> group, removes the number
  entry from the <verbatim|pan> control, and renders the <verbatim|preset>
  item as a Pd radio control:

  <\verbatim>
    \;

    aux = vgroup("aux [pd:hidden]", aux_part);

    pan = hslider("pan [pd:no-slider-num]", 0, -1, 1, 0.01);

    preset = nentry("preset [pd:radio-slider]", 0, 0, 7, 1);

    \;
  </verbatim>

  <subsubsection|Remote Control><label|remote-control>

  Also included in the sources is a helper abstraction faust-remote.pd and an
  accompanying elisp package faust-remote.el. These work pretty much like
  pure-remote.pd and pure-remote.el in the <hlink|<em|pd-pure>|pd-pure.tm>
  distribution, but are tailored for the remote control of Faust dsps in a Pd
  patch. In particular, they enable you to quickly compile Faust sources
  (<verbatim|C-C> <verbatim|C-K> command) and reload the compiled dsps in Pd
  (<verbatim|C-C> <verbatim|C-X>) from Emacs. Clicking the bang control in
  the faust-remote.pd abstraction also reloads all Faust dsps.

  The faust-remote.el package was designed to be used with Juan Romero's
  Emacs <hlink|Faust mode|https://github.com/rukano/emacs-faust-mode>; please
  see etc/faust-remote.el in the pd-faust source for usage instructions. Note
  that at present faust-remote.el isn't installed automatically. You can do
  this manually by just copying the file to your Emacs site-lisp directory or
  any other location on the Emacs load-path. E.g., on Linux and other
  Unix-like systems:

  <\verbatim>
    \;

    sudo cp etc/faust-remote.el /usr/share/emacs/site-lisp/

    \;
  </verbatim>

  To enable the package, put the following line into your .emacs
  configuration file (this also auto-loads <hlink|Faust
  mode|https://github.com/rukano/emacs-faust-mode>):

  <\verbatim>
    \;

    (require 'faust-remote)

    \;
  </verbatim>

  <subsection|Caveats and Bugs><label|caveats-and-bugs>

  Some parts of this software might still be experimental, under construction
  and/or bug-ridden. Bug reports, patches and suggestions are welcome.

  In particular, please note the following known limitations in the current
  implementation:

  <\itemize>
    <item>Passive Faust controls are only supported in effect units
    (<verbatim|faust~> objects with zero voices).

    <item>The names of the voice controls of instrument units
    (<verbatim|freq>, <verbatim|gain>, <verbatim|gate>) are currently
    hard-coded, as are the names of the <verbatim|midi>, <verbatim|osc> and
    <verbatim|dsp> subfolders used to locate various kinds of files.

    <item>Polyphonic aftertouch and channel pressure messages are not
    supported in the MIDI interface right now, so you'll have to use ordinary
    MIDI controllers for these parameters instead. Coarse/fine pairs of MIDI
    controllers aren't directly supported either, so you'll have to implement
    these yourself as two separate Faust controls.

    <item>There's no translation of OSC values. pd-faust thus always assumes
    that the controls of an external OSC device have the ranges specified in
    the Faust program. If this isn't the case then you'll have to adjust
    either the OSC controller setup or the control ranges in the Faust
    program, or use an external tool like
    <hlink|OSCulator|http://www.osculator.net/> to translate the messages.
  </itemize>

  Also, please check the TODO file included in the distribution for other
  issues which we are already aware of and which will hopefully be addressed
  in future pd-faust versions.

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pd-faust-toc>

  <\itemize>
    <item><hlink|pd-faust|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <\itemize>
        <item><hlink|Compiling Faust DSPs|#compiling-faust-dsps>

        <item><hlink|The faust<math|\<sim\>> Object|#the-faust-object>

        <item><hlink|Effect and Synth Units|#effect-and-synth-units>

        <item><hlink|GUI Subpatches|#gui-subpatches>

        <item><hlink|Examples|#examples>

        <item><hlink|Operating the Patches|#operating-the-patches>

        <item><hlink|MIDI and OSC Sequencing|#midi-and-osc-sequencing>

        <item><hlink|External MIDI and OSC
        Controllers|#external-midi-and-osc-controllers>

        <item><hlink|Tweaking the GUI Layout|#tweaking-the-gui-layout>

        <item><hlink|Remote Control|#remote-control>
      </itemize>

      <item><hlink|Caveats and Bugs|#caveats-and-bugs>
    </itemize>
  </itemize>

  Previous topic

  <hlink|faust2pd: Pd Patch Generator for Faust|faust2pd.tm>

  Next topic

  <hlink|pd-pure: Pd loader for Pure scripts|pd-pure.tm>

  <hlink|toc|#pd-faust-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pd-pure.tm> \|
  <hlink|previous|faust2pd.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2018, Albert Gräf et al. Last updated on Mar
  01, 2018. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
