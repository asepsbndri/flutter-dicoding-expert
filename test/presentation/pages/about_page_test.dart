import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('AboutPage should display logo, text and back button',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget( AboutPage()));

    expect(find.byType(Image), findsOneWidget);

    expect(
      find.textContaining('Ditonton merupakan sebuah aplikasi katalog film'),
      findsOneWidget,
    );

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('Back button should pop the page',
      (WidgetTester tester) async {
    final testKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: testKey,
        home:  AboutPage(),
      ),
    );

    expect(find.byType(AboutPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsNothing);
  });
}
