import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/viewmodels/movie_view_model.dart';
import 'package:movie/views/components/movie_form_dialog.dart';
import 'package:movie/views/components/movie_list_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieViewModel>().fectMovies();
    });
    return Scaffold(
      appBar: AppBar(title: Text("Movie Collection APP"), centerTitle: true),
      body: Consumer<MovieViewModel>(
        builder: (context, viewmodel, child) {
          if (viewmodel.isloading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewmodel.movies.isEmpty) {
            return const Center(
              child: Text(
                "Non hai inserito alcun film",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            );
          }
          return MovieListWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => MovieFormDialog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
