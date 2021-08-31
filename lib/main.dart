import 'package:flutter/material.dart';
import 'package:hing/theme/theme.dart';

void main() {
  runApp(HingApp());
}

class HingApp extends StatefulWidget {
  const HingApp({Key? key}) : super(key: key);

  @override
  _HingAppState createState() => _HingAppState();
}

class _HingAppState extends State<HingApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: HingTheme.getHingThemeData(ThemeData.light()),
    );
  }
}
