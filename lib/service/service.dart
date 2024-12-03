import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/model/model.dart';

const apiKey = "2e6c2e6ae95a53ab0052be44ce7f9327";

class APIservice {
  final popularApi =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
  final upComingApi =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final topRatedApi =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";

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
