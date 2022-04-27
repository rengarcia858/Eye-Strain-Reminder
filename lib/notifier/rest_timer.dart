import 'package:flutter/material.dart';
import 'custom_timer.dart';
import 'package:google_fonts/google_fonts.dart';

class RestTimer extends StatefulWidget {
  const RestTimer({Key? key}) : super(key: key);

  @override
  Resttimer createState() => Resttimer();
}

class Resttimer extends State<RestTimer> {
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
      title: const Text('Rest Timer',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      leading: const Icon(Icons.timer_outlined, size: 20),
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
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Timer()));
                });
              },
              child: Text('Custom Timer',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black)))),
        ),
      ],
    );
  }
}