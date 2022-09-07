import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilevote/Service/auth_service.dart';
import 'package:mobilevote/pages/home_page.dart';
import 'package:mobilevote/pages/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = SignUpPage();

  @override
  void initState() {
    super.initState();
    authClass.signOut(context: context);
    checkLogin();
  }

  checkLogin() async {
    String? tokne = await authClass.getToken();
    print("tokne");
    if (tokne != null) {
      setState(() {
        currentPage = const HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(title: 'Flutter Home Page'),
    );
  }
}
