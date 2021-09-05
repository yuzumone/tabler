import 'package:tabler/tabler.dart';

void main() {
  var t = Tabler();
  t.add(['a', 'b', 'c']);
  t.add([1, 22, 333]);
  print(t);
  // +---+----+-----+
  // | a | b  | c   |
  // | 1 | 22 | 333 |
  // +---+----+-----+

  var data = [
    ['1', '2', '3']
  ];
  var header = ['First', 'Second', 'Third'];
  var t2 = Tabler(
    data: data,
    header: header,
    style: TablerStyle(
      verticalChar: '!',
      horizontalChar: '=',
      junctionChar: '#',
      padding: 3,
      align: TableTextAlign.right,
    ),
  );
  print(t2);
  // #===========#============#===========#
  // !   First   !   Second   !   Third   !
  // #===========#============#===========#
  // !       1   !        2   !       3   !
  // #===========#============#===========#

  var t3 = Tabler();
  var cell1 = '\u{1B}[1m1\u{1B}[0m';
  var cell2 = '\u{1B}[31m22\u{1B}[0m';
  var cell3 = '\u{1B}[43m333\u{1B}[0m';
  t3.add([cell1, cell2, cell3]);
  t3.addHeader(['あ', '🎉🎉', 'aあ🎉']);
  print(t3);
  // +----+------+-------+
  // | あ | 🎉🎉 | aあ🎉 |
  // +----+------+-------+
  // | 1  | 22   | 333   |
  // +----+------+-------+
}
