import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcity/features/login/presentation/bloc/bloc.dart';
import 'package:smartcity/features/login/presentation/bloc/event.dart';
import 'package:smartcity/features/login/presentation/bloc/state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xffecffe2),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20.w),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'lib/assets/garbage-truck.png',
                            height: 150.h,
                            width: 150.w,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 48.h)),
                        Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 48.sp),
                          textAlign: TextAlign.start,
                        ),
                        Padding(padding: EdgeInsets.all(10.h)),
                        TextFormField(
                          onEditingComplete: () {
                            usernameController.value.text.trim();
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'required'),
                            EmailValidator(errorText: 'email is incorrect')
                          ]),
                          controller: usernameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.face),
                              labelText: "User name"),
                        ),
                        Padding(padding: EdgeInsets.all(10.h)),
                        TextFormField(
                            obscureText: true,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'required'),
                              MaxLengthValidator(15,
                                  errorText: 'password mustn'
                                      't be more than 15 charecters'),
                              MinLengthValidator(6,
                                  errorText:
                                  'password musst be more than 6 charecters ')
                            ]),
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.password),
                              labelText: "Password",
                            )),
                        Padding(padding: EdgeInsets.only(top: 20.h)),
                        Center(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xffecffe2),
                                  backgroundColor: const Color(0xff87c885),
                                  minimumSize: Size(340.w, 50.h)),
                              onPressed: () {
                                BlocProvider.of<Login_userBloc>(context).add(
                                    LoginEvent(
                                        userName:
                                        usernameController.text.trim(),
                                        password:
                                        passwordController.text.trim()));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 28.sp),
                              )),
                        ),
                      ]),
                ),
              )),
        )
      ),
    );
  }

  void showSuccessSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
