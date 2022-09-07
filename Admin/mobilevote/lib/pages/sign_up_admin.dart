import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilevote/Service/Auth_Service.dart';
import 'package:mobilevote/pages/sign_in_admin.dart';

class SignUpAdmin extends StatefulWidget {
  const SignUpAdmin();

  @override
  _SignUpAdminState createState() => _SignUpAdminState();
}

class _SignUpAdminState extends State<SignUpAdmin> {
  final firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool circular = false;
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
            size: 15,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign Up",
                  style: GoogleFonts.robotoMono(
                      textStyle: Theme.of(context).textTheme.headline3,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              const SizedBox(
                height: 10,
              ),
              buttonItem("assets/google.svg", "Continue with Google", 25,
                  () async {
                await authClass.googleSignIn(context);
              }),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Or",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              textItem("Name", _nameController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Email", _emailController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Password", _pwdController, true),
              const SizedBox(
                height: 15,
              ),
              colorButton(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "If you alredy have an Account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          // ignore: prefer_const_constructors
                          MaterialPageRoute(
                              builder: (builder) => SignInAdmin()),
                          (route) => false);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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

// Check if form is valid before perform login or signup
  //bool _validateAndSave() {
  //final form = _formKey.currentState;
  //if (form.validate()) {
  //form.save();
  //return true;
  //}
  //return false;
  //}

// Perform login or signup

  Widget colorButton() {
    return InkWell(
      onTap: () async {
              firebaseAuth.createUserWithEmailAndPassword(
                  email: _emailController.text, password: _pwdController.text).then((value) {
         FirebaseFirestore.instance
           .collection('admin')
          .doc(value.user!.uid)
          .set({
          "Name": _nameController.text,
          "Email": _emailController.text,
          "Password": _pwdController.text
          }).then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => SignInAdmin()),
                (route) => false);
          });
                  });
},
          // print(userCredential.user!.email);
          // setState(() {
          //   circular = false;
          // });
          
        // } catch (e) {
        //   final snackbar = SnackBar(content: Text(e.toString()));
        //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
        //   setState(() {
        //     circular = false;
        //   });
        // }
      
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.lightBlue),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }

  Widget buttonItem(
      String imagepath, String buttonName, double size, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagepath,
                height: size,
                width: size,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String labeltext, TextEditingController controller, bool obscureText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
