// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workouts_timer_app/controllers/workout_controller.dart';
import 'package:workouts_timer_app/models/workout_model.dart';

int indiceWorkoutColore = 0;

class AddWorkoutPage extends StatelessWidget {
  AddWorkoutPage({Key? key}) : super(key: key);

  var setState = 3.obs;
  var workTimeState = const Duration(seconds: 30).obs;
  var restTimeState = const Duration(seconds: 30).obs;

  var textController = TextEditingController().obs;
  var validateEmpty = false.obs;
  var validatePresente = false.obs;

  _getTotalTime() {
    return workTimeState.value * setState.value +
        restTimeState.value * setState.value;
  }

  final colorsList = [
    const Color(0xffE5F1B6),
    const Color(0xffC0DBE7),
    const Color(0xffE7C0C0),
    const Color(0xffECC6E3)
  ];

  Color getCardColor(int index) {
    if (index % 2 == 0) {
      Random random = Random();
      int randomNumber = random.nextInt(2);
      return colorsList[randomNumber];
    } else {
      Random random = Random();
      int randomNumber = random.nextInt(2) + 2;
      return colorsList[randomNumber];
    }
  }

  _addWorkoutToContr(WorkoutController workController) {
    String nome = textController.value.text;
    final workControllo = workController.controlloWorkout(nome);
    if (nome != '') {
      validateEmpty.value = false;
      if (workControllo == false) {
        validatePresente.value = false;
        final workout = Workout(
            nome,
            setState.value,
            workTimeState.value.inSeconds,
            restTimeState.value.inSeconds,
            getCardColor(indiceWorkoutColore));
        indiceWorkoutColore += 1;
        workController.addWorkout(workout);
      } else {
        validatePresente.value = true;
      }
    } else {
      validateEmpty.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    WorkoutController workController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Add a Workout',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 25),
                    child: Obx(
                      () => TextField(
                        controller: textController.value,
                        decoration: InputDecoration(
                          hintText: 'Name the Workout',
                          errorText: validateEmpty.value
                              ? 'Workout Name can\'t be empty'
                              : validatePresente.value
                                  ? 'Workout yet in list'
                                  : null,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    child: Column(
                      children: [
                        Card(
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
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () => {
                                                if (setState.value > 1)
                                                  setState.value--
                                              },
                                          iconSize: 20,
                                          icon: const Icon(Icons.remove)),
                                      Obx(
                                        () => Text(
                                          'x' + setState.value.toString(),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () => {
                                                if (setState.value < 25)
                                                  setState.value++
                                              },
                                          iconSize: 20,
                                          icon: const Icon(Icons.add)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Card(
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
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () => {
                                                if (workTimeState
                                                        .value.inSeconds >
                                                    5)
                                                  workTimeState.value -=
                                                      const Duration(seconds: 5)
                                              },
                                          iconSize: 20,
                                          icon: const Icon(Icons.remove)),
                                      Obx(
                                        () => Text(
                                          workTimeState
                                              .toString()
                                              .substring(3, 7),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () => {
                                                if (workTimeState
                                                        .value.inMinutes <
                                                    5)
                                                  workTimeState.value +=
                                                      const Duration(seconds: 5)
                                              },
                                          iconSize: 20,
                                          icon: const Icon(Icons.add)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Card(
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
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () => {
                                                if (restTimeState
                                                        .value.inSeconds >
                                                    5)
                                                  restTimeState.value -=
                                                      const Duration(seconds: 5)
                                              },
                                          iconSize: 20,
                                          icon: const Icon(Icons.remove)),
                                      Obx(
                                        () => Text(
                                          restTimeState
                                              .toString()
                                              .substring(3, 7),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () => {
                                                if (restTimeState
                                                        .value.inMinutes <
                                                    5)
                                                  restTimeState.value +=
                                                      const Duration(seconds: 5)
                                              },
                                          iconSize: 20,
                                          icon: const Icon(Icons.add)),
                                    ],
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
                                  _getTotalTime().toString().substring(2, 7) +
                                  ' minuti',
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            child: const Text('SAVE'),
                            onPressed: () {
                              _addWorkoutToContr(workController);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
