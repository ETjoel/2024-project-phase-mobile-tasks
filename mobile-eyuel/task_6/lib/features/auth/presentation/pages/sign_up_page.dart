import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants.dart';
import '../../../ecommerce/presentation/controller.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  size: 15, color: primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Row(children: [
              Spacer(),
              EcomIconWidget(
                height: 30,
              )
            ])),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Account created successfully',
                      style: TextStyle(color: Colors.white))));
              Navigator.pop(context);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.failure.message,
                      style: TextStyle(color: Colors.white))));
            }
            if (state is AuthGetUserSuccess) {
              Navigator.pushNamed(context, '/home');
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(size.width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'create your account',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'poppins',
                          wordSpacing: 4,
                          letterSpacing: 1),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Name',
                  style: GoogleFonts.poppins(color: Colors.grey.shade800),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: nameController,
                  hintText: 'e.g. Papa Jones',
                ),
                const SizedBox(height: 5),
                Text(
                  'Email',
                  style: GoogleFonts.poppins(color: Colors.grey.shade800),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: emailController,
                  hintText: 'e.g. papajones@email.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 5),
                Text(
                  'Password',
                  style: GoogleFonts.poppins(color: Colors.grey.shade800),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: '********',
                ),
                const SizedBox(height: 5),
                Text(
                  'Confirm Password',
                  style: GoogleFonts.poppins(color: Colors.grey.shade800),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  hintText: '********',
                ),
                const SizedBox(height: 5),
                Obx(() {
                  if (authController.showInputError.value) {
                    return const Text('Please fill all the fields',
                        style: TextStyle(color: Colors.red));
                  } else if (!authController.doesConfirmPasswordMatch.value) {
                    return const Text('Please confirm your password correctly',
                        style: TextStyle(color: Colors.red));
                  } else {
                    return const SizedBox(
                      height: 10,
                    );
                  }
                }),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: authController.checkboxChecked.value,
                        isError: authController.checkboxError.value,
                        onChanged: (value) {
                          authController.toggleCheckbox();
                        })),
                    Text('I agree to the ',
                        style:
                            GoogleFonts.poppins(color: Colors.grey.shade800)),
                    GestureDetector(
                      onTap: () {},
                      child: Text('terms and policy',
                          style: GoogleFonts.poppins(color: primaryColor)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                SignButton(
                    onPressed: () {
                      if (emailController.text != '' &&
                          passwordController.text != '' &&
                          confirmPasswordController.text != '' &&
                          nameController.text != '') {
                        if (authController.checkboxChecked.value &&
                            passwordController.text ==
                                confirmPasswordController.text) {
                          context.read<AuthBloc>().add(AuthSignUpEvent(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text));
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          authController.toggleConfirmPasswordMatch();
                        } else if (!authController.checkboxChecked.value) {
                          authController.toggleCheckbox();
                        }
                      } else {
                        authController.toggleInputError();
                      }
                    },
                    isSignIn: false),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have an account? '),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text('SIGN IN',
                            style: TextStyle(color: primaryColor))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
