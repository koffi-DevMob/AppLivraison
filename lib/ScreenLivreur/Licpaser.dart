import 'package:beamer/beamer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/ScreenLivreur/ListLivraison.dart';
import 'package:emitrans_mobile/ScreenLivreur/livraisonTermin%C3%A9.dart';
import 'package:emitrans_mobile/const/text_style.dart';
import 'package:emitrans_mobile/models/livraisonmodel.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class LivParser extends StatelessWidget {
  final ModelLivraison liv;
  final String userID;
  const  LivParser({this.liv, this.userID});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () =>
                  Beamer.of(context).beamToNamed('/detail/${liv.uid}'),
              child: Hero(
                tag: liv.nomclt,
                child: HoverAnimatedContainer(
                  height: MediaQuery.of(context).size.height * 0.35,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  hoverMargin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(liv.prodImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: MouseRegion(cursor: SystemMouseCursors.click),
                ),
              ),
            ),
            ListLivraison(liv: liv, userID: userID),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    liv.depart,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('De ${liv.arrive}'),
                ],
              ),
              Text(formattingDate(liv.LivTimes))
            ],
          ),
        )
      ],
    );
  }

  String formattingDate(Timestamp timestamp) {
    initializeDateFormatting('fr', null);
    DateTime dateTime = timestamp?.toDate();
    DateFormat dateFormat = DateFormat.MMMd('fr');
    return dateFormat.format(dateTime ?? DateTime.now());
  }
}
