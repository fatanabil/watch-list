import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/size.dart';
import 'package:movie_list/theme.dart';
import 'package:movie_list/widgets/movie_card.dart';
import 'data/movie.dart';

class SearchMovie extends StatefulWidget {
  final Movie movies;

  const SearchMovie({Key? key, required this.movies}) : super(key: key);

  @override
  _SearchMovieState createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
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
                            movies = moviesIn;
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
                              onPressed: () {},
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
                      child: GridView.count(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 2 / 3,
                    children: [
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
