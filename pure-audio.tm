<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-audio-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-faust.tm> \|
  <hlink|previous|pd-pure.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-audio<label|module-audio>>

  <label|module-fftw><label|module-sndfile><label|module-samplerate><label|module-realtime>Version
  0.6, March 24, 2014

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  This is a digital audio interface for the Pure programming language. It
  currently includes the following modules:

  <\itemize>
    <item>audio.pure: A PortAudio wrapper which gives you portable access to
    realtime audio input and output on a variety of different host APIs. This
    uses the well-known PortAudio library by Ross Bencina, Phil Burk et al,
    see <hlink|http://www.portaudio.com/|http://www.portaudio.com/>.

    <item>fftw.pure: Compute real-valued FFTs of audio signals using Matteo
    Frigo's and Steven G. Johnson's portable and fast FFTW library (``Fastest
    Fourier Transform in the West'').

    <item>sndfile.pure: Reading and writing audio files in various formats.
    This is a fairly straightforward wrapper for Erik de Castro Lopo's
    libsndfile library, see <hlink|http://www.mega-nerd.com/libsndfile/|http://www.mega-nerd.com/libsndfile/>.

    <item>samplerate.pure: Perform sample rate conversion on audio data. This
    uses another of Erik's excellent libraries, libsamplerate (a.k.a. SRC),
    see <hlink|http://www.mega-nerd.com/SRC/|http://www.mega-nerd.com/SRC/>.

    <item>realtime.pure: A little utility module which provides access to
    realtime scheduling to Pure programs. You may need this for low-latency
    realtime audio applications.
  </itemize>

  Documentation still needs to be written, so for the time being please read
  the source modules listed above and have a look at the examples provided in
  the distribution.

  <subsection|Installation<label|installation>>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-audio-0.6.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-audio-0.6.tar.gz>.

  You need to have libportaudio (v19), libsndfile (1.x), libsamplerate
  (0.1.x) and libfftw3 (3.x) installed on your system. Any fairly recent
  version of these libraries should do. For the realtime module you also need
  a POSIX threads library (libpthread) with the POSIX realtime thread
  extension; Linux, OSX and other Un*x systems should offer this.

  The Pure wrappers contained in the distribution are for 64 bit POSIX
  systems. If you're running a 32 bit system, or Windows, then you should
  regenerate them using `make generate'. This requires the header files
  portaudio.h, samplerate.h and sndfile.h (and pure-gen, of course). If you
  do this, check the includedir variables defined in the Makefiles, these
  need to point to the directories where the corresponding header files are
  to be found (the default is /usr/include).

  Then just run `make' to compile the package. If you're lucky and everything
  compiles smoothly, you can install with `sudo make install'.

  If you're not so lucky, you can get help on the Pure mailing list, see
  <hlink|http://groups.google.com/group/pure-lang|http://groups.google.com/group/pure-lang>.

  <subsection|License<label|license>>

  pure-audio is Copyright (c) 2010 by Albert Graef, licensed under the
  3-clause BSD license, see the COPYING file for details.

  Please note that if you're using these modules, you're also bound by the
  license terms of the PortAudio, libsamplerate and libsndfile libraries they
  are based on, see the corresponding sources and websites for details.

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-audio-toc>>

  <\itemize>
    <item><hlink|pure-audio|#>

    <\itemize>
      <item><hlink|Installation|#installation>

      <item><hlink|License|#license>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pd-pure: Pd loader for Pure scripts|pd-pure.tm>

  Next topic

  <hlink|pure-faust|pure-faust.tm>

  <hlink|toc|#pure-audio-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-faust.tm> \|
  <hlink|previous|pd-pure.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Mar
  24, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
