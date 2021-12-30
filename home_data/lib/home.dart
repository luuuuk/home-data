import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_data/theme.dart';
import 'package:home_data/widgets/graph_card.dart';
import 'package:home_data/widgets/info_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _drawerWidth = 0.0;
  int selectedRoom = 0;
  int selectedDataField = 0;
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: GraphCardWidget(),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDataField = 0;
                                  });
                                },
                                child: InfoCardWidget(
                                  selectedDataField == 0
                                      ? ThemeColors.accentYellow
                                      : ThemeColors.midGrey,
                                  selectedDataField == 0
                                      ? ThemeColors.lightWhite
                                      : ThemeColors.darkGrey,
                                  selectedDataField == 0
                                      ? ThemeColors.lightWhite
                                      : Colors.black,
                                  "Temp",
                                  "19 °C",
                                  Icons.thermostat,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDataField = 1;
                                  });
                                },
                                child: InfoCardWidget(
                                  selectedDataField == 1
                                      ? ThemeColors.accentYellow
                                      : ThemeColors.midGrey,
                                  selectedDataField == 1
                                      ? ThemeColors.lightWhite
                                      : ThemeColors.darkGrey,
                                  selectedDataField == 1
                                      ? ThemeColors.lightWhite
                                      : Colors.black,
                                  "Humidity",
                                  "27 %",
                                  Icons.water_damage,
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
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDataField = 2;
                                  });
                                },
                                child: InfoCardWidget(
                                  selectedDataField == 2
                                      ? ThemeColors.accentYellow
                                      : ThemeColors.midGrey,
                                  selectedDataField == 2
                                      ? ThemeColors.lightWhite
                                      : ThemeColors.darkGrey,
                                  selectedDataField == 2
                                      ? ThemeColors.lightWhite
                                      : Colors.black,
                                  "Pressure",
                                  "1012 hPa",
                                  Icons.line_weight,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDataField = 3;
                                  });
                                },
                                child: InfoCardWidget(
                                  selectedDataField == 3
                                      ? ThemeColors.accentYellow
                                      : ThemeColors.midGrey,
                                  selectedDataField == 3
                                      ? ThemeColors.lightWhite
                                      : ThemeColors.darkGrey,
                                  selectedDataField == 3
                                      ? ThemeColors.lightWhite
                                      : Colors.black,
                                  "Air Quality",
                                  "320",
                                  Icons.air,
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
