import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:workouts_timer_app/controllers/settings_controller.dart';
import 'package:workouts_timer_app/controllers/workout_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final SettingsController settingsController = Get.find();
  final WorkoutController workContr = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: TextButton(
                          onPressed: () => Get.back(),
                          child: Row(
                            children: const [
                              Icon(Icons.arrow_back),
                              Text('Home'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Center(
                      child: Text(
                    'Settings',
                    style: TextStyle(fontSize: 22),
                  ))
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    const ListTile(
                      title: Center(child: Text('Easy Workout App')),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      title: const Text('Username:'),
                      subtitle: Obx(
                        () => Text(
                          settingsController.userName.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      trailing: TextButton(
                          onPressed: () => {_createDialog()},
                          child: const Text('Change')),
                    ),
                    const Divider(),
                    Obx(
                      () => SwitchListTile(
                        value: settingsController.isDarkMode.value,
                        onChanged: (bool newValue) =>
                            {settingsController.changeThemeMode()},
                        title: const Text('Dark Mode'),
                        secondary: const Icon(Icons.mode_night_rounded),
                      ),
                    ),
                    const Divider(),
                    Obx(
                      () => SwitchListTile(
                        value: settingsController.soundOn.value,
                        onChanged: (bool newValue) =>
                            settingsController.changeSoundOn(),
                        title: const Text('Enable Sound'),
                        secondary: const Icon(Icons.audiotrack),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Terms & Policies'),
                      leading: const Icon(Icons.description),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => {},
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Report a Bug'),
                      leading: const Icon(Icons.bug_report),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => {
                        launchUrlString(
                            'mailto:smith@example.org?subject=Report a Bug&body=Description:'),
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Delete all saved Workouts'),
                      onTap: () => Get.defaultDialog(
                          onWillPop: () async => false,
                          titlePadding: const EdgeInsets.all(20),
                          title: 'Delete all saved workouts',
                          middleText:
                              'You will not be able to retrieve the deleted workouts. Proceed?',
                          textCancel: 'Back',
                          textConfirm: 'Delete',
                          onConfirm: () => {
                                workContr.deleteAllWorkouts(),
                                Get.back(),
                                Get.snackbar(
                                  "All workouts deleted",
                                  "",
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                  margin: const EdgeInsets.all(10),
                                  snackPosition: SnackPosition.BOTTOM,
                                ),
                              }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createDialog() {
    Get.defaultDialog(
        onWillPop: () async => false,
        title: 'Change Username',
        content: Column(
          children: [
            Text(
              "Please change your username.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Obx(() => TextField(
                    controller: settingsController.userNameController.value,
                    maxLength: 15,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        filled: true,
                        fillColor: Colors.orange.withOpacity(0.2),
                        hintText: 'Username',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                  )),
            ),
          ],
        ),
        cancel: SizedBox(
          child: ElevatedButton(
            onPressed: () => {
              Get.back(),
              settingsController.userNameController.value.text =
                  settingsController.userName.value,
            },
            child: const Text('Cancel'),
          ),
        ),
        confirm: SizedBox(
          child: ElevatedButton(
            onPressed: () => {_addUserName(settingsController)},
            child: const Text('Confirm'),
          ),
        ));
  }

  _addUserName(SettingsController settingsController) {
    final username = settingsController.userNameController.value.text;
    if (username != "") {
      settingsController.saveUserName(username);
      Get.back();
    } else {
      settingsController.validateName.value = true;
    }
  }
}
