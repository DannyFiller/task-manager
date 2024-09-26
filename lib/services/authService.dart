import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/trangchu.dart';
import 'package:logger/logger.dart';

class Authservice {
  var logger = Logger();
  Authservice() {}
  Future<void> SignUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-passwrod') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exist with that email';
      }
    }
  }

  Future<void> SignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i("Dang nhap thang cong");

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TrangChu(),
          ));
    } on FirebaseAuthException catch (e) {
      logger.e('Failed with error code: ${e.code}');
      // logger.e(e.message);
      if (e.code == "channel-error") {
        ShowDialog(context, 'Không tìm thấy tài khoản');
      } else if (e.code == 'invalid-credential') {
        ShowDialog(context, 'Sai mat khau');
      }
    }
  }
}

void ShowDialog(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(title)],
          ),
        ),
      );
    },
  );
}
