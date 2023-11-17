import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:the_movie_db/src/presentation/widget/loader_image.dart';

import '../../Mock/mock_movie.dart';

void main() {
  const int numberWidget = 2;
  group(
    'Test Loader Image',
    () {
      testWidgets(
        'The film is for all age, find only one widget',
        (
          WidgetTester widgetTester,
        ) async {
          await mockNetworkImages(
            () async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: LoaderImage(
                    forAdults: false,
                    image: MockMovies.mockMovie.getThumbnail(),
                  ),
                ),
              );
              expect(
                find.byType(Image),
                findsOneWidget,
              );
            },
          );
        },
      );
      testWidgets('The movie is for adult, find two image widget',
          (WidgetTester widgetTester) async {
        await mockNetworkImages(
          () async {
            await widgetTester.pumpWidget(
              MaterialApp(
                home: LoaderImage(
                  forAdults: true,
                  image: MockMovies.mockMovie.getThumbnail(),
                ),
              ),
            );
            expect(
              find.byType(Image),
              findsNWidgets(numberWidget),
            );
          },
        );
      });
    },
  );
}
