import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

class BinScreen extends StatefulWidget {
  const BinScreen(
      {Key? key,
      required this.bin,
      required this.color,
      required this.secondColor})
      : super(key: key);

  final String bin;
  final Color color;
  final Color? secondColor;
  @override
  State<BinScreen> createState() => _BinScreenState();
}

class _BinScreenState extends State<BinScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection(widget.bin).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final DocumentSnapshot data =
                          streamSnapshot.data!.docs[index];
                      final List images = data['images'];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, top: 10),
                            child: Text(
                              'About 👇',
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
                                left: 25, right: 10, top: 10, bottom: 25),
                            child: Card(
                              color: widget.secondColor,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: width * 0.2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    data['about'],
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, top: 10),
                            child: Text(
                              'Examples 👇',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: secondaryFontSize,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: images.length,
                              itemBuilder: (_, i) {
                                return Container(
                                  width: width,
                                  height: width * 0.6,
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 25, left: 10, bottom: 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(images[i]),
                                      fit: BoxFit.fill,
                                    ),
                                    color: widget.secondColor,
                                  ),
                                );
                              }),
                        ],
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(
                  color: widget.color,
                ),
              );
            }),
      ),
    );
  }
}
