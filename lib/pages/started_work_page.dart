import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workouts_timer_app/controllers/settings_controller.dart';
import 'package:workouts_timer_app/models/timer_model.dart';
import 'package:just_audio/just_audio.dart';

class StartedPage extends StatefulWidget {
  final TimerModel timerModel;
  const StartedPage(this.timerModel, {Key? key}) : super(key: key);

  @override
  _StartedPageState createState() => _StartedPageState();
}

class _StartedPageState extends State<StartedPage> {
  late AudioPlayer player;
  CountDownController _controller = CountDownController();
  int _duration = 6;
  bool adessoWork = false;
  int setAttuali = 0;
  bool primaRun = true;
  SettingsController settingsController = Get.find();

  @override
  initState() {
    super.initState();
    if (settingsController.soundOn.value) {
      player = AudioPlayer();
      player.setAsset('assets/Countdown-5sec.wav');
    }
  }

  @override
  void dispose() {
    if (settingsController.soundOn.value) {
      player.dispose();
    }
    super.dispose();
  }

  void restartCountTimer() {
    setState(() {
      if (adessoWork == false && widget.timerModel.rimaste != 0) {
        primaRun = false;
        adessoWork = true;
        setAttuali += 1;
        int workSeconds = widget.timerModel.getWorkSeconds();
        if (settingsController.soundOn.value) {
          Future.delayed(Duration(seconds: workSeconds - 5),
              () => {player.seek(const Duration())});
        }
        _controller.restart(duration: workSeconds + 1);
      } else if (adessoWork == true) {
        adessoWork = false;
        if (settingsController.soundOn.value) {
          Future.delayed(
              Duration(seconds: widget.timerModel.getRestSeconds() - 5),
              () => player.seek(const Duration()));
        }
        _controller.restart(duration: widget.timerModel.getRestSeconds() + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.timerModel.workout.name,
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 30),
                    child: Text(
                      adessoWork ? 'WORK' : 'REST',
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                  Center(
                    child: CircularCountDownTimer(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 280,
                      controller: _controller,
                      duration: _duration,
                      fillColor: adessoWork
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                      ringColor: Colors.grey.shade300,
                      backgroundColor: adessoWork ? Colors.green : Colors.red,
                      strokeWidth: 23.0,
                      strokeCap: StrokeCap.round,
                      autoStart: true,
                      isReverse: true,
                      textFormat: CountdownTextFormat.S,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 30),
                      onComplete: restartCountTimer,
                      onStart: primaRun && settingsController.soundOn.value
                          ? () => player.play()
                          : null,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      setAttuali.toString() +
                          '/' +
                          widget.timerModel.workout.numeroSet.toString() +
                          '  SETS',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            iconSize: 50,
                            splashRadius: 40,
                            onPressed: () => {
                                  if (player.playerState.playing)
                                    {player.pause()},
                                  _controller.pause(),
                                  primaRun = false,
                                  showDialog(
                                      context: context,
                                      builder: (_) => createPauseDialog(),
                                      barrierDismissible: false)
                                },
                            icon: const Icon(
                              Icons.pause_circle_filled,
                            )),
                        const Text(
                          'PAUSE',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  WillPopScope createPauseDialog() => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text(
            'Timer Stopped',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Press the button to continue the session',
            textAlign: TextAlign.center,
          ),
          actionsPadding: const EdgeInsets.only(bottom: 15),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () => {
                  if (player.playerState.playing == false) {player.play()},
                  _controller.resume(),
                  Navigator.pop(context),
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      );
}
