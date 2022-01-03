import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_data/home.dart';
import 'package:home_data/theme.dart';

import 'cubit/homedata_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeDataCubit>(
          create: (context) => HomeDataCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Home Data',
        theme: VisualizationTheme.theme,
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
