// #docregion
import 'package:angular/angular.dart';
import 'exponential_strength_pipe.dart';

@Component(
  selector: 'power-boost-calculator',
  template: '''
    <h2>Power Boost Calculator</h2>
    <div>Normal power: <input type="number" [(ngModel)]="power"/></div>
    <div>Boost factor: <input type="number" [(ngModel)]="factor"/></div>
    <p>
      Super Hero Power: {{power | exponentialStrength: factor}}
    </p>
  ''',
  directives: const [COMMON_DIRECTIVES],
  pipes: const [ExponentialStrengthPipe],
)
class PowerBoostCalculatorComponent {
  num power = 5;
  num factor = 1;
}
