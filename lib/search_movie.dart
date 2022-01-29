import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/api_auth.dart';
import 'package:movie_list/size.dart';
import 'package:movie_list/theme.dart';
import 'package:movie_list/widgets/movie_card.dart';
import 'data/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SearchMovie extends StatefulWidget {
  Movie movies;
  String movieSearch = '';

  SearchMovie({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  _SearchMovieState createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  Map<String, dynamic> _movieList = {};

  Future<void> _fetchData(movieName) async {
    var apiKey = ApiAuth().getApiKey();
    var url = "http://www.omdbapi.com/?apikey=$apiKey&&s=$movieName";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _movieList = data;
      });
    } else {
      print('request failed with status code : ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      _fetchData(widget.movies.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    String movies = widget.movies.name;

    return Scaffold(
      backgroundColor: dBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Column(
                  children: [
                    Text(
                      'Search Movie',
                      style: menuTitle,
                    ),
                    // Search Bar
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Material(
                        elevation: 5,
                        color: dBlue,
                        borderRadius: BorderRadius.circular(32),
                        shadowColor: lBlue,
                        child: TextField(
                          onChanged: (moviesIn) {
                            setState(() {
                              widget.movieSearch = moviesIn;
                              print(widget.movieSearch);
                            });
                          },
                          style: mainStyle,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            fillColor: priBlue,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search_rounded),
                              color: whiteMv,
                              onPressed: () {
                                setState(() {
                                  print(widget.movieSearch);
                                  _fetchData(widget.movieSearch);
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 24, bottom: 20, top: 20, right: 24),
                            hintText: 'Search Movies',
                            hintStyle: mainStyle,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            "Result For \'$movies\'",
                            style: mainStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Container(
                    child: GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 4
                            : 3,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: _movieList.isNotEmpty
                          ? _movieList['Search'].length
                          : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          key: Key(_movieList['Search'][index]['Title']),
                          onTap: () {},
                          child: MovieCard(
                            name: _movieList['Search'][index]['Title'],
                            year: _movieList['Search'][index]['Year'],
                            posterUrl: _movieList['Search'][index]['Poster'],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
