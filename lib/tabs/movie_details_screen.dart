import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/movie_details.dart';

/* -------------------------------------------------------------------------- */
/*                            Movie Details Screen                            */
/* -------------------------------------------------------------------------- */

class MovieDetailsScreen extends StatelessWidget {
  final MovieDetails movie;

  const MovieDetailsScreen({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    /* -------------------------------------------------------------------------- */
    /*                                  Scaffold                                  */
    /* -------------------------------------------------------------------------- */
    return Scaffold(
      backgroundColor: AppTheme.black2,

      /* -------------------------------------------------------------------------- */
      /*                                   AppBar                                   */
      /* -------------------------------------------------------------------------- */
      appBar: AppBar(
        backgroundColor: AppTheme.black1,
        title: Text(
          movie.title,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            /* -------------------------------------------------------------------------- */
            /*                                Movie Poster                                */
            /* -------------------------------------------------------------------------- */
            Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: double.infinity,
              height: 500,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            /* -------------------------------------------------------------------------- */

            /* -------------------------------------------------------------------------- */
            /*                               Movie Title                                  */
            /* -------------------------------------------------------------------------- */
            Text(
              movie.title,
              style: const TextStyle(
                color: AppTheme.white2,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            /* -------------------------------------------------------------------------- */

            /* -------------------------------------------------------------------------- */
            /*                               Movie Overview                               */
            /* -------------------------------------------------------------------------- */
            Text(
              movie.overview,
              style: const TextStyle(color: AppTheme.white2, fontSize: 16),
            ),
            const SizedBox(height: 10),

            /* -------------------------------------------------------------------------- */

            /* -------------------------------------------------------------------------- */
            /*                                Release Date                                */
            /* -------------------------------------------------------------------------- */
            Text(
              'Release Date: ${movie.releaseDate}',
              style: const TextStyle(color: AppTheme.white2, fontSize: 16),
            ),
            const SizedBox(height: 10),
            /* -------------------------------------------------------------------------- */

            /* -------------------------------------------------------------------------- */
            /*                                Vote Average                                */
            /* -------------------------------------------------------------------------- */
            Text(
              'Rating: ${movie.voteAverage} (${movie.voteCount} votes)',
              style: const TextStyle(color: AppTheme.white2, fontSize: 16),
            ),
            const SizedBox(height: 10),
            /* -------------------------------------------------------------------------- */

            /* -------------------------------------------------------------------------- */
            /*                                    Adult                                   */
            /* -------------------------------------------------------------------------- */
            Text(
              'Adult: ${movie.adult ? 'Yes' : 'No'}',
              style: const TextStyle(color: AppTheme.white2, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
