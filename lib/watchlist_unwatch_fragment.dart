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
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list.length,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0),
      itemBuilder: (BuildContext context, int index) {
        return WatchlistCard(
          title: list[index].movieTitle,
          year: list[index].movieYear,
          posterUrl: list[index].moviePoster,
        );
      },
    );
  }
}
