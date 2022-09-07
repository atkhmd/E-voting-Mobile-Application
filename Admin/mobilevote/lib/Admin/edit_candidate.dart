import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilevote/Admin/candidates_list.dart';

class EditCandidate extends StatefulWidget {
  EditCandidate(
      {required this.name,
      required this.programme,
      required this.manifesto,
      required this.age,
      this.index,
      required String candFskmImage});

  final String name;
  final String programme;
  final String manifesto;
  final String age;
  final index;

  @override
  EditCandidateState createState() => EditCandidateState();
}

class EditCandidateState extends State<EditCandidate> {
  List<String> programmes = ['CS230', 'CS245', 'CS246', 'CS251'];
  String? selectedProgramme = 'CS230';
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
  String? url;
  File? _pickedImage;

  void editCandidate() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      // ignore: await_only_futures
      await transaction.update(snapshot.reference, {
        "candFskmImage": url,
        "name": name,
        "programme": selectedProgramme,
        "manifesto": manifesto,
        "age": selectedAge
      });
    });
    Navigator.pop(context);
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile!;
    });
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  //  flex: 2,
                  child: _pickedImage == null
                      ? Container(
                          margin: const EdgeInsets.all(10),
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white70,
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(10),
                          height: 200,
                          width: 200,
                          child: Container(
                            height: 200,
                            // width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white70,
                            ),
                            child: Image.file(
                              _pickedImage!,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: TextButton.icon(
                        // color: Colors.white,
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: _pickImageCamera,
                        icon:
                            const Icon(Icons.camera, color: Colors.blueAccent),
                        label: const Text(
                          'Camera',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: TextButton.icon(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: _pickImageGallery,
                        icon: const Icon(Icons.image, color: Colors.blueAccent),
                        label: const Text(
                          'Gallery',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: TextButton.icon(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: _removeImage,
                        icon: const Icon(
                          Icons.remove_circle_rounded,
                          color: Colors.red,
                        ),
                        label: const Text(
                          'Remove',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
