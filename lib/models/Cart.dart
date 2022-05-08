import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glass_container/glass_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phase1/models/Productt.dart';
import 'Productt.dart';

FirebaseAuth auth = FirebaseAuth.instance;

getuid() {
  var user = auth.currentUser;
  var uid = user?.uid;
  return uid;
}
//CRUD

class CartServices {
  final String? userid;

  CartServices({this.userid});
  //get
  getcart() async {
    return await FirebaseFirestore.instance
        .collection("Cart")
        .where("Userid", isEqualTo: "id")
        .snapshots()
        .map((collection) => collection.docs.map((doc) => doc.data()).toList());
  }

  //upsert
  setcart(String userid, cart) {
    SetOptions options = SetOptions(merge: true);
    return FirebaseFirestore.instance
        .collection("Cart")
        .doc(userid)
        .set(cart, options);
  }
}

class Cart {
  String? uid;
  List<Map<String, dynamic>>? items;
  Cart({required this.uid, required this.items});

  factory Cart.fromfirestore( Map json){
    return Cart(
            uid: json["uid"],
            items: json["Items"]);
    }

  Map<String,dynamic> toMap(){
     return {"uid": uid,
      "Items": items};
    }
  }

