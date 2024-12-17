import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:provider/provider.dart';
import '../providers/watchlist_provider.dart';
class buildMovieItem extends StatelessWidget {

  final Movie movie;
  const buildMovieItem({super.key,required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          width: 70,
          height: 100,
          fit: BoxFit.cover,
        ),
        title: Text(movie.title),
        subtitle: Text(
          movie.overview,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            context.read<WatchlistProvider>().removeFromWatchlist(movie);
          },
        ),
      ),
    );
  }
}
