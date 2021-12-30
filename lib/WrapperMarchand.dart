import 'package:emitrans_mobile/ScreenMarchand/home_marchand.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/authentication.dart';

class WrapperMarchandScreen extends StatelessWidget {
  const WrapperMarchandScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _marchand = Provider.of<User>(context);
    if (_marchand == null){
      return LoginMarchandScreen();
    } else{
      return HomeMarchandScreen();
    }
  }
}
