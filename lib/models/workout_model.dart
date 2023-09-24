import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';

part 'workout_model.g.dart';

@HiveType(typeId: 0)
class Workout extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int numeroSet;
  @HiveField(5)
  int timeWork;
  @HiveField(6)
  int timeRest;
  @HiveField(4)
  Color colorCard;

  Workout(
    this.name,
    this.numeroSet,
    this.timeWork,
    this.timeRest,
    this.colorCard,
  );

  Duration getTimeWork() {
    return Duration(seconds: timeWork);
  }

  Duration getTimeRest() {
    return Duration(seconds: timeRest);
  }

  updateWorkout(String name, int numeroSet, int timeWork, int timeRest) {
    this.name = name;
    this.numeroSet = numeroSet;
    this.timeWork = timeWork;
    this.timeRest = timeRest;
  }
}

class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) => Color(reader.readInt());

  @override
  void write(BinaryWriter writer, Color obj) => writer.writeInt(obj.value);

  @override
  int get typeId => 200;
}
