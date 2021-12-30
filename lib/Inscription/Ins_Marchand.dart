
import 'package:emitrans_mobile/Services/authFirebase.dart';
import 'package:emitrans_mobile/common/Progress.dart';
import 'package:emitrans_mobile/common/inputDeco_design.dart';
import 'package:emitrans_mobile/common/loading.dart';
import 'package:emitrans_mobile/common/request-loader.dart';
import 'package:emitrans_mobile/const/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class InscritMarchand extends StatefulWidget {
  @override
  _InscritMarchandState createState() => _InscritMarchandState();
}

class _InscritMarchandState extends State<InscritMarchand> {

  final AuthentificationService _auth =AuthentificationService();

  bool loading = false;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String error = '';
  final nomController = TextEditingController();
  final nomboutikController = TextEditingController();
  final emailController = TextEditingController();
  final lieuController = TextEditingController();
  final numeroController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    nomController.dispose();
    nomboutikController.dispose();
    emailController.dispose();
    lieuController.dispose();
    numeroController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String username="",password="";
  bool isLoading = false;



  Widget _uiSetup(BuildContext context) {
    return loading ? Loading():Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
        child: Container(
           decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.yellow,
                    Colors.deepOrange
                  ]
              )
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.1,
            title: Text("Création de Compte Marchand", style: TextStyle(fontFamily: "WorkSans",
                fontWeight: FontWeight.w600),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp),
              onPressed: (){
                Navigator.pushReplacementNamed(
                    context, '/wrapper_marchand');
              },
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.yellow,
                  Colors.deepOrange
                ]
            )
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height:610,
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 0,
                          spreadRadius: 0),
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Inscription",
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
                                    controller: nomController,
                                    validator: (value) =>value.isEmpty?
                                    "Veuillez saisir le Nom & Prénom":null,
                                    keyboardType:TextInputType.text,
                                    decoration: buildInputDecoration(Icons.person, 'Nom & Prénom'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: TextFormField(
                                    controller: nomboutikController,
                                    validator: (value) =>value.isEmpty?
                                    "Saisir le Nom de la boutique":null,
                                    keyboardType:TextInputType.text,
                                    decoration: buildInputDecoration(Icons.add_business_sharp, 'Nom de la boutique'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: TextFormField(
                                    controller: emailController,
                                    validator: (value) =>value.isEmpty?
                                    "Veuillez entrer votre email":null,
                                    keyboardType:TextInputType.emailAddress,
                                    decoration: buildInputDecoration(Icons.article, 'Adresse email'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: TextFormField(
                                      controller: lieuController,
                                      validator: (value) =>value.isEmpty?
                                      "Entrer votre situation géographique":null,
                                      keyboardType:TextInputType.text,
                                      decoration: buildInputDecoration(Icons.location_on, 'Situation géographique')
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: TextFormField(
                                      controller: numeroController,
                                      validator: (value) =>value.length<10 ?
                                      "Veuillez entrer votre numéro":null,
                                      keyboardType:TextInputType.number,
                                      decoration: buildInputDecoration(Icons.phone, 'Numéro de téléphone')
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: TextFormField(
                                      controller: passwordController,
                                      validator: (value) =>value.length<6?
                                      "Veuillez entrer un mot de passe":null,
                                      obscureText: true,
                                      keyboardType:TextInputType.text,
                                      decoration: buildInputDecoration(Icons.lock_outline, 'Nouveau mot de passe')
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: RaisedButton(
                                    color: Color(0xff132137),
                                    onPressed: () async{
                                      setState(() {
                                        Loading();
                                      });
                                      //Connexion();
                                      if(_formkey.currentState.validate()){
                                        setState(() {
                                          loading = true;
                                        });
                                        var nom = nomController.value.text;
                                        var nomboutik = nomboutikController.value.text;
                                        var email = emailController.value.text;
                                        var lieu = lieuController.value.text;
                                        var numero = numeroController.value.text;
                                        var password = passwordController.value.text;
                                        dynamic result  = await _auth.inscritWithEmailAndPassword(nom,nomboutik ,email, lieu, numero, password);
                                        if(result==null){
                                          setState(() {
                                            loading = false;
                                            error = 'Données non valide';
                                          });
                                        }else{
                                          Navigator.pushReplacementNamed(
                                              context, '/wrapper_marchand');
                                        }
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      //side: BorderSide(color: Colors.deepOrangeAccent,width:3)
                                    ),
                                    textColor:Colors.white,child: Text("S'inscrire",style: TextStyle(
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
                                FlatButton(onPressed: (){
                                  Navigator.pushReplacementNamed(
                                      context, '/login_marchand');
                                },
                                    child: Text("Se connecter",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontFamily: 'Worksans'
                                      ),
                                    )
                                )
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 650,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Text("Copyright © 2021 Asnumeric. All rights reserved.",style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color:Colors.grey.shade600,
                        fontFamily: "Nunito",
                        decoration: TextDecoration.underline,
                      ),),
                    ],
                  )

                ],
              ),
              isLoading ? requestLoader() : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}


