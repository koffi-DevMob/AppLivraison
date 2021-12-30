import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.yellow,
                Colors.deepOrange
              ]
          )
      ),
      child: Center(
       child: SpinKitCircle(
         color: Colors.white,
         size: 50,
       ),
      ),
    );
  }
}
