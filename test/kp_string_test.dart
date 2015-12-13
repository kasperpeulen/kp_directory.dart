import 'package:kp_directory/kp_string.dart';
import 'package:test/test.dart';

void main() {
  var cases = [
    ["hello-world", 'helloWorld'],
    ['camel-case-all-the-things', 'camelCaseAllTheThings']
  ];
  for (var c in cases) {
    test("camel case from kebab case", () {
      expect(kebab2camel(c[0]), c[1]);
    });
  }
}
