import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workouts_timer_app/controllers/activities_controller.dart';
import 'package:workouts_timer_app/widgets/work_calendar.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivityController activityController = Get.find();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            child: const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    activityController.getMonthAndYear(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(builder: (context) {
                      return const Text("");
                    }),
                    const WorkCalendar(0, date: "15"),
                    const WorkCalendar(1, date: "16"),
                    const WorkCalendar(2, date: "17"),
                    const WorkCalendar(3, date: "18"),
                    const WorkCalendar(4, date: "19"),
                    const WorkCalendar(5, date: "20"),
                    const WorkCalendar(6, date: "21"),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Today\'s Report',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('10 minutes'),
                            const Text('spent Working out')
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.sports_score),
                        Column(
                          children: [
                            const Text('2 Workouts done'),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Total Time',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Text('Total time spent working out'),
                Row(
                  children: [
                    Column(
                      children: const [
                        Text('Last 7 days:'),
                        Text('2:00 min'),
                      ],
                    ),
                    Column(
                      children: const [
                        Text('All time'),
                        Text('10:00 min'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
