import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/common/loading.dart';
import 'package:emitrans_mobile/const/text_style.dart';
import 'package:emitrans_mobile/models/livraisonmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaLivraison extends StatefulWidget {
  final ModelLivraison liv;
  final String userID;
  const MaLivraison({this.liv, this.userID});

  @override
  _MaLivraisonState createState() => _MaLivraisonState();
}
class _MaLivraisonState extends State<MaLivraison> {

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Livraison').snapshots();
  bool loading = false;

  String ville;
  @override
  Widget build(BuildContext context) {
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
              backgroundColor: Colors.transparent.withOpacity(0.1),
              elevation: 0.0,
              title: Text("Liste des Livraisons",
                style: TextStyle(fontFamily: "WorkSans",
                  fontWeight: FontWeight.w600),),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                onPressed: (){
                  Navigator.pushReplacementNamed(
                      context, '/home_livreur');
                },
              ),
            ),
          ),
        ),
         body: StreamBuilder<QuerySnapshot>(
           stream: _usersStream,
           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
           }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }else{
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
               ville = "${data['arrive']}";
              return Container(
                      padding: EdgeInsets.all(5),
                      height: 210,
                      child: Card(
                        elevation: 7,
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15,),
                                      Text("Lieu de depart: ${data['LivraisonId']}",style: style(),),
                                      SizedBox(height: 10,),
                                      Text("Lieu d'arrivé: ${data['arrive']}",style: style(),),
                                      SizedBox(height: 10,),
                                      Text("Nom du client: ${data['nomclt']}",style: style(),),
                                      SizedBox(height: 10,),
                                      Text("Numero du client: ${data['numeroclt']}",style: style(),),
                                      SizedBox(height: 10,),
                                      Text("Quantité: ${data['nombre']}",style: style(),),
                                      SizedBox(height: 10,),
                                      Wrap(
                                        children: [
                                          TextButton(onPressed: ()=>alertencours('Recuperer la livraison'),
                                              child: Text("Recuperer", style: TextStyle(
                                                color:Colors.green, fontSize:17, fontFamily: 'WorkSans'
                                              ),))
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              Expanded(child:
                              Container(
                                  margin: EdgeInsets.only(left: 20,bottom: 60,top: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                      image: NetworkImage('${data['prodImage']}'),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                              ),),
                            ],
                          ),
                        ),
                      ),
              );

            })?.toList()??[],
        );
        }
      },
    )
    );
  }

  Future alertencours(String title) async{
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title , textScaleFactor: 1,)),
          content: const Icon(Icons.check, size: 90,color: Colors.greenAccent,),
          actions: [
            FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Non")
            ),
            FlatButton(
                onPressed: () async{
                  Navigator
                .pushReplacementNamed(
                    context, '/home_livreur');
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setBool('isLivraison', true);
                  },
                child: const Text("Oui"),
            ),
          ],
        );
      },
    );
  }
}
