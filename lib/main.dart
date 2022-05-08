// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_desktop/firebase_core_desktop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'firebase_options.dart';
import 'package:glass_container/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phase1/Login.dart';
import 'Shorthands.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'SignUp.dart';
import 'models/Productt.dart';
import 'models/Reciever.dart';
import 'models/tile.dart';
import 'package:firedart/firedart.dart' as fw;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context) => FireHome(),
        '/signup': (BuildContext context) => SignUp(),
        '/waiting': (BuildContext context) => AwaitingOrder()
      }));
}

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyAvm_aFVvotDmh94q0CZ0WYAtC20zkk2iE',
    appId: '1:326945861650:android:41e701814f93efdfff68cb',
    messagingSenderId: '326945861650 ',
    projectId: 'phase1-8137b',
  ));
  fw.Firestore.initialize('phase1-8137b');

  runApp(Desk());
}
*/

class ProductDetails extends StatefulWidget {
  ProductDetails(
      {Key? key,
      this.picture = 'assets/images/lays.png',
      this.title = 'lays',
      this.price,
      this.time = 0})
      : super(key: key);
  String picture;
  String title;
  double? price;
  double time;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          Image.asset("assets/images/WallpaperDog-20491944.jpg")
                              .image,
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)))), //Background
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "${widget.picture}",
                            width: width * 0.75,
                            height: width * 0.45,
                          ),
                          Details(
                            picture: widget.picture,
                            title: widget.title,
                            price: widget.price,
                            time: widget.time,
                          ),
                        ]),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 2))
                      ],
                      border: Border.all(color: Colors.white24.withOpacity(0)),
                      color: Colors.black38.withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))))),
        ],
      ),
    ));
  }
}

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQueryData(), child: IB(link: "assets/images/Payment.jpg"));
  }
}

class Meal extends StatelessWidget {
  const Meal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 200;
    double height = 200;
    return MediaQuery(
        data: MediaQueryData(),
        child: SafeArea(
            top: true,
            bottom: true,
            child: Scaffold(
              backgroundColor: Colors.transparent.withOpacity(0),
              body: Stack(children: [
                IB(link: "assets/images/WallpaperDog-20491944.jpg"),
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: <Widget>[
                      Rec(content: Text("The Cantiene")),
                      TransCard(link: "assets/images/wings.png"),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Products")
                            .where("Category", isEqualTo: "Meal")
                            .snapshots()
                            .map((snapshot) =>
                                snapshot.docs.map((doc) => doc.data).toList()),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return glassview(
                                      snapshot.data[index]["Picture"],
                                      snapshot.data[index]["Title"],
                                      width,
                                      height,
                                    );
                                  },
                                ));
                          }

                          if (!snapshot.hasData) {}

                          return CircularProgressIndicator();
                        },
                      ),
                    ]))
              ]),
            )));
  }
}

class AddCart extends StatelessWidget {
  const AddCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FireHome extends StatefulWidget {
  FireHome({Key? key}) : super(key: key);

  @override
  State<FireHome> createState() => _FireHomeState();
}

class _FireHomeState extends State<FireHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Home(),
    ));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IB(link: "assets/images/WallpaperDog-20491944.jpg"),
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            TransCard(link: "assets/images/Burgerback_ccexpress.png"),
            Text("Specials", style: GoogleFonts.lato(color: Colors.white)),
            SizedBox(height: 25.0),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where("is_Special", isEqualTo: true)
                  .snapshots()
                  .map((collection) =>
                      collection.docs.map((doc) => doc.data()).toList()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, index) =>
                              SizedBox(width: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Map data = snapshot.data[index];
                            double price = data["Price"];
                            double time = data["Time"];

                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                          picture: data["Picture"],
                                          title: data["Title"],
                                          price: price,
                                          time: time)));
                                },
                                child: IndieCard(
                                  image: data["Picture"],
                                  title: data["Title"],
                                  iconpath: "assets/images/veri.png",
                                ));
                          },
                        )),
                  ]);
                } else if (!snapshot.hasData) {
                  return Container(
                    child: Text("An Error Has occured"),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 25),
            Text("Meals", style: GoogleFonts.lato(color: Colors.white)),
            SizedBox(height: 25),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where("Category", isEqualTo: "Meal")
                  .snapshots()
                  .map((snapshot) =>
                      snapshot.docs.map((docs) => docs.data()).toList()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, index) =>
                              SizedBox(width: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Map data = snapshot.data[index];
                            double price = data["Price"];
                            double time = data["Time"];

                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                          picture: data["Picture"],
                                          title: data["Title"],
                                          price: price,
                                          time: time)));
                                },
                                child: IndieCard(
                                  image: data["Picture"],
                                  title: data["Title"],
                                  iconpath: "assets/images/veri.png",
                                ));
                          },
                        )),
                  ]);
                } else if (!snapshot.hasData) {
                  return Container(
                    child: Text("Hade "),
                  );
                }
                return Text("Sorry");
              },
            ),
            SizedBox(height: 25),
            Text("Snacks", style: GoogleFonts.lato(color: Colors.white)),
            SizedBox(height: 25),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where("Category", isEqualTo: "Snacks")
                  .snapshots()
                  .map((snapshot) =>
                      snapshot.docs.map((docs) => docs.data()).toList()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(width: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Map data = snapshot.data[index];
                            double price = data["Price"];
                            double time = data["Time"];
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                          picture: data["Picture"],
                                          title: data["Title"],
                                          price: price,
                                          time: time)));
                                },
                                child: IndieCard(
                                  image: data["Picture"],
                                  title: data["Title"],
                                  iconpath: "assets/images/veri.png",
                                ));
                          },
                        )),
                  ]);
                } else if (!snapshot.hasData) {
                  return Container(
                    child: Text("Hade "),
                  );
                }
                return Text("sorry");
              },
            ),
            Text("Drinks", style: GoogleFonts.lato(color: Colors.white)),
            SizedBox(height: 25),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where("Category", isEqualTo: "Drink")
                  .snapshots()
                  .map((snapshot) =>
                      snapshot.docs.map((docs) => docs.data()).toList()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(width: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Map data = snapshot.data[index];
                            double price = data["Price"];
                            double time = data["Time"];
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                          picture: data["Picture"],
                                          title: data["Title"],
                                          price: price,
                                          time: time)));
                                },
                                child: IndieCard(
                                  image: data["Picture"],
                                  title: data["Title"],
                                  iconpath: "assets/images/veri.png",
                                ));
                          },
                        )),
                  ]);
                } else if (!snapshot.hasData) {
                  return Container(
                    child: Text("Hade "),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 25),
            Text("Treats", style: GoogleFonts.lato(color: Colors.white)),
            SizedBox(height: 25),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Products")
                  .where("Category", isEqualTo: "Treats")
                  .snapshots()
                  .map((snapshot) =>
                      snapshot.docs.map((docs) => docs.data()).toList()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(width: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Map data = snapshot.data[index];
                            double price = data["Price"];
                            double time = data["Time"];
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                          picture: data["Picture"],
                                          title: data["Title"],
                                          price: price,
                                          time: time)));
                                },
                                child: IndieCard(
                                  image: data["Picture"],
                                  title: data["Title"],
                                  iconpath: "assets/images/veri.png",
                                ));
                          },
                        )),
                  ]);
                } else if (!snapshot.hasData) {
                  return Container(
                    child: Text("Hade "),
                  );
                }
                return Text("sorry");
              },
            ),
          ]))
    ]);
  }
}

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    String? current = FirebaseAuth.instance.currentUser?.uid;
    ScrollController controller = ScrollController();
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          IB(link: "assets/images/WallpaperDog-20491944.jpg"),
          SingleChildScrollView(
              child: Column(children: [
            TransCard(
              link: "assets/images/Icons/Bag_plus.png",
              width: 120,
              height: 120,
              glassheight: 120,
              glasswidth: 120,
              container: 250,
            ),
            PaddedText(text: "Cart"),
            Center(
              child: IconButton(
                icon: Icon(Icons.add_shopping_cart_outlined),
                onPressed: () {},
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Cart/${current}/Items")
                    .snapshots()
                    .map((collection) =>
                        collection.docs.map((docs) => docs.data()).toList()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        child: Column(children: [
                      Container(
                          child: ListView.separated(
                              controller: controller,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ActivityListTile(
                                  color: Colors.lightBlue,
                                  gradient: Colors.transparent,
                                  title: snapshot.data[index]["Title"],
                                  subtitle: snapshot.data[index]["Quantity"],
                                  trailingImage: snapshot.data[index]
                                      ["Picture"],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 1,
                                );
                              },
                              itemCount: snapshot.data.length)),
                      Container(
                          child: Center(
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            onPressed: () async {
                              Map<String, dynamic> orderdata = {
                                "uid": current,
                                "is_collected": false
                              };
                              List listdata = [];
                              var list = await FirebaseFirestore.instance
                                  .collection("Cart/${current}/Items")
                                  .get()
                                  .then((value) => value.docs
                                      .map((doc) => doc.data())
                                      .toList());
                              listdata.add(list);

                              listdata.add(orderdata);
                              var cred;

                              var user = await FirebaseFirestore.instance
                                  .collection("Students")
                                  .where("uid", isEqualTo: current)
                                  .get()
                                  .then((value) => value.docs.map((doc) {
                                        cred = doc.data();
                                      }).toList());

                              var order = {
                                "Items": listdata[0],
                                "uid": current,
                                "is_collected": false,
                                "is_completed": false,
                              };

                              FirebaseFirestore.instance
                                  .collection("Orders")
                                  .add({
                                "Items": listdata[0],
                                "uid": current,
                                "is_collected": false,
                                "is_completed": false,
                              });
                              await FirebaseFirestore.instance
                                  .collection("Cart/${current}/Items")
                                  .get()
                                  .then((value) {
                                for (var i in value.docs) {
                                  i.reference.delete();
                                }
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AwaitingOrder(order: order, cred: cred)));
                            },
                            child: Text("Proceed to Checkout")),
                      )),
                    ]));
                  } else if (!snapshot.hasData) {
                    return Text(
                      "kk",
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  return Text("Waiting");
                })
          ]))
        ],
      ),
    ));
  }
}

class AwaitingOrder extends StatefulWidget {
  AwaitingOrder({Key? key, this.order, this.imageList, this.cred})
      : super(key: key);
  Map? order;
  List? imageList;
  var cred;
  @override
  State<AwaitingOrder> createState() => _AwaitingOrderState();
}

class _AwaitingOrderState extends State<AwaitingOrder> {
  @override
  Widget build(BuildContext context) {
    List images = widget.order?["Items"];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            IB(link: "assets/images/fill.jpg"),
            GlassContainer(
              contColor: Colors.transparent,
              sigmax: 5,
              sigmay: 5,
              contWidth: MediaQuery.of(context).size.width,
              contHeight: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  //Text("${snapshot.data[0]["Items"]}")
                  GFCard(
                      boxFit: BoxFit.contain,
                      title: GFListTile(
                        title: Text("Your Order has been sent",
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 15)),
                      ),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 55, 89, 185),
                        Colors.transparent
                      ])),

                  SizedBox(height: 25),
                  
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FinishedOrders extends StatefulWidget {
  FinishedOrders({Key? key}) : super(key: key);

  @override
  State<FinishedOrders> createState() => _FinishedOrdersState();
}

class _FinishedOrdersState extends State<FinishedOrders> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
