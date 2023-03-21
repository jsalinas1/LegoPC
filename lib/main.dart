import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("PC Builder"),
        ),
        body: PCBuilder(), // Test
      ),
    );
  }
}

class PCBuilder extends StatefulWidget {
  @override
  _PCBuilderState createState() => _PCBuilderState();
}

class _PCBuilderState extends State<PCBuilder> {
  List<String> _components = [    "CPU",    "GPU",    "Motherboard",    "RAM",    "Storage",    "Case",    "Power Supply",  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _components.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_components[index]),
        );
      },
    );
  }
}
