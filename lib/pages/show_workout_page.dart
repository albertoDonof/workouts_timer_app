import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workouts_timer_app/controllers/workout_controller.dart';
import 'package:workouts_timer_app/models/timer_model.dart';
import 'package:workouts_timer_app/models/workout_model.dart';
import 'package:workouts_timer_app/pages/started_work_page.dart';

class ShowWorkoutPage extends StatelessWidget {
  final Workout workout;
  final Color coloreCard;

  const ShowWorkoutPage(this.workout, this.coloreCard, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WorkoutController workoutController = Get.find();
    TimerModel timerModel;
    var numeroSet = workout.numeroSet.obs;
    var workTime = workout.timeWork.obs;
    var restTime = workout.timeRest.obs;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (_) => editWorkoutDialog(context, numeroSet,
                              workTime, restTime, workoutController),
                          barrierDismissible: false,
                        )
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(43, 0, 40, 15),
                      child: Text(
                        workout.name,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      child: Column(
                        children: [
                          Card(
                            color: coloreCard,
                            child: SizedBox(
                              height: 85,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'SETS',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Obx(
                                      () => Text(
                                        'x' + numeroSet.value.toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Card(
                            color: coloreCard,
                            child: SizedBox(
                              height: 85,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'WORK',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Obx(
                                      () => Text(
                                        Duration(seconds: workTime.value)
                                            .toString()
                                            .substring(3, 7),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Card(
                            color: coloreCard,
                            child: SizedBox(
                              height: 85,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'REST',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Obx(
                                      () => Text(
                                        Duration(seconds: restTime.value)
                                            .toString()
                                            .substring(3, 7),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Obx(
                              () => Text(
                                '= ' +
                                    getTotalWorkoutTime(
                                            numeroSet, workTime, restTime)
                                        .substring(2, 7) +
                                    ' minuti',
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              child: const Text(
                                'START',
                                style: TextStyle(fontSize: 24),
                              ),
                              onPressed: () => {
                                timerModel =
                                    TimerModel(workout, ButtonState.initial),
                                Get.to(() => StartedPage(timerModel))
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTotalWorkoutTime(RxInt numSet, RxInt workTime, RxInt restTime) {
    Duration durata = Duration(seconds: workTime.value) * numSet.value +
        Duration(seconds: restTime.value) * numSet.value;
    return durata.toString();
  }

  AlertDialog editWorkoutDialog(BuildContext context, RxInt numSet,
          RxInt workTime, RxInt restTime, WorkoutController workContr) =>
      AlertDialog(
        title: const Text('Edit the workout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sets'),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => {if (numSet.value > 1) numSet.value--},
                        icon: const Icon(Icons.remove),
                      ),
                      Obx(() => Text('   x' + numSet.value.toString())),
                      IconButton(
                        onPressed: () =>
                            {if (numSet.value < 25) numSet.value++},
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Work Time'),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            {if (workTime.value > 5) workTime.value -= 5},
                        icon: const Icon(Icons.remove),
                      ),
                      Obx(
                        () => Text(Duration(seconds: workTime.value)
                            .toString()
                            .substring(3, 7)),
                      ),
                      IconButton(
                        onPressed: () =>
                            {if (workTime.value < 300) workTime.value += 5},
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Rest Time'),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            {if (restTime.value > 5) restTime.value -= 5},
                        icon: const Icon(Icons.remove),
                      ),
                      Obx(
                        () => Text(Duration(seconds: restTime.value)
                            .toString()
                            .substring(3, 7)),
                      ),
                      IconButton(
                        onPressed: () =>
                            {if (restTime.value < 300) restTime.value += 5},
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => {
                    numSet.value = workout.numeroSet,
                    workTime.value = workout.timeWork,
                    restTime.value = workout.timeRest,
                    Navigator.pop(context)
                  },
              child: const Text(
                'Cancel',
                textAlign: TextAlign.end,
              )),
          TextButton(
              onPressed: () => {
                    workContr.updateWorkout(
                        workout, numSet.value, workTime.value, restTime.value),
                    Navigator.pop(context)
                  },
              child: const Text(
                'Update',
                textAlign: TextAlign.end,
              ))
        ],
      );
}
