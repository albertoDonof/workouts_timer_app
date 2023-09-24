import 'package:hive/hive.dart';

part 'activity_model.g.dart';

@HiveType(typeId: 1)
class Activity extends HiveObject {
  @HiveField(0)
  int workoutsDone;
  @HiveField(1)
  int timeSpentWorking;
  @HiveField(2)
  DateTime dateWork;

  Activity(
    this.workoutsDone,
    this.timeSpentWorking,
    this.dateWork,
  );

  _updateActivity(int workDone, int timeSpentWork) {
    workoutsDone += workDone;
    timeSpentWorking += timeSpentWorking;
  }
}
