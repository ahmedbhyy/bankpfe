import 'package:animate_do/animate_do.dart';
import 'package:bankpfe/controllers/auth/sign_in_controller.dart';

import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../functions/auth_function.dart';
import '../../widgets/generalwidgets/common_loading_progress.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    SignInControllerImp controller = Get.put(SignInControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xff00aa86),
      body: Form(
        key: controller.formStateSignIn,
        child: SafeArea(
          child: ListView(
            children: [
              FadeInRight(
                duration: const Duration(milliseconds: 800),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 15.0),
                  child: Text(
                    "Sign In",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.mulish(
                      fontSize: 30.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              GetBuilder<SignInControllerImp>(
                builder: (controller) => Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                        child: FadeInRight(
                          duration: const Duration(seconds: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.mulish(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 114, 120, 120),
                                ),
                              ),
                              Image.asset(
                                "images/bna.png",
                                height: 50.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: FadeInRight(
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            "Hello there,sign in to continue",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.mulish(
                              fontSize: 20.0,
                              color: const Color.fromARGB(255, 10, 135, 96),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Center(
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 800),
                          child: Lottie.asset(
                            "images/lotties/lottie_animation3.json",
                            height: 180.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FadeInRight(
                          duration: const Duration(milliseconds: 800),
                          child: TextFieldAuth(
                            hint: "Email",
                            readonly: false,
                            mytype: TextInputType.emailAddress,
                            mycontroller: controller.emailcontroller,
                            myicon: const Icon(
                              Icons.person_2_outlined,
                              color: Color(0xff00aa86),
                            ),
                            ispass: false,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Can't to be empty ";
                              } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(val)) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 800),
                          child: TextFieldAuth(
                            hint: "Password",
                            readonly: false,
                            mytype: TextInputType.text,
                            mycontroller: controller.passwordcontroller,
                            mysuffixicon: GestureDetector(
                              onTap: () {
                                controller.hidepaasword();
                              },
                              child: Icon(
                                controller.ispasswordhidden
                                    ? Icons.visibility_off
                                    // ignore: dead_code
                                    : Icons.visibility,
                                color: const Color.fromARGB(255, 26, 105, 30),
                              ),
                            ),
                            myicon: const Icon(
                              Icons.key,
                              color: Color(0xff00aa86),
                            ),
                            ispass: controller.ispasswordhidden,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Can't to be empty ";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      controller.isloading2
                          ? const CommonLoading()
                          : InkWell(
                              onTap: () {
                                if (controller.emailcontroller.text == "" ||
                                    controller.emailcontroller.text.isEmpty) {
                                  Get.rawSnackbar(
                                      title: "Error",
                                      message: "Please write your email",
                                      backgroundColor: Colors.red);
                                } else {
                                  controller.forgetpassword(
                                      controller.emailcontroller.text);
                                }
                              },
                              child: FadeInLeft(
                                duration: const Duration(milliseconds: 800),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 1.7,
                                    top: 10.0,
                                  ),
                                  child: const Text(
                                    "Forget Password ?",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color.fromARGB(255, 1, 95, 75),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 25.0),
                      controller.isloading1
                          ? const CommonLoading()
                          : FadeInRight(
                              duration: const Duration(milliseconds: 900),
                              child: ButtonAuth(
                                mytitle: "Sign In",
                                myfunction: () {
                                  if (controller.formStateSignIn.currentState!
                                      .validate()) {
                                    controller.signin(
                                        controller.emailcontroller.text,
                                        controller.passwordcontroller.text);
                                  }
                                },
                              ),
                            ),
                      const SizedBox(height: 25.0),
                      InkWell(
                        onTap: () async {
                          controller.supportstate
                              ? await authenticate("Sign In")
                              : Get.rawSnackbar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 0, 0),
                                  title: "Not Supported",
                                  message:
                                      "Your phone doesnt support this  method to sign in, Please sign in with your email",
                                );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20.0,
                            ),
                            FadeInLeft(
                              duration: const Duration(milliseconds: 900),
                              child: Image.asset(
                                "images/faceid.png",
                                height: 50.0,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            FadeInRight(
                              duration: const Duration(milliseconds: 900),
                              child: Image.asset(
                                "images/emprinte.png",
                                height: 90.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInLeft(
                            duration: const Duration(milliseconds: 900),
                            child: Text(
                              "Don't have an account?  ",
                              style: GoogleFonts.mulish(
                                fontSize: 17.0,
                                color: const Color.fromARGB(255, 10, 135, 96),
                              ),
                            ),
                          ),
                          FadeInRight(
                            duration: const Duration(milliseconds: 900),
                            child: InkWell(
                              onTap: () {
                                controller.gotosignup(context);
                              },
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.mulish(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 10, 135, 96),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
