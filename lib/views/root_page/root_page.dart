import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:techjar_task/utils/app_colors.dart';
import 'package:techjar_task/views/album_page/album_page.dart';
import 'package:techjar_task/views/post_page/post_page.dart';
import 'package:techjar_task/views/todo_page/todo_page.dart';
import 'package:techjar_task/views/user_page/user_page.dart';

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
    const AlbumPage(),
    const UserPage()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.black,
            )
          ],
        ),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 32.sp,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.primaryColor,
          tabBorderRadius: 14.r,
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
      body: IndexedStack(
        index: _selectedIndex,
        children: _pagesList,
      ),
    );
  }
}
