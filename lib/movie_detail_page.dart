import 'package:flutter/material.dart';
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
  Map<String, dynamic> detailMovie = {};

  Future<void> _fetchData(movieId) async {
    var apiKey = ApiAuth().getApiKey();
    var url = "http://www.omdbapi.com/?apikey=$apiKey&&i=$movieId";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;

      if (mounted) {
        setState(() {
          detailMovie = data;
        });
      }
    } else {
      print('request failed with status code : ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      _fetchData(widget.movieId);
    }
  }

  bool _isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dBlue,
      appBar: AppBar(
        backgroundColor: priBlue,
        title: Text('Movie Detail'),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 72),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: Size.screenWidth / 3,
                decoration: BoxDecoration(
                  color: accGreen,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage('${widget.posterUrl}'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.movieTitle}',
                        style: mainStyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '${widget.year}',
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
            width: Size.screenWidth,
            height: 16,
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        '${detailMovie['Director']}',
                        style: mainStyle.copyWith(color: whiteMv),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        '${detailMovie['Writer']}',
                        style: mainStyle.copyWith(color: whiteMv),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        '${detailMovie['Actors']}',
                        style: mainStyle.copyWith(color: whiteMv),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        '${detailMovie['Genre']}',
                        style: mainStyle.copyWith(color: whiteMv),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        '${detailMovie['imdbRating']} / 10',
                        style: mainStyle.copyWith(color: whiteMv),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        detailMovie.length <= 0 ||
                                detailMovie['Ratings'].length <= 1
                            ? '-'
                            : '${detailMovie['Ratings'][1]['Value']}',
                        style: mainStyle.copyWith(color: whiteMv),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "\'${detailMovie['Plot']}\'",
                        style: mainStyle.copyWith(color: whiteMv),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _isAdded = !_isAdded;
          });
        },
        label: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
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
              ? Icon(
                  Icons.check,
                  color: priBlue,
                )
              : Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
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
