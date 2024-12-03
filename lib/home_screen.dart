import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/service.dart';
import 'package:movie_app/tabs/browse.dart';
import 'package:movie_app/tabs/home.dart';
import 'package:movie_app/tabs/search.dart';
import 'package:movie_app/tabs/watch_list.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> tabs = [HomeTab(), SearchTab(), BrowseTab(), WatchList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      backgroundColor: AppTheme.black1,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.white1,
          backgroundColor: AppTheme.black2,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "BROWSE"),
            BottomNavigationBarItem(
                icon: Icon(Icons.collections_bookmark), label: "WATCHLIST"),
          ]),
    );
  }
}
