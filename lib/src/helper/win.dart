import 'package:flutter/material.dart';



     class Alerts {

     static   loading(context) {
       showDialog(
         context: context,
         barrierDismissible: false,
         builder: (BuildContext context) {
           return const AlertDialog(
             content: Directionality(
               textDirection: TextDirection.rtl,
               child: CircularProgressIndicator(),
             ),
           );
         },
       );

     }

     }






