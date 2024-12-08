import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/model/category/category.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/model/movie_details.dart';

const apiKey = "2e6c2e6ae95a53ab0052be44ce7f9327";

class APIservice {
  final popularApi =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
  final upComingApi =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final topRatedApi =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";
  final genreApi =
      "https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey";
  final discoverApi =
      "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=";

  Future<Category> getCategories() async {
    Uri url = Uri.parse(genreApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Category.fromJson(data);
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<MovieDetails>> getMoviesByCategory(int categoryId) async {
    final url = '$discoverApi$categoryId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((movieData) => MovieDetails.fromJson(movieData)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> getPopular() async {
    Uri url = Uri.parse(popularApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("failed to load data");
    }
  }

  Future<List<Movie>> getUpComing() async {
    Uri url = Uri.parse(upComingApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("failed to load data");
    }
  }

  Future<List<Movie>> getTopRated() async {
    Uri url = Uri.parse(topRatedApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("failed to load data");
    }
  }
}
