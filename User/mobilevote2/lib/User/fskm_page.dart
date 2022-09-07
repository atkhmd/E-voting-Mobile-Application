import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilevote/User/fskm_cand1.dart';
import 'package:mobilevote/User/fskm_cand2.dart';
import 'package:mobilevote/User/fskm_cand3.dart';

class Fskm extends StatefulWidget {
  const Fskm({Key? key, required List<QueryDocumentSnapshot<Object?>> document})
      : super(key: key);

  @override
  _FskmState createState() => _FskmState();
}

class _FskmState extends State<Fskm> {
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
      body: SingleChildScrollView(
        child: Stack(
          //resizeToAvoidBottomInset: false,
          //body: SafeArea(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                //space distribution
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Student Election 2022 \n",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bungee(
                              textStyle: Theme.of(context).textTheme.headline3,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      Text("Choose Your Candidates \n",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                              textStyle: Theme.of(context).textTheme.headline2,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                        child: GestureDetector(
                          child: Image.asset(
                            'assets/vote.png',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FskmCand1(),
                              ),
                            );
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 50.0),
                      //   child: StreamBuilder(
                      //     stream: FirebaseFirestore.instance
                      //         .collection("candidate")
                      //         .snapshots(),
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<QuerySnapshot> snapshot) {
                      //       if (!snapshot.hasData) {
                      //         return const Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //       }
                      //       return CandidateList(
                      //         document: snapshot.data!.docs,
                      //       );
                      //     },
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Candidate 1 \n Wan Nur'Ain binti Wan Sa'ari \n\n",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoMono(
                              textStyle: Theme.of(context).textTheme.headline3,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                        child: GestureDetector(
                          child: Image.asset(
                            'assets/vote.png',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FskmCand2(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Candidate 2 \n Nurul Ain Saqinah binti Mahmud \n\n",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoMono(
                              textStyle: Theme.of(context).textTheme.headline3,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                        child: GestureDetector(
                          child: Image.asset(
                            'assets/vote.png',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FskmCand3(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("Candidate 3 \n Aqib Fawwaz bin Sazali\n\n ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoMono(
                              textStyle: Theme.of(context).textTheme.headline3,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
