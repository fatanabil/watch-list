import 'package:flutter/material.dart';
import 'package:movie_list/helpers/dbhelper.dart';
import 'package:movie_list/models/movie_model.dart';
import 'package:movie_list/theme.dart';
import 'package:movie_list/widgets/watchlist_card.dart';

class WatchlistUnFragment extends StatefulWidget {
  const WatchlistUnFragment({Key? key}) : super(key: key);

  @override
  WatchlistUnFragmentState createState() => WatchlistUnFragmentState();
}

class WatchlistUnFragmentState extends State<WatchlistUnFragment> {
  MovieDbProvider movieDb = MovieDbProvider();

  late Offset tapXY;
  late RenderBox overlay;

  RelativeRect get relRectSize => RelativeRect.fromRect(
      tapXY & const Size(40, 40), Offset.zero & overlay.size);

  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  Future<List<MovieModel>> _getData() async {
    var data = await movieDb.getUnwatchMovie();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context)?.context.findRenderObject() as RenderBox;

    return FutureBuilder(
      future: _getData(),
      builder: ((context, snapshot) {
        var result = [];
        if (snapshot.hasData) {
          result = snapshot.data as List<MovieModel>;
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: accGreen),
          );
        } else if (result.isEmpty) {
          return Center(
            child: Image.asset(
              'assets/img/no-movie.png',
              scale: 2,
            ),
          );
        } else {
          return GridView.builder(
            itemCount: result.length,
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
                      title: result[index].movieTitle,
                      year: result[index].movieYear,
                      posterUrl: result[index].moviePoster,
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
                                      Icons.add,
                                      color: whiteMv,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Add to Done list',
                                      style: TextStyle(
                                        color: whiteMv,
                                      ),
                                    ),
                                  ],
                                ),
                                value: ['add', result[index].movieId],
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red[400],
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Remove from Watch list',
                                      style: TextStyle(
                                        color: Colors.red[400],
                                      ),
                                    ),
                                  ],
                                ),
                                value: ['remove', result[index].movieId],
                              ),
                            ],
                          ).then((value) {
                            if (value?[0] == 'add') {
                              if (mounted) {
                                setState(() async {
                                  MovieModel movie = result[index];
                                  movie.isWatched = 1;
                                  await movieDb.updateToDone(value![1], movie);
                                  setState(() {});
                                });
                              }
                            } else {
                              if (mounted) {
                                setState(() async {
                                  await movieDb.deleteItem(value![1]);
                                  setState(() {});
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
          );
        }
      }),
    );
  }
}
