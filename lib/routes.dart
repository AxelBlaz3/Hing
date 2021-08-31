import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      default:
        throw Exception(
            'Unknown route ${settings.name}. Make sure to add the route to RouteGenerator before navigating.');
    }
  }
}
