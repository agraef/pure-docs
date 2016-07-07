<TeXmacs|1.99.4>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pd-faust-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pd-pure.tm> \|
  <hlink|previous|faust2pd.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pd-faust><label|pd-faust>

  Version 0.10, July 07, 2016

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  pd-faust is a dynamic environment for running Faust dsps in Pd. It is based
  on the author's <hlink|<em|faust2pd>|faust2pd.tm> script, but offers many
  small improvements and some major additional features:

  <\itemize>
    <item>Faust dsps are implemented using two Pd objects, <verbatim|fsynth~>
    and <verbatim|fdsp~>, which provide the necessary infrastructure to run
    Faust synthesizer and effect units in Pd, respectively. As of pd-faust
    0.10, there's also a <verbatim|faust~> convenience object which unifies
    <verbatim|fsynth~> and <verbatim|fdsp~> and provides reasonable defaults
    for most creation arguments.

    <item>In contrast to faust2pd, the Pd GUI of Faust units is generated
    dynamically, inside Pd. While pd-faust supports the same global GUI
    layout options as faust2pd, it also provides various options to adjust
    the layout of individual control items.

    <item>pd-faust recognizes the <verbatim|midi> and <verbatim|osc>
    controller attributes in the Faust source and automatically provides
    corresponding MIDI and OSC controller mappings. OSC-based controller
    automation is also available.

    <item>Perhaps most importantly, Faust dsps can be reloaded at any time
    (even while the Pd patch is running), in which case the GUI and the
    controller mappings are regenerated automatically and on the fly as
    needed.
  </itemize>

  <subsection|Copying><label|copying>

  Copyright (c) 2011-2016 by Albert Graef

  pd-faust is distributed under the GNU LGPL v3+. Please see the included
  COPYING and COPYING.LESSER files for details.

  This package also includes the faust-stk instruments which are distributed
  under an MIT-style license, please check the examples/dsp/README-STK file
  and the dsp files for authorship information and licensing details
  pertaining to these. The original faust-stk sources can be found in the
  Faust distribution, cf. <hlink|http://faust.grame.fr/|http://faust.grame.fr/>.

  <subsection|Installation><label|installation>

  You'll need <hlink|Faust|http://faust.grame.fr/> and
  <hlink|Pd|http://puredata.info/>, obviously. Fairly recent versions of
  these are required. Faust versions \<gtr\>= 0.9.46 and 2.0.a3 and Pd
  version \<gtr\>= 0.43.1 have been tested and are known to work.

  The pd-faust objects are written in the
  <hlink|Pure|http://purelang.bitbucket.org/> programming language, so you'll
  also need an installation of the Pure interpreter (0.51 or later), along
  with the following packages (minimum required versions are given in
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
  popular alternative Pd distributions available on the web.

  Some further build options are described in the Makefile. In particular, it
  is possible to compile the Faust dsps to LLVM bitcode which can be loaded
  directly by the Pure interpreter, but for that you'll need a special Faust
  version (see the <hlink|Faust2|https://bitbucket.org/purelang/pure-lang/wiki/Faust2>
  website for how to get this version up and running) and an LLVM-capable
  C/C++ compiler such as clang or gcc with the dragonegg plugin (please check
  the Makefile and the <hlink|LLVM|http://llvm.org/> website for details).

  If you have the required tools then you can build the bitcode modules by
  running <verbatim|make> <verbatim|bitcode> after <verbatim|make>. If you
  run <verbatim|make> <verbatim|install> afterwards, the bitcode modules will
  be installed along with the \Pnormal\Q Faust plugins. In addition, a second
  object library called <verbatim|pdfaust2> will be built and installed,
  which can be used as a drop-in replacement for <verbatim|pdfaust> and lets
  you run the bitcode modules. (Note that in the present implementation it is
  not possible to load both <verbatim|pdfaust> and <verbatim|pdfaust2> in Pd,
  you'll have to pick one or the other.)

  <subsection|Usage><label|usage>

  Working with pd-faust basically involves adding a bunch of
  <verbatim|faust~> (or the underlying <verbatim|fsynth~> and
  <verbatim|fdsp~>) objects to a Pd patch along with the corresponding GUI
  subpatches, and wiring up the Faust units in some variation of a
  synth-effects chain which typically takes input from Pd's MIDI interface
  (<verbatim|notein>, <verbatim|ctlin>, etc.) and outputs the signals
  produced by the Faust units to Pd's audio interface (<verbatim|dac~>).

  For convenience, pd-faust also includes the <verbatim|midiseq> and
  <verbatim|oscseq> objects and a corresponding <verbatim|midiosc>
  abstraction which can be used to handle MIDI input and playback as well as
  OSC controller automation. This useful helper abstraction is described in
  more detail under <hlink|Operating the Patches|#operating-the-patches>
  below.

  <with|font-series|bold|Note:> pd-faust interprets MIDI, OSC and Faust dsp
  filenames relative to the hosting Pd patch by default. It will also search
  the <verbatim|midi>, <verbatim|osc> and <verbatim|dsp> subfolders, if they
  exist, for the corresponding types of files. Failing that, it finally
  searches the directories on the Pd library path (including their
  <verbatim|midi>, <verbatim|osc> and <verbatim|dsp> subfolders). To disable
  this search, just use absolute pathnames (or pathnames relative to the
  <verbatim|.> or <verbatim|..> directory) instead.

  <subsubsection|The fdsp<math|\<sim\>> and fsynth<math|\<sim\>>
  Objects><label|the-fdsp-and-fsynth-objects>

  The <verbatim|fdsp~> object is invoked as follows:

  <\verbatim>
    \;

    fdsp~ dspname instname channel

    \;
  </verbatim>

  <\itemize>
    <item><verbatim|dspname> denotes the name of the Faust dsp (usually this
    is just the name of the .dsp file with the extension stripped off).
    Please note that the Faust dsp must be provided in a form which can be
    loaded in <em|Pure> (not Pd!), so the <verbatim|pure.cpp> architecture
    (included in the Faust distribution) must be used to compile the dsp to a
    shared library. (If you're already running
    <hlink|Faust2|https://bitbucket.org/purelang/pure-lang/wiki/Faust2>, you
    can also compile to an LLVM bitcode file instead; Pure has built-in
    support for loading these.) There's a GNU Makefile in the examples/dsp
    subdirectory which shows how to do this. This Makefile is self-contained,
    so you can just drop it into any directory with Faust dsp sources and run
    <verbatim|make> there to compile the modules to a format which is ready
    to be loaded with pd-faust.

    <item><verbatim|instname> denotes the name of the instance of the Faust
    unit. Multiple instances of the same Faust dsp can be used in a Pd patch,
    which must all have different instance names. In addition, the instance
    name is also used to identify the GUI subpatch of the unit (see below)
    and to generate unique OSC addresses for the unit's control elements.

    <item><verbatim|channel> is the number of the MIDI channel the unit
    responds to. This can be 1..16, or 0 to specify \Pomni\Q operation
    (listen to MIDI messages on all channels).
  </itemize>

  <with|font-series|bold|Note:> Since the <verbatim|fdsp~> and
  <verbatim|fsynth~> objects are written in Pure, their creation arguments
  should be specified in Pure syntax. In particular, both <verbatim|dspname>
  or <verbatim|instname> may either be Pure identifiers or double-quoted
  strings (the former will automatically be translated to the latter).
  Similarly, the <verbatim|channel> argument (as well as the
  <verbatim|numvoices> argument of the <verbatim|fsynth~> object, see below)
  must be an integer constant in Pure syntax, which is pretty much like Pd
  syntax but also allows the integer to be specified in hexadecimal, octal or
  binary.

  The <verbatim|fdsp~> object requires a Faust dsp which can work as an
  effect unit, processing audio input and producing audio output. The unit
  can have as many audio input and output channels as you like (including
  zero).

  The <verbatim|fsynth~> object works in a similar fashion, but has an
  additional creation argument specifying the desired number of voices:

  <\verbatim>
    \;

    fsynth~ dspname instname channel numvoices

    \;
  </verbatim>

  The <verbatim|fsynth~> object requires a Faust dsp which can work as a
  monophonic synthesizer. This typically means that the unit has zero audio
  inputs and a nonzero number of audio outputs, although it is possible to
  have synths processing any number of audio input channels as well. (You can
  even have synths producing zero audio outputs, but this is generally not
  very useful.) In addition, pd-faust assumes that the Faust unit provides
  three so-called \Pvoice controls\Q which indicate which note to play:

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
  logic to drive the given number of voices of an <verbatim|fsynth~> object.
  That is, it will actually create a separate instance of the Faust dsp for
  each voice and handle polyphony by allocating voices from this pool in a
  round-robin fashion, performing the usual voice stealing if the number of
  simultaneous notes to play exceeds the number of voices. Also note that an
  <verbatim|fsynth~> operated in omni mode (<verbatim|channel> <verbatim|=>
  <verbatim|0>) automatically filters out messages on channel 10 which is
  reserved for percussion in the General MIDI standard.

  The <verbatim|fdsp~> and <verbatim|fsynth~> objects respond to the
  following messages:

  <\itemize>
    <item><verbatim|bang> outputs the current control settings on the control
    outlet in OSC format.

    <item><verbatim|write> outputs the current control settings to external
    MIDI and/or OSC devices. This message can also be invoked with a numeric
    argument to toggle the \Pwrite mode\Q of the unit; please see
    <hlink|External MIDI and OSC Controllers|#external-midi-and-osc-controllers>
    below for details.

    <item><verbatim|reload> reloads the Faust unit. This also reloads the
    shared library or bitcode file if the unit was recompiled since the
    object was last loaded. (Instead of feeding a <verbatim|reload> message
    to the control inlet of a Faust unit, you can also just send a
    <verbatim|bang> to the <verbatim|reload> receiver.)

    <item><verbatim|addr> <verbatim|value> changes the control indicated by
    the OSC address <verbatim|addr>. This is also used internally for
    communication with the Pd GUI and for controller automation.
  </itemize>

  In addition, the <verbatim|fdsp~> and <verbatim|fsynth~> objects respond to
  MIDI controller messages of the form <verbatim|ctl> <verbatim|val>
  <verbatim|num> <verbatim|chan>, and the <verbatim|fsynth~> object also
  understands note-related messages of the form <verbatim|note>
  <verbatim|num> <verbatim|vel> <verbatim|chan> (note on/off) and
  <verbatim|bend> <verbatim|val> <verbatim|chan> (pitch bend). In either
  case, pd-faust provides the necessary logic to map controller and
  note-related messages to the corresponding control changes in the Faust
  unit.

  <with|font-series|bold|Note:> Like pd-pure, pd-faust also remaps Pd's
  <verbatim|menu-open> command so that it lets you edit the Faust source of
  an <verbatim|fdsp~> or <verbatim|fsynth~> object by right-clicking on the
  object and choosing <verbatim|Open> from the context menu.

  <subsubsection|The faust<math|\<sim\>> Object><label|the-faust-object>

  Starting with version 0.10, pd-faust includes the <verbatim|faust~>
  external as a convenience which provides the functionality of both
  <verbatim|fdsp~> and <verbatim|fsynth~> in a single object. This object
  also supplies reasonable defaults for most arguments. While the underlying
  <verbatim|fdsp~> and <verbatim|fsynth~> objects are still available for
  backward compatibility, the <verbatim|faust~> object is often much easier
  to use and should be considered the preferred way to create Faust objects
  in a Pd patch now.

  The <verbatim|faust~> object is invoked as follows:

  <\verbatim>
    \;

    fsynth~ dspname [instname] [channel] [numvoices]

    \;
  </verbatim>

  As indicated, all creation arguments except the first, <verbatim|dspname>
  argument are optional. The meaning of these arguments is the same as with
  the <verbatim|fdsp~> and <verbatim|fsynth~> objects. A <verbatim|numvoices>
  value of zero can be used to indicate an effect unit. If the
  <verbatim|numvoices> argument is omitted, the <verbatim|faust~> object
  checks the meta data of the Faust module to see whether the loaded Faust
  module is an effect or a synth and creates an instance of the corresponding
  underlying object (<verbatim|fdsp~> or <verbatim|fsynth~>).

  Note that if only a single number follows the <verbatim|dspname> or
  <verbatim|instname> argument then it is always interpreted as a channel
  number; thus, if you want to denote the <verbatim|numvoices> argument then
  you'll have to specify <em|both> <verbatim|channel> and
  <verbatim|numvoices>, in that order.

  By default, the instance name is assumed to be the same as the dsp name,
  the default MIDI channel is 0 (omni), and the number of voices of an
  instrument is determined using the value of the <verbatim|nvoices> meta key
  declared in the dsp source. Thus, to turn a Faust dsp into a synth with 8
  voices you can use a declaration like the following anywhere in the Faust
  program:

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
  can explicitly specify different instance names using the
  <verbatim|instname> argument, and the default <verbatim|channel> value of
  zero (denoting omni input) can be overridden as needed if the unit should
  only listen on a specific MIDI channel.

  <subsubsection|GUI Subpatches><label|gui-subpatches>

  For each <verbatim|faust~>, <verbatim|fdsp~> and <verbatim|fsynth~> object,
  the Pd patch may contain an (initially empty) \Pone-off\Q graph-on-parent
  subpatch with the same name as the instance name of the Faust unit:

  <\verbatim>
    \;

    pd instname

    \;
  </verbatim>

  You shouldn't insert anything into this subpatch, its contents (a bunch of
  Pd GUI elements corresponding to the control elements of the Faust unit)
  will be generated automatically by pd-faust when the corresponding
  <verbatim|faust~>, <verbatim|fdsp~> or <verbatim|fsynth~> object is
  created, and whenever the unit gets reloaded at runtime.

  As with faust2pd, the default appearance of the GUI can be adjusted in
  various ways; see <hlink|Tweaking the GUI Layout|#tweaking-the-gui-layout>
  below for details.

  The relative order in which you insert a <verbatim|faust~>,
  <verbatim|fdsp~> or <verbatim|fsynth~> object and its GUI subpatch into the
  main patch matters. Normally, the GUI subpatch should be inserted
  <em|first>, so that it will be updated automatically when its associated
  Faust unit is first created, and also when the main patch is saved and then
  reloaded later.

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
  this all works. Having installed pd-faust as described above, you can run
  these from the examples directory, e.g.: <verbatim|pd> <verbatim|test.pd>.
  (You can also run the examples without actually installing pd-faust if you
  invoke Pd from the main pd-faust source directory, e.g., as follows:
  <verbatim|pd> <verbatim|-lib> <verbatim|lib/pdfaust>
  <verbatim|examples/test.pd>.)

  Here are some of the examples that are currently available:

  <\itemize>
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
  information about these.

  The MIDI files are all in standard MIDI file format. (Some of these come
  from the faust-stk distribution, others can be found on the web.) The OSC
  files used by pd-faust for controller automation are plain ASCII files
  suitable for hand-editing if you know what you are doing; the format should
  be fairly self-explanatory.

  <subsubsection|Operating the Patches><label|operating-the-patches>

  The generated Pd GUI elements for the Faust dsps are pretty much the same
  as with <hlink|<em|faust2pd>|faust2pd.tm> (which see). The only obvious
  change is the addition of a \Precord\Q button (gray toggle in the upper
  right corner) which enables recording of OSC automation data.

  In each example distributed with pd-faust you can also find an instance of
  the <verbatim|midiosc> abstraction which serves as a little sequencer
  applet that enables you to control MIDI playback and OSC recording. The
  usage of this abstraction should be fairly obvious, but you can also find a
  brief description below.

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
  generated MIDI and other messages to the connected <verbatim|fsynth~> and
  <verbatim|fdsp~> objects. Live MIDI input is also accepted and forwarded to
  the control outlet, after being translated to the format understood by
  <verbatim|fsynth~> and <verbatim|fdsp~> objects. In addition,
  <verbatim|midiosc> can also be controlled through an external MIDI
  sequencer connected to Pd's MIDI input. To these ends, <hlink|MIDI Machine
  Control|http://en.wikipedia.org/wiki/MIDI-Machine-Control> (MMC) can be
  used to start and stop OSC playback and recording with the transport
  controls of the external sequencer program. To make this work, the external
  sequencer must be configured as an MMC master.

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
  interfacing than what <verbatim|midiosc> provides. On the other hand, for
  simple uses your patches may just feed control messages directly into
  <verbatim|faust~>, <verbatim|fdsp~> and <verbatim|fsynth~> objects instead.
  If you just need plain MIDI input, another possibility is to use the
  <verbatim|midi-input> abstraction contained in the author's
  <hlink|pd-lv2plugin|https://bitbucket.org/agraef/pd-lv2plugin> package
  which encodes incoming MIDI messages in a format compatible with the
  <verbatim|faust~>, <verbatim|fdsp~> and <verbatim|fsynth~> objects.

  <subsubsection|External MIDI and OSC Controllers><label|external-midi-and-osc-controllers>

  The <verbatim|fsynth~> object has built-in (and hard-wired) support for
  MIDI notes, pitch bend and MIDI controller 123 (all notes off). Other
  controller data received from external MIDI and OSC devices is interpreted
  according to the controller mappings defined in the Faust source (this is
  explained below), by updating the corresponding GUI elements and the
  control variables of the Faust dsp. For obvious reasons, this only works
  with <em|active> Faust controls.

  A <verbatim|faust~>, <verbatim|fdsp~> or <verbatim|fsynth~> object can also
  be put in <em|write mode> by feeding a message of the form <verbatim|write>
  <verbatim|1> into its control inlet (the <verbatim|write> <verbatim|0>
  message disables write mode again). For convenience, the <verbatim|write>
  toggle in the <verbatim|midiosc> abstraction allows you to do this
  simultaneously for all Faust units connected to <verbatim|midiosc>`s
  control outlet.

  When an object is in write mode, it also <em|outputs> MIDI and OSC
  controller data in response to both automation data and the manual
  operation of the Pd GUI elements, again according to the controller
  mappings defined in the Faust source, so that it can drive an external
  device such as a MIDI fader box or a multitouch OSC controller. Note that
  this works with both <em|active> and <em|passive> Faust controls.

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
  data will be generated and sent to Pd's MIDI output, on the MIDI channel
  specified in the creation arguments of the Faust unit (0 meaning \Pomni\Q,
  i.e., output on all MIDI channels).

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
  input and output facilities. Neither vanilla Pd nor pd-faust includes any
  of these, so you will have to rely on 3rd party externals for that. We
  recommend Martin Peach's <hlink|OSC externals|http://puredata.info/Members/martinrp/OSCobjects>
  which are included in Hans-Christoph Steiner's
  <hlink|Pd-extended|http://puredata.info/downloads/pd-extended>
  distribution. pd-faust includes a version of the <verbatim|midiosc>
  abstraction named <verbatim|midiosc-mrpeach> which can be used as a drop-in
  replacement for <verbatim|midiosc> and implements OSC input and output
  using Martin Peach's objects. You most likely have to edit this abstraction
  to make it work for your local network setup; at least you'll probably have
  to change the network addresses in the abstraction so that it works with
  the OSC device or application that you use.

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
  accompanying elisp program faust-remote.el. These work pretty much like
  pure-remote.pd and pure-remote.el in the <hlink|<em|pd-pure>|pd-pure.tm>
  distribution, but are tailored for the remote control of Faust dsps in a Pd
  patch. In particular, they enable you to quickly reload the Faust dsps in
  Pd using a simple keyboard command (<verbatim|C-C> <verbatim|C-X> by
  default) from Emacs. The faust-remote.el program was designed to be used
  with Juan Romero's Emacs <hlink|Faust mode|https://github.com/rukano/emacs-faust-mode>;
  please see etc/faust-remote.el in the pd-faust source for usage
  instructions.

  <subsection|Caveats and Bugs><label|caveats-and-bugs>

  Some parts of this software might still be experimental, under construction
  and/or bug-ridden. Bug reports, patches and suggestions are welcome. Please
  send these directly to the author, or post them either to the Faust or the
  Pure mailing list.

  In particular, please note the following known limitations in the current
  implementation:

  <\itemize>
    <item>Passive Faust controls are only supported in <verbatim|fdsp~>
    objects.

    <item>The names of the voice controls in the <verbatim|fsynth~> object
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
        <item><hlink|The fdsp<math|\<sim\>> and fsynth<math|\<sim\>>
        Objects|#the-fdsp-and-fsynth-objects>

        <item><hlink|The faust<math|\<sim\>> Object|#the-faust-object>

        <item><hlink|GUI Subpatches|#gui-subpatches>

        <item><hlink|Examples|#examples>

        <item><hlink|Operating the Patches|#operating-the-patches>

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

  <copyright> Copyright 2009-2016, Albert Gräf et al. Last updated on Jul
  07, 2016. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
