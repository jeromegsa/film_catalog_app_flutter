// screens/movie_detail_screen.dart
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map movie = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
                'https://image.tmdb.org/t/p/w500${movie['poster_path']}' , height: 100,),
            const SizedBox(height: 20),
            Text(
              'Titre: ${movie['title']}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Résumé: ${movie['overview']}'),
            const SizedBox(height: 10),
            Text('Date de sortie: ${movie['release_date']}'),
            const SizedBox(height: 10),
            Text('Score: ${movie['vote_average']}'),
          ],
        ),
      ),
    );
  }
}
