/**
 * @license
 * Copyright Google Inc. All Rights Reserved.
 */

import 'dart:async';

import 'package:angular/angular.dart';

// #docregion AsyncPipe
@Component(
    selector: 'async-greeter',
    template: '''
      <div>
        <p>Wait for it ... {{ greeting | async }}</p>
        <button [disabled]="!done" (click)="tryAgain()">Try Again!</button>
      </div>''')
class AsyncGreeterPipe {
  static const _delay = const Duration(seconds: 2);

  Future<String> greeting;
  bool done;

  AsyncGreeterPipe() {
    tryAgain();
  }

  String greet() {
    done = true;
    return "Hi!";
  }

  void tryAgain() {
    done = false;
    greeting = new Future<String>.delayed(_delay, greet);
  }
}

@Component(
    selector: 'async-time',
    template: "<p>Time: {{ time | async | date:'mediumTime'}}</p>") //
class AsyncTimePipe {
  static const _delay = const Duration(seconds: 1);
  final Stream<DateTime> time =
      new Stream.periodic(_delay, (_) => new DateTime.now());
}
