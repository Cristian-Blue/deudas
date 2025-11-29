import 'package:cuenta/presentation/admin/layout/drawer_widget.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Administrador')),
      drawer: DrawerWidget(),
      body: child,
    );
  }
}
