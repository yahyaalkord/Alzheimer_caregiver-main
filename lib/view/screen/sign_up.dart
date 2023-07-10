import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller/sign_up_controller.dart';
import '../../core/constant/image_assets.dart';
import '../../core/function/valid_input.dart';
import '../widget/auth_widget/custom_text_form_field_auth_widget.dart';
import '../widget/auth_widget/custom_text_signUp_and_signIn.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpControllerImp signUpControllerImp = Get.put(SignUpControllerImp());
    return Scaffold(
      body: SingleChildScrollView(
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
                  top: 80.0, bottom: 50.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MarckScript'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: const [
                  //     Text(
                  //       'Lets get,',
                  //       style: TextStyle(fontSize: 30.0),
                  //     ),
                  //     Text(
                  //       'you on board',
                  //       style: TextStyle(fontSize: 30.0),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 70,
                  ),
                  Form(
                    key: signUpControllerImp.formState,
                    child: Column(
                      children: [
                        CustomTextFormFieldAuthWidget(
                          hintText: "Enter Your name",
                          labelText: "Full Name",
                          textInputType: TextInputType.text,
                          myEditingController: signUpControllerImp.username,
                          validator: (val) {
                            return validInput(val!, 5, 100, 'username');
                          },
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextFormFieldAuthWidget(
                          hintText: "Enter Your Email",
                          labelText: "Email",
                          textInputType: TextInputType.emailAddress,
                          myEditingController: signUpControllerImp.email,
                          validator: (val) {
                            return validInput(val!, 10, 50, 'email');
                          },
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextFormFieldAuthWidget(
                          hintText: "Enter Your Phone",
                          labelText: "Phone",
                          textInputType: TextInputType.phone,
                          myEditingController: signUpControllerImp.phone,
                          validator: (val) {
                            return validInput(val!, 10, 50, 'phone');
                          },
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextFormFieldAuthWidget(
                          hintText: "Enter Your Password",
                          labelText: "Password",
                          textInputType: TextInputType.visiblePassword,
                          myEditingController: signUpControllerImp.password,
                          validator: (val) {
                            return validInput(val!, 5, 100, 'password');
                          },
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      signUpControllerImp.signUp(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xff08B5B6),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  CustomTextSignUpAndSignIn(
                      text1: "Already have an account?",
                      text2: "Sign In",
                      onPressed: () {
                        signUpControllerImp.goToSignInPage();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
