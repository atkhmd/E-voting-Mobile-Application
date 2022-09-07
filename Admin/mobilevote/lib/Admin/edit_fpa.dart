import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilevote/Admin/candidates_list.dart';

class EditFpa extends StatefulWidget {
  EditFpa(
      {required this.name,
      required this.programme,
      required this.manifesto,
      required this.age,
      this.index});

  final String name;
  final String programme;
  final String manifesto;
  final String age;
  final index;

  @override
  EditFpaState createState() => EditFpaState();
}

class EditFpaState extends State<EditFpa> {
  List<String> programmes = ['AT110', 'AT220', 'AT222'];
  String? selectedProgramme = 'AT110';
  List<String> ages = [
    '20 years old',
    '21 years old',
    '22 years old',
    '23 years old',
    '24 years old',
    '25 years old'
  ];
  String? selectedAge = '20 years old';
  late TextEditingController controllerName;
  late TextEditingController controllerProgramme;
  late TextEditingController controllerManifesto;
  late TextEditingController controllerAge;

  late String name;
  late String programme;
  late String manifesto;
  late String age;

  void editCandidate() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      // ignore: await_only_futures
      await transaction.update(snapshot.reference, {
        "name": name,
        "programme": selectedProgramme,
        "manifesto": manifesto,
        "age": selectedAge
      });
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    //  _dueDate = widget.dueDate;
    //  _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";

    name = widget.name;
    programme = widget.programme;
    manifesto = widget.manifesto;
    age = widget.age;

    controllerName = TextEditingController(text: widget.name);
    controllerProgramme = TextEditingController(text: widget.programme);
    controllerManifesto = TextEditingController(text: widget.manifesto);
    controllerAge = TextEditingController(text: widget.age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        backgroundColor: Colors.lightBlue,
        title: const Text('List of Candidates'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controllerName,
                onChanged: (String str) {
                  setState(() {
                    name = str;
                  });
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.dashboard),
                    hintText: "Name",
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                value: selectedProgramme,
                items: programmes
                    .map((programmes) => DropdownMenuItem<String>(
                          value: programmes,
                          child:
                              Text(programmes, style: TextStyle(fontSize: 24)),
                        ))
                    .toList(),
                onChanged: (programmes) => setState(
                  () => selectedProgramme = (programmes),
                ),
                hint: Text(
                  'Select programme',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controllerManifesto,
                onChanged: (String str) {
                  setState(() {
                    manifesto = str;
                  });
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    hintText: "Manifesto",
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextField(
            //     onChanged: (String str) {
            //       setState(() {
            //         age = str;
            //       });
            //     },
            //     decoration: const InputDecoration(
            //         icon: Icon(Icons.note),
            //         hintText: "Age",
            //         border: InputBorder.none),
            //     style: const TextStyle(fontSize: 22.0, color: Colors.black),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                value: selectedAge,
                items: ages
                    .map((ages) => DropdownMenuItem<String>(
                          value: ages,
                          child: Text(ages, style: TextStyle(fontSize: 24)),
                        ))
                    .toList(),
                onChanged: (ages) => setState(
                  () => selectedAge = (ages),
                ),
                isExpanded: false,
                hint: Text(
                  'Select age',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 50),
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
                  onPressed: () {
                    editCandidate();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CandidatesList()));
                  },
                  color: Colors.lightBlue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    "Edit Candidate",
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
      ),
    );
  }
}
