import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/objects/workout.dart';

void main() {
  group('pace', () {
    test('returns minutes per mile', () {
      final run = Workout(
        type: WorkoutType.run,
        name: 'Morning run',
        distance: 3,
        minutes: 30,
      );
      expect(run.pace(), 10.0);
    });

    test('returns 0 when distance is 0', () {
      final run = Workout(
        type: WorkoutType.run,
        name: 'Treadmill',
        minutes: 30,
      );
      expect(run.pace(), 0);
    });
  });

  group('volume', () {
    test('is weight times reps', () {
      final lift = Workout(
        type: WorkoutType.lift,
        name: 'Bench press',
        weight: 135,
        reps: 5,
      );
      expect(lift.volume(), 675);
    });
  });

  group('oneRepMax', () {
    test('estimates a max from a multi-rep set', () {
      final lift = Workout(
        type: WorkoutType.lift,
        name: 'Bench press',
        weight: 135,
        reps: 5,
      );
      expect(lift.oneRepMax(), closeTo(157.5, 0.01));
    });

    test('returns 0 when there are no reps', () {
      final lift = Workout(
        type: WorkoutType.lift,
        name: 'Deadlift',
        weight: 200,
      );
      expect(lift.oneRepMax(), 0);
    });
  });

  group('isDistanceBased', () {
    test('is true for a run', () {
      final run = Workout(type: WorkoutType.run, name: 'Morning run');
      expect(run.isDistanceBased, true);
    });

    test('is false for a lift', () {
      final lift = Workout(type: WorkoutType.lift, name: 'Bench press');
      expect(lift.isDistanceBased, false);
    });
  });
}