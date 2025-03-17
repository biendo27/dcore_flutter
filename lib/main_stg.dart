import 'flavors.dart';
import 'main.dart' as runner;

void main() {
  F.appFlavor = Flavor.stg;
  runner.main();
}
