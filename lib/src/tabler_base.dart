import 'dart:math';

enum TableTextAlign {
  left,
  center,
  right,
}

class Tabler {
  final List<List<dynamic>> _data;
  final List<dynamic> _header;
  final TablerStyle _style;
  int _rowCount = 0;

  Tabler._(this._data, this._header, this._style);

  Tabler({
    List<List<dynamic>>? data,
    List<dynamic>? header,
    TablerStyle? style,
  }) : this._(data ?? [], header ?? [], style ?? TablerStyle());

  void add(List<dynamic> data) {
    if (_rowCount != 0 && _rowCount != data.length) {
      throw Exception('Row has incorrect number of values.');
    }
    if (_rowCount == 0) {
      _rowCount = data.length;
    }
    _data.add(data);
  }

  void addAll(List<List<dynamic>> data) {
    data.forEach((e) => add(e));
  }

  void remove(int index) {
    if (index > _data.length - 1) {
      throw Exception('Can\'t delete row at index $index');
    }
    _data.removeAt(index);
  }

  void clear() {
    _data.clear();
  }

  void addHeader(List<dynamic> header) {
    if (_rowCount != 0 && _rowCount != header.length) {
      throw Exception('Row has incorrect number of values.');
    }
    if (_rowCount == 0) {
      _rowCount = header.length;
    }
    header.forEach((e) => _header.add(e));
  }

  void removeHeader() {
    _header.clear();
  }

  List<int> _getSize(String s) {
    var lines = s.split('\n');
    var height = lines.length;
    var width = lines.map((e) => e.length).reduce(max);
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
    switch (align) {
      case TableTextAlign.left:
        return text.padRight(width);
      case TableTextAlign.right:
        return text.padLeft(width);
      case TableTextAlign.center:
        final len = text.length;
        final pad = (width - len) ~/ 2;
        return text.padLeft(pad + len).padRight(width);
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

class TablerStyle {
  final String verticalChar;
  final String horizontalChar;
  final String junctionChar;
  final int padding;
  final TableTextAlign align;

  const TablerStyle({
    this.verticalChar = '|',
    this.horizontalChar = '-',
    this.junctionChar = '+',
    this.padding = 1,
    this.align = TableTextAlign.left,
  });
}
