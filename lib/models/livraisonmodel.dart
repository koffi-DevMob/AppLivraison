import 'package:cloud_firestore/cloud_firestore.dart';

class ModelLivraison{
  String uid, depart, arrive, nomclt, nombre, numeroclt,prodImage, marchId, nomMarchand;
  Timestamp LivTimes;
  bool status;
  int statusCount;

  ModelLivraison(
      {this.uid,
      this.depart,
      this.arrive,
      this.nomclt,
      this.nombre,
      this.numeroclt,
      this.prodImage,
        this.status,
        this.statusCount,
        this.LivTimes,
      this.marchId,
      this.nomMarchand
      });
}

