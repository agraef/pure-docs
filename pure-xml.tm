<TeXmacs|1.99.11>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-xml-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-g2.tm> \|
  <hlink|previous|pure-sql3.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|Pure-XML - XML/XSLT interface><label|module-xml>

  Version 0.7, April 11, 2018

  Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>

  <hlink|XML|http://www.w3.org/TR/xml>, the Extensible Markup Language,
  facilitates the exchange of complex structured data between applications
  and systems. <hlink|XSLT|http://www.w3.org/TR/xslt> allows you to transform
  XML documents to other XML-based formats such as HTML. Together, XML and
  XSLT let you create dynamic web content with ease. Both XML and XSLT are
  open standards by the W3C consortium (<hlink|http://www.w3.org|http://www.w3.org>).

  Pure's XML interface is based on the libxml2 and libxslt libraries from the
  GNOME project. If you have a Linux system then you most likely have these
  libraries, otherwise you can get them from
  <hlink|http://xmlsoft.org|http://xmlsoft.org>. For Windows users, the
  required dlls are available from the GnuWin32 project
  (<hlink|http://gnuwin32.sourceforge.net|http://gnuwin32.sourceforge.net>)
  and are already included in the Pure MSI package.

  <subsection|Copying><label|copying>

  Copyright (c) 2009 by Albert Graef \<less\><hlink|aggraef@gmail.com|mailto:aggraef@gmail.com>\<gtr\>.

  pure-xml is free software: you can redistribute it and/or modify it under
  the terms of the GNU Lesser General Public License as published by the Free
  Software Foundation, either version 3 of the License, or (at your option)
  any later version.

  pure-xml is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for
  more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see \<less\><hlink|http://www.gnu.org/licenses/|http://www.gnu.org/licenses/>\<gtr\>.

  <subsection|Installation><label|installation>

  Get the latest source from <hlink|https://bitbucket.org/purelang/pure-lang/downloads/pure-xml-0.7.tar.gz|https://bitbucket.org/purelang/pure-lang/downloads/pure-xml-0.7.tar.gz>.

  Run <verbatim|make> and then <verbatim|sudo> <verbatim|make>
  <verbatim|install> to compile and install this module. This requires
  libxml2, libxslt and Pure.

  <subsection|Usage><label|usage>

  Use the following declaration to make the operations of this module
  available in your programs:

  <\verbatim>
    \;

    using xml;

    \;
  </verbatim>

  The module defines two namespaces <verbatim|xml> and <verbatim|xslt> for
  the XML and the XSLT operations, respectively. For convenience, you can
  open these in your program as follows:

  <\verbatim>
    \;

    using namespace xml, xslt;

    \;
  </verbatim>

  A number of complete examples illustrating the use of this module can be
  found in the examples directory in the source distribution.

  <subsection|Data Structure><label|data-structure>

  This module represents XML documents using pointers to the
  <verbatim|xmlDoc> and <verbatim|xmlNode> structures provided by the libxml2
  library. Similarly, stylesheets are simply pointers to the xmlStylesheet
  structure from libxslt (cf. <hlink|Transformations|#transformations>). This
  makes it possible to use these objects directly with the operations of the
  libxml2 and libsxslt libraries (via Pure's C interface) if necessary. Note,
  however, that these are all \Pcooked\Q pointers which take care of freeing
  themselves automatically when they are no longer needed, therefore you
  shouldn't free them manually.

  You can also check for these types of pointers using the following
  predicates:

  <\description>
    <item*|xml::docp x<label|xml::docp>>checks whether <verbatim|x> is an XML
    document pointer.
  </description>

  <\description>
    <item*|xml::nodep x<label|xml::nodep>>checks whether <verbatim|x> is a
    pointer to a node in an XML document.
  </description>

  <\description>
    <item*|xslt::stylesheetp x<label|xslt::stylesheetp>>checks whether
    <verbatim|x> is an XSLT stylesheet pointer.
  </description>

  <subsubsection|The Document Tree><label|the-document-tree>

  An XML document is a rooted tree which can be created, traversed and
  manipulated using the operations of this module. There are different types
  of nodes in the tree, each carrying their own type of data. In Pure land,
  the node data is described using the following \Pnode info\Q constructors.

  <\description>
    <item*|<em|constructor> xml::element tag ns
    attrs<label|xml::element>><label|node-info>An XML element with given
    (possibly qualified) name <verbatim|tag>, a (possibly empty) list of
    namespace declarations <verbatim|ns> and a (possibly empty) list of
    attributes <verbatim|attrs>. Namespace declarations normally take the
    form of a pair of strings <verbatim|(prefix,href)>, where
    <verbatim|prefix> is the prefix associated with the namespace and
    <verbatim|href> the corresponding URI (the name of the namespace), but
    they can also be just a string <verbatim|href> if the namespace prefix is
    missing. Attributes are encoded as <verbatim|key=\>value> pairs, where
    <verbatim|key> is the attribute name and <verbatim|value> the associated
    value; both <verbatim|key> and <verbatim|value> are strings.
  </description>

  <\description>
    <item*|<em|constructor> xml::element_text tag ns attrs
    content<label|xml::element-text>>A convenience function which denotes a
    combination of an element node with a text child. This is only used when
    creating a new node, and indicates that a text node child is to be added
    to the node automatically.
  </description>

  <\description>
    <item*|<em|constructor> xml::attr key val<label|xml::attr>>An attribute
    node. These only occur as results of the <verbatim|select> and
    <verbatim|attrs> functions, and cannot be inserted directly into a
    document.
  </description>

  <\description>
    <item*|<em|constructor> xml::text content<label|xml::text>>A text node
    with the given content (a string).
  </description>

  <\description>
    <item*|<em|constructor> xml::cdata content<label|xml::cdata>>Like
    <hlink|<with|font-family|tt|xml::text>|#xml::text>, but contains unparsed
    character data.
  </description>

  <\description>
    <item*|<em|constructor> xml::comment content<label|xml::comment>>A
    comment.
  </description>

  <\description>
    <item*|<em|constructor> xml::entity_ref name<label|xml::entity-ref>>An
    entity reference (<verbatim|&name;>).
  </description>

  <\description>
    <item*|<em|constructor> xml::pi name content<label|xml::pi>>Processing
    instructions. <verbatim|name> is the application name, <verbatim|content>
    the text of the processing instructions.
  </description>

  <subsubsection|Document Types><label|document-types><label|dtd><label|document-types>

  Besides the node types described above, there are some additional node
  types used in the <hlink|document type definition|http://www.w3.org/TR/REC-xml/#dt-doctype>
  (DTD), which can be extracted from a document using the
  <verbatim|int_subset> and <verbatim|ext_subset> functions. These are for
  inspection purposes only; it is not possible to change the DTD of a
  document in-place. (However, you can create a new document and attach a DTD
  to it, using the <verbatim|new_doc> function.)

  <\description>
    <item*|<em|constructor> xml::doctype name extid<label|xml::doctype>>DTDs
    are represented using this special type of node, where <verbatim|name> is
    the name of the root element, and <verbatim|extid> is a pair consisting
    of the external identifier and the URI of the DTD (or just the URI if
    there is no external identifier). The
    <hlink|<with|font-family|tt|xml::doctype>|#xml::doctype> node has as its
    children zero or more of the following kinds of DTD declaration nodes
    (these are just straightforward abstract syntax for the !ELEMENT,
    !ATTLIST and !ENTITY declarations inside a DTD declaration; see the XML
    specification for details).
  </description>

  <label|element-declaration>

  <em|Element declarations:> Here, <verbatim|name> is the element tag and
  <verbatim|content> the definition of the element structure, see
  <hlink|element content|#element-content> below. XML supports various kinds
  of element types, please refer to <hlink|document type
  definition|http://www.w3.org/TR/REC-xml/#dt-doctype> in the XML
  specification for details.

  <\description>
    <item*|<em|constructor> xml::undefined_element
    name<label|xml::undefined-element>>An undefined element. This is in
    libxml2, but not in the XML specification, you shouldn't see this in
    normal operation.
  </description>

  <\description>
    <item*|<em|constructor> xml::empty_element
    name<label|xml::empty-element>>An element without any content.
  </description>

  <\description>
    <item*|<em|constructor> xml::any_element name<label|xml::any-element>>An
    element with unrestricted content.
  </description>

  <\description>
    <item*|<em|constructor> xml::mixed_element name
    content<label|xml::mixed-element>>A \Pmixed\Q element which can contain
    character data, optionally interspersed with child elements, as given in
    the <verbatim|content> specification.
  </description>

  <\description>
    <item*|<em|constructor> xml::std_element name
    content<label|xml::std-element>>A standard element consisting <em|only>
    of child elements, as given in the <verbatim|content> specification.
  </description>

  <label|attribute-declaration>

  <em|Attribute declarations:> These are used to declare the attributes of an
  element. <verbatim|elem_name> is the name of an element which describes the
  attribute type, <verbatim|name> is the name of the attribute itself, and
  <verbatim|default> specifies the default value of the attribute, see
  <hlink|attribute defaults|#attribute-defaults> below. XML supports a bunch
  of different attribute types, please refer to <hlink|document type
  definition|http://www.w3.org/TR/REC-xml/#dt-doctype> in the XML
  specification for details.

  <\description>
    <item*|<em|constructor> xml::cdata_attr elem_name name
    default<label|xml::cdata-attr>>
  </description>

  <\description>
    <item*|<em|constructor> xml::id_attr elem_name name
    default<label|xml::id-attr>>
  </description>

  <\description>
    <item*|<em|constructor> xml::idref_attr elem_name name
    default<label|xml::idref-attr>>
  </description>

  <\description>
    <item*|<em|constructor> xml::idrefs_attr elem_name name
    default<label|xml::idrefs-attr>>
  </description>

  <\description>
    <item*|<em|constructor> xml::entity_attr elem_name name
    default<label|xml::entity-attr>>
  </description>

  <\description>
    <item*|<em|constructor> xml::entities_attr elem_name name
    default<label|xml::entities-attr>>
  </description>

  <\description>
    <item*|<em|constructor> xml::nmtoken_attr elem_name name
    default<label|xml::nmtoken-attr>>
  </description>

  <\description>
    <item*|<em|constructor> xml::nmtokens_attr elem_name name
    default<label|xml::nmtokens-attr>>
  </description>

  <\description>
    <item*|<em|constructor> xml::enum_attr elem_name name vals
    default<label|xml::enum-attr>>
  </description>

  <\description>
    <item*|<em|constructor> xml::notation_attr elem_name name vals
    default<label|xml::notation-attr>>
  </description>

  <label|entity-declaration>

  <em|Entity declarations:> These are used for internal and external entity
  declarations. <verbatim|name> is the entity name and <verbatim|content> its
  definition. External entities also have an <verbatim|extid> (external
  identifier/URI pair) identifying the entity.

  <\description>
    <item*|<em|constructor> xml::int_entity name
    content<label|xml::int-entity>>
  </description>

  <\description>
    <item*|<em|constructor> xml::int_param_entity name
    content<label|xml::int-param-entity>>
  </description>

  <\description>
    <item*|<em|constructor> xml::ext_entity name extid
    content<label|xml::ext-entity>>
  </description>

  <\description>
    <item*|<em|constructor> xml::ext_param_entity name extid
    content<label|xml::ext-param-entity>>
  </description>

  <label|element-content>

  The element content type (<verbatim|content> argument of the <hlink|element
  declaration|#element-declaration> nodes) is a kind of regular expression
  formed with tags (specified as strings) and the following constructors:

  <\description>
    <item*|<em|constructor> xml::pcdata<label|xml::pcdata>>text data
    (<verbatim|#PCDATA>)
  </description>

  <\description>
    <item*|<em|constructor> xml::sequence
    xs<label|xml::sequence>>concatenation (<verbatim|x,y,z>)
  </description>

  <\description>
    <item*|<em|constructor> xml::union xs<label|xml::union>>alternatives
    (<verbatim|x\|y\|z>)
  </description>

  <\description>
    <item*|<em|constructor> xml::opt x<label|xml::opt>>optional element
    (<verbatim|x?>)
  </description>

  <\description>
    <item*|<em|constructor> xml::mult x<label|xml::mult>>repeated element
    (<verbatim|x*>)
  </description>

  <\description>
    <item*|<em|constructor> xml::plus x<label|xml::plus>>non-optional
    repeated element (<verbatim|x+>)
  </description>

  <label|attribute-defaults>

  Attribute defaults (the <verbatim|default> argument of <hlink|attribute
  declaration|#attribute-declaration> nodes) are represented using the
  following constructor symbols:

  <\description>
    <item*|<em|constructor> xml::required<label|xml::required>>a required
    attribute, i.e., the user must specify this
  </description>

  <\description>
    <item*|<em|constructor> xml::implied<label|xml::implied>>an implied
    attribute, i.e., the user does not have to specify this
  </description>

  <\description>
    <item*|<em|constructor> xml::default val<label|xml::default>>an attribute
    with the given default value <verbatim|val>
  </description>

  <\description>
    <item*|<em|constructor> xml::fixed val<label|xml::fixed>>an attribute
    with the given fixed value <verbatim|val>
  </description>

  <subsection|Operations><label|operations>

  This module provides all operations necessary to create, inspect and
  manipulate XML documents residing either in memory or on disk. Operations
  for formatting XML documents using XSLT stylesheets are also available.

  <subsubsection|Document Operations><label|document-operations>

  The following functions allow you to create new XML documents, load them
  from or save them to a file or a string, and provide general information
  about a document.

  <\description>
    <item*|xml::new_doc version dtd info<label|xml::new-doc>>This function
    creates an XML document. It returns a pointer to the new document.
    <verbatim|version> is a string denoting the XML version (or <verbatim|"">
    to indicate the default). <verbatim|info> is the <hlink|node
    info|#node-info> of the root node (which should denote an element node).
    <verbatim|dtd> denotes the document type which can be <verbatim|()> to
    denote an empty DTD, a string (the URI/filename of the DTD), or a pair
    <verbatim|(pubid,sysid)> where <verbatim|pubid> denotes the public
    identifier of the DTD and <verbatim|sysid> its system identifier (URI).

    Note that only simple kinds of documents with an internal DTD can be
    created this way. Use the <verbatim|load_file> or <verbatim|load_string>
    function below to create a skeleton document if a more elaborate prolog
    is required.
  </description>

  <\description>
    <item*|xml::load_file name flags<label|xml::load-file>>

    <item*|xml::load_string s flags<label|xml::load-string>>Load an XML
    document from a file <verbatim|name> or a string <verbatim|s>.
    <verbatim|flags> denotes the parser flags, a bitwise disjunction of any
    of the following constants, or 0 for the default:

    <\itemize>
      <item><verbatim|xml::DTDLOAD>: load DTD

      <item><verbatim|xml::DTDVALID>: validate

      <item><verbatim|xml::PEDANTIC>: pedantic parse

      <item><verbatim|xml::SUBENT>: substitute entities

      <item><verbatim|xml::NOBLANKS>: suppress blank nodes
    </itemize>

    The return value is the document pointer. These operations may also fail
    if there is a fatal error parsing the document.
  </description>

  <\description>
    <item*|xml::save_file name doc encoding
    compression<label|xml::save-file>>

    <item*|xml::save_string doc<label|xml::save-string>>Save an XML document
    <verbatim|doc> to a file or a string. When saving to a file,
    <verbatim|encoding> denotes the desired encoding (or <verbatim|""> for
    the default), <verbatim|compression> the desired level of zlib
    compression (0 means none, 9 is maximum, -1 indicates the default). Note
    that with <hlink|<with|font-family|tt|xml::save_string>|#xml::save-string>,
    the result is always encoded as UTF-8.
  </description>

  <\description>
    <item*|xml::doc_info doc<label|xml::doc-info>>Retrieve general
    information about a document. Returns a tuple
    <verbatim|(version,encoding,url,compression,standalone)>, where
    <verbatim|version> is the XML version of the document,
    <verbatim|encoding> the external encoding (if any), <verbatim|url> the
    name/location of the document (if any), <verbatim|compression> the level
    of zlib compression, and <verbatim|standalone> is a flag indicating
    whether the document contains any external markup declarations \Pwhich
    affect the information passed from the XML processor to the
    application\Q, see the section on the <hlink|standalone document
    declaration|http://www.w3.org/TR/REC-xml/#sec-rmd> in the XML spec for
    details. (Apparently, in libxml2 <verbatim|standalone> is either a truth
    value or one of the special values -1, indicating that there's no XML
    declaration in the prolog, or -2, indicating that there's an XML
    declaration but no <verbatim|standalone> attribute.)
  </description>

  <\description>
    <item*|xml::int_subset doc<label|xml::int-subset>>

    <item*|xml::ext_subset doc<label|xml::ext-subset>>Retrieve the internal
    and external DTD subset of a document. Returns a <verbatim|doctype> node
    (fails if there's no corresponding DTD).
  </description>

  <with|font-series|bold|Example>

  Read the sample.xml document distributed with the sources (ignoring blank
  nodes) and retrieve the document info:

  <\verbatim>
    \;

    \<gtr\> using xml;

    \<gtr\> let sample = xml::load_file "sample.xml" xml::NOBLANKS;

    \<gtr\> xml::doc_info sample;

    "1.0","","sample.xml",0,-2

    \;
  </verbatim>

  <subsubsection|Traversing Documents><label|traversing-documents>

  These operations are used to traverse the document tree, i.e., the nodes of
  the document. They take either a document pointer <verbatim|doc> or a node
  pointer <verbatim|node> as argument, and yield a corresponding node pointer
  (or a document pointer, in the case of <hlink|<with|font-family|tt|xml::doc>|#xml::doc>).
  The node pointers can then be used with the <hlink|Node
  Information|#node-information> and <hlink|Node
  Manipulation|#node-manipulation> operations described below.

  <\description>
    <item*|xml::root doc<label|xml::root>>the root node of <verbatim|doc>
  </description>

  <\description>
    <item*|xml::doc node<label|xml::doc>>the document <verbatim|node> belongs
    to
  </description>

  <\description>
    <item*|xml::parent node<label|xml::parent>>the parent of <verbatim|node>
  </description>

  <\description>
    <item*|xml::first node<label|xml::first>>

    <item*|xml::last node<label|xml::last>>first and last child node
  </description>

  <\description>
    <item*|xml::next node<label|xml::next>>

    <item*|xml::prev node<label|xml::prev>>next and previous sibling
  </description>

  <\description>
    <item*|xml::first_attr node<label|xml::first-attr>>

    <item*|xml::last_attr node<label|xml::last-attr>>first and last attribute
    node
  </description>

  All these operations fail if the corresponding target node does not exist,
  or if the type of the given node is not supported by this implementation.

  There are also two convenience functions to retrieve the children and
  attribute nodes of a node:

  <\description>
    <item*|xml::children node<label|xml::children>>returns the list of all
    child nodes of <verbatim|node>
  </description>

  <\description>
    <item*|xml::attrs node<label|xml::attrs>>returns the list of all
    attribute nodes of <verbatim|node>
  </description>

  Moreover, given a node pointer <verbatim|node>, <verbatim|node!i> can be
  used to retrieve the <verbatim|i>th child of <verbatim|node>.

  <with|font-series|bold|Example>

  Peek at the root node of the sample document and its children:

  <\verbatim>
    \;

    \<gtr\> let r = xml::root sample; r;

    #\<less\>pointer 0xe15e10\<gtr\>

    \<gtr\> xml::node_info r;

    xml::element "story" [] []

    \<gtr\> #xml::children r;

    5

    \<gtr\> xml::node_info (r!0);

    xml::cdata "\<less\>greeting\<gtr\>Hello, world!\<less\>/greeting\<gtr\>"

    \;
  </verbatim>

  <subsubsection|Node Information><label|node-information>

  These operations retrieve information about the nodes of an XML document.

  <\description>
    <item*|xml::select doc xpath<label|xml::select>>

    <item*|xml::select doc (xpath,ns)>Retrieve nodes using an
    <hlink|XPath|http://www.w3.org/TR/xpath> specification. Given an XPath (a
    string) <verbatim|xpath>, this operation returns the list of all matching
    nodes in the given document <verbatim|doc>. You can also specify a node
    as the first argument, in which case the document of the given node is
    searched and paths are interpreted relative to the given node (rather
    than the root node of the document).

    Moreover, instead of just an XPath you can also specify a pair
    <verbatim|(xpath,ns)> consisting of an XPath <verbatim|xpath> and a list
    <verbatim|ns> of <verbatim|prefix=\>uri> string pairs which describe the
    namespaces to be recognized in the XPath expression. This is necessary to
    select nodes by qualified tag or attribute names. Note that only the
    namespace URIs must match up with those used in the queried document; the
    corresponding namespace prefixes can be chosen freely, so you can use
    whatever prefixes are convenient to formulate the XPath query. However,
    for each namespace prefix used in the XPath expression (not the
    document!), there <em|must> be a corresponding binding in the
    <verbatim|ns> list. Otherwise the underlying libxml2 function will
    complain about an undefined namespace prefix and
    <hlink|<with|font-family|tt|xml::select>|#xml::select> will fail.
  </description>

  <\description>
    <item*|xml::node_info node<label|xml::node-info>>Retrieve the node data
    from <verbatim|node>. Returns a <hlink|node info|#node-info> value, as
    described in <hlink|Data Structure|#data-structure> above. Fails if the
    node does not belong to one of the supported node types.
  </description>

  <\description>
    <item*|xml::is_blank_node<label|xml::is-blank-node>>Checks whether a node
    is a blank node (empty or whitespace only) and thus possibly ignorable.
  </description>

  <\description>
    <item*|xml::node_base node<label|xml::node-base>>Returns the base URI of
    the given node.
  </description>

  <\description>
    <item*|xml::node_path node<label|xml::node-path>>Returns the path of a
    node in the document, in the format accepted by <verbatim|select>.
  </description>

  <\description>
    <item*|xml::node_content node<label|xml::node-content>>Returns the text
    carried by the node, if any (after entity substitution).
  </description>

  In addition, you can retrieve and change attributes of element nodes with
  the following operations:

  <\description>
    <item*|xml::node_attr node name<label|xml::node-attr>>Retrieves the value
    of the attribute with the given <verbatim|name> (after entity
    substitution).
  </description>

  <\description>
    <item*|xml::set_node_attr node name value<label|xml::set-node-attr>>

    <item*|xml::unset_node_attr node name<label|xml::unset-node-attr>>Sets or
    unsets an attribute value.
  </description>

  <with|font-series|bold|Examples>

  Set and unset a node attribute:

  <\verbatim>
    \;

    \<gtr\> xml::set_node_attr r "foo" "4711";

    ()

    \<gtr\> xml::node_info r;

    xml::element "story" [] ["foo"=\<gtr\>"4711"]

    \<gtr\> xml::node_attr r "foo";

    "4711"

    \<gtr\> xml::unset_node_attr r "foo";

    ()

    \<gtr\> xml::node_info r;

    xml::element "story" [] []

    \;
  </verbatim>

  The <verbatim|select> function is <em|very> powerful, and probably the
  single most important operation of this module if you want to extract
  information from an existing XML document without traversing the entire
  structure. Here is a very simple example of its use:

  <\verbatim>
    \;

    \<gtr\> [xml::node_content n, xml::node_path n \| n = xml::select sample
    "//author"];

    [("John Fleck","/story/storyinfo/author")]

    \;
  </verbatim>

  Note that if the XPath expression contains qualified names, the
  corresponding namespace prefixes and their URIs must be given in the second
  argument along with the XPath, as follows:

  <\verbatim>
    \;

    xml::select doc ("//foo:bar", ["foo"=\<gtr\>"http://www.foo.org"]);

    \;
  </verbatim>

  <subsubsection|Node Manipulation><label|node-manipulation>

  These operations enable you to manipulate the document structure by adding
  a new node to the document tree (specified through its <hlink|node
  info|#node-info>), and by removing (unlinking) existing nodes from the
  tree.

  <\description>
    <item*|xml::replace node info<label|xml::replace>>Add the new node
    specified by <verbatim|info> in place of the given node <verbatim|node>.
  </description>

  <\description>
    <item*|xml::add_first node info<label|xml::add-first>>

    <item*|xml::add_last node info<label|xml::add-last>>Add the new node as
    the first or last child of <verbatim|node>, respectively.
  </description>

  <\description>
    <item*|xml::add_next node info<label|xml::add-next>>

    <item*|xml::add_prev node info<label|xml::add-prev>>Add the new node as
    the next or previous sibling of <verbatim|node>, respectively.
  </description>

  The operations above all return a pointer to the new XML node object.

  <\description>
    <item*|xml::unlink node<label|xml::unlink>>Deletes an existing node from
    the document tree. Returns <verbatim|()>.
  </description>

  <with|font-series|bold|Examples>

  Replace the first child of the root node in the sample document:

  <\verbatim>
    \;

    \<gtr\> xml::node_info (r!0);

    xml::cdata "\<less\>greeting\<gtr\>Hello, world!\<less\>/greeting\<gtr\>"

    \<gtr\> xml::replace (r!0) (xml::text "bla bla");

    #\<less\>pointer 0xd40d80\<gtr\>

    \<gtr\> xml::node_info (r!0);

    xml::text "bla bla"

    \;
  </verbatim>

  Delete that node:

  <\verbatim>
    \;

    \<gtr\> xml::unlink (r!0);

    ()

    \<gtr\> xml::node_info (r!0);

    xml::comment "This is a sample document for testing the xml interface."

    \;
  </verbatim>

  <subsubsection|Transformations><label|transformations>

  The following operations provide basic XSLT support. As already mentioned,
  stylesheets are represented as pointers to the xsltStylesheet structure
  provided by libxslt. Note that, in difference to XML document pointers,
  this is an opaque type, i.e., there is no direct means to inspect and
  manipulate parsed stylesheets in memory using the operations of this
  module. However, a stylesheet is just a special kind of XML document and
  thus can be manipulated after reading the stylesheet as an ordinary XML
  document. The <hlink|<with|font-family|tt|load_stylesheet>|#xslt::load-stylesheet>
  function then allows you to convert the document pointer to an XSLT
  Stylesheet object.

  Applying a stylesheet to an XML document generally involves the following
  steps:

  <\enumerate>
    <item>Load and parse the stylesheet using
    <hlink|<with|font-family|tt|load_stylesheet>|#xslt::load-stylesheet>. The
    parameter to <hlink|<with|font-family|tt|load_stylesheet>|#xslt::load-stylesheet>
    can be either the name of a stylesheet file or a corresponding document
    pointer. The function returns a pointer to the stylesheet object which is
    used in the subsequent processing.

    <item>Invoke <hlink|<with|font-family|tt|apply_stylesheet>|#xslt::apply-stylesheet>
    on the stylesheet and the target document. This returns a new document
    containing the transformed XML document.

    <item>Run <hlink|<with|font-family|tt|save_result_file>|#xslt::save-result-file>
    or <hlink|<with|font-family|tt|save_result_string>|#xslt::save-result-string>
    on the result and the stylesheet to save the transformed document in a
    file or a string.
  </enumerate>

  Here is a brief summary of the XSLT operations. Please check the
  <hlink|XSLT|http://www.w3.org/TR/xslt> documentation for details of the
  transformation process.

  <\description>
    <item*|xslt::load_stylesheet x<label|xslt::load-stylesheet>>Load a
    stylesheet. <verbatim|x> can be either an XML document pointer, or a
    string denoting the desired <verbatim|.xsl> file.
  </description>

  <\description>
    <item*|xslt::apply_stylesheet style doc
    params<label|xslt::apply-stylesheet>>Apply the stylesheet
    <verbatim|style> to the given document <verbatim|doc> with the given
    parameters <verbatim|params>. The third argument is a (possibly empty)
    list of <verbatim|key=\>value> string pairs which allows you to pass
    additional parameters to the stylesheet.
  </description>

  <\description>
    <item*|xslt::save_result_file name doc style
    compression<label|xslt::save-result-file>>

    <item*|xslt::save_result_string doc style<label|xslt::save-result-string>>Save
    the transformation result <verbatim|doc> obtained with the stylesheet
    <verbatim|style> to a file or a string. This works pretty much like
    <verbatim|save_file> or <verbatim|save_string>, but also keeps track of
    some output-related information contained in the stylesheet.
  </description>

  <with|font-series|bold|Example>

  Load the recipes.xml document and the recipes.xsl stylesheet distributed
  with the sources:

  <\verbatim>
    \;

    \<gtr\> let recipes = xml::load_file "recipes.xml" xml::DTDVALID;

    \<gtr\> let style = xslt::load_stylesheet "recipes.xsl";

    \;
  </verbatim>

  Apply the stylesheet to the document and save the result in a html file:

  <\verbatim>
    \;

    \<gtr\> let res = xslt::apply_stylesheet style recipes [];

    \<gtr\> xslt::save_result_file "recipes.html" res style 0;

    ()

    \;
  </verbatim>

  That's all. You can now have a look at recipes.html in your favourite web
  browser.

  <subsubsection*|<hlink|Table Of Contents|index.tm>><label|pure-xml-toc>

  <\itemize>
    <item><hlink|Pure-XML - XML/XSLT interface|#>

    <\itemize>
      <item><hlink|Copying|#copying>

      <item><hlink|Installation|#installation>

      <item><hlink|Usage|#usage>

      <item><hlink|Data Structure|#data-structure>

      <\itemize>
        <item><hlink|The Document Tree|#the-document-tree>

        <item><hlink|Document Types|#document-types>
      </itemize>

      <item><hlink|Operations|#operations>

      <\itemize>
        <item><hlink|Document Operations|#document-operations>

        <item><hlink|Traversing Documents|#traversing-documents>

        <item><hlink|Node Information|#node-information>

        <item><hlink|Node Manipulation|#node-manipulation>

        <item><hlink|Transformations|#transformations>
      </itemize>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Pure-Sql3|pure-sql3.tm>

  Next topic

  <hlink|pure-g2|pure-g2.tm>

  <hlink|toc|#pure-xml-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-g2.tm> \|
  <hlink|previous|pure-sql3.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2019, Albert Gräf et al. Last updated on Aug
  21, 2019. Created using <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1.3.
</body>
