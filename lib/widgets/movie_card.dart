import 'package:flutter/material.dart';
import 'package:movie_list/theme.dart';

class MovieCard extends StatelessWidget {
  final String name;
  final String year;
  final double rating;
  final String? posterUrl;

  MovieCard({
    this.name = '',
    this.year = '',
    this.rating = 0.0,
    this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: accGreen,
        image: posterUrl == null || posterUrl == 'N/A'
            ? DecorationImage(
                image: AssetImage('assets/img/default.png'),
              )
            : DecorationImage(
                image: NetworkImage(posterUrl!),
                fit: BoxFit.cover,
              ),
        borderRadius: BorderRadius.circular(5),
      ),
      // padding: EdgeInsets.only(bottom: 16, left: 8),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Stack(
          children: [
            Container(
              decoration: posterUrl == null || posterUrl == 'N/A'
                  ? BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    )
                  : BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent
                        ],
                        stops: [0.3, 1],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        name,
                        style: posterUrl == null || posterUrl == 'N/A'
                            ? movieTitle.copyWith(color: priBlue)
                            : movieTitle,
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
          ],
        ),
      ),
    );
  }
}
