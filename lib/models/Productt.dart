import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';

class Product {
  final String? title;
  final String? category;
  final String? picture;
  double? price;
  double? time;
  bool? is_Special;
  Product(
      {required this.title,
       this.category,
       this.picture,
       this.price,
       this.time,
       this.is_Special});
  factory Product.fromfirestore(Map<dynamic, dynamic> json) {
    return Product(
      title: json["Title"],
      category: json["Category"],
      picture: json["Picture"],
      price: json['Price'],
      time: json["Time"],
      is_Special: json["is_Special"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Title": title,
      "Category": category,
      "Picture": picture,
      "Price": price,
      "Time": time,
      "is_Special": is_Special,
    };
  }
}

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //get
  Stream<List<Product>> getProducts(BuildContext context) {
    return _db.collection("Products").snapshots().map((collection) =>
            collection.docs.map((doc) => Product.fromfirestore(doc.data())))
        as Stream<List<Product>>;
  }

  Future<void> setProducts(Product product) {
    var options = SetOptions(merge: true);
    return _db
        .collection("Products")
        .doc(product.title)
        .set(product.toMap(), options);
  }

  Future<void> deleteProduct(Product productt) {
    return _db.collection("Products").doc(productt.title).delete();
  }
}
