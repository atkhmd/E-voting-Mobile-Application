import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilevote/Service/Auth_Service.dart';
import 'package:mobilevote/User/success_vote.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FskmCand3 extends StatefulWidget {
  const FskmCand3({Key? key}) : super(key: key);

  @override
  _FskmCand3State createState() => _FskmCand3State();
}

class _FskmCand3State extends State<FskmCand3> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('You already voted!'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          //width: double.infinity,
          //height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            //space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Candidate 3 \n",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/vote.png"))),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      "\n \n Aqib Fawwaz bin Sazali \n \n  Bachelor of Information System Engineering \n \n In A Blink of Eye, Nothing Is Impossible for HIM \n 22 y/o \n  \n",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoMono(
                          textStyle: Theme.of(context).textTheme.headline3,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.only(top: 1, left: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150),
                          border: const Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () => _vote(context),
                        color: Colors.lightBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          "Vote Candidate",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _vote(BuildContext context) {
    AwesomeDialog(
      context: context,
      borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
      width: MediaQuery.of(context).size.width * 0.90,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Confirm your Selection?',
      showCloseIcon: true,
      btnCancelOnPress: () {
        //Get.back();
      },
      btnOkOnPress: () {
        FirebaseFirestore.instance
            .runTransaction((Transaction transaction) async {
          CollectionReference reference =
              FirebaseFirestore.instance.collection('vote');
          User? user = FirebaseAuth.instance.currentUser;
          // Get docs from collection reference
          QuerySnapshot querySnapshot = await reference.get();
          var users = [];
          int count = 0;
          // Get data from docs and convert map to List
          await FirebaseFirestore.instance
              .collection('vote')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              users.add(doc["voterEmail"]);
              print(doc["candidate"]);
              if (doc["candidate"] == "candidate3") {
                count++;
              }
            });
          });
          print(count);

          if (!users.contains(user?.email)) {
            print("Here");
            await reference
                .add({"candidate": "candidate3", "voterEmail": user?.email});
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SuccessVote()));
          } else {
            _showToast(context);
          }
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SuccessVote()));
        //Get.to(SuccessVote());
      },
    ).show();
  }
}
