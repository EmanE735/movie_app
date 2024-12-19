import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/service.dart';
import 'package:movie_app/tabs/movie_details_screen.dart';
import 'package:movie_app/widgets/watchlist_button.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> upComing;
  late Future<List<Movie>> topRated;

  @override
  void initState() {
    popularMovies = APIservice().getPopular();
    upComing = APIservice().getUpComing();
    topRated = APIservice().getTopRated();
    super.initState();
  }

  /* -------------------------------------------------------------------------- */
  /*                         Build Main Screen                                  */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* -------------------------------------------------------------------------- */
              /*                         Featured Movies Section                            */
              /* -------------------------------------------------------------------------- */
              FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final movies = snapshot.data!;

                  return SizedBox(
                    height: 250,
                    child: PageView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                  movie: movie,
                                  categoryId: movie.genreIds.isNotEmpty
                                      ? movie.genreIds[0]
                                      : 28,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color: AppTheme.black1,
                            child: Stack(
                              children: [
                                ShaderMask(
                                  shaderCallback: (rect) {
                                    return LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.8)
                                      ],
                                      stops: const [0.5, 1.0],
                                    ).createShader(rect);
                                  },
                                  blendMode: BlendMode.darken,
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/original/${movie.backDropPath}',
                                    height: 400,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Play Button
                                Center(
                                  child: Container(
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    child: const Icon(Icons.play_arrow,
                                        color: Colors.white, size: 45),
                                  ),
                                ),
                                // Movie Info
                                Positioned(
                                  left: 16,
                                  right: 16,
                                  bottom: 16,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Stack(
                                        children: [
                                          Image.network(
                                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                                            height: 130,
                                            width: 90,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 4,
                                            left: 4,
                                            child:
                                                WatchlistButton(movie: movie),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              movie.title,
                                              style: AppTheme
                                                  .featuredMovieTitleStyle,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              movie.releaseDate
                                                  .split('-')
                                                  .reversed
                                                  .join('/'),
                                              style: AppTheme.movieDateStyle,
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const Icon(Icons.star,
                                                    color: Colors.amber,
                                                    size: 16),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${movie.voteAverage.toStringAsFixed(1)}/10',
                                                  style: AppTheme.ratingStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              /* -------------------------------------------------------------------------- */
              /*                         New Releases Section                               */
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
                        "New Releases",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: FutureBuilder(
                        future: upComing,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final movies = snapshot.data!;
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return _buildMovieCard(movie);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              /* -------------------------------------------------------------------------- */
              /*                         Recommended Section                                */
              /* -------------------------------------------------------------------------- */
              Container(
                color: AppTheme.black2.withOpacity(0.7),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Text(
                        "Recommended",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: FutureBuilder(
                        future: topRated,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final movies = snapshot.data!;
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return _buildMovieCard(movie);
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

  /* -------------------------------------------------------------------------- */
  /*                         Movie Card Widget                                  */
  /* -------------------------------------------------------------------------- */
  Widget _buildMovieCard(Movie movie) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
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
            // Movie poster and details
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.grey1.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Movie Poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original/${movie.backDropPath}',
                      height: 130,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Movie Title
                  SizedBox(
                    width: 100,
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Movie Rating
                  SizedBox(
                    width: 100,
                    child: Row(
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
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Watchlist button positioned in top-left
            Positioned(
              top: 2,
              left: 2,
              child: WatchlistButton(movie: movie),
            ),
          ],
        ),
      ),
    );
  }
}
