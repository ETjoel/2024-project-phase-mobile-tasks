import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_6/features/ecommerce/presentation/widgets/widget.dart';

void main() {
  testWidgets('test if there is user info in app bar in homepage',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
      body: UserInfo(),
    )));

    final userName = find.text('Yohannes');
    final date = find.text('July 14, 2023');
    final hello = find.text('Hello');

    expect(userName, findsOneWidget);
    expect(date, findsOneWidget);
    expect(hello, findsOneWidget);
  });
}
