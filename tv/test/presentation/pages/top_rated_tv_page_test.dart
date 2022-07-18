import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/dummy_objects.dart';

class MockTopRatedTvShowsBloc extends MockBloc<TopRatedTvShowsEvent, TopRatedTvShowsState> implements TopRatedTvShowsBloc {}

class TopRatedTvShowsEventFake extends Fake implements TopRatedTvShowsEvent {}

class TopRatedTvShowsStateFake extends Fake implements TopRatedTvShowsState {}

@GenerateMocks([TopRatedTvShowsBloc])
void main() {
  late MockTopRatedTvShowsBloc mockTopRatedTvShowsBloc;

  setUp(() {
    mockTopRatedTvShowsBloc = MockTopRatedTvShowsBloc();
  });

  setUpAll(() {
    registerFallbackValue(TopRatedTvShowsEventFake());
    registerFallbackValue(TopRatedTvShowsStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvShowsBloc>.value(
      value: mockTopRatedTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockTopRatedTvShowsBloc.state).thenReturn(TopRatedTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockTopRatedTvShowsBloc.state).thenReturn(TopRatedTvShowsHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockTopRatedTvShowsBloc.state).thenReturn(const TopRatedTvShowsError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
