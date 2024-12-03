import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/providers/coupon_provider.dart';
import 'package:sp_pontos/core/providers/photo_provider.dart';
import 'package:sp_pontos/core/providers/tourist_attraction_provider.dart';
import 'package:sp_pontos/core/styles/theme/theme.dart';
import 'package:sp_pontos/features/auth/CYO/presenter/page/CYO.dart';
import 'package:sp_pontos/features/auth/data/auth_repository.dart';
import 'package:sp_pontos/features/auth/signin/presenter/pages/signin_page.dart';
import 'package:sp_pontos/features/auth/signin/presenter/state/auth_sigin_state.dart';
import 'package:sp_pontos/features/auth/signup/presenter/pages/signup_page.dart';
import 'package:sp_pontos/features/auth/signup/presenter/state/auth_signup_state.dart';
import 'package:sp_pontos/features/cupons/presenter/pages/cupons_page.dart';
import 'package:sp_pontos/features/details_place/presenter/pages/details_page.dart';
import 'package:sp_pontos/features/explore/presenter/page/explorer_page.dart';
import 'package:sp_pontos/features/home/presenter/page/home_page.dart';
import 'package:sp_pontos/features/perfil/presenter/pages/perfil_page.dart';
import 'package:sp_pontos/features/upload/presenter/pages/upload_page.dart';
import 'package:sp_pontos/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthSignupState(AuthRepository(FirebaseAuth.instance)),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthSiginState(AuthRepository(FirebaseAuth.instance)),
        ),
        ChangeNotifierProvider(create: (_) => TouristAttractionProvider()),
        ChangeNotifierProvider(create: (_) => PhotoProvider()),
        ChangeNotifierProvider(create: (_) => CouponProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      routes: {
        '/': (context) => CYOPage(),
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/details': (context) => DetailsPage(),
        '/cupons': (context) => CuponsPage(),
        '/explorer': (context) => ExplorerPage(),
        '/perfil': (context) => PerfilPage(),
        '/upload': (context) => UploadPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
