import 'package:flutter/material.dart';

import 'package:ec_validator/pages/index.dart';

class CustomBottomNavigatorBar extends StatefulWidget {

  const CustomBottomNavigatorBar ({super.key});

  @override
  State<CustomBottomNavigatorBar> createState() => _CustomBottomNavigatorBarState();
}

class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> {
  int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget>[
    DniValidatorPage(),
    RucValidatorPage(),
    PhoneValidatorPage(),
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
            BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Phone'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purpleAccent,
          onTap: _onItemTapped,
        ),
      );
  }
}