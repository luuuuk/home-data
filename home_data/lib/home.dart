import 'package:flutter/material.dart';
import 'package:home_data/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _drawerWidth = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeColors.darkGrey,
        child: SafeArea(
          child: Container(
            color: ThemeColors.lightWhite,
            child: Row(
              children: [
                AnimatedContainer(
                  width: _drawerWidth,
                  color: ThemeColors.lightGrey,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: Column(),
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
                              const Text(
                                "Home Data",
                                style: TextStyle(fontSize: 21),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _drawerWidth =
                                        _drawerWidth == 0.0 ? 96.0 : 0.0;
                                  });
                                },
                                icon: const Icon(Icons.menu),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
