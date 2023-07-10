import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcity/core/widgets/app_regex.dart';
import 'package:smartcity/features/authintication/data/models/authUserModel.dart';
import 'package:smartcity/features/authintication/presentation/manager/auth_bloc.dart';

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
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                            'تسجيل الدخول',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 37.sp),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                          Padding(padding: EdgeInsets.all(10.h)),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              onEditingComplete: () {
                                usernameController.value.text.trim();
                              },
                              validator: Validators().userIdV ,
                              controller: usernameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.face),
                                  labelText: "المعرف الوظيفي"),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(10.h)),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                                obscureText: true,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'يرجى ادخال كلمة المرور'),
                                ]),
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.password),
                                  labelText: "كلمة المرور",
                                )),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.h)),
                          Center(
                            child: BlocBuilder<AuthBloc, AuthState>(
                              buildWhen: (previous, current) => (current is  LoadingState|| current is LoginSuccessState || current is LoginFailedState),
                              builder: (context, state) {
                                if(state is LoadingState){
                                  return CircularProgressIndicator() ;
                                }
                                return TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: const Color(0xffecffe2),
                                        backgroundColor: const Color(0xff87c885),
                                        minimumSize: Size(340.w, 50.h)),
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          LogInEvent(
                                            user: AuthUser(
                                              userRole: 'driver',
                                                userId: usernameController.text.trim(),
                                                userPass:
                                                passwordController.text.trim()
                                            )
                                              ));
                                    },
                                    child: Text(
                                      'الدخول',
                                      style: TextStyle(fontSize: 28.sp),
                                    ));
                              },
                            ),
                          ),
                        ]),
                  ),
                )),
          )),
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
