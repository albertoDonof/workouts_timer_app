import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workouts_timer_app/controllers/settings_controller.dart';
import 'package:workouts_timer_app/controllers/workout_controller.dart';
import 'package:workouts_timer_app/models/workout_model.dart';
import 'package:workouts_timer_app/pages/settings_page.dart';
import 'package:workouts_timer_app/pages/show_workout_page.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.find();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Expanded(
                  child: Text(
                    'Hi ' + settingsController.userName.value,
                    style: const TextStyle(fontSize: 35),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ),
              IconButton(
                iconSize: 35,
                splashRadius: 30,
                onPressed: () => Get.to(() => SettingsPage()),
                icon: const Icon(Icons.settings),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: const Text(
                  'Workouts',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                child: GetBuilder(
                  builder: (WorkoutController workController) {
                    return workController.getWorkouts().isEmpty
                        ? _buildEmptyShowWidget()
                        : Expanded(
                            child: ListView.builder(
                              itemCount: workController.getWorkouts().length,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildWorkoutCard(
                                    workController.getWorkouts()[index],
                                    workController,
                                    index);
                              },
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutCard(
      Workout workout, WorkoutController workoutController, int index) {
    return Card(
      color: workout.colorCard,
      child: ListTile(
        onTap: () =>
            {Get.to(() => ShowWorkoutPage(workout, workout.colorCard))},
        title: Text(workout.name.toString() + ' $index'),
        subtitle: Text(getTotalWorkoutTime(workout) + ' min'),
        trailing: IconButton(
            onPressed: () => {workoutController.deleteWorkout(workout)},
            icon: const Icon(Icons.delete_outline)),
      ),
    );
  }

  String getTotalWorkoutTime(Workout workout) {
    Duration durata = Duration(seconds: workout.timeWork) * workout.numeroSet +
        Duration(seconds: workout.timeRest) * workout.numeroSet;
    return durata.inMinutes.toString();
  }

  Widget _buildEmptyShowWidget() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
            'Lista vuota , non hai impostato ancora alcun workout , vai nella sezione Add Workout per inserirne uno'),
      ),
    );
  }
}
