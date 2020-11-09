import 'package:flutter/material.dart';
import 'package:nasapic/showPic.dart';

void main() => runApp(NasaApod());

class NasaApod extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (BuildContext ctx) => ShowPic()},
    );
  }
}
