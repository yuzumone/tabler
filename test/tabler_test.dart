import 'package:tabler/tabler.dart';
import 'package:test/test.dart';

void main() {
  group('tabler test no header', () {
    test('no header asii only', () {
      var t = Tabler();
      t.add(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''+---+----+-----+
| a | b  | c   |
| 1 | 22 | 333 |
+---+----+-----+''';
      expect(t.toString(), expected);
    });

    test('no header asii only setting padding', () {
      var t = Tabler(style: TablerStyle(padding: 4));
      t.add(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''+---------+----------+-----------+
|    a    |    b     |    c      |
|    1    |    22    |    333    |
+---------+----------+-----------+''';
      expect(t.toString(), expected);
    });

    test('no header asii only setting char', () {
      var t = Tabler(
        style: TablerStyle(
          verticalChar: '!',
          horizontalChar: '=',
          junctionChar: '#',
        ),
      );
      t.add(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''#===#====#=====#
! a ! b  ! c   !
! 1 ! 22 ! 333 !
#===#====#=====#''';
      expect(t.toString(), expected);
    });

    test('no header asii only align right', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.right));
      t.add(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''+---+----+-----+
| a |  b |   c |
| 1 | 22 | 333 |
+---+----+-----+''';
      expect(t.toString(), expected);
    });

    test('no header asii only align center', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.center));
      t.add(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''+---+----+-----+
| a | b  |  c  |
| 1 | 22 | 333 |
+---+----+-----+''';
      expect(t.toString(), expected);
    });

    test('no header with multi bytes', () {
      var t = Tabler();
      t.add(['あ', '🎉🎉', 'aあ🎉']);
      t.add([1, 22, 333]);
      var expected = '''+----+------+-------+
| あ | 🎉🎉 | aあ🎉 |
| 1  | 22   | 333   |
+----+------+-------+''';
      expect(t.toString(), expected);
    });

    test('no header with multi bytes align right', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.right));
      t.add(['あ', '🎉🎉', 'aあ🎉']);
      t.add([1, 22, 333]);
      var expected = '''+----+------+-------+
| あ | 🎉🎉 | aあ🎉 |
|  1 |   22 |   333 |
+----+------+-------+''';
      expect(t.toString(), expected);
    });

    test('no header with multi bytes align center', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.center));
      t.add(['あ', '🎉🎉', 'aあ🎉']);
      t.add([1, 22, 333]);
      var expected = '''+----+------+-------+
| あ | 🎉🎉 | aあ🎉 |
| 1  |  22  |  333  |
+----+------+-------+''';
      expect(t.toString(), expected);
    });
  });

  group('tabler test with header', () {
    test('with header asii only', () {
      var t = Tabler();
      t.addHeader(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''+---+----+-----+
| a | b  | c   |
+---+----+-----+
| 1 | 22 | 333 |
+---+----+-----+''';
      expect(t.toString(), expected);
    });

    test('with header asii only setting padding', () {
      var t = Tabler(style: TablerStyle(padding: 4));
      t.addHeader(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''+---------+----------+-----------+
|    a    |    b     |    c      |
+---------+----------+-----------+
|    1    |    22    |    333    |
+---------+----------+-----------+''';
      expect(t.toString(), expected);
    });

    test('with header asii only setting char', () {
      var t = Tabler(
        style: TablerStyle(
          verticalChar: '!',
          horizontalChar: '=',
          junctionChar: '#',
        ),
      );
      t.addHeader(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''#===#====#=====#
! a ! b  ! c   !
#===#====#=====#
! 1 ! 22 ! 333 !
#===#====#=====#''';
      expect(t.toString(), expected);
    });

    test('with header asii only align right', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.right));
      t.addHeader(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''+---+----+-----+
| a |  b |   c |
+---+----+-----+
| 1 | 22 | 333 |
+---+----+-----+''';
      expect(t.toString(), expected);
    });

    test('with header asii only align center', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.center));
      t.addHeader(['a', 'b', 'c']);
      t.add([1, 22, 333]);
      var expected = '''+---+----+-----+
| a | b  |  c  |
+---+----+-----+
| 1 | 22 | 333 |
+---+----+-----+''';
      expect(t.toString(), expected);
    });

    test('with header with multi bytes', () {
      var t = Tabler();
      t.addHeader(['あ', '🎉🎉', 'aあ🎉']);
      t.add([1, 22, 333]);
      var expected = '''+----+------+-------+
| あ | 🎉🎉 | aあ🎉 |
+----+------+-------+
| 1  | 22   | 333   |
+----+------+-------+''';
      expect(t.toString(), expected);
    });

    test('no header with multi bytes align right', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.right));
      t.addHeader(['あ', '🎉🎉', 'aあ🎉']);
      t.add([1, 22, 333]);
      var expected = '''+----+------+-------+
| あ | 🎉🎉 | aあ🎉 |
+----+------+-------+
|  1 |   22 |   333 |
+----+------+-------+''';
      expect(t.toString(), expected);
    });

    test('no header with multi bytes align center', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.center));
      t.addHeader(['あ', '🎉🎉', 'aあ🎉']);
      t.add([1, 22, 333]);
      var expected = '''+----+------+-------+
| あ | 🎉🎉 | aあ🎉 |
+----+------+-------+
| 1  |  22  |  333  |
+----+------+-------+''';
      expect(t.toString(), expected);
    });
  });
}
