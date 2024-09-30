import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../widgets/widget.dart';
import 'add_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const UserInfo(),
        actions: const [LogoutButton()],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthGetUserSuccess) {
              return floatingChatButton(state.user);
            } else {
              return const SizedBox();
            }
          }),
          const SizedBox(height: 10),
          floatingButton(context),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignOutLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: ThreeDotWaiting(size: 20),
                  );
                });
          } else if (state is AuthSignOutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/signin', (Route<dynamic> route) => false);
          }
        },
        child: const Column(
          children: [
            SearchComponent(),
            ListBuilderBloc(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton floatingChatButton(UserEntity user) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: primaryColor,
      heroTag: 'chat',
      onPressed: () {
        Navigator.pushNamed(context, '/chatlist', arguments: user);
      },
      child: const Icon(Icons.chat, color: Colors.white),
    );
  }

  FloatingActionButton floatingButton(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
      heroTag: 'add',
      onPressed: () {
        Navigator.push(
          context,
          pageTransition(),
        );
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  PageRouteBuilder<dynamic> pageTransition() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return BlocProvider.value(
            value: context.read<ProductBloc>(), child: const AddProductPage());
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
