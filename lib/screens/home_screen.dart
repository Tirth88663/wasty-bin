import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wasty_bin/theme/theme.dart';

import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List<String> drawerTitles = [
      'Waste Sorting',
      'Competitions',
      'Donate',
      'Vendors'
    ];
    List<IconData> drawerIcons = [
      Icons.book,
      Icons.rocket_launch,
      Icons.handshake_outlined,
      Icons.fire_truck_outlined
    ];
    List<String> tips = [
      'Avoid single-use items and use only permanent/reusable ones.',
      'Reusing bags and having unlined bins will reduce plastic use by eliminating the need for plastic garbage bags.',
      'Do your research and make the switch to use packaging materials that cause less harm to the environment.',
      'Eliminate plastic bottles and bags; use reusable bags, and introduce water dispensers throughout the office.',
      'Instead of using paper documents, communicate through email, instant messenger chat, via video meetings, and save everything safely in the cloud.',
      'Switch to biodegradable, and other alternative forms of eco-friendly packaging'
    ];
    List<String> images = [
      'assets/images/warming 1.png',
      'assets/images/warming 2.png',
      'assets/images/warming 3.jpg',
      'assets/images/warming 4.png',
      'assets/images/warming 5.jpg',
    ];
    List<String> titles = [
      'Know how to sort your waste',
      'Compete and Save Earth',
      'Donate NGOs and help others',
      'Scrape Vendors near you'
    ];
    List<String> routes = ['/guide', '/competition', '/donate', '/vendor'];
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      drawerScrimColor: Colors.black87,
      endDrawer: Drawer(
        backgroundColor: primaryColor,
        child: Center(
          child: ListView.builder(
              itemCount: drawerTitles.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  left: width * 0.09,
                  right: width * 0.04,
                  bottom: width * 0.75),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    drawerIcons[index],
                    color: Colors.white,
                  ),
                  title: Text(
                    drawerTitles[index],
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: tertiaryFontSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(context, routes[index]),
                );
              }),
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person_2,
              color: primaryColor,
            ),
          ),
          onTap: () => Navigator.pushNamed(context, '/profile'),
        ),
        title: Text(
          '${loggedInUser.name} \n Welcome',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: tertiaryFontSize,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
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
                  'Tips 💡',
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
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 10 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(
                            'https://greenbusinessbureau.com/business-function/facilities/cleaning-maintenance/waste-management-checklist/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Card(
                        color: Colors.green[50],
                        child: SizedBox(
                          height: 150,
                          width: 350,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                tips[0],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(
                            'https://greenbusinessbureau.com/business-function/facilities/cleaning-maintenance/waste-management-checklist/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Card(
                        color: Colors.green[100],
                        child: SizedBox(
                          height: 150,
                          width: 350,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                tips[1],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(
                            'https://greenbusinessbureau.com/business-function/facilities/cleaning-maintenance/waste-management-checklist/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Card(
                        color: Colors.green[50],
                        child: SizedBox(
                          height: 150,
                          width: 350,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                tips[2],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(
                            'https://greenbusinessbureau.com/business-function/facilities/cleaning-maintenance/waste-management-checklist/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Card(
                        color: Colors.green[100],
                        child: SizedBox(
                          height: 150,
                          width: 350,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                tips[3],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(
                            'https://greenbusinessbureau.com/business-function/facilities/cleaning-maintenance/waste-management-checklist/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Card(
                        color: Colors.green[50],
                        child: SizedBox(
                          height: 150,
                          width: 350,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                tips[4],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(
                            'https://greenbusinessbureau.com/business-function/facilities/cleaning-maintenance/waste-management-checklist/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Card(
                        color: Colors.green[100],
                        child: SizedBox(
                          height: 150,
                          width: 350,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                tips[5],
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
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
                  // autoPlay: true,
                  // viewportFraction: 1.0,
                  // aspectRatio: 2.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Text(
                  'Things You Might Want to Check 👇',
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
                  child: ListView.builder(
                      itemCount: titles.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, routes[index]);
                          },
                          child: Card(
                            color: Colors.green[50],
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              height: width * 0.4,
                              width: width,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.32,
                                    height: width * 0.4,
                                    child: Image.asset(
                                      images[index],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    width: width * 0.45,
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      titles[index],
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
