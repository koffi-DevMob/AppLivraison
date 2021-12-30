import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ScreenLivreur/home_livreur.dart';
import 'auth/authLivreur.dart';

class WrapperLivreurScreen extends StatelessWidget {
  const WrapperLivreurScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _livreur = Provider.of<User>(context);
    if (_livreur == null){
      return LoginLivreurScreen();
    } else{
      return HomeLivreurScreen();
    }
  }
}
