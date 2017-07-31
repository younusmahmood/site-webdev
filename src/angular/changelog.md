---
layout: angular
title: AngularDart Changelog
description: A summary of changes to the AngularDart documentation and examples.
---

This page summarizes changes to the AngularDart documentation and examples.
Many of these changes are due to new releases of
AngularDart, AngularDart Components, or the Dart SDK.
Others are the result of new recommendations or documentation.

Also see:

* [History of commits to AngularDart documentation](https://github.com/dart-lang/site-webdev/commits/master/src/angular)
* [History of commits to AngularDart examples](https://github.com/dart-lang/site-webdev/commits/master/examples/ng/doc)
* Package changelogs:
  * [`angular2` changelog][]
  * [`angular` changelog][]
  * [`angular_components` changelog](https://pub.dartlang.org/packages/angular_components#pub-pkg-tab-changelog)


## AngularDart 4.0 alpha (July 2017)

<aside class="alert alert-info" markdown="1">
**Note:**
These changes aren't yet visible on webdev.dartlang.org,
but you can see a preview at
[webdev-dartlang-org-dev.firebaseapp.com/angular.](https://webdev-dartlang-org-dev.firebaseapp.com/angular)
</aside>

All pubspecs and imports changed, as well as API doc URLs,
due to the `angular2` package changing its name to `angular`.
We expect imports (and API doc URLs) to change again before 4.0 is stable,
because the router and forms implementations are moving into new packages
(`angular_router` and `angular_forms`).
We also expect to remove references to `resolved_identifiers`.

* Updated references to packages and transformers in `pubspec.yaml`:
  * `angular2` &rarr; `angular`
* Updated `angular` <!-- & angular_components --> version:
  * `^3.1.0` &rarr; `^4.0.0-alpha`
* Changed imports:
    * `angular2/angular2.dart` &rarr; `angular/angular.dart`
    * `angular2/platform/browser.dart` &rarr; `angular/angular.dart`
      <!-- [PENDING: why?] -->
    * `angular2/common.dart` &rarr; `angular/angular.dart`
{% comment %}
    * `angular2/router.dart` &rarr; ... [PENDING: fix]
    * In Dart files that use form directives
    (those that use `COMMON_DIRECTIVES` or `FORM_DIRECTIVES`)
    add an import of ... [PENDING: fix].
    * [PENDING: add any other import changes here...]
{% endcomment %}
* Changed API doc URLs
  * The `angular2` &rarr; `angular` change affected API doc URLs. <br>
    Example:
    .../angular2/NgFor-class
    &rarr;
    [.../angular/NgFor-class](/angular/api/angular/NgFor-class)

More information:

* [`angular` changelog][]
* [History for site-webdev/examples/ng (4-dev branch)](https://github.com/dart-lang/site-webdev/commits/4-dev/examples/ng)
* [4.0 prep tracking issue](https://github.com/dart-lang/site-webdev/issues/670)


## API doc changes (July 2017)

Because `common.dart` is going away in 4.0, we changed API doc generation.
We also fixed some bugs in the API doc homepage
and added import information for each library.

* `angular2.common` &rarr; `angular2` <br>
  Example: .../angular2.common/NgFor-class &rarr; .../angular2/NgFor-class
* [The AngularDart API doc homepage](/angular/api)
  now shows an `import` statement next to each library's heading.


## Dart 1.24 (June 2017)

We did initial work to prepare the examples to use
the Dart development compiler (dartdevc):

* Updated `pubspec.yaml` to make dartdevc the default development compiler.
* Moved most implementation Dart files under `lib/src/*`,
  instead of `lib/*`, to improve dartdevc performance.

More information:
* [Preparing your code](/tools/dartdevc#preparing-your-code) in the
[dartdevc documentation](/tools/dartdevc)
* [Dart 1.24 announcement](http://news.dartlang.org/2017/06/dart-124-faster-edit-refresh-cycle-on.html)
* [PR #744](https://github.com/dart-lang/site-webdev/pull/744/files) and other
  ["src reorg" PRs](https://github.com/dart-lang/site-webdev/pulls?utf8=%E2%9C%93&q=is%3Apr%20%22src%20reorg%22)
* [PR #684](https://github.com/dart-lang/site-webdev/pull/684/files)
  (pubspec changes)


## AngularDart 3.1 (May 2017)

The examples changed to update the release and reflect new recommendations.

* Replaced `core.dart` imports:
  `angular2/core.dart` &rarr; `angular2/angular2.dart`
* To prepare for 3.1's experimental compiler, in each example:
  * Removed `platform_directives` from `pubspec.yaml`,
    moving the directives it listed
    to the relevant components' `directives` lists.
  * Removed `platform_pipes` from `pubspec.yaml`,
    moving `COMMON_PIPES` to the relevant components' `pipes` lists.
* Updated the `angular2` dependency in each example's pubspec:
  `^3.0.0` &rarr; `^3.1.0`.

Here's an example of moving the directive and pipe lists:

<?code-excerpt title="OLD: pubspec.yaml"?>
```
transformers:
- angular2:
    platform_directives:
    - 'package:angular2/common.dart#CORE_DIRECTIVES'
    platform_pipes:
    - 'package:angular2/common.dart#COMMON_PIPES'
```

<?code-excerpt title="NEW: component file (Dart)"?>
```
@Component(
  ...
  directives: const [CORE_DIRECTIVES],
  pipes: const [COMMON_PIPES])
```

Common directive constants include `COMMON_DIRECTIVES`, `CORE_DIRECTIVES`,
`FORM_DIRECTIVES`, and `ROUTER_DIRECTIVES`.


More information:

* [`angular2` changelog][]
* [PR #625](https://github.com/dart-lang/site-webdev/pull/625/files?w=1)
  (moves directive and pipe lists from pubspecs to components)


## Testing doc and code, part 1 (March-April 2017)

Created an initial [Testing page](/angular/guide/testing) and
added component tests to the tutorial examples.

Pubspec updates:

* Added `angular_test` and `test` to the `dev_dependencies` list.
* Added the `reflection_remover` and `pub_serve` transformers.

More information:

* [PR #478](https://github.com/dart-lang/site-webdev/pull/478/files) (initial text and toh-0 tests)
* [PR #567](https://github.com/dart-lang/site-webdev/pull/567/files?w=1) (toh-6 tests)

[`angular` changelog]: https://pub.dartlang.org/packages/angular/versions/4.0.0-alpha%2B1#pub-pkg-tab-changelog
[`angular2` changelog]: https://pub.dartlang.org/packages/angular2#pub-pkg-tab-changelog