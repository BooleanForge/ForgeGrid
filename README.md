# Forge Grid

**Forge Grid** is a Flutter datagrid made for mobile for displaying structured data in a dynamic grid with columns and rows.  
Ideal for dashboards, reports, and any scenario requiring an interactive table.

## Features

✔️ Dynamic columns and rows  
✔️ Smooth horizontal scrolling  
✔️ Customizable colors and styles  
✔️ Support for events at row level  

## Installation

Add `forge_grid` to your `pubspec.yaml`:

```yaml
dependencies:
  forge_grid: ^0.0.1
```

Then run:

```sh
flutter pub get
```

## Basic Usage

Basic usage is quite simple!

Create a list of `ForgeColumn(s)`, giving a `title` to every column.

```dart
List<ForgeColumn> myColumns = [
  ForgeColumn(title: 'Id'),
  ForgeColumn(title: 'Name'),
  ForgeColumn(title: 'Location'),
]
```

Create a list of `ForgeRow(s)`, where every row has as many `ForgeCells` as the number of columns. The order of the cells should be kept the same as the columns.

```dart
List<ForgeRow> myRows = [
  ForgeRow(
    cells: [
      ForgeCell(data: '1'),
      ForgeCell(data: 'Mario Rossi'),
      ForgeCell(data: 'Milan'),
    ]
  ),
  ForgeRow(
    cells: [
      ForgeCell(data: '2'),
      ForgeCell(data: 'Luca Bianchi'),
      ForgeCell(data: 'Florence'),
    ]
  )
  ForgeRow(
    cells: [
      ForgeCell(data: '3'),
      ForgeCell(data: 'Lucia Verdi'),
      ForgeCell(data: 'Rome'),
    ]
  )
]
```

Then, add a ForgeGrid widget with the defined columns and rows:

```dart
ForgeGrid(
  columns: myColumns,
  rows: myRows,
);
```

## Advanced Usage

### Grid Styling

Grid can be styled and customized with a `ForgeGridStyle` object.

#### ForgeGridStyle.size

Default: `ForgeGridSize.contain`.

`ForgeGridSize.contain` will resize the grid to take less space possible, with no horizontal scrolling.
Best suited for grids with no more than 3 columns.

`ForgeGridSize.expand` will let the grid take all the space it needs, eventually with horizontal scrolling.
Best suited for grid with more then 3 columns.

#### ForgeGridStyle.headerWrap

Default: `ForgeGridTextWrap.noWrap`

If the header text will wrap or not, when column has no more space.

#### ForgeGridStyle.wrap

Default: `ForgeGridTextWrap.wrap`

If the text inside the rows will wrap or not, when column has no more space.

### Columns Styling

#### ForgeColumn.size

Default: `1`

The property will behave differently based on the `size` property of the grid.

- `ForgeGridStyle.contain`: the column will use `size` as a percentage of the available space. For example, if three columns have size of 1, 5 and 2, the first column will use 1/8 of the available space, the second will use 5/8 of the available space and the last one 2/8 of the available space.
- `ForgeGridStyle.expand`: the column will use `size` as logical pixels, eventually using horizontal scrolling.

#### ForgeColumn.sortable

Default: `false`

#### ForgeColumn.textStyle

Default: `TextStyle(fontWeight: FontWeight.bold)`

#### ForgeColumn.backgroundColor

Default: `Colors.white`

#### ForgeColumn.align

Default: `TextAlign.left`

### Row Action

Rows have a `Function? onTap` that can be used to fire actions when the row is tapped.

## TODO List

- [ ] Grid styling (Work in progress)
- [ ] Row styling
- [ ] Pagination
- [ ] Search
- [x] Sorting
- [ ] Filtering
- [ ] Complex headers
- [x] Horizontal scroll
- [ ] Lazy loading
- [ ] Cell editing
- [x] Row tap
- [ ] Row grouping
- [ ] Export csv/pdf

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.
