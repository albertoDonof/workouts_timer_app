import 'workout_model.dart';

enum ButtonState { initial, started, paused }

class TimerModel {
  final Workout workout;
  ButtonState buttonState;
  late int rimaste;

  TimerModel(this.workout, this.buttonState) {
    rimaste = workout.numeroSet;
  }

  bool sonoFinite() {
    return rimaste == 0;
  }

  int getWorkSeconds() {
    rimaste--;
    return workout.timeWork;
  }

  int getRestSeconds() {
    return workout.timeRest;
  }
}
