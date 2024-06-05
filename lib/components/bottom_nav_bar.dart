import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedItem;
  final Function(int) onTap;
  const BottomNavBar({super.key, required this.selectedItem, required this.onTap});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w*.015, vertical: h*.01),
          child: GNav(
            gap: 10,
            tabBorderRadius: 100,
            backgroundColor: Colors.grey[100]!,
            activeColor: Colors.white,
            color: const Color(0xff3D3D3D),
            tabBackgroundGradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 253, 134, 134),
                Colors.redAccent
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight
            ),
            iconSize: 30,
            textSize: 18,
            padding: EdgeInsets.symmetric(horizontal: w*.07, vertical: h*.01),
            tabs: const[
              GButton(icon: CupertinoIcons.home, text: 'Home',),
              GButton(icon: Icons.category, text: 'Categories',),
              GButton(icon: CupertinoIcons.heart_fill, text: 'Saved',),
            ],
            onTabChange: widget.onTap,
            selectedIndex: 0,
          ),
        ),
    );
  }
}