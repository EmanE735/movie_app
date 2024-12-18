import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/service.dart';
import 'package:movie_app/tabs/movie_details_screen.dart';
import 'package:movie_app/widgets/watchlist_button.dart';
//import 'package:movie_app/home_screen.dart';

/* -------------------------------------------------------------------------- */
/*                             Movie List Screen                              */
/* -------------------------------------------------------------------------- */

class MovieListScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const MovieListScreen({
    required this.categoryId,
    required this.categoryName,
    super.key,
  });

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<Movie>> moviesFuture;

  @override
  void initState() {
    super.initState();
    /* -------------------------------------------------------------------------- */
    /*                   Fetch Movies by Category on Init                        */
    /* -------------------------------------------------------------------------- */
    moviesFuture = APIservice().getMoviesByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      /* -------------------------------------------------------------------------- */
      /*                                  AppBar                                   */
      /* -------------------------------------------------------------------------- */
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: AppTheme.black1,
          title: Text(
            widget.categoryName,
            style: const TextStyle(color: AppTheme.white2),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: FutureBuilder<List<Movie>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          /* -------------------------------------------------------------------------- */
          /*                               Loading State                               */
          /* -------------------------------------------------------------------------- */
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          /* -------------------------------------------------------------------------- */
          /*                               Error State                                */
          /* -------------------------------------------------------------------------- */
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          /* -------------------------------------------------------------------------- */
          /*                               No Data State                              */
          /* -------------------------------------------------------------------------- */
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies available.'));
          }
          /* -------------------------------------------------------------------------- */
          /*                           Movies Data Loaded                              */
          /* -------------------------------------------------------------------------- */
          else {
            final movies = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.65,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      /* -------------------------------------------------------------------------- */
                      /*                           Navigate to Movie Details Screen                */
                      /* -------------------------------------------------------------------------- */
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                            movie: movie,
                            categoryId: widget.categoryId,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          /* -------------------------------------------------------------------------- */
                          /*                                Movie Poster                               */
                          /* -------------------------------------------------------------------------- */
                          Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned(
                            top: 0,
                            left: 1,
                            child: WatchlistButton(movie: movie),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
