import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/viewmodels/movie_view_model.dart';
import 'package:movie/views/components/movie_form_dialog.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(movie.title),
        subtitle: Text(
          "Anno:${movie.year} - Durata:${movie.duration} - \n trama: ${movie.plot}",
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => MovieFormDialog(movie: movie),
                );
              },
              icon: Icon(Icons.edit, color: Colors.blue),
            ),
            IconButton(
              onPressed: () {
                context.read<MovieViewModel>().deleteMovies(movie.id!);
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
