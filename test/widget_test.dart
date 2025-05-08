import 'package:flutter_test/flutter_test.dart';
import 'package:white_tiles/main.dart';

void main() {
  testWidgets('WhiteTileApp has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const WhiteTileApp());

    expect(find.text('WhiteTile'), findsOneWidget);
  });
}
