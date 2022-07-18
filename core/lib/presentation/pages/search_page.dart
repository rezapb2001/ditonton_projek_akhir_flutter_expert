import 'package:flutter/material.dart';
import 'package:tv/tv.dart';
import 'package:movie/movie.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/searchPage';

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  _buildCardMovie(context),
                  const SizedBox(height: 5.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Divider(color: Colors.grey),
                  ),
                  const SizedBox(height: 5.0),
                  _buildCardTv(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardMovie(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        height: 95,
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 15),
              height: 75,
              width: 90,
              child:
                  const Icon(Icons.movie, color: Colors.yellowAccent, size: 50),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Search Movies',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, SearchMoviePage.routeName);
      },
    );
  }

  Widget _buildCardTv(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        height: 95,
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 15),
              height: 75,
              width: 90,
              child: const Icon(Icons.live_tv,
                  color: Colors.yellowAccent, size: 50),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Search Tv Series',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, SearchTvPage.routeName);
      },
    );
  }
}
