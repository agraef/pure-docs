<TeXmacs|1.99.5>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-gl-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gtk.tm> \|
  <hlink|previous|pure-g2.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Pure OpenGL Bindings><label|pure-opengl-bindings>

  Version 0.9, March 04, 2017

  Scott Dillard

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  These are fairly complete Pure bindings for the OpenGL graphics library,
  which allow you to do 2D and 3D graphics programming with Pure. The
  bindings should work out of the box on most contemporary systems which have
  OpenGL drivers installed, thanks to Scott's on-demand loading code for the
  GL functions, which accounts for the fact that different GL implementations
  will export different functions. (Mostly to account for Microsoft's Museum
  of Ancient OpenGL History, otherwise known as opengl32.dll.)

  Information about OpenGL can be found at:
  <hlink|http://www.opengl.org/|http://www.opengl.org/>

  As of pure-gl 0.5, the bindings are now generated using pure-gen instead of
  Scott's original OpenGL-specific generator. The stuff needed to do this is
  included (except pure-gen, which is a separate package available from the
  Pure website), so that you can regenerate the bindings if necessary.

  <subsection|Copying><label|copying>

  Copyright (c) 2009, Scott E Dillard

  Copyright (c) 2009, Albert Graef

  Copyright (c) 2002-2005, Sven Panne

  pure-gl is distributed under a 3-clause BSD-style license, please see the
  accompanying COPYING file for details.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-gl-0.9.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-gl-0.9.tar.gz>.

  Normally you just run <verbatim|make> <verbatim|&&> <verbatim|sudo>
  <verbatim|make> <verbatim|install>, as with the other Pure modules. (See
  The Makefile for further options.) This doesn't regenerate the bindings and
  so can be done on any system which has Pure, OpenGL and a C compiler
  installed.

  If you miss some vendor-specific OpenGL functionality which is in your
  system's header files but not in the distributed bindings, with some effort
  you can fix that yourself by regenerating the bindings, see below.

  <subsection|Using the GL Bindings><label|module-GL><label|module-GLU><label|module-GLUT><label|module-GL-ARB><label|module-GL-EXT><label|module-GL-NV><label|module-GL-ATI><label|module-GL>

  The bindings mainly consist of 3 Pure files: GL.pure, GLU.pure and
  GLUT.pure.

  In your Pure program, write something like:

  <\verbatim>
    \;

    using GL, GLU, GLUT;

    \;
  </verbatim>

  GL.pure covers OpenGL up through version 2.1. To get access to extensions,
  you include GL_XXX.pure where XXX is the extensions suffix. Currently,
  there are GL_ARB.pure, GL_EXT.pure, GL_NV.pure and GL_ATI.pure, which
  should cover about 99% of the useful extensions out there. If you need more
  than that, it is straightforward to tweak the Makefile to scrape some of
  the more esoteric extensions from your headers. All OpenGL functions are
  loaded on first use. If your OpenGL implementation does not define a given
  function, a <verbatim|gl_unsupported> exception is thrown with the name of
  the function as its only argument.

  The functions are in namespaces GL, GLU and GLUT respectively. Functions
  are in curried form, i.e.:

  <\verbatim>
    \;

    GL::Vertex3d 1.0 2.0 3.0;

    \;
  </verbatim>

  GL enumerants are in uppercase, as in C:

  <\verbatim>
    \;

    GL::Begin GL::LINE_STRIP;

    \;
  </verbatim>

  Currently, if the GLU or GLUT bindings reference a function that your DLL
  does not contain, it echoes this to stdout. I'm working on a way to supress
  this.

  Some examples can be found in the examples subdirectory. This also includes
  a wrapper of Rasterman's imlib2 library (also generated with pure-gen), and
  an example which uses this to render an image as a texture.

  The examples/flexi-line directory contains Eduardo Cavazos' port of the
  flexi-line demo. Run <verbatim|pure> <verbatim|flexi-line-auto.pure>, sit
  back and enjoy. There's also an interactive version of the demo available
  in flexi-line.pure.

  <subsection|Regenerating the Bindings><label|regenerating-the-bindings>

  You need to have pure-gen installed to do this.

  Also make sure that you have the OpenGL headers installed. By default, the
  Makefile assumes that they are in the GL subdirectory of /usr/include, you
  can set the <verbatim|glpath> variable in the Makefile accordingly to
  change this. (Set <verbatim|glpath> to the path under which the GL
  subdirectory resides, not to the GL subdirectory itself. See below for an
  example.) Note that on Linux systems, /usr/include/GL usually contains the
  MESA headers. If available, you may want to use your GPU vendor's headers
  instead, to get all the extensions available on your system.

  Alternatively, you can also just put the headers (gl.h, glext.h, glu.h,
  glut.h, and any other OpenGL headers that get #included in those) into the
  GL subdirectory of the pure-gl sources, by copying them over or creating
  symbolic links to them. This is particularly useful for maintainers, who
  may want to use a \Pstaged\Q header set which is different from the
  installed OpenGL headers. The \Q.\Q directory will always be searched
  first, so you can also just put the vendor-specific headers there. For
  instance, if you're like Scott and you use Ubuntu with an Nvidia GPU, then
  you can do this:

  <\verbatim>
    \;

    cd pure-gl/GL

    ln -s /usr/share/doc/nvidia-glx-new-dev/include/GL/gl.h

    ln -s /usr/share/doc/nvidia-glx-new-dev/include/GL/glext.h

    \;
  </verbatim>

  Finally, the Makefile also assumes that you have freeglut (an improved GLUT
  replacement) installed and want all the extensions offered by freeglut. To
  use the vanilla GLUT without the extensions instead, you only have to
  change the value of the <verbatim|source> variable in the Makefile from
  GL/all_gl_freeglut.h to GL/all_gl.h. If you use openglut instead of
  freeglut you will have to change the GL/all_gl_freeglut.h file accordingly.

  Once you have set up things to your liking, you can regenerate the bindings
  by running make as follows:

  <\verbatim>
    \;

    make generate

    \;
  </verbatim>

  If you need a custom path to the OpenGL headers as described above (say,
  /usr/local/include) then do this instead:

  <\verbatim>
    \;

    make generate glpath=/usr/local/include

    \;
  </verbatim>

  If you're lucky, this will regenerate all the GL*.pure and GL*.c files, and
  recompile the shared module from the GL*.c files after that. This shared
  module, instead of the OpenGL libraries themselves, is what gets loaded by
  the Pure modules.

  If you're not so lucky, save a complete build log with all the error
  messages and ask on the pure-lang mailing list for help.

  See the \PGenerator stuff\Q section in the Makefile for further options.
  Adding a rule for other extensions should be easy, just have a look at an
  existing one (e.g., GL_EXT.c) and modify it accordingly.

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-gl-toc>

  <\itemize>
    <item><hlink|Pure OpenGL Bindings|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Using the GL Bindings|#module-GL>

      <item><hlink|Regenerating the Bindings|#regenerating-the-bindings>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-g2|pure-g2.tm>

  Next topic

  <hlink|Pure GTK+ Bindings|pure-gtk.tm>

  <hlink|toc|#pure-gl-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gtk.tm> \|
  <hlink|previous|pure-g2.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2017, Albert Gräf et al. Last updated on Mar
  04, 2017. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
