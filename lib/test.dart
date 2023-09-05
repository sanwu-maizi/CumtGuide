import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String markdownText = '''
# Welcome to My Flutter Markdown App!

This is an example of how you can use the `flutter_markdown` library to render Markdown content in your Flutter app.

## Features:

- Display **bold** and *italic* text
- Create bullet point lists
- Add [links](https://flutter.dev/) to external websites
- Include images:
![Flutter Logo](https://flutter.dev/assets/flutter-lockup-4cb0ee072ab35f47ae7aaf1a081fb307d734bab71a06862a934b36d6709be1e6.svg)

Let's get started!
''';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Markdown Example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Markdown(data: markdownText),
          ),
        ),
      ),
    );
  }
}
