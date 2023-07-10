import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../controller/auth_controller/sign_in_controller.dart';
import '../../core/constant/image_assets.dart';
import '../../core/function/valid_input.dart';
import '../widget/auth_widget/custom_text_form_field_auth_widget.dart';
import '../widget/auth_widget/custom_text_signUp_and_signIn.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInControllerImp signInControllerImp = Get.put(SignInControllerImp());

    return Scaffold(
      body: GetBuilder<SignInControllerImp>(
        builder: (signInControllerImp) {
          return ModalProgressHUD(
            inAsyncCall: signInControllerImp.showSpinner,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/login_bg.png',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 60.0, bottom: 50.0, left: 32.0, right: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Center(
                            child: Text(
                              'Welcome',
                              style: TextStyle(
                                  fontSize: 50.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MarckScript'),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/person.png'),
                            // Text(
                            //   'please login',
                            //   style: TextStyle(
                            //       fontSize: 30.0, color: Colors.white),
                            // ),
                            // Text(
                            //   'to your account',
                            //   style: TextStyle(
                            //       fontSize: 30.0, color: Colors.white),
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Form(
                          key: signInControllerImp.formState,
                          child: Column(
                            children: [
                              GetBuilder<SignInControllerImp>(
                                  builder: (signInControllerImp) {
                                return CustomTextFormFieldAuthWidget(
                                  hintText: "Enter Your Email",
                                  labelText: "Email",
                                  textInputType: TextInputType.emailAddress,
                                  validator: (val) {
                                    return validInput(val!, 5, 100, 'email');
                                  },
                                  myEditingController:
                                      signInControllerImp.email,
                                );
                              }),
                              const SizedBox(height: 20.0),
                              GetBuilder<SignInControllerImp>(
                                  builder: (signInControllerImp) {
                                return CustomTextFormFieldAuthWidget(
                                  hintText: "Enter Your Password",
                                  labelText: "Password",
                                  textInputType: TextInputType.visiblePassword,
                                  validator: (val) {
                                    return validInput(val!, 5, 40, 'password');
                                  },
                                  myEditingController:
                                      signInControllerImp.password,
                                );
                              }),
                              const SizedBox(height: 10.0),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xff08B5B6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        GetBuilder<SignInControllerImp>(
                            builder: (signInControllerImp) {
                          return InkWell(
                            onTap: () {
                              signInControllerImp.signIn(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff08B5B6),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.white),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextSignUpAndSignIn(
                            text1: "Don't have an account?",
                            text2: "Sign Up",
                            onPressed: () {
                              signInControllerImp.goToSignUpPage();
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
