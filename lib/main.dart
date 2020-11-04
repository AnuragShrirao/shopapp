import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/componenets/auth.dart';
import 'package:shopapp/componenets/cart_products.dart';
import 'package:shopapp/componenets/cityproider.dart';
import 'package:shopapp/componenets/theme.dart';
import 'package:shopapp/screens/Login_new.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(
           create: (BuildContext context) => ThemeProvider(
            isDarkMode: preferences.getBool("isDarkTheme")==null?false:preferences.getBool("isDarkTheme"),
          ),
        ),
        ChangeNotifierProvider(
          create: (_)=>CartProduct(),
        ),
        ChangeNotifierProvider(
          create: (_) => CityProvider(),
        ),
        ChangeNotifierProvider.value(value: AuthProvider.initialize(),),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: "FLUTTER DEMO",
          theme: themeProvider.getTheme,
          home:ScreenController(),);
      },
    );
  }
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    switch(auth.status){
      case Status.Uninitialized:return LogIn();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LogIn();
      case Status.Authenticated:
        return HomePage();
        default: return LogIn();
    }
  }
}
