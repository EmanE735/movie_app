/* -------------------------------------------------------------------------- */
/*                         Import Required Packages                            */
/* -------------------------------------------------------------------------- */
import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/firebase_service.dart';
import 'package:movie_app/tabs/movie_details_screen.dart';
import 'package:movie_app/widgets/watchlist_button.dart';

/* -------------------------------------------------------------------------- */
/*                         Watchlist Main Widget                              */
/* -------------------------------------------------------------------------- */
class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

/* -------------------------------------------------------------------------- */
/*                         Watchlist State                                    */
/* -------------------------------------------------------------------------- */
class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black2,
      /* -------------------------------------------------------------------------- */
      /*                         AppBar Section                                     */
      /* -------------------------------------------------------------------------- */
      appBar: AppBar(
        backgroundColor: AppTheme.black1,
        title: const Text(
          'My Watchlist',
          style: TextStyle(color: AppTheme.white2),
        ),
      ),
      /* -------------------------------------------------------------------------- */
      /*                         Watchlist Content                                  */
      /* -------------------------------------------------------------------------- */
      body: StreamBuilder<List<Movie>>(
        stream: FirebaseService().getWatchlistMovies(),
        builder: (context, snapshot) {
          /* -------------------------------------------------------------------------- */
          /*                         Loading and Error States                          */
          /* -------------------------------------------------------------------------- */
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final movies = snapshot.data ?? [];

          if (movies.isEmpty) {
            return const Center(
              child: Text(
                'Your watchlist is empty',
                style: TextStyle(color: AppTheme.white2),
              ),
            );
          }

          /* -------------------------------------------------------------------------- */
          /*                         Movies Grid View                                  */
          /* -------------------------------------------------------------------------- */
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return _buildMovieCard(context, movie);
            },
          );
        },
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                         Movie Card Builder                                 */
  /* -------------------------------------------------------------------------- */
  Widget _buildMovieCard(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(
              movie: movie,
              categoryId: movie.genreIds.isNotEmpty ? movie.genreIds[0] : 28,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          /* -------------------------------------------------------------------------- */
          /*                         Movie Card Content                                */
          /* -------------------------------------------------------------------------- */
          Card(
            color: AppTheme.black1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* -------------------------------------------------------------------------- */
                /*                         Movie Poster                                      */
                /* -------------------------------------------------------------------------- */
                Expanded(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                /* -------------------------------------------------------------------------- */
                /*                         Movie Details                                    */
                /* -------------------------------------------------------------------------- */
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: AppTheme.white2,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      /* -------------------------------------------------------------------------- */
                      /*                         Rating Section                                    */
                      /* -------------------------------------------------------------------------- */
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(
                            '${movie.voteAverage.toStringAsFixed(1)}/10',
                            style: const TextStyle(color: AppTheme.white2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          /* -------------------------------------------------------------------------- */
          /*                         Watchlist Button                                  */
          /* -------------------------------------------------------------------------- */
          Positioned(
            top: 8,
            left: 8,
            child: WatchlistButton(movie: movie),
          ),
        ],
      ),
    );
  }
}
