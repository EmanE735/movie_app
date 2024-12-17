import 'package:flutter/material.dart';
import 'package:movie_app/providers/watchlist_provider.dart';

import 'package:movie_app/tabs/movie_card_for_watchList.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    final watchlist = watchlistProvider.watchlist;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: GridView.builder(
        itemCount: watchlistProvider.watchlist.length,
        itemBuilder: (context, index) {
          final movieIndex =watchlistProvider.watchlist[index];
          return MovieCard(
            movie: movieIndex,
            onRemove: () {
              watchlistProvider.removeFromWatchlist(movieIndex);
              setState(() {});
              
            },
          );
        }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.999,
                ),
      ),
    );
  }
}
