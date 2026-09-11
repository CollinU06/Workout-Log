import 'package:flutter/material.dart';
import 'package:to_dont_list/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/objects/workout.dart';
import 'package:to_dont_list/widgets/workout_tile.dart';

void main() {
  testWidgets('WorkoutTile shows the workout name', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: WorkoutTile(
      workout: Workout(
          type: WorkoutType.run,
          name: 'Morning run',
          distance: 3,
          minutes: 30),
      onDeleteWorkout: (Workout workout) {},
    ))));

    expect(find.text('Morning run'), findsOneWidget);
  });

  testWidgets('Tapping a WorkoutTile shows the details', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: WorkoutTile(
      workout: Workout(
          type: WorkoutType.run,
          name: 'Morning run',
          distance: 3,
          minutes: 30),
      onDeleteWorkout: (Workout workout) {},
    ))));

    expect(find.text('Pace: 10.0 min/mi'), findsNothing);

    await tester.tap(find.byType(ListTile));
    await tester.pump();

    expect(find.text('Pace: 10.0 min/mi'), findsOneWidget);
  });
  testWidgets('Dialog switches to weight and reps for a lift', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WorkoutList()));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("DistanceField")), findsOneWidget);

    await tester.tap(find.byKey(const Key("TypeDropdown")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Lift").last);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("WeightField")), findsOneWidget);
    expect(find.byKey(const Key("RepsField")), findsOneWidget);
  });

  testWidgets('Adding a run puts it in the list', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WorkoutList()));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key("NameField")), 'Evening run');
    await tester.enterText(find.byKey(const Key("DistanceField")), '2');
    await tester.enterText(find.byKey(const Key("MinutesField")), '20');
    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pumpAndSettle();

    expect(find.text('Evening run'), findsOneWidget);
  });
}