import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eye_strain_reminder/notifier/description.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<Timer> with TickerProviderStateMixin {
  late AnimationController controller;
  bool isPlaying = false;
  final List<bool> selected = List.generate(4, (_) => false);

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD0),
      appBar: AppBar(
        title: Text(
          'Rest Timer',
          style: GoogleFonts.cormorantGaramond(
              textStyle: const TextStyle(
                  color: Color(0xFFFFFDD0),
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color(0xFF202A44),
        actions: [
          IconButton(
              icon: const Icon(Icons.error_outline),
              onPressed: () => showAlertDialog(context))
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: const Alignment(0, -0.5),
            child: ToggleButtons(
              isSelected: selected,
              hoverColor: Colors.blueGrey,
              borderColor: const Color(0xFF202A44),
              onPressed: (int newIndex) {
                setState(() {
                  if (newIndex == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DescriptionPage(act: acts[0])));
                  } else if (newIndex == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DescriptionPage(act: acts[1])));
                  } else if (newIndex == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DescriptionPage(act: acts[2])));
                  } else if (newIndex == 3) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DescriptionPage(act: acts[3])));
                  } else {
                    selected[newIndex] = false;
                  }
                });
              },
              children: const <Widget>[
                Icon(Icons.preview),
                Icon(Icons.front_hand_outlined),
                Icon(Icons.remove_red_eye_outlined),
                Icon(Icons.man_outlined)
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    color: const Color(0xFF202A44),
                    value: progress,
                    strokeWidth: 6,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.isDismissed) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SizedBox(
                          height: 300,
                          child: CupertinoTimerPicker(
                            initialTimerDuration: controller.duration!,
                            onTimerDurationChanged: (time) {
                              setState(() {
                                controller.duration = time;
                              });
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      countText,
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  child: const RoundButton(
                    icon: Icons.stop,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
        child: const Text('OK'), onPressed: () => Navigator.pop(context, 'OK'));

    AlertDialog alert = AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Eye Rest Recommendation'),
      contentPadding: const EdgeInsets.all(30),
      content: Table(
          border: const TableBorder(
              verticalInside: BorderSide(
                  width: 1, color: Colors.black, style: BorderStyle.solid)),
          children: const [
            TableRow(children: [
              Text('Time Interval',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Rest Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            TableRow(children: [
              Text('20 minutes', textAlign: TextAlign.center),
              Text('20 seconds', textAlign: TextAlign.center),
            ]),
            TableRow(children: [
              Text('30 minutes', textAlign: TextAlign.center),
              Text('5 minutes', textAlign: TextAlign.center),
            ]),
            TableRow(children: [
              Text('1 hour', textAlign: TextAlign.center),
              Text('10 minutes', textAlign: TextAlign.center),
            ]),
            TableRow(children: [
              Text('2 hours', textAlign: TextAlign.center),
              Text('15 minutes', textAlign: TextAlign.center),
            ])
          ]),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

List<Activity> acts = [
  const Activity(
    urlImage: 'assets/rule_20_20_20.png',
    title: '20-20-20 Rule',
    desc:'''
        -> Look at an object 20 feet away from you for 20 seconds every 20 minutes.''',
  ),
  const Activity(
    urlImage: 'assets/palming.png',
    title: 'Palming',
    desc: '''
        -> To palm, start by rubbing your hands together to warm them up.
        -> Close your eyes and place the palm of each hand over the corresponding cheekbone. 
        -> Cup your hand over each eye and breath deeply for five minutes''',
  ),
  const Activity(
    urlImage: 'assets/blink_break.png',
    title: 'Blink Break',
    desc: '''
        -> Close your eyes completely.
        -> Wait for 2 seconds and then open them.
        -> Right after close your eyes again.
        -> Wait for 2 second and squeeze your eyes.
        -> Open them and relax.''',
  ),
  const Activity(
    urlImage: 'assets/stretching.png',
    title: 'Stand Up and Move',
    desc: '''
        -> Stand up and move.
        -> Stretch your arms, legs, back, neck, and shoulders, make stretching movements.''',
  ),
];

class Activity {
  final String title;
  final String desc;
  final String urlImage;

  const Activity({
    required this.title,
    required this.desc,
    required this.urlImage,
  });
}

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: const Color(0xFF202A44),
        child: Icon(
          icon,
          size: 36,
        ),
      ),
    );
  }
}