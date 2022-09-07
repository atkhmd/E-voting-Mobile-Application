import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilevote/Service/auth_service.dart';
import 'package:mobilevote/User/choose_faculty.dart';
import 'package:mobilevote/pages/home_page.dart';
import 'package:mobilevote/pages/sign_up_page.dart';

class SuccessVote extends StatefulWidget {
  const SuccessVote({Key? key}) : super(key: key);

  // ignore: use_key_in_widget_constructors

  @override
  _SuccessVoteState createState() => _SuccessVoteState();
}

class _SuccessVoteState extends State<SuccessVote> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("eVote"),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await authClass.signOut(context: context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => HomePage()),
                    (route) => false);
              })
        ],
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
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
                Text(
                  "You've Successfuly voted!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bungee(
                      textStyle: Theme.of(context).textTheme.headline3,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/congrats.png"))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
