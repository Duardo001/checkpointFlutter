import 'dart:convert';

class Result {
  int page;
  List<Movie> movies;
  int totalPages;
  int totalResults;

  Result({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        page: json["page"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Review {
  String author;
  String content;

  Review({
    required this.author,
    required this.content,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        author: json["author"] ?? 'Desconhecido',
        content: json["content"] ?? '',
      );
}

class CastMember {
  int id;
  String name;
  String character;
  String profilePath;

  CastMember({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) => CastMember(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        character: json["character"] ?? '',
        profilePath: json["profile_path"] ?? '',
      );
}

class Movie {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: json["genre_ids"] != null ? List<int>.from(json["genre_ids"].map((x) => x)) : [],
        id: json["id"] ?? 0,
        originalLanguage: json["original_language"] ?? '',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble() ?? 0,
        posterPath: json["poster_path"] ?? '',
        releaseDate: DateTime.tryParse(json["release_date"]),
        title: json["title"] ?? '',
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0,
        voteCount: json["vote_count"] ?? 0,
      );
}
