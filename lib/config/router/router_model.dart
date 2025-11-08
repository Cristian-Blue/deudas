import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterModel {
  String name;
  GoRouterWidgetBuilder screen;
  String title;
  String patch;
  IconData icon;
  String description;
  bool inDrawer;

  RouterModel({
    required this.name,
    required this.screen,
    required this.title,
    required this.patch,
    required this.icon,
    required this.description,
    this.inDrawer = true,
  });
}
