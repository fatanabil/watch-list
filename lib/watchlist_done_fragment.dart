import 'package:flutter/material.dart';

import 'widgets/watchlist_card.dart';

class WatchlistDoneFragment extends StatefulWidget {
  const WatchlistDoneFragment({Key? key}) : super(key: key);

  @override
  _WatchlistDoneFragmentState createState() => _WatchlistDoneFragmentState();
}

class _WatchlistDoneFragmentState extends State<WatchlistDoneFragment> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 3,
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
