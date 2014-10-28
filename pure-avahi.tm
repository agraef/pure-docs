<TeXmacs|1.0.7.20>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-avahi-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-bonjour.tm> \|
  <hlink|previous|purelib.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-avahi: Pure Avahi Interface<label|module-avahi>>

  Version 0.3, October 28, 2014

  Albert Gräf \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  This is a simple interface to <hlink|Avahi|http://avahi.org/>, a
  <hlink|Zeroconf|http://en.wikipedia.org/wiki/Zero-configuration-networking>
  implementation for Linux and other Un*x systems. The module lets you
  publish and query Zeroconf network services using Avahi, allowing you to
  establish connections for various kinds of TCP and UDP network services
  without having to manually configure network addresses. It is typically
  used along with the <hlink|<with|font-family|tt|sockets>|pure-sockets.tm#module-sockets>
  module which lets you create the network connections discovered with
  <hlink|<with|font-family|tt|avahi>|#module-avahi>.

  To keep things simple and easy to use, the module only exposes the most
  essential functionality of Ahavi right now, but the provided functions
  should hopefully be sufficient for most programs which require
  interoperability with other Avahi or Apple Bonjour applications. One known
  limitation is that the module allows you to publish and discover services
  in the default Avahi domain only. Typically this is the <verbatim|local>
  domain, limiting you to services in the local network. However, this should
  cover most common uses of Zeroconf.

  There's a companion <hlink|<with|font-family|tt|bonjour>|pure-bonjour.tm#module-bonjour>
  module which implements the same API for
  <hlink|Bonjour|http://developer.apple.com/bonjour/>, Apple's Zeroconf
  implementation. Since both modules implement the same functions, albeit in
  different namespaces, they can be used as drop-in replacements for each
  other. We also offer a compatibility module named <verbatim|zeroconf> which
  can be used with either pure-avahi or pure-bonjour in a transparent
  fashion, so that no source changes are needed when switching the underlying
  implementation; please check the zeroconf.pure script included in the
  sources for details.

  This module is in its early stages, so it may still contain bugs or lack
  some features. Please report bugs on the issue tracker at the Pure
  Bitbucket site, and use the Pure mailing list for general discussion of the
  module.

  <subsection|Copying<label|copying>>

  Copyright (c) 2014 by Albert Graef.

  pure-avahi is free software: you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-avahi is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
  for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation<label|installation>>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-avahi-0.3.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-avahi-0.3.tar.gz>.

  Run <verbatim|make> to compile the module and <verbatim|make>
  <verbatim|install> (as root) to install it in the Pure library directory.
  This requires GNU make, and of course you need to have Pure and Avahi
  installed. The latter should be readily available on most Linux systems,
  and ports are available for BSD systems as well.

  <verbatim|make> tries to guess your Pure installation directory and
  platform-specific setup. If it gets this wrong, you can set some variables
  manually, please check the Makefile for details.

  Please note that the zeroconf.pure compatibility module is not installed by
  default, so you may want to copy it to the Pure library directory if
  needed.

  <subsection|Usage<label|usage>>

  To use the operations of this module, you need to have Avahi installed and
  the Avahi daemon running on your system. The details of this depend on the
  particular system that you use, so please consult the documentation of your
  Linux or BSD distribution for instructions.

  The following import declaration loads the functions of the avahi module in
  your Pure script:

  <\verbatim>
    using avahi;
  </verbatim>

  All operations are in the <verbatim|avahi> namespace, so you might want to
  add the following declaration to access the functions using their
  unqualified identifiers:

  <\verbatim>
    using namespace avahi;
  </verbatim>

  <subsection|Publishing Services<label|publishing-services>>

  These functions allow you to advertise a network service using Avahi, so
  that the service can be discovered by other applications participating in
  the Zeroconf protocol. Each service has a name (a string which uniquely
  identifies the service), a type (indicating the application and transport
  protocols utilized by the service) and a port number (TCP or UDP port
  number, depending on the service type). The service type normally takes the
  form <verbatim|_app._tcp> (for TCP services) or <verbatim|_app._udp> (for
  UDP), where <verbatim|_app> specifies the protocol of the particular
  application (such as <verbatim|_ipp> for network-connected printers, or
  <verbatim|_osc> for applications speaking the OSC a.k.a. Open Sound Control
  protocol).

  <\description>
    <item*|avahi::publish name stype port<label|avahi::publish>>Advertise a
    service in the local domain, given by its name (a string), service type
    (a string) and (TCP or UDP) port number (an integer). Note that this
    operation is actually carried out asynchronously. Use
    <hlink|<with|font-family|tt|avahi::check>|#avahi::check> below to wait
    for and report the result of the operation. The returned result is a
    pointer to the service object which can be passed to the following
    operations, or <verbatim|NULL> in case of error. (A <verbatim|NULL>
    pointer can be passed safely to <hlink|<with|font-family|tt|avahi::check>|#avahi::check>;
    it will fail in this case.) The service will be unpublished automatically
    when the service object is garbage-collected.
  </description>

  <\description>
    <item*|avahi::check service<label|avahi::check>>Check for the result of a
    <hlink|<with|font-family|tt|avahi::publish>|#avahi::publish> operation.
    This blocks until a result is available. A negative integer value
    indicates failure (in this case the result is the Avahi error code).
    Otherwise the result is a triple with the actual service name, type and
    port. Note that the name may be different from the one passed to
    <hlink|<with|font-family|tt|avahi::publish>|#avahi::publish> if there was
    a name collision with another service. Such collisions are resolved
    automatically by tacking on a suffix of the form <verbatim|#n> to the
    service name.
  </description>

  <subsection|Discovering Services<label|discovering-services>>

  These functions let you discover services of a given service type. For each
  (resolvable) service you'll be able to retrieve the corresponding network
  address and port, which is what you'll need to actually open a network
  connection to communicate with the service.

  <\description>
    <item*|avahi::browse stype<label|avahi::browse>>Browse available services
    of a given type in the local domain. This operation is carried out
    asynchronously; use <hlink|<with|font-family|tt|avahi::avail>|#avahi::avail>
    below to check whether new information is available, and
    <hlink|<with|font-family|tt|avahi::get>|#avahi::get> to retrieve the
    actual service list. The result returned by
    <hlink|<with|font-family|tt|avahi::browse>|#avahi::browse> is a pointer
    to the browser object which can be passed to the following operations, or
    <verbatim|NULL> in case of error. (A <verbatim|NULL> pointer can be
    passed safely to the other operations; they will fail in this case.) Any
    resources allocated to the browser will be released automatically when
    the browser object is garbage-collected.
  </description>

  <\description>
    <item*|avahi::avail browser<label|avahi::avail>>Check whether the service
    information was updated since the last invocation of
    <hlink|<with|font-family|tt|avahi::get>|#avahi::get>. Returns an integer
    (truth value), which may also be negative (indicating the Avahi error
    code) in case of error.
  </description>

  <\description>
    <item*|avahi::get browser<label|avahi::get>>Retrieve the current list of
    services. Each list entry is a tuple with the name, type, domain, IP
    address (all string values) and port number (an integer) of a service.
    The entries are in the same order as returned by Avahi, but only include
    services whose network addresses can actually be resolved using Avahi.
    Note that this information may change over time, as new services are
    announced on the network or removed from it. An application will
    typically call <hlink|<with|font-family|tt|avahi::avail>|#avahi::avail>
    from time to time to check whether new information is available and then
    retrieve the updated service list using
    <hlink|<with|font-family|tt|avahi::get>|#avahi::get>. The result may also
    be a negative integer (indicating the Avahi error code) in case of error.
  </description>

  <subsection|Example<label|example>>

  Here's an example showing how to publish an UDP OSC (Open Sound Control)
  service which might be used to connect to mobile OSC applications such as
  hexler's TouchOSC:

  <\verbatim>
    using avahi;

    using namespace avahi;

    \;

    let s = publish "OSC Server" "_osc._udp" 8000;

    check s;
  </verbatim>

  The last line checks for the result of the operation and returns the actual
  service name, type and port number if all went well. A TouchOSC instance
  running on the local network will then offer you to connect to the service.

  Continuing the example, here's how you can obtain a list of OSC services
  currently available on your local network:

  <\verbatim>
    let t = browse "_osc._udp";

    avail t;

    get t;
  </verbatim>

  If you're running TouchOSC somewhere on your local network, it will be
  listed there, along with our own service which we published above. The call
  in the second line can be used to check whether any new information is
  available. Applications typically invoke these two from time to time to
  update their service list, using code like the following:

  <\verbatim>
    avail t && get t;
  </verbatim>

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-avahi-toc>>

  <\itemize>
    <item><hlink|pure-avahi: Pure Avahi Interface|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <item><hlink|Publishing Services|#publishing-services>

      <item><hlink|Discovering Services|#discovering-services>

      <item><hlink|Example|#example>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Pure Library Manual|purelib.tm>

  Next topic

  <hlink|pure-bonjour: Pure Bonjour Interface|pure-bonjour.tm>

  <hlink|toc|#pure-avahi-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-bonjour.tm> \|
  <hlink|previous|purelib.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2014, Albert Gräf et al. Last updated on Oct
  28, 2014. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
