import 'package:clone/resources/auth_methods.dart';
import 'package:clone/screens/signup_screen.dart';
import 'package:clone/utils/colors.dart';
import 'package:clone/utils/utils.dart';
import 'package:clone/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreenState extends StatefulWidget {
  const LoginScreenState({super.key});

  @override
  State<LoginScreenState> createState() => _LoginScreenStateState();
}

class _LoginScreenStateState extends State<LoginScreenState> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoding = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoding = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      //have to show snackbar
      showSnackBar(res, context);
    }
    setState(() {
      _isLoding = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              //svg image
              Image.asset(
                'assets/guru.png',
                height: 70,
              ),
              const SizedBox(height: 64),
              //textfield input for email
              TextFieldInput(
                  hintText: 'Enter your Email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController),
              //textfield input for pswd

              const SizedBox(
                height: 25,
              ),

              TextFieldInput(
                hintText: 'Enter your Password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),

              const SizedBox(
                height: 25,
              ),
              //login button

              InkWell(
                onTap: loginUser,
                child: Center(
                  child: Container(
                    child: _isLoding
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Log in'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: blueColor),
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 2),
              //Transitioning to signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
