/*import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/Services/authFirebase.dart';
import 'package:emitrans_mobile/common/inputDeco_design.dart';
import 'package:emitrans_mobile/common/loading.dart';
import 'package:emitrans_mobile/models/livraisonmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'design_course_app_theme.dart';
import 'package:intl/intl.dart';

class LivraisonScreen extends StatefulWidget {

  @override
  _LivraisonScreenState createState() => _LivraisonScreenState();
}

class _LivraisonScreenState extends State<LivraisonScreen>
    with TickerProviderStateMixin {

  final AuthentificationService _auth = AuthentificationService();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String username="",password="";
  bool isLoading = false;
  bool loading = false;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  String error = '';
  final departController = TextEditingController();
  final arriveController = TextEditingController();
  final nomcltController = TextEditingController();
  final typeController = TextEditingController();
  final numerocltController = TextEditingController();
  final montantController = TextEditingController();
  var imageController = TextEditingController();

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Livraisons");

  User currentUser;

  @override
  void dispose(){
    departController.dispose();
    arriveController.dispose();
    nomcltController.dispose();
    numerocltController.dispose();
    montantController.dispose();
    typeController.dispose();
    imageController.dispose();
    super.dispose();
  }


  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  var photo;


  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('Livraison');

    Future<void> getImage(ImageSource source)async{
      XFile _pickedFile = await ImagePicker().pickImage(source: source);
      File _file = File(_pickedFile.path);
      photo = _file;
    }


    Future<void> AjoutLivraison() {
      var depart = departController.value.text;
      var arrive = arriveController.value.text;
      var nomclt = nomcltController.value.text;
      var nombre = typeController.value.text;
      var numeroclt = numerocltController.value.text;
      var montant = montantController.value.text;
      var date = DateTime.now();
      return users
          .add({
        'depart':depart,
        'arrive':arrive,
        'nomclt':nomclt,
        'numeroclt':numeroclt,
        'nombre':nombre,
        'montant':montant,
        'date': date,
      })
          .then((value) => print("Livraison ajoutée"))
          .catchError((error) => print("Failed to add user: $error"));
    }


    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 2) +
        24.0;
    return loading
        ? Loading(): Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.yellow,
                        Colors.deepOrange
                      ]
                  )
              ),
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.9,
                    child: Image.asset('assets/livraison/logoemitrans.png'),
                  ),
                ],
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Nouvelle Livraison",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color:  Colors.blue[900],
                                          fontFamily: 'WorkSans'
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 3,
                                      width: 55,
                                      color: Colors.deepOrange,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Form(
                                  key: _formkey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: TextFormField(
                                          controller: departController,
                                          validator: (value) =>value.isEmpty?
                                          "Veuillez saisir le lieu de depart":null,
                                          keyboardType:TextInputType.text,
                                          decoration: buildInputDecoration(Icons.location_on, 'Lieu de Depart'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: TextFormField(
                                          controller: arriveController,
                                          validator: (value) =>value.isEmpty?
                                          "Veuillez saisir le lieu d'arriver":null,
                                          keyboardType:TextInputType.text,
                                          decoration: buildInputDecoration(Icons.location_on, 'Lieu d\'Arrivé'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: TextFormField(
                                          controller: nomcltController,
                                          validator: (value) =>value.isEmpty?
                                          "Veuiilez saisir le Nom du client":null,
                                          keyboardType:TextInputType.text,
                                          decoration: buildInputDecoration(Icons.person, 'Nom du client'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: TextFormField(
                                            controller: numerocltController,
                                            validator: (value) =>value.length<10 ?
                                            "Veuillez entrer le numéro du client":null,
                                            keyboardType:TextInputType.number,
                                            decoration: buildInputDecoration(Icons.phone, 'Numéro du client')
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: TextFormField(
                                            controller: typeController,
                                            validator: (value) =>value.isEmpty?
                                            "Veuillez entrer le nombre de colis":null,
                                            obscureText: false,
                                            keyboardType:TextInputType.number,
                                            decoration: buildInputDecoration(Icons.local_shipping, 'Nombre de colis')
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: TextFormField(
                                            controller: montantController,
                                            validator: (value) =>value.isEmpty?
                                            "Veuillez entrer le montant":null,
                                            obscureText: false,
                                            keyboardType:TextInputType.number,
                                            decoration: buildInputDecoration(Icons.monetization_on, 'Montant')
                                        ),
                                      ),
                                     Padding(
                                          padding: const EdgeInsets.only(top: 5,left: 30),
                                          child: Row(
                                            children: [
                                              Material(
                                                color: Colors.transparent, // button color
                                                child: InkWell(
                                                  splashColor: Colors.orange.withOpacity(0.1), // splash color
                                                  onTap: () {
                                                    getImage(ImageSource.camera);
                                                  }, // button pressed
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Icon(Icons.camera_alt,size: 70,color: Colors.deepOrange,),
                                                      Text('Image du produit ', style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: 'Nunito'
                                                      ),)// icon
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 40,),
                                              Flexible(
                                                  child:CircleAvatar(
                                                    radius: 65,
                                                    backgroundColor: Colors.white,
                                                    backgroundImage: NetworkImage(photo.path) != null ? FileImage(photo) : null,
                                                  )
                                              ),
                                            ],
                                          )
                                      ),
                                      Divider(height: 50,),

                                      SizedBox(
                                        width: 200,
                                        height: 50,
                                        child: RaisedButton(
                                          color: Color(0xff132137),
                                          onPressed: () async{
                                            setState(() {
                                              Loading();
                                            });
                                            if(_formkey.currentState.validate()){
                                              setState(() {
                                                loading = true;
                                              });
                                              AjoutLivraison();
                                              this.setState((){
                                                Navigator.pop(context);
                                              });
                                            }
                                            },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            //side: BorderSide(color: Colors.deepOrangeAccent,width:3)
                                          ),
                                          textColor:Colors.white,child: Text("Sauvegarder",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontFamily: 'Worksans'
                                        ),),

                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: DesignCourseAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}*/
import 'dart:io';

import 'package:emitrans_mobile/Services/databaseLivraison.dart';
import 'package:emitrans_mobile/common/inputDeco_design.dart';
import 'package:emitrans_mobile/common/showSnackBar.dart';
import 'package:emitrans_mobile/models/livraisonmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarDialog {
  User vendeur;
  ModelLivraison liv;
  CarDialog({this.vendeur,this.liv});

  // pour visualiser la boite de dialogue
  void showCarDialog(BuildContext context, ImageSource source) async {
    XFile _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile.path);
    final _keyForm = GlobalKey<FormState>();
    String depart= '';
    String arrive = '';
    String nomclt= '';
    String numeroclt= '';
    String nombre = '';

    String _formError = 'Veillez fournir de bonnes informations!';
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          final mobilHeight = MediaQuery.of(context).size.height * 0.25;
          final webHeight = MediaQuery.of(context).size.height * 0.5;
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            children: [
              Container(
                height: kIsWeb ? webHeight : mobilHeight,
                margin: EdgeInsets.all(8.0),
                color: Colors.grey,
                child: kIsWeb
                    ? Image(
                  image: NetworkImage(_file.path),
                  fit: BoxFit.cover,
                )
                    : Image(
                  image: FileImage(_file),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                      key: _keyForm,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextFormField(
                              onChanged: (value) => depart = value,
                              validator: (value) =>
                              depart == '' ? _formError : null,
                              keyboardType:TextInputType.text,
                              decoration: buildInputDecoration(Icons.location_on, 'Lieu de depart'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextFormField(
                              onChanged: (value) => arrive = value,
                              validator: (value) =>
                              arrive == '' ? _formError : null,
                              keyboardType:TextInputType.text,
                              decoration: buildInputDecoration(Icons.location_on, 'Lieu d\'Arrivé'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextFormField(
                              onChanged: (value) => nomclt = value,
                              validator: (value) =>
                              nomclt == '' ? _formError : null,
                              keyboardType:TextInputType.text,
                              decoration: buildInputDecoration(Icons.person, 'Nom du client'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextFormField(
                                onChanged: (value) =>numeroclt = value,
                                validator: (value) =>
                               numeroclt == '' ? _formError : null,
                                keyboardType:TextInputType.number,
                                decoration: buildInputDecoration(Icons.phone, 'Numéro du client')
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextFormField(
                                onChanged: (value) => nombre = value,
                                validator: (value) =>
                                nombre == '' ? _formError : null,
                                obscureText: false,
                                keyboardType:TextInputType.number,
                                decoration: buildInputDecoration(Icons.local_shipping, 'Nombre de colis')
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('ANNULER'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => onSubmit(context, _keyForm, _file,
                                _pickedFile, depart, arrive, nomclt, numeroclt, nombre, vendeur),
                            child: Text('SAUVEGARDER'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  void onSubmit(context, keyForm, file, fileWeb, depart, arrive, nomclt, numeroclt, nombre, vendeur) async {
    if (keyForm.currentState.validate()) {
      Navigator.of(context).pop();
      showNotification(context, "Chargement...");
      try {
        DatabaseService db = DatabaseService();
        String _carUrlImg = await db.uploadFile(file, fileWeb);
        db.addLivraison(
          ModelLivraison(
              depart:depart,
              arrive :arrive,
              nomclt:nomclt,
              numeroclt: numeroclt,
              nombre : nombre,
              marchId:vendeur.uid,
              prodImage :_carUrlImg,
          )
        );
      } catch (error) {
        showNotification(context, "Erreur $error");
      }
    }
  }
}
