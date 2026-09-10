import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/workout.dart';

typedef WorkoutDeletedCallback = Function(Workout workout);

class WorkoutTile extends StatefulWidget {
  WorkoutTile({
    required this.workout,
    required this.onDeleteWorkout,
  }) : super(key: ObjectKey(workout));

  final Workout workout;
  final WorkoutDeletedCallback onDeleteWorkout;

  @override
  State<WorkoutTile> createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {
  bool expanded = false;

  IconData typeIcon() {
    if (widget.workout.type == WorkoutType.run) {
      return Icons.directions_run;
    } else if (widget.workout.type == WorkoutType.bike) {
      return Icons.directions_bike;
    } else if (widget.workout.type == WorkoutType.walk) {
      return Icons.directions_walk;
    } else if (widget.workout.type == WorkoutType.lift) {
      return Icons.fitness_center;
    } else if (widget.workout.type == WorkoutType.practice) {
      return Icons.sports_basketball;
    } else {
      return Icons.local_fire_department;
    }
  }

  String statLine() {
    if (widget.workout.isDistanceBased) {
      return "${widget.workout.distance} mi";
    } else if (widget.workout.type == WorkoutType.lift) {
      return "${widget.workout.reps} reps";
    } else {
      return "${widget.workout.minutes} min";
    }
  }

  Widget detailBox() {
    if (widget.workout.isDistanceBased) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Distance: ${widget.workout.distance} mi"),
          Text("Time: ${widget.workout.minutes} min"),
          Text("Pace: ${widget.workout.pace().toStringAsFixed(1)} min/mi"),
        ],
      );
    } else if (widget.workout.type == WorkoutType.lift) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Weight: ${widget.workout.weight} lb"),
          Text("Reps: ${widget.workout.reps}"),
          Text("Volume: ${widget.workout.volume()} lb"),
          Text("Est. 1RM: ${widget.workout.oneRepMax().toStringAsFixed(1)} lb"),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Time: ${widget.workout.minutes} min"),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                expanded = false;
              });
            },
            leading: CircleAvatar(child: Icon(typeIcon())),
            title: Text(widget.workout.name),
            subtitle: Text(statLine()),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.onDeleteWorkout(widget.workout);
              },
            ),
          ),
          detailBox(),
        ],
      );
    } else {
      return ListTile(
        onTap: () {
          setState(() {
            expanded = true;
          });
        },
        leading: CircleAvatar(child: Icon(typeIcon())),
        title: Text(widget.workout.name),
        subtitle: Text(statLine()),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            widget.onDeleteWorkout(widget.workout);
          },
        ),
      );
    }
  }
}