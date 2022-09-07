import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilevote/Service/auth_service.dart';
import 'package:mobilevote/User/choose_faculty.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:mobilevote/User/success_vote.dart';

class FpaList extends StatefulWidget {
  const FpaList({Key? key}) : super(key: key);

  @override
  _FpaListState createState() => _FpaListState();
}

class _FpaListState extends State<FpaList> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        backgroundColor: Colors.lightBlue,
        title: Text('List of Candidates'),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await authClass.signOut(context: context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => Choosefaculty()),
                    (route) => false);
              })
        ],
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const Choosefaculty()));
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     size: 15,
        //     color: Colors.black,
        //   ),
        // ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("candidateFpa")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return CandidateList(
                  document: snapshot.data!.docs,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CandidateList extends StatelessWidget {
  const CandidateList({required this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String name = document[i]['name'].toString();
        String programme = document[i]['programme'].toString();
        String manifesto = document[i]['manifesto'];
        String age = document[i]['age'].toString();
        var candidate_id = document[i].id.toString();

        return Dismissible(
          key: Key(document[i].id),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          manifesto,
                          style: const TextStyle(
                              fontSize: 20.0, letterSpacing: 0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          programme,
                          style: const TextStyle(
                              fontSize: 20.0, letterSpacing: 0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          age,
                          style: const TextStyle(
                              fontSize: 20.0, letterSpacing: 0.5),
                        ),
                      ),
                      MaterialButton(
                        minWidth: 10,
                        height: 50,
                        onPressed: () => _vote(context, candidate_id, name),
                        // defining the shape
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Text(
                          "VOTE",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });

  _vote(BuildContext context, String candidate_id, String name) {
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
              FirebaseFirestore.instance.collection('voteFpa');
          User? user = firebase_auth.FirebaseAuth.instance.currentUser;
          // Get docs from collection reference
          QuerySnapshot querySnapshot = await reference.get();
          var users = [];

          int count = 0;
          // Get data from docs and convert map to List
          await FirebaseFirestore.instance
              .collection('voteFpa')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              users.add(doc["voterEmail"]);
              print(doc["candidate"]);
              // if (doc["candidate"] == "candidate2") {
              //   count++;
              // }
            });
          });
          print(count);

          if (!users.contains(user?.email)) {
            print("Here");
            await reference.add({
              "candidate": candidate_id,
              "candidateName": name,
              "voterEmail": user?.email
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SuccessVote()));
          } else {
            _showToast(context);
          }
        });
      },
    ).show();
  }

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
}
