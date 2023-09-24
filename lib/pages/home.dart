import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workouts_timer_app/controllers/activities_controller.dart';
import 'package:workouts_timer_app/controllers/workout_controller.dart';
import 'package:workouts_timer_app/pages/activities_page.dart';
import 'package:workouts_timer_app/pages/add_workout_page.dart';
import 'package:workouts_timer_app/pages/home_body_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  var currenIndex = 2.obs;

  @override
  Widget build(BuildContext context) {
    WorkoutController workController = Get.put(WorkoutController());
    ActivityController activityController = Get.put(ActivityController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Obx(
            () => IndexedStack(
              index: currenIndex.value,
              children: [
                const HomeBody(),
                AddWorkoutPage(),
                const ActivitiesPage()
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Workout',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: 'Activities',
              ),
            ],
            currentIndex: currenIndex.value,
            selectedItemColor: Colors.red,
            onTap: (int index) {
              currenIndex.value = index;
            },
          ),
        ));
  }
}
