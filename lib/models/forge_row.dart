import 'package:forge_grid/models/forge_cell.dart';

/// A single row of the datagrid
class ForgeRow {
  /// The cells inside the row. Order of the cells must be the same of the declared columns
  List<ForgeCell> cells;

  /// Action called when the entire row is tapped
  Function? onTap;

  ForgeRow({
    required this.cells,
    this.onTap,
  });
}
