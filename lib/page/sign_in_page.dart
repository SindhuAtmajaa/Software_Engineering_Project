import 'package:aqua_sense_mobile/cubit/sign_in_cubit.dart';
import 'package:aqua_sense_mobile/cubit/sign_in_state.dart';
import 'package:aqua_sense_mobile/cubit/sign_up_cubit.dart';
import 'package:aqua_sense_mobile/page/dashboard_page.dart';
import 'package:aqua_sense_mobile/page/sign_up_page.dart';
import 'package:aqua_sense_mobile/widget/alert/toast_widget.dart';
import 'package:aqua_sense_mobile/widget/loading/dialog_progress.dart';
import 'package:aqua_sense_mobile/widget/text_field/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? isObscure = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          showProgressDialog(context: context);
        }
        if (state is SignInLoaded) {
          Navigator.pop(context);
        }

        if (state is SignInSuccess) {
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => DashboardPage(
                username: state.username,
              )));
          showToast(
            context: context,
            child: ToastWidget(
              borderColor: Colors.green,
              backgroundColor: Colors.green.withOpacity(0.2),
              message: "Login has been successfull",
              lineHeight: 1,
            ),
          );
        }

        if (state is SignInFailed) {
          Navigator.pop(context);
          showToast(
            context: context,
            child: ToastWidget(
              borderColor: Colors.red,
              backgroundColor: Colors.red.withOpacity(0.2),
              message: state.message,
              lineHeight: 1,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 120.h),
                  Image.asset('assets/icons/ic_logo_app.png', height: 100),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.poppins(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please enter your details',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Email',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  CustomInputField(
                    controller: cubit.emailController,
                    hintText: "example@example.com",
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  CustomInputField(
                    controller: cubit.passwordController,
                    hintText: "Enter Password",
                    obscureText: isObscure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure!;
                        });
                      },
                      icon: Icon(
                          isObscure! ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 12.h),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      cubit.login();
                    },
                    child: Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffB311FF),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      SignUpCubit()..initCubit(),
                                  child: const SignupPage(),
                                )),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t Have an Account? ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                          ),
                        ),
                        Text(
                          'Create Now!',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    'By using AquaSense, you agree to our',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                      fontSize: 9.sp,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Terms of Service',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 9.sp,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Text(
                        ' and ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                          fontSize: 9.sp,
                        ),
                      ),
                      Text(
                        'Privacy Policy',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 9.sp,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
