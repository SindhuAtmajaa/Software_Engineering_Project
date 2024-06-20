import 'dart:developer';

import 'package:aqua_sense_mobile/cubit/sign_in_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());


  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    emit(SignInLoading());

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if the user document exists in Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        emit(SignInSuccess(
          username: userDoc.get('username'),
        ));
      } else {
        emit(const SignInFailed(
          message: "Please check your username and password"
        ));
        log('Error: User document does not exist in Firestore');
      }
    } on FirebaseAuthException catch (e) {
       emit(SignInFailed(
          message: e.message,
        ));
      log('Error: ${e.message}');
    }
  }
}
