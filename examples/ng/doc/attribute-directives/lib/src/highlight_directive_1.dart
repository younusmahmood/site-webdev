// #docregion
import 'package:angular/angular.dart';

@Directive(selector: '[myHighlight]')
class HighlightDirective {
  HighlightDirective(ElementRef el) {
    el.nativeElement.style.backgroundColor = 'yellow';
  }
}
