import 'package:fintrack/src/approute.dart';
import 'package:fintrack/src/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const MyApp({super.key, required this.appRouter});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: widget.appRouter.onGenerateRoute,
      initialRoute: '/home',
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
