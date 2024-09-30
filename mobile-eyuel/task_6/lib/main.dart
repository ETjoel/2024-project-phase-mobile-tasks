import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants.dart';
import 'features/auth/domain/entities/user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/sign_in_page.dart';
import 'features/auth/presentation/pages/sign_up_page.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/chat/presentation/pages/chat_list_page.dart';
import 'features/chat/presentation/pages/chatroom_page.dart';
import 'features/ecommerce/presentation/bloc/product_bloc/product_bloc.dart';
import 'features/ecommerce/presentation/pages/home_page.dart';
import 'features/ecommerce/presentation/widgets/three_dot_waiting_widget.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => sl<AuthBloc>()..add(AuthGetUserEvent())),
          BlocProvider(
            create: (context) => sl<ProductBloc>(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            canvasColor: Colors.white,
            useMaterial3: true,
          ),
          routes: {
            '/home': (context) {
              context.read<ProductBloc>().add(LoadAllProductsEvent());
              return const HomePage();
            },
            '/chatroom': (context) => const ChatPage(),
            '/signin': (context) => SignInPage(),
            '/signup': (context) => SignUpPage(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/chatlist') {
              final user = settings.arguments as UserEntity;
              return MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) =>
                        sl<ChatBloc>()..add(LoadMyChatListEvent()),
                    child: ChatListPage(user: user),
                  );
                },
              );
            }
            return null;
          },
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthGetUserLoading) {
                return const Scaffold(
                  body: Center(
                    child: ThreeDotWaiting(
                      size: 20,
                      color: primaryColor,
                    ),
                  ),
                );
              } else if (state is AuthGetUserSuccess) {
                return BlocProvider(
                  create: (context) =>
                      sl<ProductBloc>()..add(LoadAllProductsEvent()),
                  child: const HomePage(),
                );
              } else {
                return SignInPage();
              }
            },
          ),
        ));
  }
}
