import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emitrans_mobile/common/loading.dart';
import 'package:emitrans_mobile/const/text_style.dart';
import 'package:flutter/material.dart';

class ListeLivraison extends StatefulWidget {
  const ListeLivraison({Key key}) : super(key: key);

  @override
  _ListeLivraisonState createState() => _ListeLivraisonState();
}

class _ListeLivraisonState extends State<ListeLivraison> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Livraison').snapshots();
  bool loading = false;
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
              title: Text("Liste des Livraisons", style: TextStyle(fontFamily: "WorkSans",
                  fontWeight: FontWeight.w600),),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                onPressed: (){
                  Navigator.pushReplacementNamed(
                      context, '/home_marchand');
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
    return Container(
      child: GestureDetector(
        child: SingleChildScrollView(
          child: Column(
              children:[
                Padding(
                  padding:
                  const EdgeInsets.only(top: 2,bottom: 2,),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16,bottom: 16),
                            child: SingleChildScrollView(
                              child: Wrap(
                                children: <Widget>[
                                  DataTable(
                                    columns: [
                                      DataColumn(label: Text('Depart',style: style(),)),
                                      DataColumn(label: Text('Arrivé',style: style(),)),
                                      DataColumn(label: Text('Client',style: style(),)),
                                      DataColumn(label: Text('Côut',style: style(),)),
                                      DataColumn(label: Text('Type',style: style(),)),
                                    ],
                                    rows:snapshot.data.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                      return DataRow(
                                          cells: [
                                            DataCell(Text("${data['depart']}",style: style1(),)),
                                            DataCell(Text("${data['arrive']}",style: style1(),)),
                                            DataCell(Text("${data['nomclt']}",style: style1(),)),
                                            DataCell(Text("${data['montant']}",style: style1(),)),
                                            DataCell(Text("${data['typecolis']}",style: style1(),)),
                                          ]
                                      );
                                    })?.toList()??[],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );

        }
/*
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['nom']),
              subtitle: Text(data['nomboutik']),
            );
          }).toList(),
        );*/
      },
    )
    );
  }
}
