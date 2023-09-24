import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/workout_model.dart';

class WorkoutController extends GetxController {
  final List<Workout> _workouts = [];

  late Box<Workout> workBox;

  WorkoutController() {
    workBox = Hive.box<Workout>('workouts');

    for (int i = 0; i < workBox.values.length; i++) {
      Workout workI = workBox.getAt(i) as Workout;
      _workouts.add(workI);
    }
  }

  List<Workout> getWorkouts() => _workouts;

  bool controlloWorkout(String nome) {
    for (Workout work in _workouts) {
      if (work.name == nome) return true;
    }
    return false;
  }

  addWorkout(Workout workout) {
    _workouts.add(workout);
    workBox.add(workout);
    update();
  }

  updateWorkout(Workout oldWork, int numSet, int timeWork, int timeRest) {
    int index = _workouts.indexOf(oldWork);
    _workouts[index]
        .updateWorkout(_workouts[index].name, numSet, timeWork, timeRest);
    workBox.putAt(index, _workouts[index]);
    update();
  }

  deleteWorkout(Workout workout) {
    int index = _workouts.indexOf(workout);
    workBox.deleteAt(index);
    _workouts.removeAt(index);
    update();
  }

  deleteAllWorkouts() {
    if (workBox.isNotEmpty) {
      _workouts.clear();
      workBox.clear();
    }
    update();
  }
}
