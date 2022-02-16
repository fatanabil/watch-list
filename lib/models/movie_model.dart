class MovieModel {
  final String movieId, movieTitle, moviePoster, movieYear;
  int isWatched = 0;

  MovieModel({
    required this.movieId,
    required this.movieTitle,
    required this.moviePoster,
    required this.movieYear,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movieId': movieId,
      'movieTitle': movieTitle,
      'moviePoster': moviePoster,
      'movieYear': movieYear,
      'isWatched': isWatched,
    };
  }
}
