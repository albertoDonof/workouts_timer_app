import 'package:flutter/material.dart';

class WorkCalendar extends StatelessWidget {
  const WorkCalendar(this.position, {Key? key, required this.date})
      : super(key: key);

  final int position;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.red[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(builder: (context) {
              switch (position) {
                case 0:
                  {
                    return const Text("Mon");
                  }
                case 1:
                  {
                    return const Text("Tue");
                  }
                case 2:
                  {
                    return const Text("Wed");
                  }
                case 3:
                  {
                    return const Text("Thu");
                  }
                case 4:
                  {
                    return const Text("Fri");
                  }
                case 5:
                  {
                    return const Text("Sat");
                  }
                case 6:
                  {
                    return const Text("Sun");
                  }
                default:
                  {
                    return const Text("");
                  }
              }
            }),
            Text(date),
          ],
        ));
  }
}
