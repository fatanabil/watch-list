import 'package:flutter/material.dart';
import 'package:movie_list/theme.dart';
import 'package:movie_list/widgets/watchlist_card.dart';

class WatchlistUnFragment extends StatefulWidget {
  const WatchlistUnFragment({Key? key}) : super(key: key);

  @override
  WatchlistUnFragmentState createState() => WatchlistUnFragmentState();
}

class WatchlistUnFragmentState extends State<WatchlistUnFragment> {
  var list = {};

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 7,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0),
      itemBuilder: (BuildContext context, int index) {
        return WatchlistCard(title: 'Avengers', year: '2012');
      },
    );
  }
}
