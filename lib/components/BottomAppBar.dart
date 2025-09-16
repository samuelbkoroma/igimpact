import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:igniteimpact/screens/HomePage.dart';
import 'package:igniteimpact/screens/Internships.dart';
import 'package:igniteimpact/screens/SavedJob.dart';
import 'package:igniteimpact/screens/settings.dart';
import 'package:igniteimpact/theme/colors.dart';

class BottomAppbar extends StatefulWidget {
  const BottomAppbar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomAppbarState createState() => _BottomAppbarState();
}

class _BottomAppbarState extends State<BottomAppbar> {
  int _selectedIndex = 0;

  final List<TabItem> _items = [
    TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    TabItem(
      icon: Icons.work,
      title: 'Internships',
    ),
    TabItem(
      icon: Icons.bookmark,
      title: 'Saved',
    ),
    TabItem(
      icon: Icons.person,
      title: 'Profile',
    ),
  ];

  final List<Widget> _pages = [
    Homepage(),
    Internships(),
    SavedJob(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomBarFloating(
        items: _items,
        backgroundColor: Colors.white,
        color: Colors.grey,
        colorSelected: mainBlue,
        indexSelected: _selectedIndex,
        paddingVertical: 10,
        onTap: _onItemTapped,
      ),
    );
  }
}
