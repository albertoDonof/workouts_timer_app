import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workouts_timer_app/config/themes.dart';
import 'package:workouts_timer_app/controllers/settings_controller.dart';
import 'package:workouts_timer_app/models/activity_model.dart';
import 'package:workouts_timer_app/models/workout_model.dart';

import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  Hive.registerAdapter<Activity>(ActivityAdapter());
  Hive.registerAdapter<Color>(ColorAdapter());
  Hive.registerAdapter<Workout>(WorkoutAdapter());
  await Hive.openBox('settings');
  await Hive.openBox<Workout>('workouts');
  await Hive.openBox<Activity>('activities');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.put(SettingsController());
    return GetMaterialApp(
      title: 'Easy Workout App',
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: settingsController.getThemeMode(),
      home: HomePage(),
      onReady: () {
        //settingsController.userName.value = "";
        if (settingsController.userName.value == "") {
          Get.defaultDialog(
            onWillPop: () async => false,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            title: "Hey! Welcome",
            titleStyle: const TextStyle(fontSize: 24),
            content: Column(
              children: [
                Text(
                  "Please set your username for the app.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Obx(() => TextField(
                      controller: settingsController.userNameController.value,
                      decoration: InputDecoration(
                          hintText: 'Username',
                          errorText: settingsController.validateName.value
                              ? 'Username must be max. 15 characters'
                              : null),
                    )),
              ],
            ),
            confirm: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () => {_addUserName(settingsController)},
                  child: const Text("Get Started")),
            ),
          );
        }
      },
    );
  }

  _addUserName(SettingsController settingsController) {
    final username = settingsController.userNameController.value.text;
    if (username != "") {
      if (username.length <= 15) {
        settingsController.saveUserName(username);
        Get.back();
      } else {
        settingsController.validateName.value = true;
      }
    }
  }
}
