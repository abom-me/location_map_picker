import 'package:flutter/material.dart';



     class Alerts {

     static   loading(context) {
       showDialog(
         context: context,
         barrierDismissible: false,
         builder: (BuildContext context) {
           return  AlertDialog(
             content: Container(
               padding: EdgeInsets.all(10),
               width: 100,
               height: 100,
               child: CircularProgressIndicator(),
             ),
           );
         },
       );

     }

     }






