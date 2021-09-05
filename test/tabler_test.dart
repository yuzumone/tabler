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

    test('no header with ansi espace charctor', () {
      var t = Tabler();
      var cell1 = '\u{1B}[1m1\u{1B}[0m';
      var cell2 = '\u{1B}[31m22\u{1B}[0m';
      var cell3 = '\u{1B}[43m333\u{1B}[0m';
      t.add(['a', 'b', 'c']);
      t.add([cell1, cell2, cell3]);
      var expected = '''+---+----+-----+
| a | b  | c   |
| $cell1 | $cell2 | $cell3 |
+---+----+-----+''';
      expect(t.toString(), expected);
    });

    test('no header with ansi espace charctor align right', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.right));
      var cell1 = '\u{1B}[1m1\u{1B}[0m';
      var cell2 = '\u{1B}[31m22\u{1B}[0m';
      var cell3 = '\u{1B}[43m333\u{1B}[0m';
      t.add(['a', 'b', 'c']);
      t.add([cell1, cell2, cell3]);
      var expected = '''+---+----+-----+
| a |  b |   c |
| $cell1 | $cell2 | $cell3 |
+---+----+-----+''';
      expect(t.toString(), expected);
    });

    test('no header with ansi espace charctor align center', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.center));
      var cell1 = '\u{1B}[1m1\u{1B}[0m';
      var cell2 = '\u{1B}[31m22\u{1B}[0m';
      var cell3 = '\u{1B}[43m333\u{1B}[0m';
      t.add(['a', 'b', 'c']);
      t.add([cell1, cell2, cell3]);
      var expected = '''+---+----+-----+
| a | b  |  c  |
| $cell1 | $cell2 | $cell3 |
+---+----+-----+''';
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

    test('with header with ansi espace charctor', () {
      var t = Tabler();
      var cell1 = '\u{1B}[1m1\u{1B}[0m';
      var cell2 = '\u{1B}[31m22\u{1B}[0m';
      var cell3 = '\u{1B}[43m333\u{1B}[0m';
      t.add([cell1, cell2, cell3]);
      t.addHeader(['あ', '🎉🎉', 'aあ🎉']);
      var expected = '''+----+------+-------+
| あ | 🎉🎉 | aあ🎉 |
+----+------+-------+
| $cell1  | $cell2   | $cell3   |
+----+------+-------+''';
      expect(t.toString(), expected);
    });

    test('with header with ansi espace charctor align right', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.right));
      var cell1 = '\u{1B}[1m1\u{1B}[0m';
      var cell2 = '\u{1B}[31m22\u{1B}[0m';
      var cell3 = '\u{1B}[43m333\u{1B}[0m';
      t.add([cell1, cell2, cell3]);
      t.addHeader(['あ', '🎉🎉', 'aあ🎉']);
      var expected = '''+----+------+-------+
| あ | 🎉🎉 | aあ🎉 |
+----+------+-------+
|  $cell1 |   $cell2 |   $cell3 |
+----+------+-------+''';
      expect(t.toString(), expected);
    });

    test('with header with ansi espace charctor align center', () {
      var t = Tabler(style: TablerStyle(align: TableTextAlign.center));
      var cell1 = '\u{1B}[1m1\u{1B}[0m';
      var cell2 = '\u{1B}[31m22\u{1B}[0m';
      var cell3 = '\u{1B}[43m333\u{1B}[0m';
      t.add([cell1, cell2, cell3]);
      t.addHeader(['あ', '🎉🎉', 'aあ🎉']);
      var expected = '''+----+------+-------+
| あ | 🎉🎉 | aあ🎉 |
+----+------+-------+
| $cell1  |  $cell2  |  $cell3  |
+----+------+-------+''';
      expect(t.toString(), expected);
    });
  });
}
