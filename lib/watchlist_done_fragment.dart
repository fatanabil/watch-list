import 'package:flutter/material.dart';
import 'package:movie_list/helpers/dbhelper.dart';
import 'package:movie_list/models/MovieModel.dart';

import 'theme.dart';
import 'widgets/watchlist_card.dart';

class WatchlistDoneFragment extends StatefulWidget {
  const WatchlistDoneFragment({Key? key}) : super(key: key);

  @override
  _WatchlistDoneFragmentState createState() => _WatchlistDoneFragmentState();
}

class _WatchlistDoneFragmentState extends State<WatchlistDoneFragment> {
  List<MovieModel> list = [];
  MovieDbProvider movieDb = MovieDbProvider();

  late Offset tapXY;
  late RenderBox overlay;

  RelativeRect get relRectSize => RelativeRect.fromRect(
      tapXY & const Size(40, 40), Offset.zero & overlay.size);

  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  Future<void> fetchData() async {
    var data = await movieDb.getWatchedMovie();
    if (mounted) {
      setState(() {
        list = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context)?.context.findRenderObject() as RenderBox;

    return list.isNotEmpty
        ? GridView.builder(
            itemCount: list.length,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: WatchlistCard(
                      title: list[index].movieTitle,
                      year: list[index].movieYear,
                      posterUrl: list[index].moviePoster,
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        splashColor: whiteMv.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                        onTapDown: getPosition,
                        onLongPress: () {
                          showMenu(
                            context: context,
                            position: relRectSize,
                            color: priBlue,
                            items: [
                              PopupMenuItem(
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.arrow_back,
                                      color: whiteMv,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Move back to Watch list',
                                      style: TextStyle(color: whiteMv),
                                    ),
                                  ],
                                ),
                                value: ['move', list[index].movieId],
                              ),
                            ],
                          ).then((value) {
                            if (value![0] == 'move') {
                              if (mounted) {
                                setState(() async {
                                  MovieModel movie = list[index];
                                  movie.isWatched = 0;
                                  await movieDb.updateToUnwatch(
                                      value[1], movie);
                                  fetchData();
                                });
                              }
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/no-movie.png',
                scale: 2,
              ),
            ],
          );
  }
}
