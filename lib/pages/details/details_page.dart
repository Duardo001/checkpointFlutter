import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/details/widgets/movie_cast.dart';
import 'package:movie_app/pages/details/widgets/movie_reviews.dart';
// import 'package:movie_app/pages/details/widgets/movie_reviews.dart';
import 'package:movie_app/pages/details/widgets/recommended_movies.dart';
import 'package:movie_app/services/api_services.dart';

class MovieDetailsPage extends StatefulWidget {
  final int id;

  const MovieDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late Future<Movie> movieDetails;

  @override
  void initState() {
    super.initState();
    movieDetails = ApiServices().getMovieDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: FutureBuilder<Movie>(
        future: movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final movie = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  const SizedBox(height: 16),
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Lançamento: ${movie.releaseDate?.year.toString() ?? 'Data indisponível'}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Avaliação: ${movie.voteAverage.toStringAsFixed(2)} / 10',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Sinopse:',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  MovieCast(id: movie.id),
                  const SizedBox(height: 16),
                  RecommendedMovies(id: movie.id),

                  const SizedBox(height: 16),
                  MovieReviews(id: movie.id), 


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
