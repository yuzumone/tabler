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
}
