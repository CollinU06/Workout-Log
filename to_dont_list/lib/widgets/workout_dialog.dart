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
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  WorkoutType selectedType = WorkoutType.run;

  bool isDistanceType() {
    return selectedType == WorkoutType.run ||
        selectedType == WorkoutType.bike ||
        selectedType == WorkoutType.walk;
  }

  int readInt(TextEditingController controller) {
    int? value = int.tryParse(controller.text);
    if (value == null) {
      return 0;
    } else {
      return value;
    }
  }

  double readDouble(TextEditingController controller) {
    double? value = double.tryParse(controller.text);
    if (value == null) {
      return 0;
    } else {
      return value;
    }
  }

  Widget nameField() {
    return TextField(
      key: const Key("NameField"),
      controller: _nameController,
      decoration: const InputDecoration(labelText: "Workout name"),
    );
  }

  Widget numberField(
      TextEditingController controller, String label, String keyName) {
    return TextField(
      key: Key(keyName),
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget typeDropdown() {
    return DropdownButton<WorkoutType>(
      key: const Key("TypeDropdown"),
      value: selectedType,
      isExpanded: true,
      items: const [
        DropdownMenuItem(value: WorkoutType.run, child: Text("Run")),
        DropdownMenuItem(value: WorkoutType.bike, child: Text("Bike")),
        DropdownMenuItem(value: WorkoutType.walk, child: Text("Walk")),
        DropdownMenuItem(value: WorkoutType.lift, child: Text("Lift")),
        DropdownMenuItem(value: WorkoutType.practice, child: Text("Practice")),
        DropdownMenuItem(value: WorkoutType.general, child: Text("General")),
      ],
      onChanged: (WorkoutType? newType) {
        setState(() {
          if (newType != null) {
            selectedType = newType;
          }
        });
      },
    );
  }

  List<Widget> buildFields() {
    if (isDistanceType()) {
      return [
        nameField(),
        typeDropdown(),
        numberField(_distanceController, "Distance (miles)", "DistanceField"),
        numberField(_minutesController, "Minutes", "MinutesField"),
      ];
    } else if (selectedType == WorkoutType.lift) {
      return [
        nameField(),
        typeDropdown(),
        numberField(_weightController, "Weight (lb)", "WeightField"),
        numberField(_repsController, "Reps", "RepsField"),
      ];
    } else {
      return [
        nameField(),
        typeDropdown(),
        numberField(_minutesController, "Minutes", "MinutesField"),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Workout'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: buildFields(),
        ),
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
              distance: readDouble(_distanceController),
              minutes: readInt(_minutesController),
              weight: readDouble(_weightController),
              reps: readInt(_repsController),
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