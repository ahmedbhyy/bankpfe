import 'package:animate_do/animate_do.dart';
import 'package:bankpfe/controllers/auth/sign_up_controller.dart';
import 'package:bankpfe/widgets/authwidgets/button_auth.dart';
import 'package:bankpfe/widgets/authwidgets/textfield_auth.dart';
import 'package:bankpfe/widgets/generalwidgets/common_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpControllerImp controller = Get.put(SignUpControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xff00aa86),
      body: Form(
        key: controller.formStatesingup,
        child: SafeArea(
          child: ListView(
            children: [
              FadeInRight(
                duration: const Duration(milliseconds: 800),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 15.0),
                  child: Text(
                    "Sign Up",
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
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
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
                              "Welcome to us",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.mulish(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 114, 120, 120),
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
                          "Hello there,create New account",
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
                          hint: "Username",
                          readonly: false,
                          mytype: TextInputType.text,
                          mycontroller: controller.usernamecontroller,
                          myicon: const Icon(
                            Icons.person_2_outlined,
                            color: Color(0xff00aa86),
                          ),
                          ispass: false,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Can't to be empty ";
                            }
                            return null;
                          },
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
                            Icons.email_outlined,
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
                    GetBuilder<SignUpControllerImp>(
                      builder: (controller) => Padding(
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
                                controller.isPasswordHidden
                                    ? Icons.visibility_off
                                    // ignore: dead_code
                                    : Icons.visibility,
                              ),
                            ),
                            myicon: const Icon(
                              Icons.key,
                              color: Color(0xff00aa86),
                            ),
                            ispass: controller.isPasswordHidden,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Can't to be empty ";
                              } else if (val.length < 8) {
                                return 'Weak password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    GetBuilder<SignUpControllerImp>(
                      builder: (controller) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: FadeInLeft(
                          duration: const Duration(milliseconds: 800),
                          child: TextFieldAuth(
                            hint: "Confirm Password",
                                  readonly: false,
                            mytype: TextInputType.text,
                            mycontroller: controller.repasswordcontroller,
                            mysuffixicon: GestureDetector(
                              onTap: () {
                                controller.hiderepaasword();
                              },
                              child: Icon(
                                controller.isrePasswordHidden
                                    ? Icons.visibility_off
                                    // ignore: dead_code
                                    : Icons.visibility,
                              ),
                            ),
                            myicon: const Icon(
                              Icons.key,
                              color: Color(0xff00aa86),
                            ),
                            ispass: controller.isrePasswordHidden,
                            validator: (val) {
                              controller.validatePassword(
                                val!,
                              );
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    controller.isloading
                        ? const CommonLoading()
                        : FadeInRight(
                            duration: const Duration(milliseconds: 900),
                            child: ButtonAuth(
                              mytitle: "Sign Up",
                              myfunction: () {
                                if (controller.formStatesingup.currentState!
                                    .validate()) {
                                  controller.signup(
                                      controller.emailcontroller.text,
                                      controller.passwordcontroller.text,
                                      context);
                                }
                              },
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
                            "Already have an account?  ",
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
                              controller.gotosignIn(context);
                            },
                            child: Text(
                              "Sign In",
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
            ],
          ),
        ),
      ),
    );
  }
}
