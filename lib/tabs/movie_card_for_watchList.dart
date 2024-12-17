import 'package:flutter/material.dart';
import 'package:movie_app/app_theme.dart';
import 'package:movie_app/model/model.dart';

import 'package:movie_app/tabs/movie_details_screen.dart';


class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onRemove;

  MovieCard({required this.movie, required this.onRemove});

  @override
  Widget build(BuildContext context) {
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
        child: Container(width: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Movie Poster
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/original/${movie.backDropPath}',
                        height: 130,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                        onPressed:  onRemove
                         
                        ,
                        icon:
                            Icon(Icons.remove_circle_outline, color: Colors.red),
                      )
                    ],
                  ),
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
      ),
    );
  }
}
    
    
     /* Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: movie.posterPath.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: 60,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(Icons.movie, size: 60, color: Colors.grey),
        title: Text(
          movie.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          movie.overview.length > 60
              ? movie.overview.substring(0, 60) + '...'
              : movie.overview,
          style: TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    ); */
  
