import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilevote/Admin/candidates_list.dart';
import 'package:mobilevote/Admin/user_profile.dart';
import 'package:mobilevote/Service/auth_service.dart';
import 'package:mobilevote/pages/sign_up_admin.dart';
import 'vote_results.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) => Scaffold(
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
                      MaterialPageRoute(builder: (builder) => SignUpAdmin()),
                      (route) => false);
                })
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            buildQuoteCard(),
            buildRoundedCard(),
            buildCard(),
          ],
        ),
      );

  Widget buildQuoteCard() => Card(
        shadowColor: Colors.lightBlue,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 150,
            color: Colors.lightBlue,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: 'My Profile',
                      hintStyle: GoogleFonts.bungee(
                          textStyle: Theme.of(context).textTheme.headline3,
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          color: Colors.black),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11.0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Icon(
                    Icons.account_box_rounded,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile()));
          },
        ),
      );

  Widget buildRoundedCard() => Card(
        shadowColor: Colors.lightBlue,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 150,
            color: Colors.lightBlue,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: 'List of Candidates',
                      hintStyle: GoogleFonts.bungee(
                          textStyle: Theme.of(context).textTheme.headline3,
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          color: Colors.black),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11.0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CandidatesList()));
          },
        ),
      );

  Widget buildCard() => Card(
        shadowColor: Colors.lightBlue,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 150,
            color: Colors.lightBlue,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: 'Vote Results',
                      hintStyle: GoogleFonts.bungee(
                          textStyle: Theme.of(context).textTheme.headline3,
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          color: Colors.black),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11.0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Icon(
                    Icons.receipt_long_rounded,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VoteResults()));
          },
        ),
      );
}
