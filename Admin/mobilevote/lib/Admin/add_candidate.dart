import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilevote/Admin/candidates_list.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';
// import 'dart:io';

class AddCandidates extends StatefulWidget {
  const AddCandidates({Key? key}) : super(key: key);

  @override
  _AddCandidatesState createState() => _AddCandidatesState();
}

class _AddCandidatesState extends State<AddCandidates> {
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
  File? _pickedImage;
  String name = ' ';
  String programme = ' ';
  String manifesto = '';
  String age = '';
  String? url;

  Future<void> _addData() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("candFskmImage")
        .child(name + '.jpg');
    await ref.putFile(_pickedImage!);
    url = await ref.getDownloadURL();

    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('candidate');
      await reference.add({
        "candFskmImage": url,
        "name": name,
        "programme": selectedProgramme,
        "manifesto": manifesto,
        "age": selectedAge
      });
    });
    //Navigator.pop(context);
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20.0,
            ),
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
                isExpanded: false,
                hint: const Text(
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
            SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
