import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.blue,
        elevation: 0,
        title: Text(
          'Reset Password',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your registered email \n You will receive an email for \n reset your password",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                //space
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                //email field
                TextFormField(
                  autofocus: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Email.";
                    }
                    //reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter Valid Email");
                    }
                    //reg expression for validation of domain
                    // if (!RegExp("\b*.com\$", caseSensitive: true).hasMatch(value)) {
                    //   return ("Enter Valid Email");
                    // }
                    return null;
                  },
                  onSaved: (value) {
                    formKey.currentState!.validate();
                    emailController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    prefixIcon: const Icon(CupertinoIcons.mail_solid,
                        color: Color(0xFF023047)),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Email",
                    hintStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                //space
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                //sent button
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 10,
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  height: 60,
                  minWidth: width * 0.35,
                  color: primaryColor,
                  splashColor: Colors.green,
                  onPressed: () => resetPassword(),
                  child: Text(
                    "Reset Password",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        Fluttertoast.showToast(msg: 'Password Reset Email Sent');
        Navigator.of(context).popUntil((route) => route.isFirst);
      } on FirebaseAuthException catch (e) {
        print(e);
        Fluttertoast.showToast(msg: e.message.toString());
        Navigator.of(context).pop();
      }
    }
  }
}
