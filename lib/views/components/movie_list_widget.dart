import 'package:flutter/material.dart';
import 'package:movie/viewmodels/movie_view_model.dart';
import 'package:provider/provider.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MovieViewModel>();
    final movies = viewModel.movies;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(movie.title),
                  subtitle: Text(
                    "Anno:${movie.year} - Durata:${movie.duration} - \n trama: ${movie.plot}",
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
