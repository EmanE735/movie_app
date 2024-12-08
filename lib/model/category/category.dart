import 'genre.dart';

/* -------------------------------------------------------------------------- */
/*                             Category Model Class                           */
/* -------------------------------------------------------------------------- */

class Category {
  final List<Genre>? genres;

  const Category({this.genres});

  /* -------------------------------------------------------------------------- */
  /*                       Factory Constructor for JSON Parsing                */
  /* -------------------------------------------------------------------------- */
  factory Category.fromJson(Map<String, dynamic> json) => Category(
        // If genres exist in the JSON, map each genre to the Genre class.
        genres: (json['genres'] as List<dynamic>?)
            ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  /* -------------------------------------------------------------------------- */
  /*                               Convert Category to JSON                     */
  /* -------------------------------------------------------------------------- */
  Map<String, dynamic> toJson() => {
        'genres': genres?.map((e) => e.toJson()).toList(),
      };
}
