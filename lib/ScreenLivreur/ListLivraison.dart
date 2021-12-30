import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/ScreenLivreur/Licpaser.dart';
import 'package:emitrans_mobile/ScreenLivreur/livraisonTermin%C3%A9.dart';
import 'package:emitrans_mobile/Services/databaseLivraison.dart';
import 'package:emitrans_mobile/common/loading.dart';
import 'package:emitrans_mobile/const/text_style.dart';
import 'package:emitrans_mobile/models/livraisonmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListLivraison extends StatefulWidget {
  final ModelLivraison liv;
  final String userID;
  const ListLivraison({this.liv, this.userID});

  @override
  _ListLivraisonState createState() => _ListLivraisonState();
}
class _ListLivraisonState extends State<ListLivraison> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4.0,
      right: 12.0,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white.withOpacity(0.7),
          ),
          child: widget.liv.status
              ? GestureDetector(
            onTap: () => DatabaseService()
                .removeFavoriteCar(widget.liv, widget.userID),
            child: Tooltip(
              message: 'Ne plus aimer',
              child: Row(
                children: [
                  Text(
                    '${widget.liv.statusCount}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          )
              : GestureDetector(
            onTap: () => DatabaseService()
                .addLivraisonEff(widget.liv, widget.userID),
            child: Tooltip(
              message: 'Aimer',
              child: Row(
                children: [
                  widget.liv.statusCount > 0
                      ? Text(
                    '${widget.liv.statusCount}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : Container(),
                  Icon(
                    Icons.favorite,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
