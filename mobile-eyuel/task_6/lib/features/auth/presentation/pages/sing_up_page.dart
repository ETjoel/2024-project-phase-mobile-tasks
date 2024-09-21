import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants.dart';
import '../widgets/widgets.dart';

class DemoSignUpPage extends StatelessWidget {
  const DemoSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          canvasColor: Colors.white,
          useMaterial3: true,
          primaryColor: primaryColor,
          secondaryHeaderColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  bool checkboxValue = false;
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
        body: SingleChildScrollView(
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
                controller: emailController,
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
                controller: passwordController,
                obscureText: true,
                hintText: '********',
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Checkbox(value: checkboxValue, onChanged: (value) {}),
                  Text('I agree to the ',
                      style: GoogleFonts.poppins(color: Colors.grey.shade800)),
                  GestureDetector(
                    onTap: () {},
                    child: Text('terms and policy',
                        style: GoogleFonts.poppins(color: primaryColor)),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              SignButton(onPressed: () {}, name: 'SIGN IN'),
              SizedBox(
                height: size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an account? '),
                  GestureDetector(
                      onTap: () {},
                      child: const Text('SIGN IN',
                          style: TextStyle(color: primaryColor))),
                ],
              )
            ],
          ),
        ));
  }
}
