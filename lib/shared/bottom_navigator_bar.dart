import 'package:flutter/material.dart';

import 'package:ec_validator/pages/index.dart';

class CustomBottomNavigatorBar extends StatefulWidget {

  const CustomBottomNavigatorBar ({super.key});

  @override
  State<CustomBottomNavigatorBar> createState() => _CustomBottomNavigatorBarState();
}

class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> {
  int _selectedIndex = 0;
  
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  static final List<Widget> _widgetOptions = <Widget>[
    DniValidatorPage(),
    const Text('Index 1: Ruc', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.assignment_ind_rounded), label: 'DNI'),
            BottomNavigationBarItem(icon: Icon(Icons.business), label: 'RUC'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      );
  }
}