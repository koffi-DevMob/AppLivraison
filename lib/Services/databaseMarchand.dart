import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/models/userMarchand.dart';
import 'package:flutter/foundation.dart';

class DatabaseServiceMarchand{
  final String uid;

  DatabaseServiceMarchand({this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Marchands");

  Future <void> saveUser(String nom,String nomboutik ,String email, String lieu, String numero,) async{
    return await userCollection.doc(uid).set({
      'nom':nom,
      'nomboutik':nomboutik,
      'email':email,
      'lieu':lieu,
      'numero':numero,
    });
  }

  Stream<List<MarchandUserData>> get marchand{
    Query queryLivreur = userCollection;
    return queryLivreur.snapshots().map((snapshot){
      return snapshot.docs.map((doc) {
        return MarchandUserData(
          uid: doc.id,
          nom: doc.get('nom'),
          nomboutik: doc.get('nomboutik'),
          email: doc.get('email'),
          lieu: doc.get('lieu'),
          numero: doc.get('numero'),
        );
      }).toList();
    });
  }

  /*MarchandUserData _userFromSnapshot(DocumentSnapshot snapshot){
    return MarchandUserData(
      uid: snapshot.id,
      nom: snapshot.data(),
      nomboutik: snapshot.data(),
      email: snapshot.data(),
      lieu: snapshot.data(),
      numero: snapshot.data(),
    );
  }

  Stream<MarchandUserData> get user{
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }


  List<MarchandUserData> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc)
    {
      return _userFromSnapshot(doc);
    });
  }

  Stream<List<MarchandUserData>> get users{
    return userCollection.snapshots().map(_userListFromSnapshot);
  }*/
}