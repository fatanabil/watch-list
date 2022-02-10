import 'package:flutter/material.dart';
import 'package:movie_list/data/movie.dart';
import 'package:movie_list/theme.dart';
import 'package:movie_list/size.dart';

import 'search_movie.dart';
import 'widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String movies = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dBlue,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    width: Size.screenWidth,
                    height: Size.screenWidth / 2,
                    color: accGreen,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Movie\nCarousel',
                          textAlign: TextAlign.center,
                          style: sub,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CarouselIndicator(),
                            CarouselIndicator(),
                            CarouselIndicator(),
                            CarouselIndicator(),
                            CarouselIndicator(),
                          ],
                        )
                      ],
                    )),
                // Searc Bar
                Container(
                  padding: const EdgeInsets.only(
                      right: 16, left: 16, top: 32, bottom: 16),
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
                          icon: const Icon(Icons.search_rounded),
                          color: whiteMv,
                          onPressed: () {
                            _navigateToNextScreen(
                                context,
                                SearchMovie(
                                  movies: Movie(movies),
                                ));
                            FocusScope.of(context).requestFocus(FocusNode());
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Recomended for you',
                            style: menuTitle,
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: whiteMv,
                              ))
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      padding:
                          const EdgeInsets.only(top: 8, left: 16, right: 16),
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Wrap(
                        spacing: 10.0,
                        direction: Axis.horizontal,
                        children: const [
                          MovieCard(name: 'A', year: '2006', rating: 8.0),
                          MovieCard(name: 'A', year: '2006', rating: 8.0),
                          MovieCard(name: 'A', year: '2006', rating: 8.0),
                          MovieCard(name: 'A', year: '2006', rating: 8.0),
                          MovieCard(name: 'A', year: '2006', rating: 8.0),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _navigateToNextScreen(BuildContext context, Widget widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.all(2),
      decoration:
          BoxDecoration(color: dBlue, borderRadius: BorderRadius.circular(5)),
    );
  }
}
