import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      drawerScrimColor: Colors.black87,
      endDrawer: Drawer(
        backgroundColor: primaryColor,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
                left: width * 0.09, right: width * 0.04, bottom: width * 0.75),
            children: [
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
            ],
          ),
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
                      fontSize: tertiaryFontSize,
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
                    Card(
                      color: Colors.green[100],
                      child: const SizedBox(height: 150, width: 350),
                    ),
                    Card(
                      color: Colors.green[100],
                      child: const SizedBox(height: 150, width: 350),
                    ),
                    Card(
                      color: Colors.green[100],
                      child: const SizedBox(height: 150, width: 350),
                    ),
                    Card(
                      color: Colors.green[100],
                      child: const SizedBox(height: 150, width: 350),
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
                      fontSize: tertiaryFontSize,
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
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.green[50],
                          child: const SizedBox(height: 150, width: 350),
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
