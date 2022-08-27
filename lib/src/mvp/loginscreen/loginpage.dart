// ignore_for_file: unawaited_futures, public_member_api_docs, use_rethrow_when_possible, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLogin = false;
GoogleSignInAccount? googleSignInAccount;
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: VariableUtilities.theme.whiteColor,
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator()),
              const SizedBox(
                width: 20,
              ),
              Text(
                'Loading',
                style: TextStyle(color: VariableUtilities.theme.blackColor),
              ),
            ],
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); //pop dialog
      Navigator.pushReplacementNamed(
        context,
        RouteUtilities.userScreen,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
          content: Text('Login Successful')));
    });
  }

  Future signWithGoogle() async {
    try {
      googleSignInAccount = await googleSignIn.signIn();
      emailtext = googleSignInAccount!.email.toString();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('emailText', emailtext);
      print(googleSignInAccount!.email);
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      var result = await FirebaseAuth.instance.signInWithCredential(credential);

      _onLoading();

      await auth.signInWithCredential(credential);
      SharedPreferences preferences = await SharedPreferences.getInstance();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.backgroundColor,
      body: Center(
        child: Consumer<UserProvider>(builder: (context, provider, child) {
          return GestureDetector(
            onTap: () async {
              signWithGoogle();
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.setString('emailText', emailtext);
              sharedPreferences.setBool('isLoged', true);
            },
            child: Container(
              height: 50,
              width: 210,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white30),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ClipOval(
                    child: Image.asset(
                      AssetUtilities.googleimage,
                      height: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Google SignIn',
                    style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.keeptextColor,
                        fontWeight: FWT.bold),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
