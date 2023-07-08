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
    for (var e in data) {
      add(e);
    }
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
    _header.addAll(header);
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
    for (var element in rows) {
      element.asMap().forEach((i, value) {
        w[i] = max(w[i], _getSize(value)[0]);
      });
    }
    return w;
  }

  String _stringifyHrule(List<int> widths) {
    final lpad = _style.padding;
    final rpad = _style.padding;
    final horizontalChar = _style.horizontalChar;
    final junctionChar = _style.junctionChar;
    final isBorder = _style.border;

    var bits = <String>[];
    if (isBorder) {
      bits.add(junctionChar);
    }
    widths.asMap().forEach((i, value) {
      bits.add(List.filled(lpad + rpad + value, horizontalChar).join(''));
      if (isBorder || i < widths.length - 1) {
        bits.add(junctionChar);
      }
    });
    return bits.join('');
  }

  String _stringifyRow(List<String> row, List<int> widths) {
    final pad = List.filled(_style.padding, ' ').join('');
    final verticalChar = _style.verticalChar;
    final align = _style.align;
    final isBorder = _style.border;
    final rowHeight = row.map((e) => _getSize(e)[1]).reduce(max);
    final bits = [];

    for (var _ in List.generate(rowHeight, (index) => index)) {
      if (isBorder) {
        bits.add([verticalChar]);
      } else {
        bits.add(['']);
      }
    }
    row.asMap().forEach((i, value) {
      var width = widths[i];
      var lines = value.split('\n');
      var dHeight = rowHeight - lines.length;
      if (dHeight > 0) {
        lines = lines + List.filled(dHeight, '');
      }
      lines.asMap().forEach((j, v) {
        var s = _justify(v, width, align);
        bits[j].add('$pad$s$pad');
        if (isBorder || i < row.length - 1) {
          bits[j].add(verticalChar);
        }
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
          return '$space$text$space ';
        } else {
          return space + text + space;
        }
    }
  }

  String _build(List<List<String>> data, List<String> header) {
    final lines = <String>[];
    final widths = _computeWidths([...data, header]);
    final hrule = _stringifyHrule(widths);

    if (header.isNotEmpty) {
      lines.add(hrule);
      lines.add(_stringifyRow(header, widths));
    }

    lines.add(hrule);
    for (var e in data) {
      lines.add(_stringifyRow(e, widths));
    }
    lines.add(hrule);
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

  /// Controls whether or not a border is drawn around the table.
  final bool border;

  /// Creates a table style.
  const TablerStyle({
    this.verticalChar = '|',
    this.horizontalChar = '-',
    this.junctionChar = '+',
    this.padding = 1,
    this.align = TableTextAlign.left,
    this.border = true,
  });
}

extension StringExt on String {
  String removeAnsiEscape() {
    final regex = RegExp(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])');
    return replaceAll(regex, '');
  }
}
