import 'package:flutter/material.dart';
import 'package:movie_list/size.dart';
import 'package:movie_list/theme.dart';
import 'package:movie_list/watchlist_done_fragment.dart';
import 'package:movie_list/watchlist_unwatch_fragment.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dBlue,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 24),
          width: MySize.screenWidth,
          height: MySize.screenHeight,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Text(
                  'Watchlist',
                  style: menuTitle.copyWith(
                    fontSize: 32,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 48,
                  child: TabBar(
                    indicatorColor: accGreen,
                    labelColor: accGreen,
                    unselectedLabelColor: priBlue,
                    tabs: [
                      Tab(
                        text: 'Not Yet',
                      ),
                      Tab(
                        text: 'Done',
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      Center(
                        child: WatchlistUnFragment(),
                      ),
                      Center(
                        child: WatchlistDoneFragment(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
