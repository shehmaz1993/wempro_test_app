import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wempro_test_app/src/views/ui/Input_assertion_screen.dart';
import 'package:wempro_test_app/src/views/utils/Size.dart';
import 'package:wempro_test_app/src/views/utils/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  MultiProvider(
      providers: listOfProvider,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:InputScreen(),
      ),
    );
  }
}
