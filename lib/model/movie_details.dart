/* -------------------------------------------------------------------------- */
/*                         Movie Details Model Class                          */
/* -------------------------------------------------------------------------- */

class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String posterPath;
  final List<int> genreIds;
  final double voteAverage;
  final int voteCount;
  final bool adult;

  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                          Constructor for MovieDetails                     */
  /* -------------------------------------------------------------------------- */
  MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.genreIds,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
  });

  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                    Factory Constructor to Convert JSON to Object          */
  /* -------------------------------------------------------------------------- */
  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
      genreIds: List<int>.from(json['genre_ids']),
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      adult: json['adult'],
    );
  }

  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                            Convert MovieDetails to JSON                    */
  /* -------------------------------------------------------------------------- */
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'release_date': releaseDate,
        'poster_path': posterPath,
        'genre_ids': genreIds,
        'vote_average': voteAverage,
        'vote_count': voteCount,
        'adult': adult,
      };

  /* -------------------------------------------------------------------------- */
}
