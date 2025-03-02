import 'package:flutter/material.dart';
import 'package:forge_grid/models/forge_column.dart';
import 'package:forge_grid/models/forge_grid_style.dart';
import 'package:forge_grid/models/forge_row.dart';
import 'package:forge_grid/helpers/enums.dart';

/// The grid itself. Requires a list of columns, and a list of rows where every rows has as many cells as the columns.
class ForgeGrid extends StatefulWidget {
  /// The list of [columns] that will be shown in the datagrid
  final List<ForgeColumn> columns;

  /// The list of [rows] that will be shown in the datagrid
  ///
  /// Every row must contain [cells] in the same number as columns
  final List<ForgeRow> rows;

  /// Additional styling for the datagrid
  final ForgeGridStyle? gridStyle;

  const ForgeGrid({
    super.key,
    required this.columns,
    required this.rows,
    this.gridStyle,
  });

  @override
  State<ForgeGrid> createState() => _ForgeGridState();
}

class _ForgeGridState extends State<ForgeGrid> {
  late List<int> _columnWidths;
  late List<ForgeSortState> _sortState;
  late final ForgeGridStyle _gridStyle;
  int _numberOfColumns = 0;

  @override
  void initState() {
    super.initState();
    _initGridStyle();
    _initColumnWeights();

    _numberOfColumns = widget.columns.length;

    _initSortState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Inits the [GridStyle], using a default one if none are provided
  void _initGridStyle() {
    _gridStyle = widget.gridStyle ?? ForgeGridStyle();
  }

  /// Inits the [sort state] of the grid.
  ///
  /// Every column is marked as [not sorted].
  void _initSortState() {
    _sortState = [];
    for (int i = 0; i < _numberOfColumns; i++) {
      _sortState.add(ForgeSortState.notSorted);
    }
  }

  /// Inits the [columns weights].
  ///
  /// These are used to determine column width, but for [expanded] and [contained] grid.
  void _initColumnWeights() {
    _columnWidths = [];
    for (var column in widget.columns) {
      _columnWidths.add(column.size);
    }
  }

  /// Sorts all rows based on the selected column and the sorting method (not sorted, ascending, descending).
  List<ForgeRow> _sortRows() {
    List<ForgeRow> sortedRows = [];
    int columnIndex = _sortState.indexWhere((state) => state != ForgeSortState.notSorted);
    if (columnIndex == -1) columnIndex = 0;
    switch (_sortState[columnIndex]) {
      case ForgeSortState.notSorted:
        sortedRows.clear();
        sortedRows.addAll(widget.rows);
        break;
      case ForgeSortState.ascending:
        sortedRows.clear();
        sortedRows.addAll(widget.rows);
        sortedRows.sort((a, b) => a.cells[columnIndex].data.compareTo(b.cells[columnIndex].data));
        break;
      case ForgeSortState.descending:
        sortedRows.clear();
        sortedRows.addAll(widget.rows);
        sortedRows.sort((a, b) => b.cells[columnIndex].data.compareTo(a.cells[columnIndex].data));
        break;
    }
    return sortedRows;
  }

  /// Modifies visually the sort state of the column
  void _toggleSortState(int columnIndex) {
    for (int i = 0; i < _numberOfColumns; i++) {
      if (columnIndex == i) {
        if (_sortState[columnIndex] == ForgeSortState.notSorted) {
          setState(() => _sortState[columnIndex] = ForgeSortState.ascending);
        } else if (_sortState[columnIndex] == ForgeSortState.ascending) {
          setState(() => _sortState[columnIndex] = ForgeSortState.descending);
        } else {
          setState(() => _sortState[columnIndex] = ForgeSortState.notSorted);
        }
      } else {
        setState(() => _sortState[i] = ForgeSortState.notSorted);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_gridStyle.size == ForgeGridSize.contain) {
          int totalWeight = _columnWidths.reduce((a, b) => a + b);
          double unitWidth = constraints.maxWidth / totalWeight;

          return Column(
            children: [
              _buildHeader(unitWidth: unitWidth),
              _buildTable(unitWidth),
            ],
          );
        } else {
          double unitWidth = 1;

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  _buildHeader(unitWidth: unitWidth),
                  _buildTable(unitWidth),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildHeader({required double unitWidth}) {
    return Material(
      color: Colors.transparent,
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(widget.columns.length, (index) {
            double columnWidth = unitWidth * _columnWidths[index];
            return SizedBox(
              width: columnWidth,
              child: _buildHeaderCell(widget.columns[index], index),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTable(double unitWidth) {
    return widget.rows.isNotEmpty
        ? Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: _sortRows().map((row) => _buildRow(row, unitWidth: unitWidth)).toList(),
              ),
            ),
          )
        : _buildEmptyTable();
  }

  Widget _buildRow(ForgeRow row, {required double unitWidth}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha((0.2 * 255).toInt()),
        highlightColor: Colors.blue.withAlpha((0.1 * 255).toInt()),
        onTap: row.onTap == null
            ? null
            : () async {
                await row.onTap!();
              },
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(widget.columns.length, (index) {
              double columnWidth = unitWidth * _columnWidths[index];
              return SizedBox(
                width: columnWidth,
                child: _buildCell(row.cells[index].data, false, index, textAlign: widget.columns[index].align),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(ForgeColumn column, int columnIndex) {
    return Ink(
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: Colors.grey.shade300)),
        color: column.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                column.title,
                style: column.textStyle,
                softWrap: _gridStyle.headerWrap == ForgeGridTextWrap.wrap,
                overflow: _gridStyle.headerWrap == ForgeGridTextWrap.wrap ? null : TextOverflow.ellipsis,
                textAlign: column.align,
              ),
            ),
            Visibility(
              visible: widget.columns[columnIndex].sortable,
              child: const SizedBox(width: 4),
            ),
            Visibility(
              visible: widget.columns[columnIndex].sortable,
              child: GestureDetector(
                onTap: () {
                  _toggleSortState(columnIndex);
                  _sortRows();
                },
                child: Icon(
                  _sortState[columnIndex] == ForgeSortState.notSorted
                      ? Icons.sort
                      : _sortState[columnIndex] == ForgeSortState.ascending
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String text, bool isHeader, int columnIndex, {TextAlign textAlign = TextAlign.left}) {
    return Ink(
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: Colors.grey.shade300)),
        color: isHeader ? Colors.blueGrey.shade100 : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          softWrap: _gridStyle.textWrap == ForgeGridTextWrap.wrap,
          overflow: _gridStyle.textWrap == ForgeGridTextWrap.wrap ? null : TextOverflow.ellipsis,
          textAlign: textAlign,
        ),
      ),
    );
  }

  Widget _buildEmptyTable() {
    return const Expanded(
      child: Center(
        child: Text('No results to show.'),
      ),
    );
  }
}
