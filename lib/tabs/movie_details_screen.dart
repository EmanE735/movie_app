/* -------------------------------------------------------------------------- */
/*                         Import Required Packages                            */
/* -------------------------------------------------------------------------- */
import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/service.dart';
import 'package:movie_app/model/category/genre.dart';
import 'package:movie_app/model/category/category.dart';

/* -------------------------------------------------------------------------- */
/*                         Movie Details Screen Widget                        */
/* -------------------------------------------------------------------------- */
class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  final int categoryId;

  const MovieDetailsScreen({
    required this.movie,
    required this.categoryId,
    super.key,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

/* -------------------------------------------------------------------------- */
/*                         Movie Details Screen State                         */
/* -------------------------------------------------------------------------- */
class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  // Variables for API calls
  late Future<List<Movie>> relatedMoviesFuture;
  late Future<Category> categoriesFuture;

  /* -------------------------------------------------------------------------- */
  /*                         Initialize State                                   */
  /* -------------------------------------------------------------------------- */
  @override
  void initState() {
    super.initState();
    relatedMoviesFuture = APIservice().getMoviesByCategory(widget.categoryId);
    categoriesFuture = APIservice().getCategories();
  }

  /* -------------------------------------------------------------------------- */
  /*                         Build Main Screen                                  */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black2,
      /* -------------------------------------------------------------------------- */
      /*                                AppBar                                     */
      /* -------------------------------------------------------------------------- */
      appBar: AppBar(
        backgroundColor: AppTheme.black1,
        title: Text(
          widget.movie.title,
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
      /* -------------------------------------------------------------------------- */
      /*                         Main Content Body                                 */
      /* -------------------------------------------------------------------------- */
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* -------------------------------------------------------------------------- */
              /*                         Hero Image Section                               */
              /* -------------------------------------------------------------------------- */
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const Icon(
                    Icons.play_circle_fill,
                    size: 60,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /* -------------------------------------------------------------------------- */
              /*                         Movie Info Section                               */
              /* -------------------------------------------------------------------------- */
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* -------------------------------------------------------------------------- */
                  /*                         Movie Poster                                      */
                  /* -------------------------------------------------------------------------- */
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                      height: 120,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  /* -------------------------------------------------------------------------- */
                  /*                         Movie Details                                    */
                  /* -------------------------------------------------------------------------- */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.movie.title,
                          style: const TextStyle(
                            color: AppTheme.white2,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Rating
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.movie.voteAverage}/10',
                              style: const TextStyle(
                                color: AppTheme.white2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Release Date
                        Text(
                          widget.movie.releaseDate,
                          style: const TextStyle(
                            color: AppTheme.white2,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),

                        /* -------------------------------------------------------------------------- */
                        /*                         Genres Section                                    */
                        /* -------------------------------------------------------------------------- */
                        FutureBuilder<Category>(
                          future: categoriesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.genres!.isEmpty) {
                              return const Text('No genres available');
                            }

                            final genreNames = Genre.getGenreNames(
                              widget.movie.genreIds,
                              snapshot.data!.genres!,
                            );

                            return Wrap(
                              spacing: 8.0,
                              children: genreNames.map((genreName) {
                                return Chip(
                                  label: Text(genreName),
                                  backgroundColor: AppTheme.black1,
                                  labelStyle: const TextStyle(
                                    color: AppTheme.white2,
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /* -------------------------------------------------------------------------- */
              /*                         Overview Section                                  */
              /* -------------------------------------------------------------------------- */
              Text(
                widget.movie.overview,
                style: const TextStyle(
                  color: AppTheme.white2,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),

              /* -------------------------------------------------------------------------- */
              /*                         More Like This Section                            */
              /* -------------------------------------------------------------------------- */
              Container(
                color: AppTheme.grey1.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Text(
                        'More Like This',
                        style: TextStyle(
                          color: AppTheme.white2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: FutureBuilder<List<Movie>>(
                        future: relatedMoviesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No related movies available.'));
                          }

                          final relatedMovies = snapshot.data!;
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: relatedMovies.length,
                            itemBuilder: (context, index) {
                              final movie = relatedMovies[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsScreen(
                                          movie: movie,
                                          categoryId: movie.genreIds.isNotEmpty
                                              ? movie.genreIds[0]
                                              : widget.categoryId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              AppTheme.grey1.withOpacity(0.6),
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          width: 80,
                                          child: Text(
                                            movie.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: AppTheme.white2,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 24,
                                            ),
                                            Text(
                                              '${movie.voteAverage}/10',
                                              style: const TextStyle(
                                                color: AppTheme.white2,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
