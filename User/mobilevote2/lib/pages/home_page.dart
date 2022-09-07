import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilevote/Service/Auth_Service.dart';
import 'package:mobilevote/User/choose_faculty.dart';
import 'package:mobilevote/pages/sign_in_page.dart';

class HomePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomePage({String? title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
        child: Column(
          //space distribution
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 0,
                ),
                Text("Welcome, ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bungee(
                        textStyle: Theme.of(context).textTheme.headline3,
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                Text("to e-Vote",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bungee(
                        textStyle: Theme.of(context).textTheme.headline3,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                const SizedBox(
                  height: 20,
                ),
                Text("Your Vote Matters",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoMono(
                        textStyle: Theme.of(context).textTheme.headline3,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black))
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/vote.png"))),
            ),
            Column(
              children: <Widget>[
                const SizedBox(height: 20),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Choosefaculty()));
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    "VOTE NOW",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
