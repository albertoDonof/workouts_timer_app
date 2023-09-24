import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/activity_model.dart';

class ActivityController extends GetxController {
  final List<Activity> _activities = [];

  late Box<Activity> activBox;

  late DateTime todayDate;

  ActivityController() {
    todayDate = DateTime.now();

    activBox = Hive.box<Activity>('activities');
    for (int i = 0; i < activBox.values.length; i++) {
      Activity actI = activBox.getAt(i) as Activity;
      _activities.add(actI);
    }
  }

  getMonthAndYear() {
    String date;
    switch (todayDate.month) {
      case 1:
        date = "January";
        break;
      case 2:
        date = "February";
        break;
      case 3:
        date = "March";
        break;
      case 4:
        date = "April";
        break;
      case 5:
        date = "May";
        break;
      case 6:
        date = "June";
        break;
      case 7:
        date = "July";
        break;
      case 8:
        date = "August";
        break;
      case 9:
        date = "September";
        break;
      case 10:
        date = "October";
        break;
      case 11:
        date = "November";
        break;
      case 12:
        date = "Dicember";
        break;
      default:
        date = "";
    }
    return date += " " + todayDate.year.toString();
  }

  addActivity(Activity activity) {
    _activities.add(activity);
    activBox.add(activity);
    update();
  }
}
