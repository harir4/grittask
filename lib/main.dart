import 'package:flutter/material.dart';
import 'package:grittask/controller/wheather_controller.dart';
import 'package:grittask/screens/permission_screen.dart';
import 'package:grittask/widgets/search_widget.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherBook(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(useMaterial3: true),
        theme: ThemeData(useMaterial3: true),
        home: const HomePage(),
        routes: {
          '/search-weather': (context) => const SearchWeatherView(),
        },
      ),
    );
  }
}
