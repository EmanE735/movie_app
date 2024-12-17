import 'package:flutter/material.dart';
import 'package:movie_app/home_screen.dart';
import 'package:movie_app/providers/watchlist_provider.dart';
 import 'package:provider/provider.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
    ChangeNotifierProvider(
      create: (_) => WatchlistProvider(),
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
       routes: {HomeScreen.routeName: (_) => HomeScreen()},
       initialRoute: HomeScreen.routeName,
          ),
    );
  }
}
