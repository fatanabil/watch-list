import 'package:flutter/material.dart';
import 'package:movie_list/theme.dart';

class MovieCard extends StatelessWidget {
  final String name;
  final String year;
  final double rating;
  final String posterUrl;

  const MovieCard({
    Key? key,
    this.name = '',
    this.year = '',
    this.rating = 0.0,
    this.posterUrl = 'N/A',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: accGreen,
        image: posterUrl == 'N/A'
            ? const DecorationImage(
                image: AssetImage('assets/img/default.png'),
              )
            : DecorationImage(
                image: Image.network(
                  posterUrl,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Image.asset('assets/img/default.png');
                  },
                ).image,
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
              decoration: posterUrl == 'N/A'
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
                        stops: const [0.3, 1],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 16, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: posterUrl == 'N/A'
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
