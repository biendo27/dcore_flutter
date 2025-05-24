import 'flavors.dart';
import 'main.dart' as runner;

void main() {
  F.appFlavor = Flavor.prod;
  runner.main();
}
