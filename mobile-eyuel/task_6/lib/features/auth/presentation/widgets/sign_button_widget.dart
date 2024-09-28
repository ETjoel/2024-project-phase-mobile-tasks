import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants.dart';
import '../../../ecommerce/presentation/widgets/three_dot_waiting_widget.dart';
import '../bloc/auth_bloc.dart';

class SignButton extends StatelessWidget {
  final Function onPressed;
  final bool isSignIn;
  final double width;
  const SignButton({
    Key? key,
    required this.onPressed,
    this.width = double.infinity,
    required this.isSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (isSignIn) {
                if (state is AuthSignInLoading) {
                  return const ThreeDotWaiting(size: 15);
                } else {
                  return Text(
                    'SIGN IN',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  );
                }
              } else {
                if (state is AuthSignUpLoading) {
                  return const ThreeDotWaiting(size: 15);
                } else {
                  return Text(
                    'SIGN UP',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  );
                }
              }
            },
          ),
        ));
  }
}
