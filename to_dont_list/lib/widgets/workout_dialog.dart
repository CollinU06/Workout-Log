import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/workout.dart';

typedef WorkoutAddedCallback = Function(Workout workout);

class WorkoutDialog extends StatefulWidget {
  const WorkoutDialog({
    super.key,
    required this.onWorkoutAdded,
  });

  final WorkoutAddedCallback onWorkoutAdded;

  @override
  State<WorkoutDialog> createState() => _WorkoutDialogState();
}

class _WorkoutDialogState extends State<WorkoutDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();

  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  WorkoutType selectedType = WorkoutType.run;

  int readMinutes() {
    int? value = int.tryParse(_minutesController.text);
    if (value == null) {
      return 0;
    } else {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Workout'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key("NameField"),
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Workout name"),
          ),
          TextField(
            key: const Key("MinutesField"),
            controller: _minutesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Minutes"),
          ),
          DropdownButton<WorkoutType>(
            key: const Key("TypeDropdown"),
            value: selectedType,
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: WorkoutType.run, child: Text("Run")),
              DropdownMenuItem(value: WorkoutType.bike, child: Text("Bike")),
              DropdownMenuItem(value: WorkoutType.walk, child: Text("Walk")),
              DropdownMenuItem(value: WorkoutType.lift, child: Text("Lift")),
              DropdownMenuItem(
                  value: WorkoutType.practice, child: Text("Practice")),
              DropdownMenuItem(
                  value: WorkoutType.general, child: Text("General")),
            ],
            onChanged: (WorkoutType? newType) {
              setState(() {
                if (newType != null) {
                  selectedType = newType;
                }
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("OKButton"),
          style: yesStyle,
          child: const Text('OK'),
          onPressed: () {
            widget.onWorkoutAdded(Workout(
              type: selectedType,
              name: _nameController.text,
              minutes: readMinutes(),
            ));
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}