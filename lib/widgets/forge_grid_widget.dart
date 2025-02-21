import 'package:flutter/material.dart';
import 'package:forge_grid/models/forge_column.dart';
import 'package:forge_grid/models/forge_row.dart';
import 'package:forge_grid/utils/enums.dart';

class ForgeGrid extends StatefulWidget {
  const ForgeGrid({
    super.key,
    required this.columns,
    required this.rows,
  });

  final List<ForgeColumn> columns;
  final List<ForgeRow> rows;

  @override
  State<ForgeGrid> createState() => _ForgeGridState();
}

class _ForgeGridState extends State<ForgeGrid> {
  late List<int> _columnWeights;
  late List<ForgeSortState> _sortState;
  int _numberOfColumns = 0;

  @override
  void initState() {
    super.initState();
    _buildColumnWeights();
    _numberOfColumns = widget.columns.length;

    _initSortState();
  }

  void _initSortState() {
    _sortState = [];
    for (int i = 0; i < _numberOfColumns; i++) {
      _sortState.add(ForgeSortState.notSorted);
    }
  }

  void _buildColumnWeights() {
    _columnWeights = [];
    for (var column in widget.columns) {
      _columnWeights.add(column.size);
    }
  }

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
        int totalWeight = _columnWeights.reduce((a, b) => a + b);
        double unitWidth = constraints.maxWidth / totalWeight;

        return Column(
          children: [
            _buildHeader(unitWidth: unitWidth),
            widget.rows.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: _sortRows().map((row) => _buildRow(row, unitWidth: unitWidth)).toList(),
                      ),
                    ),
                  )
                : _buildEmptyTable(),
          ],
        );
      },
    );
  }

  Widget _buildHeader({required double unitWidth}) {
    return Material(
      color: Colors.transparent,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(widget.columns.length, (index) {
            double columnWidth = unitWidth * _columnWeights[index];
            return SizedBox(
              width: columnWidth,
              child: _buildCell(widget.columns[index].title, true, index, textAlign: widget.columns[index].align),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRow(ForgeRow row, {required double unitWidth}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withOpacity(0.2), // Customize ripple color
        highlightColor: Colors.blue.withOpacity(0.1),
        onTap: row.onTap == null
            ? null
            : () async {
                await row.onTap!();
                // setState(() {
                //   _sortRows();
                //   print('Sorted rows: ${_sortedRows[0].cells[1].data}');
                // });
              },
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(widget.columns.length, (index) {
              double columnWidth = unitWidth * _columnWeights[index];
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

  Widget _buildCell(String text, bool isHeader, int columnIndex, {TextAlign textAlign = TextAlign.left}) {
    return Ink(
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: Colors.grey.shade300)),
        color: isHeader ? Colors.blueGrey.shade100 : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isHeader
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      softWrap: true,
                      textAlign: textAlign,
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
              )
            : Text(
                text,
                softWrap: true,
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
