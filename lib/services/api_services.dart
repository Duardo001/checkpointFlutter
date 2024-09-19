import 'dart:convert';

import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  Future<Result> getTopRatedMovies() async {
    var endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getNowPlayingMovies() async {
    var endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Result> getUpcomingMovies() async {
    var endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }

  Future<Result> getPopularMovies() async {
    const endPoint = 'movie/popular';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }

  Future<Movie> getMovieDetails(int id) async {
    final endPoint = 'movie/$id';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse); // Verifique a estrutura do JSON aqui
      return Movie.fromJson(jsonResponse);
    } else {
      throw Exception('failed to load movies details');
    }
  }

  Future<List<Movie>> getRecommendedMovies(int id) async {
    final endPoint = 'movie/$id/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return List<Movie>.from(
          jsonResponse["results"].map((x) => Movie.fromJson(x)));
    } else {
      throw Exception('Failed to load recommended movies');
    }
  }

  Future<List<Review>> getMovieReviews(int movieId) async {
    final endPoint = 'movie/$movieId/reviews';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return List<Review>.from(
          jsonResponse["results"].map((x) => Review.fromJson(x)));
    } else {
      throw Exception('Failed to load movie reviews');
    }
  }

  Future<List<CastMember>> getMovieCast(int id) async {
    final endPoint = 'movie/$id/credits';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<CastMember> cast = List<CastMember>.from(
          jsonResponse['cast'].map((x) => CastMember.fromJson(x)));

      return cast.where((actor) => actor.profilePath.isNotEmpty).toList();
    } else {
      throw Exception('Failed to load movie cast');
    }
  }
}
