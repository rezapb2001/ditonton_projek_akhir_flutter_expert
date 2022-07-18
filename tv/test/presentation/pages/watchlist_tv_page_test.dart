import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/dummy_objects.dart';

class MockWatchlistTvShowsBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState> implements WatchlistTvBloc {}

class WatchlistTvShowsEventFake extends Fake implements WatchlistTvEvent {}

class WatchlistTvShowsStateFake extends Fake implements WatchlistTvState {}

@GenerateMocks([WatchlistTvBloc])
void main() {
  late MockWatchlistTvShowsBloc mockWatchlistTvShowsBloc;

  setUp(() {
    mockWatchlistTvShowsBloc = MockWatchlistTvShowsBloc();
  });

  setUpAll(() {
    registerFallbackValue(WatchlistTvShowsEventFake());
    registerFallbackValue(WatchlistTvShowsStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockWatchlistTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockWatchlistTvShowsBloc.state).thenReturn(WatchlistTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockWatchlistTvShowsBloc.state).thenReturn(WatchlistTvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockWatchlistTvShowsBloc.state).thenReturn(const WatchlistTvError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
