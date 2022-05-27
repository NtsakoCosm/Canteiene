import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserManagement {
  storeUser(user, context) {
    FirebaseFirestore.instance.collection('/users').add({}).then((value) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/landingpage');
    }).catchError((e) {
      print(e);
    });
  }
}
