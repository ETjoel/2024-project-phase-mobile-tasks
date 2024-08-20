import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        actions: const [NotificationButton()],
      ),
      floatingActionButton: floatingButton(context),
      body: const Column(
        children: [
          SearchComponent(),
          ListBuilderBloc(),
        ],
      ),
    );
  }

  FloatingActionButton floatingButton(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
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
