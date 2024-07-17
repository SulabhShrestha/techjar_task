import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:techjar_task/views/post_page/post_page.dart';
import 'package:techjar_task/views/todo_page/todo_page.dart';

/// Hosts all the pages along with bottom navigation bar
///

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});

  @override
  ConsumerState<RootPage> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {
  final List<Widget> _pagesList = [
    const PostPage(),
    const TodoPage(),
    const PostPage(),
    const PostPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Container(
                height: 48,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: GNav(
                    rippleColor: Colors.grey[300]!,
                    hoverColor: Colors.grey[100]!,
                    gap: 8,
                    activeColor: Colors.black,
                    iconSize: 32,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: Colors.blue.shade300,
                    tabBorderRadius: 14,
                    color: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    tabActiveBorder: Border.all(),
                    tabs: const [
                      GButton(
                        icon: Icons.home_outlined,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.task_outlined,
                        text: 'Todo',
                      ),
                      GButton(
                        icon: Icons.photo_outlined,
                        text: 'Album',
                      ),
                      GButton(
                        icon: Icons.account_circle_outlined,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: _pagesList.elementAt(_selectedIndex),
        ));
  }
}
