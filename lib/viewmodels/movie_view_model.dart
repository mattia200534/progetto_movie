import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/services/movie_services.dart';

class MovieViewModel extends ChangeNotifier {
  final DBservice _bservice = DBservice();
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  List<Movie> get movies => _filteredMovies;
  bool _isloading = false;
  bool get isloading => _isloading;

  //metodo per poter recuperare i film
  Future<void> fectMovies() async {
    _isloading = true;
    notifyListeners();
    _movies = await _bservice.getAllMovies();
    _isloading = false;
    notifyListeners();
  }

  //* metodo per aggiungere un film

  Future<void> addMovie(Movie movie) async {
    await _bservice.insertMovie(movie);
    await fectMovies();
  }

  //metodo per cancellare un film
  Future<void> deleteMovies(int id) async {
    await _bservice.deleteMovie(id);
    await fectMovies();
  }

  //metodo per aggiornare un film
  Future<void> updateMovie(Movie movie) async {
    if (movie.id == null) return;
    await _bservice.updateMovie(movie);
    await fectMovies();
  }

  //metodo per recuperare un film dall'id
  Movie? getMovieById(int id) {
    try {
      return _movies.firstWhere((movie) => movie.id == id);
    } catch (e) {
      return null;
    }
  }

  void filterMovies(String query) {
    if (query.isEmpty) {
      _filteredMovies = List.from(_movies);
    } else {
      _filteredMovies = _movies
          .where(
            (movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()) ||
                movie.plot.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }
}
