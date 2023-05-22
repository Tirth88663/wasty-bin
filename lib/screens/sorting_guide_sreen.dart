import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wasty_bin/screens/bin_screen.dart';
import 'package:wasty_bin/theme/theme.dart';

class SortingGuideScreen extends StatefulWidget {
  const SortingGuideScreen({Key? key}) : super(key: key);

  @override
  State<SortingGuideScreen> createState() => _SortingGuideScreenState();
}

class _SortingGuideScreenState extends State<SortingGuideScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List<String> binsImages = [
      'assets/images/red-bin.png',
      'assets/images/green-bin.png',
      'assets/images/blue-bin.png'
    ];
    List<String> bins = ['redbin', 'greenbin', 'bluebin'];
    List<Color> binsColor = [Colors.red, Colors.green, Colors.blue];
    List<Color?> binsSecondColor = [
      Colors.red[50],
      Colors.green[50],
      Colors.blue[50]
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.green[100],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Align(
              alignment: Alignment.center,
              child: TabBar(
                labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                controller: tabController,
                labelColor: Colors.white,
                labelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: tertiaryFontSize,
                    color: Colors.black,
                  ),
                ),
                unselectedLabelColor: Colors.grey,
                indicator: RectangularIndicator(
                  strokeWidth: 0,
                  color: primaryColor,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                splashFactory: InkSplash.splashFactory,
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  // Use the default focused overlay color
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.green[100];
                }),
                tabs: const [
                  Tab(
                    child: Text('what goes where'),
                  ),
                  Tab(
                    child: Text('Know more'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: width * 1.69,
            width: double.maxFinite,
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (_, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BinScreen(
                                bin: bins[i],
                                color: binsColor[i],
                                secondColor: binsSecondColor[i],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: width,
                          height: width * 0.5,
                          margin: const EdgeInsets.only(
                              right: 10, top: 25, left: 10, bottom: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(binsImages[i]),
                                fit: BoxFit.contain,
                              ),
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
                              ]),
                        ),
                      );
                    }),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('articles')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final DocumentSnapshot data =
                                streamSnapshot.data!.docs[index];
                            final List titles = data['titles'];
                            final List links = data['links'];
                            final List images = data['images'];
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: links.length,
                                itemBuilder: (_, i) {
                                  return GestureDetector(
                                    onTap: () async {
                                      var url = Uri.parse(links[i]);
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
                                          right: 10,
                                          top: 25,
                                          left: 10,
                                          bottom: 0),
                                      padding: const EdgeInsets.only(left: 2),
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
                                                images[i],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            width: width * 0.45,
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Center(
                                              child: Text(
                                                titles[i],
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
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
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
