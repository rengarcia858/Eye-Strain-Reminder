import 'package:flutter/material.dart';
import 'package:eye_strain_reminder/notifier/custom_timer.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionPage extends StatelessWidget {
  final Activity act;

  const DescriptionPage({Key? key, required this.act}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF6EAD4),
        appBar: AppBar(
          title: Text(
            'Description',
            style: GoogleFonts.cormorantGaramond(
                textStyle: const TextStyle(
                    color: Color(0xFFF6EAD4),
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
          ),
          centerTitle: true,
          elevation: 10,
          backgroundColor: const Color(0xFFA2A595),
        ),
        body: Column(
          children: [
            AspectRatio(aspectRatio: 2.8,
            child: Image.asset(act.urlImage, fit: BoxFit.contain)),
            const SizedBox(height: 8),
            Text(act.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold, color: Color(0xFFB4A284)
                )),
            Text(act.desc,
                style: const TextStyle(fontSize: 15, color: Color(0xFFB4A284))),
          ],
        ),
      );
}