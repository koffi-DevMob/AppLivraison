import 'dart:async';
import 'package:emitrans_mobile/Services/authFirebase.dart';
import 'package:flutter/material.dart';


class PopUpOptionMenu extends StatelessWidget {

  final AuthentificationService _auth = AuthentificationService();

  static const SignOut = "Deconnxion";

  static const List<String> choices = <String>[ SignOut];

  var context;

  void initState(){
    //TODO: implement initState
    initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) async {
        switch (choice) {
          case 'Se déconecter':
            await _auth.signOut();
            break;
          default:
            Navigator.of(context).pushReplacementNamed('/');
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return choices.map((ch) {
          return PopupMenuItem<String>(value: ch, child: Text(ch));
        }).toList();
      },
    );
  }

  void afterClick(String choice) async {
    switch (choice) {
      case 'Se déconecter':
       await _auth.signOut();
        break;
      case 'Profil':
        print('User Profil');
        break;
      case 'Paramètres':
        print('User Settings');
        break;
      default:
        print('Default action');
        break;
    }
  }

  Future <Null>dialogues(String title)async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return SimpleDialog(
          title: Center(child: Text(title , textScaleFactor: 2,)),
          contentPadding: EdgeInsets.all(10),
          children: [
            RaisedButton(
                color: Colors.teal,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: (){
                  Navigator.pushReplacementNamed(
                      context, '/home');
                })
          ],);
      },
    );
  }

}



