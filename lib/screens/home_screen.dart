// screens/home_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  Future<List<dynamic>>? movies;

  @override
  void initState() {
    super.initState();
    movies = apiService.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue de Films'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun film disponible.'));
          } else {
            final movieList = snapshot.data!;
            return GridView.builder(
              
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75),
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                final movie = movieList[index];
                return Card(
                  
                  elevation: 5,
                  child: Column(
      
                    children: [
                      Expanded(
                        child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie['poster_path']}', width: 400,),
                      ),
                      SafeArea(
                          child: ListTile(
                        title: Text(
                          movie['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            fontSize: 24
                          ),
                        ),
                        subtitle: Text(
                          'Sorti en : ${movie['release_date']}',
                          textAlign: TextAlign.center,
                          
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/details',
                              arguments: movie);
                        },
                      ))
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
