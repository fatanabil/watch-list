import 'package:flutter/material.dart';
import 'package:movie_list/data/api_auth.dart';
import 'package:movie_list/movie_detail_page.dart';
import 'package:movie_list/size.dart';
import 'package:movie_list/theme.dart';
import 'package:movie_list/widgets/movie_card.dart';
import 'data/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SearchMovie extends StatefulWidget {
  Movie movies;
  String movieSearch = 'null';

  SearchMovie({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  _SearchMovieState createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  Future<Map<String, dynamic>> _getData(movieName) async {
    var apiKey = ApiAuth().getApiKey();
    var url = "http://www.omdbapi.com/?apikey=$apiKey&&s=$movieName";

    var response = await http.get(Uri.parse(url));

    var data = convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 404) {
      throw Error();
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    String movies = widget.movies.name;

    return Scaffold(
      backgroundColor: dBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Column(
                  children: [
                    Text(
                      'Search Movie',
                      style: menuTitle,
                    ),
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Material(
                        elevation: 5,
                        color: dBlue,
                        borderRadius: BorderRadius.circular(32),
                        shadowColor: lBlue,
                        child: TextFormField(
                          initialValue: widget.movieSearch == 'null'
                              ? movies
                              : widget.movieSearch,
                          onChanged: (moviesIn) {
                            widget.movieSearch = moviesIn;
                          },
                          onFieldSubmitted: (value) {
                            setState(() {});
                            FocusScope.of(context).requestFocus(FocusNode());
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
                              icon: const Icon(Icons.search_rounded),
                              color: whiteMv,
                              onPressed: () {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.only(
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
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            widget.movieSearch == 'null'
                                ? "Result For \'$movies\'"
                                : "Result For \'${widget.movieSearch}\'",
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
                  child: FutureBuilder(
                    future: _getData(widget.movieSearch == 'null'
                        ? movies
                        : widget.movieSearch),
                    builder: (context, snapshot) {
                      var result = {};
                      if (snapshot.hasData) {
                        result = snapshot.data! as Map<String, dynamic>;
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: accGreen),
                        );
                      } else if (result['Response'] == "False") {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img/no-movie.png',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Movie Not Found",
                                textAlign: TextAlign.center,
                                style: mainStyle.copyWith(
                                  color: lBlue,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: MySize.screenHeight / 5,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? 4
                                      : 3,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: result['Response'] == "False"
                                ? 0
                                : result['Search'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      key:
                                          Key(result['Search'][index]['Title']),
                                      child: MovieCard(
                                        name: result['Search'][index]['Title'],
                                        year: result['Search'][index]['Year'],
                                        posterUrl: result['Search'][index]
                                            ['Poster'],
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Material(
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: InkWell(
                                        splashColor:
                                            Colors.white.withOpacity(0.1),
                                        onTap: () {
                                          _navigateToNextScreen(
                                            context,
                                            MovieDetail(
                                              movieId: result['Search'][index]
                                                  ['imdbID'],
                                              movieTitle: result['Search']
                                                  [index]['Title'],
                                              year: result['Search'][index]
                                                  ['Year'],
                                              posterUrl: result['Search'][index]
                                                  ['Poster'],
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        );
                      }
                    },
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

void _navigateToNextScreen(BuildContext context, Widget widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}
