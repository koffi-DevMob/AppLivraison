import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/models/livraisonmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class DatabaseService {

  String VendeurID, LivraisonId;
  DatabaseService({this.VendeurID, this.LivraisonId});

  // Déclaraction et Initialisation
  CollectionReference _modelLivraisons = FirebaseFirestore.instance.collection('Livraison');
  FirebaseStorage _storage = FirebaseStorage.instance;
  // upload de l'image vers Firebase Storage
  Future<String> uploadFile(File file, XFile fileWeb) async {
    Reference reference = _storage.ref().child('produits/${DateTime.now()}.png');
    Uint8List imageTosave = await fileWeb.readAsBytes();
    SettableMetadata metaData = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask = kIsWeb
        ? reference.putData(imageTosave, metaData)
        : reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  // ajout de la voiture dans la BDD
  void addLivraison(ModelLivraison modelLivraison) {

    _modelLivraisons.add({
      "depart": modelLivraison.depart,
      "arrive": modelLivraison.arrive,
      "nomclt": modelLivraison.nomclt,
      "numeroclt": modelLivraison.numeroclt,
      "nombre": modelLivraison.nombre,
      "marchId": modelLivraison.marchId,
      "nomMarchand":0,
      "prodImage": modelLivraison.prodImage,
      "LivTimes": FieldValue.serverTimestamp(),
      "statusCount":0,
    });
  }

  // suppression de la voiture
  Future<void> deleteLivraison(String LivraisonId) => _modelLivraisons.doc(LivraisonId).delete();


  // Récuperation de toutes les livraison en temps réel
 Stream<List<ModelLivraison>> get livraison {
    Query queryLivraison = _modelLivraisons.orderBy('LivTimes', descending: true);
    return queryLivraison.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ModelLivraison(
          uid: doc.id,
          depart: doc.get('depart'),
          arrive: doc.get('arrive'),
          nomclt: doc.get('nomclt'),
          numeroclt: doc.get('numeroclt'),
          nombre: doc.get('nombre'),
          LivTimes: doc.get('LivTimes'),
          statusCount: doc.get('statusCount'),
          marchId: doc.get('marchId'),
          nomMarchand: doc.get('nomMarchand'),
          prodImage: doc.get('LivTimes'),
        );
      }).toList();
    });
  }

  // ajout de la livraison effectuée dans une sous-collection
  void addLivraisonEff(ModelLivraison modelLivraison, String VendeurID) async {
    final DocRef = _modelLivraisons.doc(modelLivraison.uid);
    final LivraisonEff = DocRef.collection('LivraisonEffectuée');
    int statusCount = modelLivraison.statusCount;
    int increaseCount = statusCount += 1;
    LivraisonEff.doc(VendeurID).set({
      "depart": modelLivraison.depart,
      "arrive": modelLivraison.arrive,
      "nomclt": modelLivraison.nomclt,
      "numeroclt": modelLivraison.numeroclt,
      "nombre": modelLivraison.nombre,
      "marchId": modelLivraison.marchId,
      "nomMarchand": modelLivraison.nomMarchand,
      "prodImage": modelLivraison.prodImage,
      "LivTimes": FieldValue.serverTimestamp(),
      "statusCount": modelLivraison.statusCount,
    });
    DocRef.update({"LivraisonEffectuée": increaseCount});
  }

  // rétirer la liraison de la liste des favoris
  void removeFavoriteCar(ModelLivraison modelLivraison, String VendeurID) {
    final DocRef = _modelLivraisons.doc(modelLivraison.uid);
    final favoritedBy = DocRef.collection('favoritedBy');
    int statusCount = modelLivraison.statusCount;
    int decreaseCount = statusCount -= 1;
    DocRef.update({"StatusCount": decreaseCount});
    favoritedBy.doc(VendeurID).delete();
  }

  // Récuperation des livraisons de l'utilisateur en temps réel
  Stream<ModelLivraison> get getstatus {
    final favoritedBy = _modelLivraisons.doc(LivraisonId).collection('favoritedBy');
    return favoritedBy.doc(VendeurID).snapshots().map((doc) {
      return ModelLivraison(
        uid: doc.id,
        depart: doc.get('depart'),
        arrive: doc.get('arrive'),
        nomclt: doc.get('nomclt'),
        numeroclt: doc.get('numeroclt'),
        nombre: doc.get('nombre'),
        LivTimes: doc.get('LivTimes'),
        statusCount: doc.get('statusCount'),
        marchId: doc.get('marchId'),
        nomMarchand: doc.get('nomMarchand'),
        prodImage: doc.get('LivTimes'),
      );
    });
  }

  Future<ModelLivraison> singleCar(String LivraisonId) async {
    final doc = await _modelLivraisons.doc(LivraisonId).get();
    return ModelLivraison(
      uid: doc.id,
      depart: doc.get('depart'),
      arrive: doc.get('arrive'),
      nomclt: doc.get('nomclt'),
      numeroclt: doc.get('numeroclt'),
      nombre: doc.get('nombre'),
      LivTimes: doc.get('LivTimes'),
      statusCount: doc.get('statusCount'),
      marchId: doc.get('marchId'),
      nomMarchand: doc.get('nomMarchand'),
      prodImage: doc.get('LivTimes'),
    );
  }
}
