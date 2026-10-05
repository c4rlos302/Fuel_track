import 'package:flutter_test/flutter_test.dart';

import 'package:fuel_track/app/app.dart';

void main() {
  testWidgets('FuelTrack inicia correctamente', (tester) async {
    await tester.pumpWidget(
      const FuelTrackApp(),
    );

    expect(find.text('FuelTrack'), findsOneWidget);
  });
}