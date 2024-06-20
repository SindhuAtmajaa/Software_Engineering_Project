import 'dart:developer';

import 'package:aqua_sense_mobile/config/routes.dart';
import 'package:aqua_sense_mobile/cubit/sign_up_cubit.dart';
import 'package:aqua_sense_mobile/widget/alert/toast_widget.dart';
import 'package:aqua_sense_mobile/widget/loading/dialog_progress.dart';
import 'package:aqua_sense_mobile/widget/text_field/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  bool? isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   cubit.emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          showProgressDialog(context: context);
        }

        if (state is SignUpLoaded) {
          Navigator.pop(context);
        }
        if (state is SignUpSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, (route) => false);
          showToast(
            context: context,
            child: ToastWidget(
              borderColor: Colors.green,
              backgroundColor: Colors.green.withOpacity(0.2),
              message: "Register has been successfull",
              lineHeight: 1,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Make Your Account',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back)),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'Username',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  CustomInputField(
                    controller: cubit.usernameController,
                    hintText: "Enter Username",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    onChanged: (p0) {
                      cubit.validateUsername();
                    },
                  ),
                  if (cubit.usernameAlreadyExist!)
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          '*Username has already been taken',
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  if (!cubit.isActiveUsername!)
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          '*Please fill in the blank field',
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 16.h),
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
                  if (!cubit.isEmailValid! || cubit.emailAlreadyExist!)
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          '*Invalid email address',
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        width: 30.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                            color: cubit.containerColors[0],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        width: 30.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                            color: cubit.containerColors[1],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        width: 30.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                            color: cubit.containerColors[2],
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        cubit.passwordStrengthText!,
                        style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          color: cubit.colorText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Text(
                          cubit.passwordStrengthDesc!,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      if (cubit.usernameController.text.isEmpty) {
                        cubit.validateUsername();
                      } else {
                        if (cubit.isActive! && cubit.isActiveUsername!) {
                          log("tes touring");
                          cubit.register();
                        }
                      }
                    },
                    child: Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width.w,
                      decoration: BoxDecoration(
                          color: (cubit.isActive! && cubit.isActiveUsername!)
                              ? const Color(0xffB311FF)
                              : const Color(0xff828282),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 145.h),
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
