import 'package:flutter/material.dart';
import 'package:link_bridge/link_bridge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LinkBridge'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                LinkBridge().init().then((link) {
                  debugPrint(link.toString());
                });
              },
              child: Text(
                'Get Initial Link',
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                LinkBridge().listen((link) {
                  debugPrint(link.toString());
                });
              },
              child: Text(
                'Start Listen Link',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
