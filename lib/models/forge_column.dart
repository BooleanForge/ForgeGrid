import 'package:flutter/material.dart';

/// Creates a column
class ForgeColumn {
  /// Title the will be shown on the header of the column
  String title;

  /// The weight of the column.<br>Three columns with a weight of 1,3,4
  /// means that the first column will occupy 1/8 of the available horizontal space,
  /// the second will occupy 3/8 of the space and the last 4/8 of the space
  int size;

  /// If the column can be sorted or not
  bool sortable;

  /// Style of the header text
  TextStyle textStyle;

  /// Color of the header background
  Color backgroundColor;

  /// Text alignment of the entire column (rows included)
  TextAlign align;

  ForgeColumn({
    required this.title,
    this.size = 1,
    this.sortable = false,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.backgroundColor = Colors.white,
    this.align = TextAlign.left,
  });
}
