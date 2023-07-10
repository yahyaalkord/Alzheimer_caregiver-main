import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../controller/auth_controller/sign_up_for_patient_controller.dart';
import '../../core/constant/image_assets.dart';
import '../../core/function/valid_input.dart';
import '../../model/common/navigation_drawer.dart' as custom;
import '../widget/auth_widget/custom_text_form_field_auth_widget.dart';
import '../widget/other/custom_home_container.dart';

class SignUpForPatient extends StatelessWidget {
  const SignUpForPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpForPatientControllerImp signUpForPatientControllerImp =
        Get.put(SignUpForPatientControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Patient"),
        centerTitle: true,
        backgroundColor: Color(0xff096b6c),
        elevation: 0,
      ),
      drawer: const custom.NavigationDrawer(),
      body: SingleChildScrollView(
        child: GetBuilder<SignUpForPatientControllerImp>(
          builder: (signUpForPatientControllerImp) {
            return ModalProgressHUD(
              inAsyncCall: signUpForPatientControllerImp.showSpinner,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: CustomHomeContainer(
                        widget: Text(""),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 60.0, bottom: 50.0, left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            'Add A New Patient',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontFamily: 'MarckScript'),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
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
                          height: 40,
                        ),
                        Form(
                          key: signUpForPatientControllerImp.formState,
                          child: Column(
                            children: [
                              CustomTextFormFieldAuthWidget(
                                hintText: " Enter Your name",
                                labelText: " Full Name",
                                textInputType: TextInputType.text,
                                myEditingController:
                                    signUpForPatientControllerImp.username,
                                validator: (val) {
                                  return validInput(val!, 5, 100, 'username');
                                },
                              ),
                              const SizedBox(height: 20.0),
                              CustomTextFormFieldAuthWidget(
                                hintText: " Enter Your Email",
                                labelText: " Email",
                                textInputType: TextInputType.emailAddress,
                                myEditingController:
                                    signUpForPatientControllerImp.email,
                                validator: (val) {
                                  return validInput(val!, 10, 50, 'email');
                                },
                              ),
                              const SizedBox(height: 20.0),
                              CustomTextFormFieldAuthWidget(
                                hintText: " Enter Your Phone",
                                labelText: " Phone",
                                textInputType: TextInputType.phone,
                                myEditingController:
                                    signUpForPatientControllerImp.phone,
                                validator: (val) {
                                  return validInput(val!, 10, 50, 'phone');
                                },
                              ),
                              const SizedBox(height: 20.0),
                              CustomTextFormFieldAuthWidget(
                                hintText: " Enter Your Password",
                                labelText: " Password",
                                textInputType: TextInputType.visiblePassword,
                                myEditingController:
                                    signUpForPatientControllerImp.password,
                                validator: (val) {
                                  return validInput(val!, 5, 100, 'password');
                                },
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        InkWell(
                          onTap: () {
                            signUpForPatientControllerImp.signUp(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xff08B5B6),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              'Register Patient',
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
