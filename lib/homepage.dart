import 'package:eye_strain_reminder/notifier/music_player.dart';
import 'package:eye_strain_reminder/notifier/rest_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eye_strain_reminder/notifier/time_interval.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class Themes {
  final String title;
  final Color bgColor;

  const Themes({
    required this.title,
    required this.bgColor,
  });
}

class HomePageState extends State<HomePage> {
  final bool isExpanded = false;
  static Color bgColor = Colors.white;
  final style = ElevatedButton.styleFrom(
      alignment: Alignment.centerLeft,
      minimumSize: const Size(1010, 50),
      textStyle: const TextStyle(fontSize: 20, color: Colors.black),
      primary: Colors.transparent,
      elevation: 0,
      onSurface: const Color.fromARGB(149, 149, 225, 184),
      onPrimary: const Color.fromARGB(149, 149, 225, 184),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5));

  List<Themes> optThemes = [
    const Themes(
      title: 'Default',
      bgColor: Colors.white,
    ),
    const Themes(
      title: 'Tinted Ice',
      bgColor: Color.fromARGB(202, 202, 244, 244),
    ),
    const Themes(
      title: "Bird's Child",
      bgColor: Color.fromARGB(255, 255, 242, 204),
    ),
    const Themes(
      title: 'Pink Shimmer',
      bgColor: Color.fromARGB(253, 253, 224, 217),
    ),
    const Themes(
      title: 'Pickford',
      bgColor: Color.fromARGB(202, 202, 239, 209),
    ),
    const Themes(
      title: 'Dark',
      bgColor: Colors.black87,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Eye Strain Reminder',
          style: GoogleFonts.cormorantGaramond(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 255, 210, 133),
        leading: Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/circle_logo.png')),
        actions: [
          IconButton(
              icon: const Icon(Icons.error_outline),
              color: Colors.black,
              onPressed: () => showAlertDialog(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 210, 133),
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: themes()),
          Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 210, 133),
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: const Reminder()),
          Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 210, 133),
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: const RestTimer()),
           Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 210, 133),
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: const Music()),
        ]),
      ),
    );
  }

  ExpansionTile themes() => ExpansionTile(
        title: const Text('Themes',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        leading: const Icon(Icons.imagesearch_roller_rounded),
        textColor: Colors.blue,
        collapsedTextColor: Colors.black,
        trailing: Icon(
            isExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down),
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: optThemes.length,
              itemBuilder: (context, index) {
                return Container(
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
                        setState(() {
                          bgColor = optThemes[index].bgColor;
                        });
                      },
                      child: Text(optThemes[index].title,
                          style: GoogleFonts.roboto(
                              textStyle:
                                  const TextStyle(color: Colors.black)))),
                );
              }),
        ],
      );

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