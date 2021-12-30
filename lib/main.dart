import 'dart:io';
import 'package:emitrans_mobile/ScreenLivreur/home_livreur.dart';
import 'package:emitrans_mobile/ScreenLivreur/livraisonTermin%C3%A9.dart';
import 'package:emitrans_mobile/ScreenMarchand/List_livraison.dart';
import 'package:emitrans_mobile/Services/authFirebase.dart';
import 'package:emitrans_mobile/Services/databaseLivraison.dart';
import 'package:emitrans_mobile/Services/databaseLivreur.dart';
import 'package:emitrans_mobile/Wrapper.dart';
import 'package:emitrans_mobile/auth/authentication.dart';
import 'package:emitrans_mobile/const/app_theme.dart';
import 'package:emitrans_mobile/introduction_animation/introduction_animation_screen.dart';
import 'package:emitrans_mobile/models/livraisonmodel.dart';
import 'package:emitrans_mobile/models/userLivreur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'Inscription/Ins_Livreur.dart';
import 'Inscription/Ins_Marchand.dart';
import 'ScreenLivreur/Depense.dart';
import 'ScreenLivreur/Ma_livraison.dart';
import 'ScreenMarchand/home_marchand.dart';
import 'Services/authServices.dart';
import 'WrapperMarchand.dart';
import 'auth/authLivreur.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        StreamProvider<LivreurUserData>.value(value: AuthentificationService().user,
          initialData: null,),
        StreamProvider<User>.value(
          initialData: null,
          value: AuthService().user,
        ),
        StreamProvider<List<ModelLivraison>>.value(
          initialData: [],
          value: DatabaseService().livraison,
        ),
      ],
        child: MaterialApp(
          title: 'EMITRANS',
          debugShowCheckedModeBanner: false,
          initialRoute:'/',
          routes: {
           '/': (context) => IntroductionAnimationScreen(),
            //'/': (context) => HomeLivreurScreen(),
            '/wrapper_livreur': (context) => WrapperLivreurScreen(),
            '/wrapper_marchand': (context) => WrapperMarchandScreen(),
            '/login_marchand': (context) => LoginMarchandScreen(),
            '/login_livreur': (context) => LoginLivreurScreen(),
            '/inscrit_marchand': (context) => InscritMarchand(),
            '/inscrit_livreur': (context) => InscritLivreur(),
            '/home_marchand': (context) => HomeMarchandScreen(),
            '/home_livreur': (context) => HomeLivreurScreen(),
            '/liste_livraison': (context) => ListeLivraison(),
            '/ma_livraison': (context) => MaLivraison(),
            '/ajout_depense': (context) => DepenseScreen(),
            '/list_terminer': (context) => LivTerminer(),

          },
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            textTheme: AppTheme.textTheme,
            platform: TargetPlatform.iOS,
          ),
          //home: IntroductionAnimationScreen(),
        ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}