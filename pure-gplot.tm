<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-gplot-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gsl.tm> \|
  <hlink|previous|pure-glpk.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Gnuplot bindings<label|gnuplot-bindings>>

  Kay-Uwe Kirstein

  <subsection|Copying<label|copying>>

  Copyright (c) 2009, 2010 by Kay-Uwe Kirstein.

  pure-gplot is free software: you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  <subsection|Introduction<label|introduction>>

  This module contains a pure binding to gnuplot. Communication to gnuplot is
  performed via pipes. The usual work flow to generate plot via gnuplot is
  the following:

  <\enumerate>
    <item>open pipe via <verbatim|open>

    <item>send plot commands, e.g., with <verbatim|plot>

    <item>close pipe with <verbatim|close>
  </enumerate>

  <subsection|Function Reference<label|function-reference>>

  <subsubsection|Open / Closing Functions<label|open-closing-functions>>

  <\quote-env>
    <verbatim|gplot::open> <verbatim|cmd;>
  </quote-env>

  opens a pipe to gnuplot, using <em|cmd>. <em|cmd> usually is something like
  <verbatim|gnuplot> or <verbatim|/path/to/gnuplot/bin/gnuplot> depending on
  your path configuration. <verbatim|open> returns a pointer to the actual
  pipe for later usage, so a typical call to open might look like this:

  <\quote-env>
    <verbatim|let> <verbatim|gp> <verbatim|=> <verbatim|gplot::open>
    <verbatim|"/path_to_gnuplot/gnuplot";>
  </quote-env>

  gplot::GPLOT_EXE is a predefined variable with the standard Gnuplot
  executable. It is set to <verbatim|pgnuplot> on Windows and to
  <verbatim|gnuplot> otherwise and can be overridden bythe GPLOT_EXE
  environment variable. (<verbatim|pgnuplot.exe> is a special executable for
  Windows, which is capable of stdin pipes in contrast to the normal
  <verbatim|gnuplot.exe>). Usage of <verbatim|gplot::GPLOT_EXE> might look
  like this:

  <\quote-env>
    <verbatim|let> <verbatim|gp> <verbatim|=> <verbatim|gplot::open>
    <verbatim|gplot::GPLOT_EXE;>

    <verbatim|gplot::close> <verbatim|gp;>
  </quote-env>

  closes a gnuplot session, given by the handle <em|gp>.

  <subsubsection|Low-Level Commands<label|low-level-commands>>

  <\quote-env>
    <verbatim|gplot::puts_no_echo> <verbatim|string> <verbatim|gp;>
  </quote-env>

  sends the string to the gnuplot session <em|gp> points to. As the name
  states, there is no echo read back from gnuplot (Don't know whether
  <em|gnuplot> or <em|pgnuplot.exe> supports reading/bidirectional pipes at
  all).

  <\quote-env>
    <verbatim|gplot::puts> <verbatim|string> <verbatim|gp;>
  </quote-env>

  is a convenience wrapper to <verbatim|gplot::puts_no_echo>.

  <subsubsection|Plot Commands<label|plot-commands>>

  The main (versatile) function to generate plots is the simple plot command,
  which expects a list of the data to be plotted.

  <\quote-env>
    <verbatim|gplot::plot> <verbatim|gp> <verbatim|data> <verbatim|opt;>
  </quote-env>

  where <em|gp> is the pointer to the gnuplot session, <em|data> is a list
  containing the data to be plotted and <em|opt> is a tuple, containing
  options for the plot. <em|opt> might be empty () or <verbatim|DEFAULT> for
  default options (refer to gnuplot for them).

  If data for the x-axis (ordinate) should be explicitely given <em|plotxy>
  should be used instead:

  <\quote-env>
    <verbatim|gplot::plotxy_deprecated> <verbatim|gp> <verbatim|(xdata,>
    <verbatim|ydata)> <verbatim|opt;>

    <verbatim|gplot::plotxy> <verbatim|gp> <verbatim|(xdata,>
    <verbatim|ydata)> <verbatim|opt> <verbatim|[];>
  </quote-env>

  Multiple datasets can be plotted into a single graph by combining them to
  tuples of lists:

  <\quote-env>
    <verbatim|gplot::plotxy> <verbatim|gp> <verbatim|(xdata,>
    <verbatim|y1data,> <verbatim|y2data,> <verbatim|..)> <verbatim|opt;>

    <verbatim|gplot::plotxy> <verbatim|gp> <verbatim|(xdata,>
    <verbatim|y1data,> <verbatim|y2data,> <verbatim|..)> <verbatim|opt>
    <verbatim|[];>

    <verbatim|gplot::plotxy> <verbatim|gp> <verbatim|(xdata,>
    <verbatim|y1data,> <verbatim|y2data,> <verbatim|..)> <verbatim|opt>
    <verbatim|titles;>
  </quote-env>

  where the latter form gives additional titles for each y-data set.

  <subsubsection|Plot Options<label|plot-options>>

  <\quote-env>
    <verbatim|gplot::xtics> <verbatim|gp> <verbatim|list_of_tic_labels;>
  </quote-env>

  Sets the tic labels of the x-axis to the given text labels. The labels can
  be given aas a simple list of strings, which are taken as successive labels
  or as a list of tuples with the form <verbatim|(value,> <verbatim|label)>,
  in which case each label is placed at its <verbatim|value> position.

  <\quote-env>
    <verbatim|gplot::xtics> <verbatim|gp> <verbatim|()> or
    <verbatim|gplot::xtics> <verbatim|gp> <verbatim|"default";>
  </quote-env>

  This restores the default tics on the y-axis.

  <\quote-env>
    <verbatim|gplot::title> <verbatim|t;>
  </quote-env>

  Sets a title string on top of the plot (default location)

  <\quote-env>
    <verbatim|gplot::output> <verbatim|gp> <verbatim|terminal>
    <verbatim|name;>
  </quote-env>

  Sets the terminal and output name for the successive plots. For some
  terminal additional options might be given:

  <\quote-env>
    <verbatim|gplot::output> <verbatim|gp> <verbatim|(terminal,>
    <verbatim|options)> <verbatim|name>.
  </quote-env>

  For terminals like x11 or windows, name can be empty <verbatim|()>.

  <\quote-env>
    <verbatim|gplot::xlabel> <verbatim|gp> <verbatim|name> or
    <verbatim|gplot::ylabel> <verbatim|gp> <verbatim|name>
  </quote-env>

  Adds labels to the x- or y-axis, respectively. An empty name removes the
  label for successive plots, e.g., <verbatim|gplot::xlabel> <verbatim|gp>
  <verbatim|"">.

  <subsubsection|Private Functions<label|private-functions>>

  <\quote-env>
    <verbatim|gpdata> <verbatim|data>, <verbatim|gpxydata>
    <verbatim|(xdata,> <verbatim|y1data,> <verbatim|..)>
  </quote-env>

  Internal functions to handle lists of data point (<verbatim|gpdata>) or
  tuples of lists of data points (<verbatim|gpxydata>) and convert them to be
  understood by Gnuplot.

  <\quote-env>
    <verbatim|gpxycmd>, <verbatim|gpxycmdtitle>
  </quote-env>

  Internal function to generate the plotting command for multiple datasets.
  <verbatim|gpxycmdtitle> adds titles to each dataset, a.k.a plot legend.

  <verbatim|gplot::gpopt> <verbatim|("style",> <verbatim|style,>
  <verbatim|args);>

  Internal function to convert a plot style to the respective gnuplot syntax

  <\quote-env>
    <verbatim|gplot::gptitle> <verbatim|t;>
  </quote-env>

  Internal function to generate title information for individual datasets

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-gplot-toc>>

  <\itemize>
    <item><hlink|Gnuplot bindings|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Introduction|#introduction>

      <item><hlink|Function Reference|#function-reference>

      <\itemize>
        <item><hlink|Open / Closing Functions|#open-closing-functions>

        <item><hlink|Low-Level Commands|#low-level-commands>

        <item><hlink|Plot Commands|#plot-commands>

        <item><hlink|Plot Options|#plot-options>

        <item><hlink|Private Functions|#private-functions>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Pure-GLPK - GLPK interface for the Pure programming
  language|pure-glpk.tm>

  Next topic

  <hlink|pure-gsl - GNU Scientific Library Interface for Pure|pure-gsl.tm>

  <hlink|toc|#pure-gplot-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gsl.tm> \|
  <hlink|previous|pure-glpk.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Oct
  28, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
