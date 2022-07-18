import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../dummy_data/tv/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class TvDetailStateFake extends Fake implements TvDetailState {}

class MockTvRecommendationsBloc
    extends MockBloc<TvRecommendationsEvent, TvRecommendationsState>
    implements TvRecommendationsBloc {}

class TvRecommendationsEventFake extends Fake
    implements TvRecommendationsEvent {}

class TvRecommendationsStateFake extends Fake
    implements TvRecommendationsState {}

class MockWatchlistTvShowsBloc
    extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

class WatchlistTvShowsEventFake extends Fake implements WatchlistTvEvent {}

class WatchlistTvShowsStateFake extends Fake implements WatchlistTvState {}

@GenerateMocks([TvDetailBloc])
void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockWatchlistTvShowsBloc mockWatchlistTvShowsBloc;

  setUpAll(() {
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvDetailStateFake());
    registerFallbackValue(TvRecommendationsEventFake());
    registerFallbackValue(TvRecommendationsStateFake());
    registerFallbackValue(WatchlistTvShowsEventFake());
    registerFallbackValue(WatchlistTvShowsStateFake());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockWatchlistTvShowsBloc = MockWatchlistTvShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(create: (context) => mockTvDetailBloc),
        BlocProvider<TvRecommendationsBloc>(
            create: (context) => mockTvRecommendationsBloc),
        BlocProvider<WatchlistTvBloc>(
            create: (context) => mockWatchlistTvShowsBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvRecommendationsHasData(testTvList));
    when(() => mockWatchlistTvShowsBloc.state)
        .thenReturn(const WatchlistTvStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvRecommendationsHasData(testTvList));
    when(() => mockWatchlistTvShowsBloc.state).thenReturn(const WatchlistTvStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
