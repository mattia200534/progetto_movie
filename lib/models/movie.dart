class Movie {
  final String title;
  final int duration;
  final String plot;
  final int year;

  Movie({
    required this.title,
    required this.duration,
    required this.plot,
    required this.year,
  });

  // metodo per convertire un oggetto dart in una map
  Map<String, dynamic> toMap() {
    return {'title': title, 'duration': duration, 'plot': plot, 'year': year};
  }

  //metodo per recuperare una map e trasformarla in un oggetto dart
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      duration: map['duration'],
      plot: map['plot'],
      year: map['year'],
    );
  }
}
