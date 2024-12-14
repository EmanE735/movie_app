class Movie {
  final int id;
  final String title;
  final String backDropPath;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final String overview;
  final int voteCount;
  final bool adult;
  final List<int> genreIds;

  Movie({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.overview,
    this.voteCount = 0,
    this.adult = false,
    this.genreIds = const [],
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? 0,
      title: map['title'] ?? 'Unknown Title',
      backDropPath: map['backdrop_path'] ?? '',
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? 'Unknown Release Date',
      voteAverage: (map['vote_average'] ?? 0).toDouble(),
      overview: map['overview'] ?? 'No Overview Available',
      voteCount: map['vote_count'] ?? 0,
      adult: map['adult'] ?? false,
      genreIds:
          map['genre_ids'] != null ? List<int>.from(map['genre_ids']) : [],
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) => Movie.fromMap(json);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backdrop_path': backDropPath,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'overview': overview,
      'vote_count': voteCount,
      'adult': adult,
      'genre_ids': genreIds,
    };
  }

  Map<String, dynamic> toJson() => toMap();
}
