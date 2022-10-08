import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Color> colors = {
    'purple': Colors.purple,
    'blue': Colors.blue,
    'yellow': Colors.yellow,
    'pink': Colors.pink,
    'teal': Colors.teal,
    'orange': Colors.orange,
    'red': Colors.red,
    'green': Colors.green
  };

  final Map<String, Text> text = {
    'purple': const Text(
      'purple',
      style: TextStyle(backgroundColor: Colors.purple),
    ),
    'blue': const Text(
      'blue',  style: TextStyle(backgroundColor: Colors.blue)
    ),
    'yellow': const Text(
      'yellow',
        style: TextStyle(backgroundColor: Colors.yellow)
    ),
    'pink': const Text(
      'pink',
        style: TextStyle(backgroundColor: Colors.pink)
    ),
    'teal': const Text(
      'teal',
        style: TextStyle(backgroundColor: Colors.teal)
    ),
    'orange': const Text(
      'orange',
        style: TextStyle(backgroundColor: Colors.orange)
    ),
    'red': const Text(
      'red',
        style: TextStyle(backgroundColor: Colors.red)
    ),
    'green': const Text(
      'green',
        style: TextStyle(backgroundColor: Colors.green)
    )
  };

  Color? selectedColor;
  Text? selectedText;

  @override
  void initState() {
    _getStoredColor();
    _getStoredText();

    super.initState();
  }

  void _getStoredColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? colorName = prefs.getString('key');
    setState(() {
      selectedColor = colors[colorName];
    });
  }

  void _getStoredText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? textName = prefs.getString('key');
    setState(() {
      selectedText = text[textName];
    });
  }

  void _setColor(
    String colorName,
    Color color,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('color', colorName);
    setState(() {
      selectedColor = color;
    });
  }

  // ignore: unused_element
  void _setText(
    String textName,
    Text text,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('text', textName);
    setState(() {
      selectedText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: selectedText ?? const Text('Color Picker'),
        backgroundColor: selectedColor ?? Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'You are operating on ${kIsWeb ? "the web" : Platform.operatingSystem}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            // for (var entry in text.entries)
              for (var entry in colors.entries)
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(30.0)),
                      backgroundColor: entry.value,
                      minimumSize: const Size(300, 60),
                    ),
                    onPressed: () {
                      _setColor(entry.key, entry.value);
                    },
                    child: const Text(''),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
