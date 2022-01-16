import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_data/cubit/homedata_cubit.dart';
import 'package:home_data/theme.dart';
import 'package:home_data/widgets/graph_card.dart';
import 'package:home_data/widgets/info_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _drawerWidth = 0.0;
  int selectedRoom = 0;
  int selectedDataField = 0;
  List<String> titles = ["Kitchen", "Bedroom", "Office"];
  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  void _onRefresh() async {
    // Get data
    // if failed,use refreshFailed()
    await BlocProvider.of<HomeDataCubit>(context).getData();

    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // Load data for tracking items
    if (mounted) {
      setState(() {});
    }

    refreshController.loadComplete();
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
                          _drawerWidth = 0.0;
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
                            Icons.kitchen,
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
                          _drawerWidth = 0.0;
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
                            Icons.bed_outlined,
                            color: selectedRoom == 1
                                ? ThemeColors.lightWhite
                                : ThemeColors.darkGrey,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRoom = 2;
                          _drawerWidth = 0.0;
                        });
                      },
                      child: AnimatedContainer(
                        margin: const EdgeInsets.only(top: 24.0),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        height: selectedRoom == 2 ? 54 : 48,
                        width: selectedRoom == 2 ? 54 : 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: selectedRoom == 2
                              ? ThemeColors.accentYellow
                              : ThemeColors.midGrey,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.desktop_mac_rounded,
                            color: selectedRoom == 2
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
                  child: SmartRefresher(
                    header: CustomHeader(builder: (context, mode) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ThemeColors.darkGrey,
                        ),
                      );
                    }),
                    controller: refreshController,
                    onLoading: _onLoading,
                    onRefresh: _onRefresh,
                    enablePullDown: true,
                    child: BlocConsumer<HomeDataCubit, HomeDataState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state.status == 'success') {
                            return Column(
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _drawerWidth =
                                                      _drawerWidth == 0.0
                                                          ? 96.0
                                                          : 0.0;
                                                });
                                              },
                                              child: Container(
                                                color: ThemeColors.lightWhite,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      height: 2.5,
                                                      width: 21,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                        color: ThemeColors
                                                            .darkGrey,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 5, 16, 5),
                                                      height: 2.5,
                                                      width: 18,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                        color: ThemeColors
                                                            .darkGrey,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 2.5,
                                                      width: 18,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                        color: ThemeColors
                                                            .darkGrey,
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
                                Expanded(
                                  flex: 2,
                                  child: GraphCardWidget(
                                      state.document!['sensor'][selectedRoom],
                                      selectedDataField),
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
                                            state
                                                    .document!['sensor']
                                                        [selectedRoom]
                                                    .last['temperature']
                                                    .toStringAsFixed(2) +
                                                " °C",
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
                                            state
                                                    .document!['sensor']
                                                        [selectedRoom]
                                                    .last['humidity']
                                                    .toStringAsFixed(2) +
                                                " %",
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
                                            state
                                                    .document!['sensor']
                                                        [selectedRoom]
                                                    .last['pressure']
                                                    .toStringAsFixed(0) +
                                                " hPa",
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
                                            state
                                                .document!['sensor']
                                                    [selectedRoom]
                                                .last['gas']
                                                .toStringAsFixed(0),
                                            Icons.air,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: Text("No data available."),
                            );
                          }
                        }),
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
