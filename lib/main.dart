import 'package:flutter/material.dart';

import 'package:onlinestorecapp/src/pages/home_page.dart';
import 'package:onlinestorecapp/src/pages/login_page.dart';
import 'package:onlinestorecapp/src/blocs/provider.dart';
import 'package:onlinestorecapp/src/pages/instrument_page.dart';
import 'package:onlinestorecapp/src/pages/signUp_page.dart';
import 'package:onlinestorecapp/src/user_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();
    String _route = 'login';
    if(prefs.token != "") {
      _route = 'home';
    }

    return Provider(
      child:   MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: _route,
        routes: {
          'login'    : (BuildContext context ) => LoginPage(),
          'signup'   : (BuildContext context ) => SignUpPage(),
          'home'     : (BuildContext context ) => HomePage(),
          'product'  : (BuildContext context ) => ProductPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );
  }
}
