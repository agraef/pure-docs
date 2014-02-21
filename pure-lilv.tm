<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-lilv-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-midi.tm> \|
  <hlink|previous|pure-liblo.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-lilv: Pure Lilv Interface<label|module-lilv>>

  Version 0.1, February 21, 2014

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  This package provides a Pure module for David Robillard's
  <hlink|Lilv|http://drobilla.net/software/lilv/>, a library for LV2 plugin
  host writers. <hlink|LV2|http://lv2plug.in/> is the new Linux audio plugin
  standard (LADSPA successor) which aims to be portable and extensible. Lilv
  makes it possible to load LV2 plugins in audio and other multimedia
  software. It is provided as a comprehensive and well-tested reference
  implementation for LV2 plugin hosts, so that authors of multimedia software
  don't have to craft their own (and often incomplete or bug-ridden)
  implementations of the LV2 plugin API.

  This module is still under development. When it is finished, it should
  provide all the common facilities needed to write LV2 hosts in Pure. We
  already offer operations to retrieve information about the LV2 plugins
  installed on a system, and to instantiate and run most basic plugins. Basic
  MIDI support is also available. More work is still needed in order to
  support more exotic event types such as transport state and tempo changes,
  handling of presets and plugin state, and any other extensions which may be
  required to run more advanced plugins. We're still trying to figure these
  out, so if you notice anything that's missing in the current implementation
  then please submit a feature request.

  Documentation still needs to be written. For the time being, please refer
  to the lilv.pure script for a description of the programming interface, and
  to the scripts in the examples folder for examples showing how to use the
  operations provided by this module.

  <subsection|Copying<label|copying>>

  pure-lilv is Copyright (c) 2014 by Albert Gräf. It is distributed under a
  3-clause BSD license, please check the COPYING file included in the
  distribution for details.

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-lilv-toc>>

  <\itemize>
    <item><hlink|pure-lilv: Pure Lilv Interface|#>

    <\itemize>
      <item><hlink|Copying|#copying>
    </itemize>
  </itemize>

  Previous topic

  <hlink|pure-liblo|pure-liblo.tm>

  Next topic

  <hlink|pure-midi|pure-midi.tm>

  <hlink|toc|#pure-lilv-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-midi.tm> \|
  <hlink|previous|pure-liblo.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Feb
  21, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
