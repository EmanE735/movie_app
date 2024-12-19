import 'package:movie_app/main.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';

import 'package:movie_app/tabs/browse.dart';
import 'package:movie_app/tabs/home.dart';
import 'package:movie_app/tabs/search.dart';
import 'package:movie_app/tabs/watch_list.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.black2,
      selectedItemColor: AppTheme.primary,
      unselectedItemColor: AppTheme.white1,
      currentIndex: _HomeScreenState.currentIndex,
      onTap: (index) {
        _HomeScreenState.currentIndex = index;
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.browse_gallery),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Watchlist',
        ),
      ],
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  static int currentIndex = 0;
  final List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    const BrowseTab(),
    const WatchList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      body: tabs[currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  static Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.black2,
      selectedItemColor: AppTheme.primary,
      unselectedItemColor: AppTheme.white1,
      currentIndex: currentIndex,
      onTap: (index) {
        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        currentIndex = index;
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.browse_gallery),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Watchlist',
        ),
      ],
    );
  }
}
