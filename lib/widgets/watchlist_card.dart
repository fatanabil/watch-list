import 'package:flutter/material.dart';
import 'package:movie_list/theme.dart';

class WatchlistCard extends StatelessWidget {
  final String title, year;
  final String? posterUrl;

  const WatchlistCard({
    Key? key,
    required this.title,
    required this.year,
    this.posterUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: accGreen,
        image: DecorationImage(
          image: posterUrl == null || posterUrl == 'N/A'
              ? AssetImage('assets/img/default.png')
              : Image.network(
                  posterUrl!,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Image.asset('assets/img/default.png');
                  },
                ).image,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AspectRatio(
        aspectRatio: 3 / 1,
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
              padding: EdgeInsets.only(left: 8, bottom: 16, right: 8),
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
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
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
