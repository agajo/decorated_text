import 'package:decorated_text/decorated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('error if fillColor and fillGradient are not null',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: DecoratedText(
      'hoge',
      fillColor: Colors.black,
      fillGradient: LinearGradient(colors: [Colors.blue, Colors.red]),
    )));
    expect(tester.takeException(), isInstanceOf<StateError>());
  });
}
