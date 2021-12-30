import 'package:emitrans_mobile/models/userLivreur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'design_course_app_theme.dart';

class getAppBarUI extends StatelessWidget {
  final User user;
  const getAppBarUI({ this.user}) ;

  @override
  Widget build(BuildContext context) {
    return  PreferredSize(
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
                        'Bienvenue ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.2,
                          color: DesignCourseAppTheme.nearlyBlack,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        user.email,
                        textAlign: TextAlign.left,
                        style: TextStyle(
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
                        onPressed: ()async{
                          await FirebaseAuth.instance.signOut().
                          then((value)=>Navigator.popAndPushNamed(context, '/wrapper_livreur'));
                        },
                        icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.red,size: 30,),
                        label: Text('',style: TextStyle(color: Colors.black),))
                )
              ],
            ),
          ),
        )
    );
  }
}
