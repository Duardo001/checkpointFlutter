import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';

class MovieCast extends StatelessWidget {
  final int id;
  const MovieCast({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CastMember>>(
      future: ApiServices().getMovieCast(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum elenco disponível.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Elenco',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 220, 
              child: PageView.builder(
                itemCount: snapshot.data!.length,
                controller: PageController(
                    viewportFraction: 0.8), 
                itemBuilder: (context, index) {
                  final castMember = snapshot.data![index];
                  return Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        castMember.profilePath.isNotEmpty
                            ? Image.network('https://image.tmdb.org/t/p/w500${castMember.profilePath}', height: 150, fit: BoxFit.cover)
                            : Image.asset('assets/placeholder.jpg', height: 150), // Placeholder caso não tenha imagem
                        const SizedBox(height: 8),
                        Text(castMember.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(castMember.character),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
