import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/ScreenLivreur/ListLivraison.dart';
import 'package:emitrans_mobile/ScreenLivreur/Ma_livraison.dart';
import 'package:emitrans_mobile/Services/databaseLivraison.dart';
import 'package:emitrans_mobile/common/loading.dart';
import 'package:emitrans_mobile/common/showSnackBar.dart';
import 'package:emitrans_mobile/const/text_style.dart';
import 'package:emitrans_mobile/models/livraisonmodel.dart';
import 'package:emitrans_mobile/models/userLivreur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Depense.dart';
import 'appbar.dart';
import 'design_course_app_theme.dart';
import 'livraisonTerminé.dart';

class HomeLivreurScreen extends StatefulWidget {
  final ModelLivraison liv;
  final String userID;
  const HomeLivreurScreen({this.liv, this.userID});
  @override
  _HomeLivreurScreenState createState() => _HomeLivreurScreenState();
}
class _HomeLivreurScreenState extends State<HomeLivreurScreen> {

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Livraison').snapshots();
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String arrive;

  Future<bool> checkLivraison() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String ville = sharedPreferences.getString('ville');
    bool check = sharedPreferences.getBool('isLivraison');
    arrive = ville;
    if (check != null) {
      return check;
    } else {
      check = false;
      return check;
    }
  }

  void supprime(BuildContext context, ){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Text('supprimé'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          },
              child:Text('annuler')
          ),
          ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
          },
          child: Text('supprime'),
          )
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    return FutureBuilder(
       future: checkLivraison(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          final bool isLivraison = snapshot.data;

          return
            loading ? Loading(): Scaffold(
            backgroundColor: DesignCourseAppTheme.nearlyWhite,
            body: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .padding
                        .top,
                  ),
                  getAppBarUI(user:_user),
                 Container(
                    height: 380,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                          child: Wrap(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  children: [
                                    if (!isLivraison) ...[
                                      Image.asset("assets/livraison/image.png"),
                                    ] else ...[
                                      SizedBox(height: 100,),
                                     Center(child: Text('Livraison en cours!', style: TextStyle(
                                       color: Colors.green, fontSize: 30, fontWeight: FontWeight.w700,
                                     ),),
                                     ),
                                      SizedBox(height: 100,),
                                      message(),
                                    ]
                                  ],
                                ),
                              )
                            ],
                          ),
                      ),
                    ),
                  ),
                  //ActionLivraison(userId: _user.uid,),
                  Expanded(
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        child: Column(
                          children: <Widget>[
                            if (!isLivraison) ...[
                              Padding(
                                padding: const EdgeInsets.only(left: 40, right: 40,),
                                child:Positioned(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Row(
                                        children: [
                                          Expanded(
                                              child:Container(
                                                height: 140,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.deepOrange,
                                                        Colors.orange,
                                                      ]
                                                  ),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20.0),
                                                      bottomLeft: Radius.circular(20.0),
                                                      bottomRight: Radius.circular(20.0),
                                                      topRight: Radius.circular(20.0)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey.withOpacity(1),
                                                        offset: Offset(1.1, 1.1),
                                                        blurRadius: 10.0),
                                                  ],
                                                ),
                                                child:Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 30,left: 10),
                                                      child: RaisedButton.icon(
                                                        icon: const Icon(FontAwesomeIcons.check,size: 55,color: Colors.white,),
                                                        color: Colors.transparent,
                                                        elevation: 0,
                                                        onPressed: () {
                                                          Navigator.push<dynamic>(
                                                            context,
                                                            MaterialPageRoute<dynamic>(
                                                              builder: (BuildContext context) => LivTerminer(),
                                                            ),
                                                          );
                                                        },
                                                        label: Text(""),
                                                      ),
                                                    ),
                                                    SizedBox(height: 15,),
                                                    Text('Livraison', style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Worksans"
                                                    ),)
                                                  ],
                                                ),

                                              )
                                          ),
                                          SizedBox(width: 20,),
                                          Expanded(
                                            child: Container(
                                                height: 140,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.deepOrange,
                                                        Colors.orange,
                                                      ]
                                                  ),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20.0),
                                                      bottomLeft: Radius.circular(20.0),
                                                      bottomRight: Radius.circular(20.0),
                                                      topRight: Radius.circular(20.0)),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color: Colors.grey.withOpacity(1),
                                                        offset: Offset(1.1, 1.1),
                                                        blurRadius: 10.0),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 30, left: 12),
                                                      child: RaisedButton.icon(
                                                        icon: const Icon(FontAwesomeIcons.list,size: 55,color: Colors.white,),
                                                        onPressed: () async {
                                                          Navigator.push<dynamic>(
                                                            context,
                                                            MaterialPageRoute<dynamic>(
                                                              builder: (BuildContext context) => MaLivraison(),
                                                            ),
                                                          );
                                                        },
                                                        color: Colors.transparent,
                                                        label: Text(""),
                                                        elevation: 0,
                                                      ),
                                                    ),

                                                    SizedBox(height: 15,),
                                                    Text('Mes Livraisons', style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Worksans"
                                                    ),)
                                                  ],
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ] else ...[
                              Padding(
                                padding: const EdgeInsets.only(left: 40, right: 40,),
                                child:Positioned(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Row(
                                        children: [
                                          Expanded(
                                              child:Container(
                                                height: 140,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.deepOrange,
                                                        Colors.orange,
                                                      ]
                                                  ),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20.0),
                                                      bottomLeft: Radius.circular(20.0),
                                                      bottomRight: Radius.circular(20.0),
                                                      topRight: Radius.circular(20.0)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey.withOpacity(1),
                                                        offset: Offset(1.1, 1.1),
                                                        blurRadius: 10.0),
                                                  ],
                                                ),
                                                child:Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 30,left: 10),
                                                      child: RaisedButton.icon(
                                                        icon: const Icon(FontAwesomeIcons.check,size: 55,color: Colors.white,),
                                                        color: Colors.transparent,
                                                        elevation: 0,
                                                        onPressed: () async {
                                                          try {
                                                            final result = await InternetAddress.lookup('google.com');
                                                            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                                              Navigator.push<dynamic>(
                                                                context,
                                                                MaterialPageRoute<dynamic>(
                                                                  builder: (BuildContext context) => LivTerminer(),
                                                                ),
                                                              );
                                                            }
                                                          } on SocketException catch (_) {
                                                            showNotification(context, 'Aucune connexion internet');
                                                          }
                                                        },
                                                        label: Text(""),
                                                      ),
                                                    ),
                                                    SizedBox(height: 15,),
                                                    Text('Livraison', style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Worksans"
                                                    ),)
                                                  ],
                                                ),

                                              )
                                          ),
                                          SizedBox(width: 20,),
                                          Expanded(
                                            child: Container(
                                                height: 140,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.deepOrange,
                                                        Colors.orange,
                                                      ]
                                                  ),
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20.0),
                                                      bottomLeft: Radius.circular(20.0),
                                                      bottomRight: Radius.circular(20.0),
                                                      topRight: Radius.circular(20.0)),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color: Colors.grey.withOpacity(1),
                                                        offset: Offset(1.1, 1.1),
                                                        blurRadius: 10.0),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 30, left: 12),
                                                      child: RaisedButton.icon(
                                                        icon: const Icon(FontAwesomeIcons.list,size: 55,color: Colors.white,),
                                                        onPressed: () {
                                                          alertencours("Une livraison est en cours, "
                                                              "merci de la terminer avant de prendre une autre");
                                                        },
                                                        color: Colors.transparent,
                                                        label: Text(""),
                                                        elevation: 0,
                                                      ),
                                                    ),

                                                    SizedBox(height: 15,),
                                                    Text('Mes Livraisons', style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Worksans"
                                                    ),)
                                                  ],
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]
                            ,
                          ],
                        ),
                      ),
                  ),
                ],
              ),
            ),
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Colors.deepOrange.withOpacity(1),
                splashColor: Colors.orange,
                elevation: 0,
                label: Text("Depenses",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:16 ,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                  ),),
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => DepenseScreen(),
                    ),
                  );
                },
                icon: Center(child: Icon(FontAwesomeIcons.wallet,size: 35,color: Colors.white,)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
          );
        }  );
  }
  Future alertencours(String title) async{
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title , textScaleFactor: 1,)),
          content: const Icon(Icons.clear, size: 90,color: Colors.red,),
          actions: [
            FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("OK")
            ),
          ],
        );
      },
    );
  }
  Future alerttermine(String title) async{
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title , textScaleFactor: 1,)),
          content: const Icon(Icons.check, size: 90,color: Colors.greenAccent,),
          actions: [
            FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Non")
            ),
            FlatButton(
              onPressed: () async{
                  DatabaseService().addLivraisonEff(widget.liv ,widget.userID);
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setBool('isLivraison', false);
                  supprime(context);
                  return
                    Navigator.pushReplacementNamed(context, '/home_livreur');
                },
              child: const Text("Oui"),
            ),
          ],
        );
      },
    );
  }

 Widget message(){
   return FutureBuilder(
       initialData: DatabaseService().livraison,
       future: checkLivraison(),
   builder: (BuildContext context, AsyncSnapshot snapshot) {
   if (snapshot.connectionState == ConnectionState.waiting) {
   return Loading();
   }
   final bool isLivraison = snapshot.data;

   return
     GestureDetector(
     child: RaisedButton(
       color: Colors.orange,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(50.0),
         //side: BorderSide(color: Colors.deepOrangeAccent,width:3)
       ),
       textColor:Colors.white,child: Text("Terminer",style: TextStyle(
         fontSize: 17,
         fontWeight: FontWeight.w600,
         color: Colors.white,
         fontFamily: 'Worksans'
     ),),
       onPressed: () async{
         if (isLivraison==true) {
           alerttermine("Avez-vous terminée la livraison?");
         }
       },
     ),
   );
     }
   );
 }

}

