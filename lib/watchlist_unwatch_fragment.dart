import 'package:flutter/material.dart';
import 'package:movie_list/helpers/dbhelper.dart';
import 'package:movie_list/models/MovieModel.dart';
import 'package:movie_list/theme.dart';
import 'package:movie_list/widgets/watchlist_card.dart';

class WatchlistUnFragment extends StatefulWidget {
  const WatchlistUnFragment({Key? key}) : super(key: key);

  @override
  WatchlistUnFragmentState createState() => WatchlistUnFragmentState();
}

class WatchlistUnFragmentState extends State<WatchlistUnFragment> {
  List<MovieModel> list = [];
  MovieDbProvider movieDb = MovieDbProvider();

  Future<void> fetchData() async {
    var data = await movieDb.getUnwatchMovie();
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
                        onTapDown: (TapDownDetails details) {},
                        onLongPress: () {
                          showMenu(
                            context: context,
                            position: RelativeRect.fill,
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
                                      style: TextStyle(color: whiteMv),
                                    ),
                                  ],
                                ),
                                value: ['add', list[index].movieId],
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
                                      style: TextStyle(color: Colors.red[400]),
                                    ),
                                  ],
                                ),
                                value: ['remove', list[index].movieId],
                              ),
                            ],
                          ).then((value) {
                            if (value?[0] == 'add') {
                              if (mounted) {
                                setState(() async {
                                  MovieModel movie = list[index];
                                  movie.isWatched = 1;
                                  await movieDb.updateToDone(value![1], movie);
                                  fetchData();
                                });
                              }
                            } else {
                              if (mounted) {
                                setState(() async {
                                  await movieDb.deleteItem(value![1]);
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
