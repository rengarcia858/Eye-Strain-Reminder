import 'package:eye_strain_reminder/notifier/custom_timer.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key1',
      channelName: 'Eye Strain Reminder',
      channelDescription: "Time to take some rest.",
      defaultColor: const Color(0xFFFFFDD0),
      playSound: true,
      enableVibration: true,
    )
  ]);
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key2',
      channelName: 'Eye Strain Reminder (10 Seconds)',
      channelDescription: "Time to take some rest.",
      defaultColor: const Color(0xFFFFFDD0),
      playSound: true,
      enableVibration: true,
    )
  ]);
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key3',
      channelName: 'Eye Strain Reminder (20 Minutes)',
      channelDescription: "Time to take some rest.",
      defaultColor: const Color(0xFFFFFDD0),
      playSound: true,
      enableVibration: true,
    )
  ]);
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key4',
      channelName: 'Eye Strain Reminder (30 Minutes)',
      channelDescription: "Time to take some rest.",
      defaultColor: const Color(0xFFFFFDD0),
      playSound: true,
      enableVibration: true,
    )
  ]);
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key5',
      channelName: 'Eye Strain Reminder (1 Hour)',
      channelDescription: "Time to take some rest.",
      defaultColor: const Color(0xFFFFFDD0),
      playSound: true,
      enableVibration: true,
    )
  ]);
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key6',
      channelName: 'Eye Strain Reminder (2 Hours)',
      channelDescription: "Time to take some rest.",
      defaultColor: const Color(0xFFFFFDD0),
      playSound: true,
      enableVibration: true,
    )
  ]);
  runApp(const EyeStrainReminder());
}

class EyeStrainReminder extends StatelessWidget {
  const EyeStrainReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {'/Timer': (context) => const Timer()},
        debugShowCheckedModeBanner: false,
        title: 'Eye Strain Reminder',
        home: const HomePage());
  }
}