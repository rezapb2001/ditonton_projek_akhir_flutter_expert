import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/dummy_objects.dart';


class MockPopularTvShowsBloc extends MockBloc<PopularTvShowsEvent, PopularTvShowsState> implements PopularTvShowsBloc {}

class PopularTvShowsEventFake extends Fake implements PopularTvShowsEvent {}

class PopularTvShowsStateFake extends Fake implements PopularTvShowsState {}

@GenerateMocks([PopularTvShowsBloc])
void main() {
  late MockPopularTvShowsBloc mockPopularTvShowsBloc;

  setUp(() {
    mockPopularTvShowsBloc = MockPopularTvShowsBloc();
  });

  setUpAll(() {
    registerFallbackValue(PopularTvShowsEventFake());
    registerFallbackValue(PopularTvShowsStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvShowsBloc>.value(
      value: mockPopularTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state).thenReturn(PopularTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state).thenReturn(PopularTvShowsHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state).thenReturn(const PopularTvShowsError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
