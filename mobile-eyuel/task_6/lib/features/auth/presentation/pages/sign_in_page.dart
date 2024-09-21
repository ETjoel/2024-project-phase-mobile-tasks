import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants.dart';
import '../widgets/widgets.dart';

class DemoSighInPage extends StatelessWidget {
  const DemoSighInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(size.width * 0.08),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                height: size.height * 0.25,
                width: double.infinity,
                child: const EcomIconWidget(
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
            CustomTextField(
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
            CustomTextField(
              controller: passwordController,
              obscureText: true,
              hintText: '********',
            ),
            SizedBox(
              height: size.height * 0.09,
            ),
            SignButton(onPressed: () {}, name: 'SIGN IN'),
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
        ),
      ),
    ));
  }
}
