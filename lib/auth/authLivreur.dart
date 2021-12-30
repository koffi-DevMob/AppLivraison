
import 'package:emitrans_mobile/Services/authFirebase.dart';
import 'package:emitrans_mobile/common/Progress.dart';
import 'package:emitrans_mobile/common/inputDeco_design.dart';
import 'package:emitrans_mobile/common/loading.dart';
import 'package:emitrans_mobile/common/request-loader.dart';
import 'package:emitrans_mobile/const/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class LoginLivreurScreen extends StatefulWidget {
  @override
  _LoginLivreurScreenState createState() => _LoginLivreurScreenState();
}

class _LoginLivreurScreenState extends State<LoginLivreurScreen> {

  final AuthentificationService _auth =AuthentificationService();

  bool loading = false;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String error = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
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
    return loading
        ? Loading():Scaffold(
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
            title: Text("Espace Livreur", style: TextStyle(fontFamily: "WorkSans",
                fontWeight: FontWeight.w600),),
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
              Positioned(
                top: 35,
                bottom: 510,
                right: 5,
                left: 5,
                child: Container(

                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/livraison/logoemitrans.png"),
                          fit: BoxFit.contain)
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 80, left: 70),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height:350,
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.only(left: 20,right: 20,top: 200),
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
                                "Espace Connexion",
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
                                    controller: emailController,
                                      validator: (value) =>value.isEmpty?
                                      "Veuillez entrer votre email":null,
                                      keyboardType:TextInputType.text,
                                      decoration: buildInputDecoration(Icons.person, 'Adresse e-mail'),
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
                                      "Veuillez entrer votre mot de passe":null,
                                      obscureText: true,
                                      keyboardType:TextInputType.text,
                                      decoration: buildInputDecoration(Icons.lock_outline, 'Mot de passe')
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: RaisedButton(
                                    color: Color(0xff132137),
                                    onPressed: () async {
                                      //Connexion();
                                      if(_formkey.currentState.validate()){
                                        setState(() {
                                          loading = true;
                                        });
                                        var email = emailController.value.text;
                                        var password = passwordController.value.text;
                                        dynamic result  = await _auth.SignInWithEmailAndPassword(email, password);
                                        if(result==null){
                                          setState(() {
                                            loading = false;
                                            error = 'Données non valide';
                                          });
                                        }
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      //side: BorderSide(color: Colors.deepOrangeAccent,width:3)
                                    ),
                                    textColor:Colors.white,child: Text("Se Connecter"),

                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FlatButton(onPressed: (){
                                  Navigator.pushReplacementNamed(
                                      context, '/inscrit_livreur');
                                },
                                    child: Text("Inscription",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontFamily: 'Worksans'
                                      ),
                                    )
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(error,style:TextStyle(color: Colors.red,
                                    fontWeight: FontWeight.w600,fontSize: 15)
                                  ,)
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


