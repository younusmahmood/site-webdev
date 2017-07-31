// #docregion
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular/router.dart';

import 'hero.dart';
import 'hero_service.dart';
// #docregion search
import 'hero_search_component.dart';

@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard_component.html',
  styleUrls: const ['dashboard_component.css'],
  directives: const [CORE_DIRECTIVES, HeroSearchComponent, ROUTER_DIRECTIVES],
)
// #enddocregion search
class DashboardComponent implements OnInit {
  List<Hero> heroes;

  final HeroService _heroService;

  DashboardComponent(this._heroService);

  Future<Null> ngOnInit() async {
    heroes = (await _heroService.getHeroes()).skip(1).take(4).toList();
  }
}
