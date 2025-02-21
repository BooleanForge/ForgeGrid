import 'package:flutter/material.dart';
import 'package:forge_grid/forge_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<ForgeColumn> _buildColumns() {
    return [
      ForgeColumn(
        title: 'Id',
        size: 30,
        sortable: true,
        align: TextAlign.right,
      ),
      ForgeColumn(
        title: 'User',
        size: 20,
        align: TextAlign.right,
      ),
      ForgeColumn(
        title: 'Location',
        size: 50,
        sortable: true,
      ),
    ];
  }

  List<ForgeRow> _buildRows(BuildContext context) {
    List<ExampleData> values = [
      ExampleData(id: '1', name: 'Mario Rossi', location: 'Rome'),
      ExampleData(id: '2', name: 'James Bolton', location: 'Manchester'),
      ExampleData(id: '3', name: 'Louise S. Frederiksen', location: 'Læsø'),
      ExampleData(id: '4', name: 'Anka Ostrowska', location: 'Warszawa'),
      ExampleData(id: '5', name: 'Maik Peters', location: 'Birkenfeld'),
    ];

    return values
        .map(
          (d) => ForgeRow(
            cells: [
              ForgeCell(data: d.id),
              ForgeCell(data: d.name),
              ForgeCell(data: d.location),
            ],
            onTap: () {
              _showSnackBar(context, d);
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ForgeGrid')),
        body: ForgeGrid(
          columns: _buildColumns(),
          rows: _buildRows(context),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, ExampleData data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on user ${data.name}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class ExampleData {
  String id;
  String name;
  String location;

  ExampleData({
    required this.id,
    required this.name,
    required this.location,
  });
}
