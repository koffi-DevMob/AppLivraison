import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/Services/authFirebase.dart';
import 'package:emitrans_mobile/common/inputDeco_design.dart';
import 'package:emitrans_mobile/common/loading.dart';
import 'package:emitrans_mobile/common/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'design_course_app_theme.dart';
import 'package:intl/intl.dart';

class DepenseScreen extends StatefulWidget {

  @override
  _DepenseScreenState createState() => _DepenseScreenState();
}

class _DepenseScreenState extends State<DepenseScreen>
    with TickerProviderStateMixin {

  final categorie = ['carburant','reparation','frais de route'];

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String username="",password="";
  bool isLoading = false;
  bool loading = false;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  String error = '';
  String categories = "carburant";
  final sitgeoController = TextEditingController();
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
    sitgeoController.dispose();
    arriveController.dispose();
    nomcltController.dispose();
    numerocltController.dispose();
    montantController.dispose();
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


  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        isLoading = true;
        imageController  = pickedFile as TextEditingController;
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('Depenses');

    Future<void> AjoutDepense() {
      // Call the user's CollectionReference to add a new user
      var cat = categories;
      var sitgeo = sitgeoController.value.text;
      var montant = montantController.value.text;
      var date = DateTime.now();
      return users
          .add({
        'Categories de depense':cat,
        'Situation géographique':sitgeo,
        'montant de la depense':montant,
        'date': date,
      })
          .then((value) => print("Depense ajoutée"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    Future<void> showCarDialog(BuildContext context) async {
      if (kIsWeb) {
        AjoutDepense();
      } else {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            AjoutDepense();
          }
        } on SocketException catch (_) {
          showNotification(context, 'Aucune connexion internet');
        }
      }
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
                    aspectRatio: 1,
                    child: Image.asset('assets/livraison/logoemitrans.png'),
                  ),
                ],
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1) - 24.0,
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
                                      "Nouvelle Depense",
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
                                        padding: const EdgeInsets.only(bottom: 8.0,),
                                        child:Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white,width: 1.9),
                                              borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 40.0),
                                            child: DropdownButton(
                                              value: categories,
                                                isExpanded: true,
                                                items: categorie?.map((String item) =>
                                                 DropdownMenuItem<String>(child: Text(item,textAlign: TextAlign.center,), value: item))
                                                     ?.toList()??[],
                                              onChanged: (value) {
                                                setState(() {
                                                  print("previous ${this.categories}");
                                                  print("selected $value");
                                                  this.categories = value;
                                                });
                                              },
                                              iconSize: 40,
                                              hint: Text("Categorie de la depense"),
                                            ),
                                          ),
                                        )
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: TextFormField(
                                          controller: sitgeoController,
                                          validator: (value) =>value.isEmpty?
                                          "Veuillez saisir la situation géograghique":null,
                                          keyboardType:TextInputType.text,
                                          decoration: buildInputDecoration(Icons.article, 'Description'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
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
                                     /* Padding(
                                          padding: const EdgeInsets.only(top: 5,left: 30),
                                          child: Row(
                                            children: [
                                              Material(
                                                color: Colors.transparent, // button color
                                                child: InkWell(
                                                  splashColor: Colors.orange.withOpacity(0.1), // splash color
                                                  onTap: () {
                                                    getImage();
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
                                                    backgroundImage: imageController != null ? FileImage(imageController) : null,
                                                  )
                                              ),
                                            ],
                                          )
                                      ),*/
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
                                             showCarDialog(context);
                                              this.setState((){
                                                Navigator.pop(context);
                                              });
                                            }
                                            },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            //side: BorderSide(color: Colors.deepOrangeAccent,width:3)
                                          ),
                                          textColor:Colors.white,child: Text("Sauvegarder",style: TextStyle(
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

}
