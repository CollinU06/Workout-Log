import 'package:flutter/material.dart';
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
}