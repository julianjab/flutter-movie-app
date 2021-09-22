import 'package:flutter/material.dart';
import 'package:flutter_movies_app/src/presentation/widgets/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';

Future<void> makeTestableWidget(WidgetTester tester, Widget widget) =>
    mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(home: widget)));

void main() {
  setUp(() {
    initializeDateFormatting('es_US');
  });

  group('MovieWidget', () {
    testWidgets(
      'should contains the movie title',
      (WidgetTester tester) async {
        await makeTestableWidget(
          tester,
          MovieWidget(
            title: 'Movie title',
            releaseDate: DateTime(2020),
            posterImage:
                'https://logowik.com/content/uploads/images/flutter5786.jpg',
          ),
        );

        expect(find.text('Movie title'), findsOneWidget);
      },
    );

    testWidgets(
      'should contains the movie poster image',
      (WidgetTester tester) async {
        await makeTestableWidget(
          tester,
          MovieWidget(
            title: 'Movie title',
            releaseDate: DateTime(2020),
            posterImage:
                'https://logowik.com/content/uploads/images/flutter5786.jpg',
          ),
        );
        expect(find.byKey(const Key('image')), findsOneWidget);
      },
    );

    testWidgets(
      'should contains the movie release date with format {dia} de {mes} del {año}',
      (WidgetTester tester) async {
        await makeTestableWidget(
          tester,
          MovieWidget(
            title: 'Movie title',
            releaseDate: DateTime(2021, 9, 21),
            posterImage:
                'https://logowik.com/content/uploads/images/flutter5786.jpg',
          ),
        );

        expect(find.text('21 de septiembre del 2021'), findsOneWidget);
      },
    );
  });
}
