/* -------------------------------------------------------------------------- */
/*                            Genre Model Class                               */
/* -------------------------------------------------------------------------- */

class Genre {
  final int id;
  final String name;

  /* -------------------------------------------------------------------------- */

  const Genre({required this.id, required this.name});

  /* -------------------------------------------------------------------------- */
  /*                     Factory Constructor for JSON Parsing                   */
  /* -------------------------------------------------------------------------- */
  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );

  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                             Convert Genre to JSON                          */
  /* -------------------------------------------------------------------------- */
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static List<String> getGenreNames(
      List<int> genreIds, List<Genre> availableGenres) {
    return genreIds
        .map((id) => availableGenres
            .firstWhere(
              (genre) => genre.id == id,
              orElse: () => const Genre(id: 0, name: "Unknown"),
            )
            .name)
        .toList();
  }
}
