import 'package:asdintech/providers/bg_verification_provider.dart';
import 'package:asdintech/screens/dashboard/dashboard.dart';
import 'package:asdintech/screens/form%20/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/formIdScreen/form_id_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx)=> BgVerificationProvider())
    ],
   child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashBoard(),
    );
  }
}
