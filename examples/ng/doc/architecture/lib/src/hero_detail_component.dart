import 'package:angular/angular.dart';

import 'hero.dart';

@Component(
  selector: 'hero-detail',
  templateUrl: 'hero_detail_component.html',
  directives: const [COMMON_DIRECTIVES],
)
class HeroDetailComponent {
  @Input()
  Hero hero;
}
