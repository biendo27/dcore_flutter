import 'flavors.dart';
import 'main.dart' as runner;

void main() {
  F.appFlavor = Flavor.dev;
  runner.main();
}
