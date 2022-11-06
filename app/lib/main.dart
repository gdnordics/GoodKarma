import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/screens/home/home_screen.dart';
import 'package:good_karma_app/screens/login/login_screen.dart';
import 'package:good_karma_app/services/search_service.dart';
import 'package:good_karma_app/services/storage_service.dart';
import 'package:provider/provider.dart';

import 'models/user_data.dart';
import 'services/auth_service.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserData(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
        Provider<StorageService>(
          create: (_) => StorageService(),
        ),
        Provider<SearchService>(
          create: (_) => SearchService(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  Widget _getScreenId() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data!.uid;
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karma App',
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
      ),
      home: _getScreenId(),
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
      },
    );
  }
}