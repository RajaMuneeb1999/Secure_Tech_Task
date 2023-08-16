import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_task/view/products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    ProductScreen(),
    ProductScreen(),
    ProductScreen(),
    ProductScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        unselectedItemColor: Colors.grey,
        // Unselected icon color
        selectedItemColor: Colors.blue,
        // Set the selected color here
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_line_spacing_rounded, color: Colors.grey),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.grey),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken, color: Colors.grey),
            label: 'Page 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color:_currentIndex==4 ?  Colors.red: Colors.grey),
            label: 'Page 4',
          ),

        ],
      ),
    );
  }
}
