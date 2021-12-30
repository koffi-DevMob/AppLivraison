import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  final AnimationController animationController;
  const WelcomeView({Key key, @required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _welcomeFirstHalfAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _welcomeImageAnimation =
        Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             /* SlideTransition(
                position: _welcomeImageAnimation,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 350, maxHeight: 350),
                  child: Image.asset(
                    'assets/introduction_animation/welcome.png',
                    fit: BoxFit.contain,
                  ),
                ),
              )*/
              SlideTransition(
                position: _welcomeFirstHalfAnimation,
                child: Text(
                  "Se connecter",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 64, right: 64, top: 16, bottom: 16),
                child: Text(
                    "Connectez-vous a votre compte afin d'ajouter de nouveaux produits pour les"
                        " marchands et d'effectuer une mouvelle livraison pour les livreurs. "
                        "BIENVENUE!",
                  textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 16
                ),
                ),
              ),
              SizedBox(height:200,),
              SizedBox(
                height: 58,
                width: 257,
                child: RaisedButton(
                    onPressed: (){
                    Navigator.pushReplacementNamed(
                    context, '/wrapper_livreur');
                    },
                  color: Color(0xff132137),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                  ),
                    child: Text("Livreur", style: TextStyle(color: Colors.white,fontFamily: 'WorkSans',
                    fontSize: 18, fontWeight: FontWeight.w600),),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
