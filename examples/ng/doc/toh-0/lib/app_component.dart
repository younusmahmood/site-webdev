// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// #docregion
import 'package:angular/angular.dart';

@Component(
  selector: 'my-app',
  template: '<h1>Hello {{name}}</h1>',
)
class AppComponent {
  var name = 'Angular';
}
