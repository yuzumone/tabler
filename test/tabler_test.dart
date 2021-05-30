import 'package:tabler/tabler.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('First Test', () {
      var t = Tabler();
      t.add(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''+---+----+-----+
| a | b  | c   |
| 1 | 22 | 333 |
+---+----+-----+''';
      expect(t.toString(), expected);
    });
  });
}
