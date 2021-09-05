import 'dart:math';
import 'package:wcwidth/wcwidth.dart';

/// Whether and how to align text horizontally.
enum TableTextAlign {
  /// Align the text on the left edge of the cell.
  left,

  /// Align the text in the center of the cell.
  center,

  /// Align the text on the right edge of the cell.
  right,
}

/// A class for displaying table format.
class Tabler {
  final List<List<dynamic>> _data;
  final List<dynamic> _header;
  final TablerStyle _style;
  int _rowCount = 0;

  Tabler._(this._data, this._header, this._style);

  /// Creates a table.
  Tabler({
    List<List<dynamic>>? data,
    List<dynamic>? header,
    TablerStyle? style,
  }) : this._(data ?? [], header ?? [], style ?? TablerStyle());

  /// Add a row to the table.
  void add(List<dynamic> data) {
    if (_rowCount != 0 && _rowCount != data.length) {
      throw Exception('Row has incorrect number of values.');
    }
    if (_rowCount == 0) {
      _rowCount = data.length;
    }
    _data.add(data);
  }

  /// Add rows to the table.
  void addAll(List<List<dynamic>> data) {
    data.forEach((e) => add(e));
  }

  /// Remove a row from the table.
  void remove(int index) {
    if (index > _data.length - 1) {
      throw Exception('Can\'t delete row at index $index');
    }
    _data.removeAt(index);
  }

  /// Clear all rows from the table.
  void clear() {
    _data.clear();
  }

  /// Add a header to the table.
  void addHeader(List<dynamic> header) {
    if (_rowCount != 0 && _rowCount != header.length) {
      throw Exception('Row has incorrect number of values.');
    }
    if (_rowCount == 0) {
      _rowCount = header.length;
    }
    header.forEach((e) => _header.add(e));
  }

  /// Clear a header from the table.
  void removeHeader() {
    _header.clear();
  }

  List<int> _getSize(String s) {
    var lines = s.split('\n');
    var height = lines.length;
    var width = lines.map((e) => e.removeAnsiEscape().wcwidth()).reduce(max);
    return [width, height];
  }

  List<int> _computeWidths(List<List<String>> rows) {
    var w = List.filled(rows[0].length, 0);
    rows.forEach((element) {
      element.asMap().forEach((i, value) {
        w[i] = max(w[i], _getSize(value)[0]);
      });
    });
    return w;
  }

  String _stringifyHrule(List<int> widths) {
    final lpad = _style.padding;
    final rpad = _style.padding;
    final horizontalChar = _style.horizontalChar;
    final junctionChar = _style.junctionChar;

    var bits = <String>[];
    bits.add(junctionChar);
    widths.forEach((element) {
      bits.add(List.filled(lpad + rpad + element, horizontalChar).join(''));
      bits.add(junctionChar);
    });
    return bits.join('');
  }

  String _stringifyRow(List<String> row, List<int> widths) {
    final pad = List.filled(_style.padding, ' ').join('');
    final verticalChar = _style.verticalChar;
    final align = _style.align;
    final rowHeight = row.map((e) => _getSize(e)[1]).reduce(max);
    final bits = [];

    List.generate(rowHeight, (index) => index)
        .forEach((e) => bits.add([verticalChar]));
    row.asMap().forEach((i, value) {
      var width = widths[i];
      var lines = value.split('\n');
      var dHeight = rowHeight - lines.length;
      if (dHeight > 0) {
        lines = lines + List.filled(dHeight, '');
      }
      lines.asMap().forEach((i, v) {
        var s = _justify(v, width, align);
        bits[i].add('$pad$s$pad');
        bits[i].add(verticalChar);
      });
    });

    return bits.map((e) => e.join('')).join('\n');
  }

  String _justify(String text, int width, TableTextAlign align) {
    var excess = width - text.removeAnsiEscape().wcwidth();
    switch (align) {
      case TableTextAlign.left:
        var space = ' ' * excess;
        return text + space;
      case TableTextAlign.right:
        var space = ' ' * excess;
        return space + text;
      case TableTextAlign.center:
        var space = ' ' * (excess ~/ 2);
        if (excess % 2 == 1) {
          return space + text + space + ' ';
        } else {
          return space + text + space;
        }
    }
  }

  String _build(List<List<String>> data, List<String> header) {
    final lines = <String>[];
    final _widths = _computeWidths([...data, header]);
    final _hrule = _stringifyHrule(_widths);

    if (header.isNotEmpty) {
      lines.add(_hrule);
      lines.add(_stringifyRow(header, _widths));
    }

    lines.add(_hrule);
    data.forEach((e) => lines.add(_stringifyRow(e, _widths)));
    lines.add(_hrule);
    return lines.join('\n');
  }

  @override
  String toString() {
    final data = _data.map((x) => x.map((y) => y.toString()).toList()).toList();
    final header = _header.map((x) => x.toString()).toList();
    return _build(data, header);
  }
}

/// A class for table style describing how to format.
class TablerStyle {
  /// The character string used to draw vertical lines.
  final String verticalChar;

  /// The character string used to draw horizontal lines.
  final String horizontalChar;

  /// The character string used to draw line junctions.
  final String junctionChar;

  /// Empty space to inscribe inside the cell.
  final int padding;

  /// How the text should be aligned horizontally.
  final TableTextAlign align;

  /// Creates a table style.
  const TablerStyle({
    this.verticalChar = '|',
    this.horizontalChar = '-',
    this.junctionChar = '+',
    this.padding = 1,
    this.align = TableTextAlign.left,
  });
}

extension StringExt on String {
  String removeAnsiEscape() {
    final regex = RegExp(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])');
    return replaceAll(regex, '');
  }
}
