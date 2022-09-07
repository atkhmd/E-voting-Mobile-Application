import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilevote/Admin/candidates_list.dart';

class AddFpa extends StatefulWidget {
  const AddFpa({Key? key}) : super(key: key);

  @override
  _AddFpaState createState() => _AddFpaState();
}

class _AddFpaState extends State<AddFpa> {
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
  String name = ' ';
  //String programme = ' ';
  String manifesto = '';
  String age = '';
  String imageUrl = " ";

  void _addData() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('candidateFpa');
      await reference.add({
        "name": name,
        "programme": selectedProgramme,
        "manifesto": manifesto,
        "age": age
      });
    });
    //Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        backgroundColor: Colors.lightBlue,
        title: const Text("Candidate's Information"),
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
            // Text("Candidate Informations",
            //     style: GoogleFonts.robotoMono(
            //         textStyle: Theme.of(context).textTheme.headline3,
            //         fontSize: 20,
            //         fontWeight: FontWeight.w700,
            //         color: Colors.black)),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Color(0xff476cfb),
                    child: ClipOval(
                      // child: SizedBox(
                      //   width: 100.0,
                      //   height: 100.0,
                      child: imageUrl == " "
                          ? Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            )
                          : Image.network(imageUrl, fit: BoxFit.fill),
                      //),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
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
                    borderSide: BorderSide(width: 2, color: Colors.black),
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
                hint: const Text(
                  'Select programme',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 2, color: Colors.black),
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
                hint: Text(
                  'Select age',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextField(
            //     onChanged: (String str) {
            //       setState(() {
            //         manifesto = str;
            //       });
            //     },
            //     decoration: const InputDecoration(
            //         icon: Icon(Icons.note),
            //         hintText: "Age",
            //         border: InputBorder.none),
            //     style: const TextStyle(fontSize: 22.0, color: Colors.black),
            //   ),
            // ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
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
                    _addData();
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
                    "Add Candidate",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
