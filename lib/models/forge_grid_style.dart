import 'package:forge_grid/helpers/enums.dart';

class ForgeGridStyle {
  /// Size of the grid. Default: [contain]
  ///
  /// [contain] will resize the grid to take less space possible, with no horizontal scrolling.
  /// Best suited for grids with no more than 3 columns.
  ///
  /// [expand] will let the grid take all the space it needs, eventually with horizontal scrolling.
  /// Best suited for grid with more then 3 columns.
  ForgeGridSize size;

  /// If column titles (header) will wrap when space ends. Default: [noWrap]
  ForgeGridTextWrap headerWrap;

  /// If text inside rows will wrap when space ends. Default: [wrap].
  ForgeGridTextWrap textWrap;

  /// Adds a padding to the last row. If used to accomodate for a [FloatingActionButton], 72 is the suggested size.
  double bottomPadding;

  ForgeGridStyle({
    this.size = ForgeGridSize.contain,
    this.headerWrap = ForgeGridTextWrap.noWrap,
    this.textWrap = ForgeGridTextWrap.wrap,
    this.bottomPadding = 0,
  });
}
