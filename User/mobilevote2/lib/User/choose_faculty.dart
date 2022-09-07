import 'package:flutter/material.dart';

import 'package:flutter/material.dart' hide Action;
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilevote/User/fpaList.dart';
import 'package:mobilevote/User/fskmList.dart';
import 'package:mobilevote/User/fskm_page.dart';
import 'package:mobilevote/pages/fskm_signup.dart';
import 'package:mobilevote/pages/sign_up_page.dart';

class Choosefaculty extends StatelessWidget {
  const Choosefaculty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 60),
          child: Column(
            //space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Choose Your Faculty",
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
                      style: GoogleFonts.firaSans(
                          textStyle: Theme.of(context).textTheme.headline3,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black))
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/vote.png"))),
              ),
              Column(
                children: <Widget>[
                  // user FSKM button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FskmSignUp()));
                    },
                    // defining the shape
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "FSKM",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  // user FPA button
                  const SizedBox(height: 20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "FPA",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
