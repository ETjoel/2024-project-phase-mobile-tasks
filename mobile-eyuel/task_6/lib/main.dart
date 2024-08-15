import 'package:flutter/material.dart';
import 'features/ecommerce/presentation/pages/home_page.dart';
import 'injection_container.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {'/': (context) => const HomePage()},
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        canvasColor: Colors.white,
        useMaterial3: true,
      ),
    );
  }
}
