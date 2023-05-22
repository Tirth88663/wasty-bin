import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

class AboutVendorScreen extends StatefulWidget {
  const AboutVendorScreen({Key? key, required this.about}) : super(key: key);
  final String? about;

  @override
  State<AboutVendorScreen> createState() => _AboutVendorScreenState();
}

class _AboutVendorScreenState extends State<AboutVendorScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Scrollbar(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "About Vendor  💁🏻",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: secondaryFontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Center(
                child: Container(
                  width: width,
                  margin: const EdgeInsets.only(top: 25, bottom: 0),
                  padding: const EdgeInsets.only(left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green[50],
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFF2F4F4F),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: Color(0xFFF0FFF0),
                          offset: Offset(-1.0, -1.0),
                          blurRadius: 8.0,
                          spreadRadius: 1.0),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: width * 0.1, horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${widget.about}',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
