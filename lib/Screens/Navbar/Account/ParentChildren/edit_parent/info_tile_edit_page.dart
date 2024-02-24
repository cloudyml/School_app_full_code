import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditInfoPageTileNonEditable extends StatelessWidget {
  EditInfoPageTileNonEditable(
      {super.key, required this.heading, required this.subheading});
  String heading;
  String subheading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 30),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: const Color.fromARGB(255, 96, 96, 96),
              ),
            ),
            TextFormField(
              initialValue: subheading,
              decoration: InputDecoration(
                enabled: false,
                hintText: "Enter name",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 135, 135, 135),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
