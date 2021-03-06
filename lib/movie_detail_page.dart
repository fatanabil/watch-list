import 'package:flutter/material.dart';
import 'package:movie_list/helpers/dbhelper.dart';
import 'package:movie_list/models/movie_model.dart';
import 'package:movie_list/size.dart';
import 'package:movie_list/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'data/api_auth.dart';

class MovieDetail extends StatefulWidget {
  final String movieId, movieTitle, year, posterUrl;

  const MovieDetail({
    Key? key,
    required this.movieId,
    required this.movieTitle,
    required this.year,
    required this.posterUrl,
  }) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDbProvider movieDb = MovieDbProvider();
  bool _isAdded = false;

  Future<Map<String, dynamic>> _getData(movieId) async {
    var apiKey = ApiAuth().getApiKey();
    var url = "http://www.omdbapi.com/?apikey=$apiKey&&i=$movieId";

    var response = await http.get(Uri.parse(url));
    var data = convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 404) {
      throw Error();
    }

    return data;
  }

  Future<int> checkMovie(String movieId) async {
    var result = await movieDb.getMovieById(movieId);
    if (result.isEmpty) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      checkMovie(widget.movieId).then((value) {
        if (value == 1) {
          setState(() {
            _isAdded = false;
          });
        } else {
          setState(() {
            _isAdded = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = MovieModel(
      movieId: widget.movieId,
      movieTitle: widget.movieTitle,
      moviePoster: widget.posterUrl,
      movieYear: widget.year,
    );

    return Scaffold(
      backgroundColor: dBlue,
      appBar: AppBar(
        backgroundColor: priBlue,
        title: const Text('Movie Detail'),
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 72),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MySize.screenWidth / 3,
                decoration: BoxDecoration(
                  color: accGreen,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: Image.network(
                      widget.posterUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/img/default.png');
                      },
                    ).image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: const AspectRatio(
                  aspectRatio: 2 / 3,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movieTitle,
                        style: mainStyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.year,
                        style: sub.copyWith(
                          fontSize: 18,
                          color: accGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: MySize.screenWidth,
            height: 16,
          ),
          FutureBuilder(
            future: _getData(widget.movieId),
            builder: (context, snapshot) {
              var result = {};

              if (snapshot.hasData) {
                result = snapshot.data! as Map<String, dynamic>;
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: accGreen),
                );
              } else {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Director',
                            style: mainStyle.copyWith(color: whiteMv),
                          ),
                        ),
                        Text(
                          ':',
                          style: mainStyle.copyWith(color: whiteMv),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              '${result['Director']}',
                              style: mainStyle.copyWith(color: whiteMv),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Writer',
                            style: mainStyle.copyWith(color: whiteMv),
                          ),
                        ),
                        Text(
                          ':',
                          style: mainStyle.copyWith(color: whiteMv),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              '${result['Writer']}',
                              style: mainStyle.copyWith(color: whiteMv),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Actors',
                            style: mainStyle.copyWith(color: whiteMv),
                          ),
                        ),
                        Text(
                          ':',
                          style: mainStyle.copyWith(color: whiteMv),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              '${result['Actors']}',
                              style: mainStyle.copyWith(color: whiteMv),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Genre',
                            style: mainStyle.copyWith(color: whiteMv),
                          ),
                        ),
                        Text(
                          ':',
                          style: mainStyle.copyWith(color: whiteMv),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              '${result['Genre']}',
                              style: mainStyle.copyWith(color: whiteMv),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'ImDB Rating',
                            style: mainStyle.copyWith(color: whiteMv),
                          ),
                        ),
                        Text(
                          ':',
                          style: mainStyle.copyWith(color: whiteMv),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              '${result['imdbRating']} / 10',
                              style: mainStyle.copyWith(color: whiteMv),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Rotten',
                            style: mainStyle.copyWith(color: whiteMv),
                          ),
                        ),
                        Text(
                          ':',
                          style: mainStyle.copyWith(color: whiteMv),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              result.isEmpty || result['Ratings'].length <= 1
                                  ? '-'
                                  : '${result['Ratings'][1]['Value']}',
                              style: mainStyle.copyWith(color: whiteMv),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Plot',
                            style: mainStyle.copyWith(color: whiteMv),
                          ),
                        ),
                        Text(
                          ':',
                          style: mainStyle.copyWith(color: whiteMv),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "\'${result['Plot']}\'",
                              style: mainStyle.copyWith(color: whiteMv),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_isAdded == false) {
            await movieDb.addItem(movie);
            setState(() {
              _isAdded = true;
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: priBlue,
                  title: const Text(
                    'Do you want to remove this movie from watchlist?',
                    style: TextStyle(
                      fontSize: 16,
                      color: whiteMv,
                    ),
                  ),
                  content: Text(
                    widget.movieTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: whiteMv,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.grey[300],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await movieDb.deleteItem(movie.movieId);
                        setState(() {
                          _isAdded = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.red[400],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        label: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(
            opacity: animation,
            child: SizeTransition(
              child: child,
              sizeFactor: animation,
              axis: Axis.horizontal,
            ),
          ),
          child: _isAdded
              ? const Icon(
                  Icons.check,
                  color: priBlue,
                )
              : Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.add),
                    ),
                    Text('Add to Watchlist'),
                  ],
                ),
        ),
      ),
    );
  }
}
