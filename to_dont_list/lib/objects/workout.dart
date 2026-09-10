enum WorkoutType { run, bike, walk, lift, practice, general }

class Workout {
  final WorkoutType type;
  final String name;
  final double distance;
  final int minutes;
  final double weight;
  final int reps;

  Workout({
    required this.type,
    required this.name,
    this.distance = 0,
    this.minutes = 0,
    this.weight = 0,
    this.reps = 0,
  });

  bool get isDistanceBased {
    return type == WorkoutType.run ||
           type == WorkoutType.bike ||
           type == WorkoutType.walk;
  }

  double pace() {
    if (distance <= 0) return 0;
    return minutes / distance;
  }

  double volume() {
    return weight * reps;
  }

  double oneRepMax() {
    if (reps <= 0) return 0;
    return weight * (1 + reps / 30);
  }
}