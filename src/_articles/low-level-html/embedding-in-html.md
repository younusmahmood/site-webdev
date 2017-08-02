---
title: "Embedding Dart in HTML"
description: "Find out how you can embed Dart into HTML pages."
written: 2011-10-01
updated: 2014-12-01
category: low-level-html
obsolete: true
---

<em>Written by Sigmund Cherem, Vijay Menon, and Seth Ladd <br>
October 2011
(updated December 2014)</em>

<aside class="alert alert-warning" markdown="1">
**Note:**
This article doesn't reflect more recent recommendations such as building
to JavaScript using the [pub]({{site.dartlang}}/tools/pub) tool
(specifically, the [pub build](/tools/pub/pub-build) command).
Also, the recommended `<script ...>` tags are out of date.
See the [Stagehand](https://github.com/google/stagehand)
templates for our current recommendations.
</aside>

Dart apps compile to JavaScript to run across modern desktop and mobile
browsers. Dart apps can also run inside a Dart virtual machine (VM), which can be
embedded into web browsers.

This article covers how to integrate Dart apps into web pages, when first
compiled to JavaScript or when run in the Dart VM.

## Quick start

1. Compile your Dart app to JavaScript with
   [dart2js](/tools/dart2js).
   If your Dart file is `app.dart` then name your JavaScript version
   `app.dart.js`.
1. Load your Dart app with a `<script type="application/dart">` tag
   (only one per HTML page).
1. Follow that tag with a &lt;script&gt; tag for the `dart.js` file.

Here is a minimal example, which works in all browsers (even if they don't
  support the Dart VM):

{% prettify dart %}
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Dart App</title>
  </head>
  <body>
    <h1>Hello, Dart!</h1>
    <script type="application/dart" src="app.dart"></script>
    <script type="text/javascript" src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

## Dart MIME type and the script tag

HTML `script` tags provide a
`type` attribute to define the language of the script.
For Dart, this attribute has the value `application/dart`.

Here is an example:

{% prettify html %}
<script type="application/dart" src="app.dart"></script>
{% endprettify %}

Dart doesn't support inline scripts (scripts defined inside the HTML page).
While an inline script technically works in Dartium (a build of Chromium
with the Dart VM), the Dart-to-JavaScript compiler (dart2js) doesn't work with
inline scripts.

{% include dartium-2.0.html %}

The Dart app must have a visible top-level function called `main()`.
The browser invokes `main()` when the DOM content is loaded (but see
caveat in the [next section](#dart-semantics-in-html)).

You should use only one `<script type="application/dart">` inside the HTML
page. The dart2js compiler produces JavaScript that assumes it is
the only Dart app on the page.

## Dart semantics in HTML

The precise semantics of Dart execution on an HTML page are evolving
and likely to change by the time Dart is natively supported in a
production browser.

Currently, your Dart app's `main()` function is run after DOM content
is loaded, but the exact timing is undefined (e.g., with respect to
the load event or deferred JavaScript).  In the future, we may invoke
`main()` synchronously during HTML parsing instead of waiting for DOM
content to load.

As such, we recommend the following:

1. Restrict your application to a single Dart script per document.
1. Place your Dart script at the end of your document's body (followed
   only by the dart.js script if you choose to use that).
1. Do not use async or defer attributes on your Dart script tag at this point.
1. Do not rely upon ordering between your Dart script and any
   JavaScript scripts that may execute after it (e.g., that appear
   after it or are marked async or defer).
1. Do not rely upon script injection of Dart code.

## The dart.js script

Use the dart.js script, part of the
[browser package](https://pub.dartlang.org/packages/browser),
to run your app in browsers that don't have a
Dart VM. The dart.js script allows you to use the same HTML page for
both Dartium and other browsers.

If no Dart VM is detected in the browser, the dart.js script swaps out the
`application/dart` script for a
`text/javascript` script that points to the JavaScript version of the
Dart app.

The dart.js script tag must come after the Dart script tag.

For example:

{% prettify html %}
<script type="application/dart" src="awesome_app.dart"></script>
<script type="text/javascript" src="packages/browser/dart.js"></script>
{% endprettify %}

To get a copy of the dart.js file,
you can use the [pub package manager](/tools/pub).
Here's how:

1. Add the following to your application's pubspec.yaml,
   replacing the version range with the appropriate version:

       dependencies:
         browser: ">=0.10.0 <0.11.0"

2. Run `pub get`.

3. Use a relative script tag to point to the installed version:

       <script src="packages/browser/dart.js"></script>

## Fundamental differences from JavaScript

Embedding Dart code is different from embedding JavaScript
in a few ways.

### A single script tag

Each HTML document can have at most one Dart script tag, or only one
script tag that references a Dart app that is compiled to JavaScript.
This fundamentally differs from the way
that JavaScript is embedded in HTML&mdash;in
JavaScript, you can have multiple script tags per document.

In JavaScript, additional script tags are used to import third party libraries
(e.g., jQuery).  In Dart, this is not necessary: import is part of the language.

Web components and HTML imports are an important caveat to the one
script per document rule.
For example, the [Polymer Dart](https://github.com/dart-lang/polymer-dart/wiki)
framework uses HTML imports to allow developers to include HTML components into a
Dart application.  Dart scripts in imported HTML documents are
injected into the main application.  See the [Polymer Dart
documentation](https://github.com/dart-lang/polymer-dart/wiki) for more details.

### Execution timing

Unlike in JavaScript,
top-level Dart constructs (such as interfaces, classes, and functions)
are declarative.
Each Dart application (defined via a script tag)
provides an explicit `main()` entry point
that is invoked by the browser when it is ready to run.

Currently, the Dart app's `main()` function
is invoked after the page's DOM is loaded.

### No inline event listeners

We disallow inline event listeners of the form:

{% prettify html %}
<div onclick="foo()">Click this text.</div>
{% endprettify %}

With JavaScript, programmers can embed inline event listener code
directly onto HTML nodes.
However, this is typically discouraged in modern JavaScript applications.
HTML pages generally render more quickly
if listeners are added programmatically afterwards.
Modern security guidelines also discourage inline code.
As such, we propose to not allow inline Dart listeners.

### No script injection of Dart code

We do not currently support or recommend dynamically injecting a
`<script>` tag that loads Dart code. Recent browser security trends,
like Content Security Policy, actively prevent this practice.
