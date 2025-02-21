import 'package:flutter/material.dart';

/// Creates a column
class ForgeColumn {
  /// Title the will be shown on the header of the column
  String title;

  /// The weight of the column.<br>Three columns with a weight of 1,3,4
  /// means that the first column will occupy 1/8 of the available horizontal space,
  /// the second will occupy 3/8 of the space and the last 4/8 of the space
  int size;

  /// If the column will be sortable or not
  bool sortable;

  /// Color of the header text
  Color color;

  /// Color of the header background
  Color backgroundColor;

  /// Text alignment of the entire column (rows included)
  TextAlign align;

  ForgeColumn({
    required this.title,
    this.size = 1,
    this.sortable = false,
    this.color = Colors.black,
    this.backgroundColor = Colors.grey,
    this.align = TextAlign.left,
  });
}
