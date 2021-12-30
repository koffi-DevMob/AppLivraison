import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/models/userLivreur.dart';
import 'package:flutter/foundation.dart';

class DatabaseServiceLivreur{
  final String uid;

  DatabaseServiceLivreur({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Livreurs");

  Future <void> saveUser(String nom, String email, String lieu, String numero) async{
    return await userCollection.doc(uid).set({
      'nom':nom,
      'email':email,
      'lieu':lieu,
      'numero':numero,
    });
  }

/*  LivreurUserData _userFromSnapshot(DocumentSnapshot snapshot){
    return LivreurUserData(
      uid: snapshot.id,
      nom: snapshot.data(),
      email: snapshot.data(),
      lieu: snapshot.data(),
      numero: snapshot.data(),
    );
  }*/


  Stream<List<LivreurUserData>> get user{
    Query queryLivreur = userCollection;
    return queryLivreur.snapshots().map((snapshot){
      return snapshot.docs.map((doc) {
        return LivreurUserData(
          uid: doc.id,
          nom: doc.get('nom'),
          email: doc.get('email'),
          lieu: doc.get('lieu'),
          numero: doc.get('numero'),
        );
      }).toList();
    });
  }


/* List<LivreurUserData> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc)
    {
      return user(doc);
    });
  }

  Stream<List<LivreurUserData>> get users{
    return userCollection.snapshots().map(_userListFromSnapshot);
  }*/
}
