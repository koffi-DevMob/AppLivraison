import 'package:emitrans_mobile/Services/databaseLivraison.dart';
import 'package:emitrans_mobile/Services/databaseMarchand.dart';
import 'package:emitrans_mobile/models/userLivreur.dart';
import 'package:emitrans_mobile/models/userMarchand.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'databaseLivreur.dart';

class AuthentificationService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LivreurUserData _userFromFirebaseUser(User user){
    return user != null ?LivreurUserData(uid: user.uid):null;
  }
  MarchandUserData _userFromFirebaseMarchand(User marchand){
    return marchand != null ?MarchandUserData(uid: marchand.uid):null;
  }

  Stream<LivreurUserData> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
  Stream<MarchandUserData> get marchand{
    return _auth.authStateChanges().map(_userFromFirebaseMarchand);
  }

  Future SignInWithEmailAndPassword(
      String email, String password
      ) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }
  Future connectInWithEmailAndPassword(
      String email, String password
      ) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String nom, String email, String lieu, String numero, String password,) async{
    try{
      UserCredential result=
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      // TODO store user in firestore

      await DatabaseServiceLivreur(uid: user.uid).saveUser(nom,email,lieu,numero);

      return _userFromFirebaseUser(user);
    } catch(exception){
      print(exception.toString());
      return null;
    }
  }

 Future inscritWithEmailAndPassword(String nom,String nomboutik ,String email, String lieu, String numero, String password) async{
    try{
      UserCredential result=
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      // TODO store user in firestore

      await DatabaseServiceMarchand(uid: user.uid).saveUser(nom,nomboutik, email,lieu,numero);
      return _userFromFirebaseUser(user);
    } catch(exception){
      print(exception.toString());
      return null;
    }
  }


  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(execption){
      print(execption.toString());
      return null;
    }
  }

}