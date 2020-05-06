import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Localhost for android - 10.0.2.2
  // Localhost for iOS - 127.0.0.1
  final IOWebSocketChannel channel =
      IOWebSocketChannel.connect('ws://127.0.0.1:8080');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('No connection');
            case ConnectionState.waiting:
              return Text('Connected');
            case ConnectionState.active:
              return Text('${snapshot.data}');
            case ConnectionState.done:
              return Text('${snapshot.data} (closed)');
          }
          return null; // unreachable
        },
      ),
    );
  }
}
