import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_data/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _drawerWidth = 0.0;
  int selectedRoom = 0;
  List<String> titles = ["Bedroom", "Kitchen"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ThemeColors.lightWhite,
          child: Row(
            children: [
              AnimatedContainer(
                width: _drawerWidth,
                color: ThemeColors.lightGrey,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 24.0),
                      child: Text(
                        "R",
                        style: GoogleFonts.quicksand(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: ThemeColors.lightGrey),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRoom = 0;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        height: selectedRoom == 0 ? 54 : 48,
                        width: selectedRoom == 0 ? 54 : 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: selectedRoom == 0
                              ? ThemeColors.accentYellow
                              : ThemeColors.midGrey,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.bed_outlined,
                            color: selectedRoom == 0
                                ? ThemeColors.lightWhite
                                : ThemeColors.darkGrey,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRoom = 1;
                        });
                      },
                      child: AnimatedContainer(
                        margin: const EdgeInsets.only(top: 24.0),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        height: selectedRoom == 1 ? 54 : 48,
                        width: selectedRoom == 1 ? 54 : 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: selectedRoom == 1
                              ? ThemeColors.accentYellow
                              : ThemeColors.midGrey,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.kitchen,
                            color: selectedRoom == 1
                                ? ThemeColors.lightWhite
                                : ThemeColors.darkGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: ThemeColors.lightWhite,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      titles[selectedRoom],
                                      style: GoogleFonts.quicksand(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _drawerWidth =
                                            _drawerWidth == 0.0 ? 96.0 : 0.0;
                                      });
                                    },
                                    child: Container(
                                      color: ThemeColors.lightWhite,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            height: 2.5,
                                            width: 21,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              color: ThemeColors.darkGrey,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 5, 16, 5),
                                            height: 2.5,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              color: ThemeColors.darkGrey,
                                            ),
                                          ),
                                          Container(
                                            height: 2.5,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              color: ThemeColors.darkGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       _drawerWidth =
                                  //           _drawerWidth == 0.0 ? 96.0 : 0.0;
                                  //     });
                                  //   },
                                  //   icon: const Icon(
                                  //     Icons.menu,
                                  //     color: ThemeColors.darkGrey,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: ThemeColors.darkGrey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                    color: ThemeColors.accentYellow,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.thermostat,
                                          color: ThemeColors.lightWhite,
                                        ),
                                        Text(
                                          "Temp",
                                          style: GoogleFonts.quicksand(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: ThemeColors.lightWhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                    color: ThemeColors.midGrey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                    color: ThemeColors.midGrey,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                    color: ThemeColors.midGrey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
