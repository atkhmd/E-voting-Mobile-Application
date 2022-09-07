import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobilevote/Admin/add_fpa.dart';
import 'package:mobilevote/Admin/edit_candidate.dart';
import 'package:mobilevote/Admin/edit_fpa.dart';

class FpaList extends StatefulWidget {
  const FpaList({Key? key}) : super(key: key);

  @override
  _FpaListState createState() => _FpaListState();
}

class _FpaListState extends State<FpaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      //width: 100.0,
                      //height: 100.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddFpa()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
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
        String manifesto = document[i]['manifesto'].toString();
        String age = document[i]['age'].toString();

        return Dismissible(
          key: Key(document[i].id),
          background: buildSwipeActionLeft(),
          onDismissed: (direction) {
            FirebaseFirestore.instance.runTransaction((transaction) async {
              DocumentSnapshot snapshot =
                  await transaction.get(document[i].reference);
              // ignore: await_only_futures
              await transaction.delete(snapshot.reference);
            });

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Data Deleted"),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      // const Padding(
                      //       padding: EdgeInsets.only(right: 16.0),
                      //       child: Icon(
                      //         Icons.note,
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          age,
                          style: const TextStyle(
                              fontSize: 20.0, letterSpacing: 0.5),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            programme,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          )),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          manifesto,
                          style: const TextStyle(
                              fontSize: 20.0, letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => EditFpa(
                              name: name,
                              programme: programme,
                              manifesto: manifesto,
                              age: age,
                              index: document[i].reference,
                            )));
                  },
                )
              ],
            ),
          ),
        );
      });

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete_forever, color: Colors.white, size: 32),
      );
}
