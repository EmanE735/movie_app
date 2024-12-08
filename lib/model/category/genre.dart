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
}