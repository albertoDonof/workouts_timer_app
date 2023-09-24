import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  late Box settingsBox;

  final darkModeKey = "isDarkMode";
  var isDarkMode = false.obs;

  final soundOnKey = "soundOn";
  var soundOn = true.obs;

  final userNameKey = "userName";
  var userNameController = TextEditingController().obs;
  var userName = "".obs;
  var validateName = false.obs;

  SettingsController() {
    settingsBox = Hive.box('settings');

    soundOn.value = isSavedSoundOn();
    userName.value = getUserName();
  }

  ThemeMode getThemeMode() {
    if (isSavedDarkMode()) {
      isDarkMode.value = true;
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  bool isSavedDarkMode() {
    return settingsBox.get(darkModeKey) ?? false;
  }

  void saveThemeMode(bool isDark) {
    isDark ? isDarkMode.value = true : isDarkMode.value = false;
    settingsBox.put(darkModeKey, isDark);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSavedDarkMode());
  }

  bool isSavedSoundOn() {
    return settingsBox.get(soundOnKey) ?? true;
  }

  void changeSoundOn() {
    if (soundOn.value) {
      soundOn.value = false;
    } else {
      soundOn.value = true;
    }
    settingsBox.put(soundOnKey, soundOn.value);
  }

  String getUserName() {
    return settingsBox.get(userNameKey, defaultValue: "");
  }

  void saveUserName(String username) {
    userName.value = username;
    settingsBox.put(userNameKey, username);
  }
}
