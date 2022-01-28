import 'package:flutter/material.dart';
import 'package:movie_list/theme.dart';

class MovieCard extends StatelessWidget {
  final String name;
  final String year;
  final double rating;

  MovieCard({this.name = '', this.year = '', this.rating = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
          color: accGreen, borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.only(bottom: 16, left: 16),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                  color: dGreen,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    rating.toString(),
                    style: movieRating,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: movieTitle,
                  textAlign: TextAlign.left,
                ),
                Text(
                  year,
                  style: movieYear,
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
