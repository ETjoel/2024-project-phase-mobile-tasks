import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants.dart';
import '../../../ecommerce/presentation/controller.dart';
import '../../../ecommerce/presentation/widgets/widget.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/widgets.dart' as auth_widgets;

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(size.width * 0.08),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignInSuccess) {
            context.read<AuthBloc>().add(AuthGetUserEvent());
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
          if (state is AuthGetUserSuccess) {
            Navigator.pushNamed(context, '/home');
          }
        },
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                height: size.height * 0.25,
                width: double.infinity,
                child: const auth_widgets.EcomIconWidget(
                  height: 50,
                  width: 120,
                )),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'sign into your account',
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
              'Email',
              style: GoogleFonts.poppins(color: Colors.grey.shade800),
            ),
            const SizedBox(height: 3),
            auth_widgets.CustomTextField(
              controller: emailController,
              hintText: 'papajones@email.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 3),
            Text(
              'Password',
              style: GoogleFonts.poppins(color: Colors.grey.shade800),
            ),
            const SizedBox(height: 3),
            auth_widgets.CustomTextField(
              controller: passwordController,
              obscureText: true,
              hintText: '********',
            ),
            SizedBox(
              height: size.height * 0.09,
            ),
            auth_widgets.SignButton(
                onPressed: () {
                  if (emailController.text != '' &&
                      passwordController.text != '') {
                    context.read<AuthBloc>().add(AuthSignInEvent(
                        emailController.text, passwordController.text));
                  }
                },
                name: 'SIGN IN'),
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                GestureDetector(
                    onTap: () {},
                    child: const Text('SIGN UP',
                        style: TextStyle(color: primaryColor))),
              ],
            )
          ],
        )),
      ),
    ));
  }
}
