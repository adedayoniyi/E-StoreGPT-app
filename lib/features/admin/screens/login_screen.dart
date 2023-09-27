
import 'package:estoregpt/core/utils/validators.dart';
import 'package:estoregpt/features/admin/services/admin_services.dart';
import 'package:estoregpt/widgets/custom_button.dart';
import 'package:estoregpt/widgets/custom_textfield.dart';
import 'package:estoregpt/widgets/height_space.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AdminServices authService = AdminServices();
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  double screenWidthValue = 0;

  loginAdmin() {
    if (loginFormKey.currentState!.validate()) {
      authService.loginInAdmin(
          context: context,
          email: emailController.text,
          password: passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidthValue = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFf6faf9),
            Color(0xFFf1eef7),
          ])),
          child: Form(
            key: loginFormKey,
            child: Row(
              mainAxisAlignment: getValueForScreenType<bool>(
                      context: context,
                      mobile: false,
                      tablet: false,
                      desktop: true)
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: [
                getValueForScreenType<bool>(
                        context: context,
                        mobile: false,
                        tablet: false,
                        desktop: true)
                    ? Image.asset(
                        "assets/images/full_logo.png",
                        height: 100,
                      )
                    : const SizedBox.shrink(),
                getValueForScreenType<bool>(
                        context: context,
                        mobile: false,
                        tablet: false,
                        desktop: true)
                    ? const VerticalDivider(
                        color: Color(0xFF70d5f8),
                      )
                    : const SizedBox.shrink(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/full_logo.png",
                      height: 70,
                    ),
                    const HeightSpace(20),
                    Center(
                      child: Container(
                        height: 400,
                        width: 330,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const HeightSpace(10),
                              CustomTextField(
                                hintText: "Email",
                                controller: emailController,
                                validator: validateEmail,
                              ),
                              CustomTextField(
                                hintText: "Password",
                                controller: passwordController,
                                validator: validateField,
                              ),
                              const HeightSpace(20),
                              CustomButton(
                                buttonText: "Login",
                                buttonTextColor: Colors.white,
                                borderRadius: 20,
                                buttonColor: const Color(0xFF70d5f8),
                                onTap: () {
                                  loginAdmin();
                                },
                              )
                            ],
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
      ),
    );
  }
}
