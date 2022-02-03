class MovieModel {
  final String movieId;

  MovieModel({required this.movieId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movieId': movieId,
    };
  }
}
