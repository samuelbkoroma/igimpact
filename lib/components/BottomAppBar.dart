import 'package:flutter/material.dart';
import 'package:igniteimpact/screens/Entrepreneurship.dart';
import 'package:igniteimpact/screens/HomePage.dart';
import 'package:igniteimpact/screens/Internships.dart';
import 'package:igniteimpact/screens/SavedJob.dart';
import 'package:igniteimpact/screens/settings.dart';
import 'package:igniteimpact/theme/colors.dart';

class BottomAppbar extends StatefulWidget {
  const BottomAppbar({super.key});

  @override
  State<BottomAppbar> createState() => _BottomAppbarState();
}

class _BottomAppbarState extends State<BottomAppbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Homepage(),
    const Internships(),
    const Entrepreneurship(),
    const SavedJob(),
    const Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home,
              label: 'Home',
              index: 0,
              isSelected: _selectedIndex == 0,
            ),
            _buildNavItem(
              icon: Icons.star,
              label: 'Star',
              index: 1,
              isSelected: _selectedIndex == 1,
            ),
            // Center floating button
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(32.5),
                  onTap: () => _onItemTapped(2),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedIndex == 2
                          ? mainBlue.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: _selectedIndex == 2 ? mainBlue : Colors.red,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            _buildNavItem(
              icon: Icons.style,
              label: 'Style',
              index: 3,
              isSelected: _selectedIndex == 3,
            ),
            _buildNavItem(
              icon: Icons.person,
              label: 'Profile',
              index: 4,
              isSelected: _selectedIndex == 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onItemTapped(index),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? mainBlue : Colors.grey,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? mainBlue : Colors.grey,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
