enum ForgeGridSize {
  /// Grid will be as wide as the available space.
  /// Best suited for 3 columns or less.
  contain,

  /// Grid will be as wide as the space occupied by the columns.
  /// Best suited for 4 or more columns.
  expand,
}

enum ForgeGridTextWrap {
  /// Text will wrap inside header or row cell if not enough space is available.
  wrap,

  /// Text will receive ellipsis if not enough space is available inside header or row cell.
  noWrap,
}

enum ForgeSortState {
  notSorted,
  ascending,
  descending,
}
