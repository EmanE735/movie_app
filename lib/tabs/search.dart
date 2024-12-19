/* -------------------------------------------------------------------------- */
/*                         Import Required Packages                            */
/* -------------------------------------------------------------------------- */
import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/service.dart';
import 'package:movie_app/tabs/movie_details_screen.dart';

/* -------------------------------------------------------------------------- */
/*                         Search Tab Main Widget                              */
/* -------------------------------------------------------------------------- */
class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      /* -------------------------------------------------------------------------- */
      /*                         Custom AppBar Section                              */
      /* -------------------------------------------------------------------------- */
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
            backgroundColor: AppTheme.black1,
            title: GestureDetector(
              onTap: () => _showSearchDelegate(context),
              child: const Text(
                'Search Movies',
                style: TextStyle(color: AppTheme.white2, fontSize: 16),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppTheme.white2),
                onPressed: () => _showSearchDelegate(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDelegate(BuildContext context) {
    showSearch(
      context: context,
      delegate: MovieSearchDelegate(),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                         Movie Search Delegate                              */
/* -------------------------------------------------------------------------- */
class MovieSearchDelegate extends SearchDelegate<String> {
  final APIservice apiService = APIservice();

  /* -------------------------------------------------------------------------- */
  /*                         Search Bar Theme Configuration                      */
  /* -------------------------------------------------------------------------- */
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppTheme.black1,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppTheme.black1,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[900],
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                         Search Field Customization                         */
  /* -------------------------------------------------------------------------- */
  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        color: AppTheme.white2,
        fontSize: 16,
      );

  @override
  String? get searchFieldLabel => 'Search movies...';

  /* -------------------------------------------------------------------------- */
  /*                         Search Bar Actions                                 */
  /* -------------------------------------------------------------------------- */
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: AppTheme.white2),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppTheme.white2),
      onPressed: () => close(context, ''),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                         Search Results Builder                             */
  /* -------------------------------------------------------------------------- */
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: AppTheme.black1,
      child: FutureBuilder<List<Movie>>(
        future: apiService.searchMovies(query),
        builder: (context, snapshot) {
          /* -------------------------------------------------------------------------- */
          /*                         Loading and Error States                          */
          /* -------------------------------------------------------------------------- */
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.white2),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: AppTheme.white2),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No movies found',
                style: TextStyle(color: AppTheme.white2),
              ),
            );
          }

          /* -------------------------------------------------------------------------- */
          /*                         Search Results List                               */
          /* -------------------------------------------------------------------------- */
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final movie = snapshot.data![index];
              return _buildMovieListItem(context, movie);
            },
          );
        },
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                         Search Suggestions Screen                          */
  /* -------------------------------------------------------------------------- */
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: AppTheme.black1,
      child: const Center(
        child: Text(
          'Start typing to search movies...',
          style: TextStyle(color: AppTheme.white2),
        ),
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                         Movie List Item Builder                            */
  /* -------------------------------------------------------------------------- */
  Widget _buildMovieListItem(BuildContext context, Movie movie) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(
                movie: movie,
                categoryId: movie.genreIds.isNotEmpty ? movie.genreIds[0] : 28,
              ),
            ),
          );
        },
        child: Row(
          children: [
            /* -------------------------------------------------------------------------- */
            /*                         Movie Poster                                      */
            /* -------------------------------------------------------------------------- */
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: movie.posterPath.isEmpty
                  ? Container(
                      width: 80,
                      height: 120,
                      color: Colors.grey[800],
                      child: const Icon(Icons.movie, color: AppTheme.white2),
                    )
                  : Image.network(
                      'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                      width: 80,
                      height: 120,
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
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: AppTheme.white2,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.releaseDate.split('-')[0],
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
