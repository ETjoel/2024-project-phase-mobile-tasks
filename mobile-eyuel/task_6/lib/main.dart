import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/pages/sign_in_page.dart';
import 'features/auth/presentation/pages/sing_up_page.dart';
import 'features/chat/presentation/pages/chat_page.dart';
import 'features/ecommerce/presentation/bloc/product_bloc/product_bloc.dart';
import 'features/ecommerce/presentation/pages/home_page.dart';
import 'injection_container.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await init();
  runApp(const DemoChatPage());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  sl<ProductBloc>()..add(LoadAllProductsEvent())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            canvasColor: Colors.white,
            useMaterial3: true,
          ),
          home: const HomePage(),
        ));
  }
}
