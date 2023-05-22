import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/theme.dart';

class CompetitionScreen extends StatefulWidget {
  const CompetitionScreen({Key? key}) : super(key: key);

  @override
  State<CompetitionScreen> createState() => _CompetitionScreenState();
}

class _CompetitionScreenState extends State<CompetitionScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.green[100],
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Text(
                  'Competitions for you  🎪',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: secondaryFontSize,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 10, top: 25, bottom: 25),
                child: Center(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('competitions')
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot data =
                                  streamSnapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () async {
                                  var url = Uri.parse(data['link']);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Container(
                                  width: width,
                                  height: width * 0.4,
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 25, left: 10, bottom: 0),
                                  padding: const EdgeInsets.only(left: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green[100],
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
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.3,
                                        height: width * 0.4,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            data['image'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        width: width * 0.45,
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Center(
                                          child: Text(
                                            data['title'],
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: tertiaryFontSize,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
