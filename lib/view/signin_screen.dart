import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantumit/controller/controller_value.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quantumit/utils/sharedpreference_helper.dart';
import 'package:quantumit/utils/validaton.dart';
import 'package:quantumit/view/homepage_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _controller = Get.put(ControllerValue());
  final auth = FirebaseAuth.instance;

  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameRegisterController = TextEditingController();
  TextEditingController _emailRegisterController = TextEditingController();
  TextEditingController _contactRegisterController = TextEditingController();
  TextEditingController _passwordRegisterController = TextEditingController();

  void googleSignIn(BuildContext context) async {
    try {
      var value = await _googleSignIn.signIn();
      if (value != null) {
        SharedPreferencesHelper.setLoginValue(
            SharedPreferencesHelper.loginKey, true);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePageScreen()));
      }
      print("signIn");
    } on Exception catch (e) {
      print(e);
    }
  }

  onFacebookLogin(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      SharedPreferencesHelper.setLoginValue(
          SharedPreferencesHelper.loginKey, true);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePageScreen()));
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future signIn() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      body: Obx(() => Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: Row(
                  children: const [
                    Text(
                      "Social",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'X',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        _controller.updateSignInValue(false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: !_controller.signInValue.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        decoration: BoxDecoration(
                            color: _controller.signInValue.value
                                ? Colors.white
                                : Colors.red,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        _controller.updateSignInValue(true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: _controller.signInValue.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        decoration: BoxDecoration(
                            color: _controller.signInValue.value
                                ? Colors.red
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                      ),
                    ))
                  ],
                ),
              ),
              !_controller.signInValue.value
                  ? SignInPage(context)
                  : SignUPPage(context),
              GestureDetector(
                onTap: () {
                  if (_loginFormKey.currentState?.validate() ?? false) {
                    if (_controller.signInValue.isFalse) {
                      signIn().then((value) {
                        if (value == null) {
                          SharedPreferencesHelper.setLoginValue(
                              SharedPreferencesHelper.loginKey, true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePageScreen()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              value,
                              style: TextStyle(fontSize: 16),
                            ),
                          ));
                        }
                      });
                    }
                  }
                  if (_registerFormKey.currentState?.validate() ?? false) {
                    if (_controller.signInValue.isTrue) {
                      if (_controller.termsAndConditionsValue.value) {
                       auth.createUserWithEmailAndPassword(
                            email: _emailRegisterController.text,
                            password: _passwordRegisterController.text);
                      }
                    }
                  } else {
                    print("rror");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: !_controller.signInValue.value
                      ? const Text(
                          "login",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      : const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                ),
              )
            ],
          )),
    );
  }

  Widget SignInPage(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 100, left: 20),
              child: Text(
                'SIgnIn into your account',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.topLeft, child: Text("Email")),
                  customTextFormField(
                      const Icon(
                        Icons.mail,
                        color: Colors.red,
                      ),
                      _emailController,
                      "Johndoe@gmail.com",
                      Validation.emailValidation),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                      alignment: Alignment.topLeft, child: Text("Password")),
                  customTextFormField(
                      const Icon(
                        Icons.lock,
                        color: Colors.red,
                      ),
                      _passwordController,
                      "******",
                      Validation.PasswordVarification),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                )),
            const SizedBox(
              height: 20,
            ),
            const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Login with",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _googleSignIn;
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1)),
                    alignment: Alignment.center,
                    child: const Text(
                      "G",
                      style: TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () {
                      onFacebookLogin(context);
                    },
                    child: Icon(
                      Icons.facebook,
                      size: 50,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Don't have an Account ? ",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Register Now",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget SignUPPage(BuildContext context) {
    return Expanded(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _registerFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                      alignment: Alignment.topLeft, child: Text("Name")),
                  customTextFormField(
                      Icon(Icons.verified_user),
                      _nameRegisterController,
                      "John Doe",
                      Validation.registerNameVaidation),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                      alignment: Alignment.topLeft, child: Text("Email")),
                  customTextFormField(
                      Icon(Icons.email),
                      _emailRegisterController,
                      "johndoe@gmail.com",
                      Validation.registerEmailvalidation),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Phone Number")),
                  Row(
                    children: [
                      CountryCodePicker(
                        showDropDownButton: true,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          controller: _contactRegisterController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Phone Number";
                            }
                            if (value.length < 8) {
                              return "Enter Valid Phone Number";
                            } else {
                              null;
                            }
                          },
                          decoration:
                              const InputDecoration(hintText: "Phone Number"),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                      alignment: Alignment.topLeft, child: Text("Password")),
                  customTextFormField(
                      Icon(Icons.lock),
                      _passwordRegisterController,
                      "********",
                      Validation.registerPasswordValidation),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 100, left: 20),
              child: Text(
                'Create an Account',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.red),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: _controller.updateTermsAndConditions,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: _controller.termsAndConditionsValue.value
                            ? Colors.red
                            : Colors.white,
                        border: Border.all(color: Colors.red, width: 1)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text("I agree With "),
                const Text(
                  "Terms & Conditoins",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      decoration: TextDecoration.underline),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Already Have an account "),
                Text(
                  " Sign In",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      decoration: TextDecoration.underline),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget customTextFormField(Widget icon, TextEditingController controller,
      String hintText, String? Function(String?)? validator) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(hintText: hintText, suffix: icon),
    );
  }
}
