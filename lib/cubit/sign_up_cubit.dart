import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? passwordStrengthText = '';
  String? passwordStrengthDesc = '';
  Color? colorText;
  List<Color> containerColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ];

  bool? isEmailValid = true;
  bool? usernameAlreadyExist = false;
  bool? emailAlreadyExist = false;
  bool? isActive = false;
  bool? isActiveUsername = true;
  bool? isUsernameOver = false;

  void initCubit() async {
    await Future.delayed(Duration.zero);
    emit(SignUpInitial());
    // usernameController.addListener(validateUsername);
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
    emit(SignUpSetup(usernameController,emailController, passwordController));
  }

  void register() async {
    emit(SignUpLoading());
    await Future.delayed(const Duration(seconds: 2));
    bool isUsernameExist = await _checkUsernameExist(usernameController.text);
    bool isEmailExist = await _checkEmailExist(emailController.text);

    if (isUsernameExist) {
      usernameAlreadyExist = true;
      emit(SignUpLoaded());
      log("username already exist");
      return;
    } else if (isEmailExist) {
      emailAlreadyExist = true;
      emit(SignUpLoaded());
      log("email already exist");
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': usernameController.text,
        'email': emailController.text,
      });

      emit(SignUpSuccess());

      // Navigate to the next page or show a success message
    } on FirebaseAuthException catch (e) {
      emit(SignUpLoaded());
      log('Error: ${e.message}');
    }
  }

  Future<bool> _checkUsernameExist(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<bool> _checkEmailExist(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isNotEmpty;
  }

  void validateUsername() {
    emit(SignUpUsernameValidating());
    final username = usernameController.text;
    if (username.isNotEmpty) {
      isActiveUsername = true;
      log("apakah ke sini ?");
      // if (username.length < 12) {
      //   isUsernameOver = false;
      //   log("ke sini");
      // } else {
      //   log("atau sini");

      //   isUsernameOver = true;
      // }
    }else{
      log("sini sih");

      isActiveUsername = false;
    }
    emit(SignUpUsernameValidating());
  }

  void _validateEmail() {
    emit(SignUpEmailValidating());
    final email = emailController.text;
    isEmailValid = email.contains('@') && email.contains('.');
    if (isEmailValid!) {
      if (passwordController.text.isNotEmpty) {
        isActive = true;
      } else {
        isActive = false;
      }
    } else {
      isActive = false;
    }
    emit(SignUpEmailValidated());
  }

  void _validatePassword() {
    emit(SignUpPasswordValidating());
    final password = passwordController.text;
    if (password.length < 8) {
      colorText = Colors.red;
      passwordStrengthText = 'Weak Password';
      passwordStrengthDesc =
          'Password is too short. It should be at least 8 characters long to improve security.';
      containerColors = [
        Colors.red,
        const Color(0xff828282),
        const Color(0xff828282)
      ];
      isActive = false;
    } else if (!_hasMixedCase(password) || !_hasNumber(password)) {
      colorText = const Color(0xffFEC42D);
      passwordStrengthText = 'Password needs a number and lowercase letter';
      passwordStrengthDesc =
          'Add a number, uppercase and a lowercase letter to strengthen your password. Almost there!';
      containerColors = [
        const Color(0xffFEC42D),
        const Color(0xffFEC42D),
        Colors.black
      ];
      isActive = false;
    } else {
      colorText = Colors.green;
      passwordStrengthText = 'Strong Password';
      passwordStrengthDesc = 'Great job! Your password is strong and secure.';
      containerColors = [Colors.green, Colors.green, Colors.green];
      isActive = true;
    }
    emit(SignUpPasswordValidated());
  }

  bool _hasMixedCase(String password) {
    return password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]'));
  }

  bool _hasNumber(String password) {
    return password.contains(RegExp(r'\d'));
  }
}
