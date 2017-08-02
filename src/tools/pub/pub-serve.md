---
layout: default
title: "pub serve"
permalink: /tools/pub/pub-serve
description: "Use pub serve to start up a development server for your Dart application."
---

_Serve_ is one of the commands of the _pub_ tool.
[Learn more about pub](/tools/pub).

{% prettify sh %}
$ pub serve [<options>] [<directories>]
{% endprettify %}

This command starts up a _development server_, or _dev server_,
for your Dart web app. The dev server is an HTTP server on localhost
that serves up your web app's
[assets]({{site.dartlang}}/tools/pub/glossary#asset).

Start the dev server from the directory that contains your web app's
`pubspec.yaml` file:

{% prettify sh %}
$ cd ~/dart/helloworld
$ pub serve
Serving helloworld on http://localhost:8080
{% endprettify %}

The dev server doesn't just serve up assets, it produces them by running
[transformers]({{site.dartlang}}/tools/pub/glossary#transformer).
A transformer converts input assets (such as Dart files or
Polymer-formatted HTML) into output assets
(such as JavaScript and HTML).

These output assets aren't in the file system; they exist only in the dev
server. When you're ready to deploy, generate output files by running
[`pub build`](/tools/pub/pub-build).

Pub automatically includes a dart2js transformer that compiles your Dart code
to JavaScript. With this, you can change some Dart code, refresh your
non-Dartium browser, and soon see the changes. See
[Configuring the Built-in dart2js Transformer](/tools/pub/dart2js-transformer)
for information on how to configure the dart2js options in your pubspec.

<aside class="alert alert-info" markdown="1">
**Note:**
The 1.24 Dart SDK introduced pub support for a second Dart-to-JavaScript compiler,
the Dart development compiler (_dartdevc_).
You can use dartdevc with `pub serve` to generate JavaScript code that
runs in any modern browser and has a fast edit-refresh cycle.
For more information, see the [dartdevc documentation.](/tools/dartdevc)
</aside>

{% comment %}
update-for-dart-2
{% endcomment %}


See [Pub Assets and Transformers]({{site.dartlang}}/tools/pub/assets-and-transformers) for
information on:

* Where in your package to put assets.
* What URLs to use when referring to assets.
* How to use `pubspec.yaml` to specify which transformers run, and in
  what order.

## Options {#options}

For options that apply to all pub commands, see
[Global options]({{site.dartlang}}/tools/pub/cmd#global-options).

<dl>
<dt><code>&lt;directories&gt;</code></dt>
<dd>Optional. Use this option to specify the directories to use
as input for the serve command, in addition to <code>lib</code>
(which is always processed).
The default values are <code>web</code> and <code>test</code>.
Directories you might typically specify include the following:

<ul>
<li>benchmark</li>
<li>bin</li>
<li>example</li>
<li>test</li>
<li>web</li>
</ul>

For example, you might specify:

{% prettify sh %}
pub serve test benchmark example/foo bar
{% endprettify %}

In the preceding example, the <code>test</code>, <code>benchmark</code>,
<code>example/foo</code>, and <code>bar</code> directories are processed,
as is the <code>lib</code> directory.
The <code>web</code> directory is not served because it isn't specified.</dd>

<dt><code>--all</code></dt>
<dd>Optional. Serves all of the buildable directories (benchmark, bin, example,
test, and web) that are present.</dd>


<dt><code>--hostname=&lt;host&gt;</code></dt>
<dd>Optional. By default, the dev server listens on <code>localhost</code>.
You can specify another host using the <code>--hostname</code> option.
For example:
{% prettify sh %}
$ pub serve --hostname=127.0.0.1
Loading source assets...
Loading markdown_converter transformers... (1.3s)
Serving markdown_converter web on http://127.0.0.1:8080
Build completed successfully
{% endprettify %}
</dd>


<dt><code>--port=&lt;number&gt;</code></dt>
<dd>Optional. By default, the dev server uses <code>http://localhost:8080</code>.
To change the port number, use the <code>--port</code> option:
{% prettify sh %}
$ pub serve --port=9080
Serving helloworld web on http://localhost:9080
{% endprettify %}
</dd>


<dt><code>--mode=&lt;mode&gt;</code></dt>
<dd>Optional. Specifies a transformation mode. Typical values are
"debug" and "release", but any word is allowed.
Transformers may use this to change how they behave.<br><br>

If the mode is "release",
then pub generates minified JavaScript using dart2js (or the specified compiler).
Otherwise, pub uses dart2js (or the specified compiler)
to generate unminified JavaScript.
In release mode, pub does not
include any source <code>.dart</code> files in the build output.
In any other mode, the raw Dart files are included.<br><br>

If this option is omitted, its default value is "debug".</dd>


<dt><code>--web-compiler=&lt;compiler&gt;</code> </dt>
<dd>Optional (added in 1.24).
Specifies which Dart-to-JavaScript compiler to use.
Possible values are "<a href="/tools/dart2js">dart2js</a>",
"<a href="/tools/dartdevc">dartdevc</a>", and "none" (no generated JavaScript).
<br><br>

If this option is omitted, its default value is "dart2js".
</dd>
</dl>

<aside class="alert alert-info" markdown="1">
*Problems?*
See [Troubleshooting Pub]({{site.dartlang}}/tools/pub/troubleshoot).
</aside>
