import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eye_strain_reminder/notifier/custom_timer.dart';

class Reminder extends StatefulWidget {
  const Reminder({Key? key}) : super(key: key);

  @override
  ReminderState createState() => ReminderState();
}

int createUniqueID() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class ReminderState extends State<Reminder> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Don\'t Allow',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    )),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((_) => Navigator.pop(context)),
                child: const Text('Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              )
            ],
          ),
        );
      }
    });
    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'Scheduled Reminder' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
            (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const Timer()),
          (route) => route.isFirst);
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  final bool _isExpanded = false;
  final style = ElevatedButton.styleFrom(
      alignment: Alignment.centerLeft,
      minimumSize: const Size(1010, 50),
      textStyle: const TextStyle(fontSize: 20, color: Colors.black),
      primary: Colors.transparent,
      elevation: 0,
      onSurface: const Color.fromARGB(149, 149, 225, 184),
      onPrimary: const Color.fromARGB(149, 149, 225, 184),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5));

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Time Interval',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      leading: const Icon(Icons.notifications_active_outlined, size: 20),
      textColor: Colors.blue,
      collapsedTextColor: Colors.black,
      trailing: Icon(
          _isExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down),
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          child: ElevatedButton(
              style: style,
              onPressed: () {
                notify();
                setState(() {
                  const snackBar = SnackBar(
                    content: Text(
                      'A reminder will show in a quick moment.',
                      style: TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.greenAccent,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                });
              },
              child: Text('Notification',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black)))),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          child: ElevatedButton(
              style: style,
              onPressed: () async {
                schedulednotify();
                setState(() {
                  const snackBar = SnackBar(
                    content: Text(
                      'The timer for the reminder is set for 1 minute.',
                      style: TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.greenAccent,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                });
              },
              child: Text('1 Minute',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black)))),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          child: ElevatedButton(
              style: style,
              onPressed: () async {
                schedulednotify1();
                setState(() {
                  const snackBar = SnackBar(
                    content: Text(
                      'The timer for the reminder is set for 20 minutes.',
                      style: TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.greenAccent,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                });
              },
              child: Text('20 Minutes',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black)))),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          child: ElevatedButton(
              style: style,
              onPressed: () async {
                schedulednotify2();
                setState(() {
                  const snackBar = SnackBar(
                    content: Text(
                      'The timer for the reminder is set for 30 minutes.',
                      style: TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.greenAccent,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                });
              },
              child: Text('30 Minutes',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black)))),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          child: ElevatedButton(
              style: style,
              onPressed: () async {
                schedulednotify3();
                setState(() {
                  const snackBar = SnackBar(
                    content: Text(
                      'The timer for the reminder is set for 1 hour.',
                      style: TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.greenAccent,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                });
              },
              child: Text('1 Hour',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black)))),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          child: ElevatedButton(
              style: style,
              onPressed: () async {
                schedulednotify4();
                setState(() {
                  const snackBar = SnackBar(
                    content: Text(
                      'The timer for the reminder is set for 2 hours.',
                      style: TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.greenAccent,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                });
              },
              child: Text('2 Hours',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black)))),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          child: ElevatedButton(
              style: style,
              onPressed: () async {
                cancelScheduledNotifications();
                setState(() {
                  const snackBar = SnackBar(
                    content: Text(
                      'Cancel all notifications',
                      style: TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.greenAccent,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                });
              },
              child: Text('Cancel all scheduled',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black)))),
        ),
      ],
    );
  }
}

Future<void> notify() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: createUniqueID(),
    channelKey: 'key1',
    title: 'Eye Strain Reminder',
    body: 'Time passed you need to take some rest',
  ));
}

Future<void> schedulednotify() async {
  String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueID(),
        channelKey: 'key2',
        title: 'Eye Strain Reminder',
        body: "It's been 1 minute, you need to take a break.",
      ),
      schedule:
          NotificationInterval(interval: 60, timeZone: timezom, repeats: true));
}

Future<void> schedulednotify1() async {
  String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueID(),
        channelKey: 'key3',
        title: 'Eye Strain Reminder',
        body: "It's been 20 minutes, you need to take a break.",
      ),
      schedule: NotificationInterval(
          interval: (20 * 60), timeZone: timezom, repeats: true));
}

Future<void> schedulednotify2() async {
  String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueID(),
        channelKey: 'key4',
        title: 'Eye Strain Reminder',
        body: "It's been 30 minutes, you need to take a break.",
      ),
      schedule: NotificationInterval(
          interval: (30 * 60), timeZone: timezom, repeats: true));
}

Future<void> schedulednotify3() async {
  String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueID(),
        channelKey: 'key5',
        title: 'Eye Strain Reminder',
        body: "It's been 1 hour, you need to take a break.",
      ),
      schedule: NotificationInterval(
          interval: (60 * 60), timeZone: timezom, repeats: true));
}

Future<void> schedulednotify4() async {
  String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueID(),
        channelKey: 'key6',
        title: 'Eye Strain Reminder',
        body: "It's been 2 hours, you need to take a break.",
      ),
      schedule: NotificationInterval(
          interval: (120 * 60), timeZone: timezom, repeats: true));
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}