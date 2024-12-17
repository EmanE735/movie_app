import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model.dart';

class WatchlistProvider extends ChangeNotifier {
  List<Movie> _watchlist = [];

  List<Movie> get watchlist => _watchlist;

  WatchlistProvider() {
    _loadWatchlist();
  }

  _loadWatchlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? watchlistString = prefs.getString('watchlist');
    if (watchlistString != null) {
      List<dynamic> watchlistJson = json.decode(watchlistString);
      _watchlist = watchlistJson.map((item) => Movie.fromJson(item)).toList();
      notifyListeners();
    }
  }

  _saveWatchlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String watchlistString = json.encode(_watchlist);
    prefs.setString('watchlist', watchlistString);
  }

  addToWatchlist(Movie movie) {
     if (!_watchlist.any((existingMovie) => existingMovie.id == movie.id)) {
    _watchlist.add(movie);
    _saveWatchlist();
    notifyListeners();
     }else{
     print('this movie is already added');
     }
  }

  Future<void> removeFromWatchlist(Movie movie) async {
    _watchlist.removeWhere((item) => item.id == movie.id);
    final prefs = await SharedPreferences.getInstance();
    final movieIds = _watchlist.map((movie) => movie.id.toString()).toList();
    await prefs.setStringList('watchlist', movieIds);
    notifyListeners();
}
}