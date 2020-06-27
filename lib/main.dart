import 'package:flutter/material.dart';

import 'package:onlinestorecapp/src/pages/home_page.dart';
import 'package:onlinestorecapp/src/pages/login_page.dart';
import 'package:onlinestorecapp/src/blocs/provider.dart';
import 'package:onlinestorecapp/src/pages/instrument_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child:   MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'login' : (BuildContext context ) => LoginPage(),
          'home'  : (BuildContext context ) => HomePage(),
          'product'  : (BuildContext context ) => ProductPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );
  }
}
