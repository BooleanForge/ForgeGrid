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

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:forge_grid/forge_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Forge Grid Example')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ForgeGrid(
            columns: [
              ForgeColumn(title: 'Id', size: 1),
              ForgeColumn(title: 'Name', size: 2),
              ForgeColumn(title: 'Location', size: 2),
            ],
            rows: [
              ForgeRow(
                cells: [
                  ForgeCell(data: '1'),
                  ForgeCell(data: 'Mario Rossi'),
                  ForgeCell(data: 'Milano'),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
```

## TODO & Future Enhancements

- [ ] Support for row selection
- [ ] Data filtering
- [ ] Style customization
- [ ] Horizontal scrolling
- [ ] Inline cell editing
- [ ] Export data (CSV, JSON)

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.
