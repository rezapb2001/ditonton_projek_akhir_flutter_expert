import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
      context.read<PopularMoviesBloc>().add(FetchPopularMovies());
      context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
      context.read<TvOnTheAirBloc>().add(FetchTvOnTheAir());
      context.read<PopularTvShowsBloc>().add(FetchPopularTvShows());
      context.read<TopRatedTvShowsBloc>().add(FetchTopRatedTvShows());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.live_tv),
              title: const Text('Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, HomeTvPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing Movie',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is NowPlayingMoviesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              const SizedBox(height: 5.0),
              _buildSubHeading(
                title: 'Popular Movie',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is PopularMoviesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              const SizedBox(height: 5.0),
              _buildSubHeading(
                title: 'Top Rated Movie',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is TopRatedMoviesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              const SizedBox(height: 5.0),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(color: Colors.grey),
              ),
              const SizedBox(height: 5.0),
              Text(
                'On Air Tv Series',
                style: kHeading6,
              ),
              BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
                builder: (context, state) {
                  if (state is TvOnTheAirLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvOnTheAirHasData) {
                    return TvList(state.result);
                  } else if (state is TvOnTheAirError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              const SizedBox(height: 5.0),
              _buildSubHeading(
                title: 'Popular Tv Series',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.routeName),
              ),
              BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
                builder: (context, state) {
                  if (state is PopularTvShowsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvShowsHasData) {
                    return TvList(state.result);
                  } else if (state is PopularTvShowsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              const SizedBox(height: 5.0),
              _buildSubHeading(
                title: 'Top Rated Tv Series',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.routeName),
              ),
              BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
                builder: (context, state) {
                  if (state is TopRatedTvShowsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvShowsHasData) {
                    return TvList(state.result);
                  } else if (state is TopRatedTvShowsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList(this.tvs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.routeName,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
