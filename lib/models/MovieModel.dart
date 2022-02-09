class MovieModel {
  final String movieId, movieTitle, moviePoster;
  final int isWatched = 0;

  MovieModel({
    required this.movieId,
    required this.movieTitle,
    required this.moviePoster,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movieId': movieId,
      'movieTitle': movieTitle,
      'moviePoster': moviePoster,
      'isWatched': isWatched,
    };
  }
}
