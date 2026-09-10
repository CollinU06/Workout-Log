import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/workout.dart';
import 'package:to_dont_list/widgets/workout_tile.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class WorkoutList extends StatefulWidget {
  const WorkoutList({super.key});

  @override
  State createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  final List<Workout> workouts = [
    Workout(
        type: WorkoutType.run, name: "Morning run", distance: 3, minutes: 30),
    Workout(type: WorkoutType.lift, name: "Bench press", weight: 135, reps: 5),
    Workout(type: WorkoutType.practice, name: "Team practice", minutes: 90),
  ];

  void _handleDeleteWorkout(Workout workout) {
    setState(() {
      workouts.remove(workout);
    });
  }

  void _handleNewWorkout(String name, TextEditingController textController) {
    setState(() {
      Workout workout = Workout(type: WorkoutType.general, name: name);
      workouts.insert(0, workout);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Workout Log'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: workouts.map((workout) {
            return WorkoutTile(
              workout: workout,
              onDeleteWorkout: _handleDeleteWorkout,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToDoDialog(onListAdded: _handleNewWorkout);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Workout Log',
    home: WorkoutList(),
  ));
}