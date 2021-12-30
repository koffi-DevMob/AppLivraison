
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/ScreenLivreur/design_course_app_theme.dart';
import 'package:emitrans_mobile/ScreenMarchand/List_livraison.dart';
import 'package:emitrans_mobile/Services/authServices.dart';
import 'package:emitrans_mobile/common/loading.dart';
import 'package:emitrans_mobile/common/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Livraison.dart';


class HomeMarchandScreen extends StatefulWidget {
  @override
  _HomeMarchandScreenState createState() => _HomeMarchandScreenState();
}

class _HomeMarchandScreenState extends State<HomeMarchandScreen> {
  bool loading = false;

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    return  loading?Loading():
          Scaffold(
               backgroundColor: DesignCourseAppTheme.nearlyWhite,
                body: Column(
                children: <Widget>[
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .padding
                      .top,
                ),
                getAppBarUI(user: _user),
                SizedBox(height: 10,),
                Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(bottom: 30),
                    child: GestureDetector(
                      child: Wrap(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Image.asset("assets/livraison/image1.png"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                 Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 50,),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40, right: 40,),
                            child: Positioned(
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius
                                                .all(
                                                Radius.circular(10.0)),
                                            // border: new Border.all(
                                            //     color: DesignCourseAppTheme.notWhite),
                                          ),
                                          child: Row(
                                            children: [
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
                                                      borderRadius: BorderRadius
                                                          .only(
                                                          topLeft: Radius
                                                              .circular(20.0),
                                                          bottomLeft: Radius
                                                              .circular(20.0),
                                                          bottomRight: Radius
                                                              .circular(20.0),
                                                          topRight: Radius
                                                              .circular(20.0)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(0),
                                                            offset: Offset(
                                                                1.1, 1.1),
                                                            blurRadius: 10.0),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(top: 30,),
                                                          child: RaisedButton.icon(
                                                            icon: const Icon(
                                                              FontAwesomeIcons
                                                                  .shippingFast,
                                                              size: 55,
                                                              color: Colors
                                                                  .white,),
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 0,
                                                            onPressed: () {
                                                              showCarDialog(context, _user);
                                                            },
                                                            label: Text(""),
                                                          ),
                                                        ),
                                                        SizedBox(height: 15,),
                                                        Text('Ma Livraison',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontWeight: FontWeight
                                                                  .w600,
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
                                                      borderRadius: BorderRadius
                                                          .only(
                                                          topLeft: Radius
                                                              .circular(20.0),
                                                          bottomLeft: Radius
                                                              .circular(20.0),
                                                          bottomRight: Radius
                                                              .circular(20.0),
                                                          topRight: Radius
                                                              .circular(20.0)),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(0),
                                                            offset: Offset(
                                                                1.1, 1.1),
                                                            blurRadius: 10.0),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(top: 30,
                                                              left: 12),
                                                          child: RaisedButton
                                                              .icon(
                                                            icon: const Icon(
                                                              FontAwesomeIcons
                                                                  .list,
                                                              size: 55,
                                                              color: Colors
                                                                  .white,),
                                                            onPressed: () {
                                                              Navigator.push<
                                                                  dynamic>(
                                                                context,
                                                                MaterialPageRoute<
                                                                    dynamic>(
                                                                  builder: (
                                                                      BuildContext context) =>
                                                                      ListeLivraison(),
                                                                ),
                                                              );
                                                            },
                                                            color: Colors
                                                                .transparent,
                                                            label: Text(""),
                                                            elevation: 0,
                                                          ),
                                                        ),

                                                        SizedBox(height: 15,),
                                                        Text(
                                                          'Liste de Livraisons',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontFamily: "Worksans"
                                                          ),)
                                                      ],
                                                    )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void showCarDialog(BuildContext context, User vendeur) async {
    if (kIsWeb) {
      CarDialog(vendeur: vendeur).showCarDialog(context, ImageSource.camera);
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          CarDialog(vendeur: vendeur).showCarDialog(context, ImageSource.camera);
        }
      } on SocketException catch (_) {
        showNotification(context, 'Aucune connexion internet');
      }
    }
  }

  Widget getAppBarUI({ final User user}) {
          return PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.deepOrange,
                          Colors.yellow,
                        ]
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Bienvenue',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: DesignCourseAppTheme.nearlyBlack,
                              ),
                            ),
                            SizedBox(height: 1,),
                            Text(
                                user.email,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "Worksans",
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.notWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: TextButton.icon(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut().
                                then((value) =>
                                    Navigator.popAndPushNamed(
                                        context, '/wrapper_marchand'));
                              },
                              icon: Icon(
                                FontAwesomeIcons.signOutAlt, color: Colors.red,
                                size: 30,),
                              label: Text('', style: TextStyle(color: Colors
                                  .black),))
                      )
                    ],
                  ),
                ),
              )
          );
  }

  signOut(BuildContext context) {
    Navigator.popAndPushNamed(
        context, '/wrapper_marchand');
    AuthService().signOut();
  }
}
