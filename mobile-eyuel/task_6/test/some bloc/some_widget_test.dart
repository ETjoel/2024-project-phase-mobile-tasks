import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_6/someBloc/some_bloc.dart';
import 'package:task_6/someBloc/some_widget.dart';

class MockCounterBloc extends MockBloc<CounterEvent, CounterState>
    implements CounterBloc {}

class MockCounterState extends Fake implements CounterState {}

void main() {
  late CounterBloc counterBloc;

  setUp(() {
    registerFallbackValue(MockCounterState());
    counterBloc = MockCounterBloc();
  });

  testWidgets('test if hello is there', (tester) async {
    when(() => counterBloc.state).thenReturn(CounterState(0));

    whenListen(
        counterBloc,
        Stream.fromIterable([
          CounterState(0),
          CounterState(1),
        ]));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: counterBloc,
          child: const SomeWidget(),
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    final hello = find.text('Hello');
    expect(hello, findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });
}
