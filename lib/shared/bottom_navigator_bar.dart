import 'package:flutter/material.dart';

import 'package:ec_validator/pages/index.dart';

class CustomBottomNavigatorBar extends StatefulWidget {

  const CustomBottomNavigatorBar ({super.key});

  @override
  State<CustomBottomNavigatorBar> createState() => _CustomBottomNavigatorBarState();
}

class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> {
  int _selectedIndex = 0;
  
  static final List<Widget> _widgetOptions = <Widget>[
    DniValidatorPage(),
    RucValidatorPage(),
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
          selectedItemColor: Colors.purpleAccent,
          onTap: _onItemTapped,
        ),
      );
  }
}