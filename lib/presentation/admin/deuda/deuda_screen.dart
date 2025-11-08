import 'package:cuenta/presentation/admin/deuda/consult_screen.dart';
import 'package:cuenta/presentation/admin/deuda/form_screen.dart';
import 'package:flutter/material.dart';

class DeudaScreen extends StatefulWidget {
  const DeudaScreen({super.key});

  @override
  State<DeudaScreen> createState() => _DeudaScreenState();
}

class _DeudaScreenState extends State<DeudaScreen> {
  int index = 0;
  final List<Widget> _screens = [FormScreen(), ConsultScreen()];

  void _onItemTapped(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[index],

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Agregar'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Consultar'),
          ],
          currentIndex: index,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
