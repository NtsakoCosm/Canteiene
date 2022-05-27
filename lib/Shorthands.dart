// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, dead_code, avoid_unnecessary_containers

import "dart:math";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phase1/main.dart';
import 'package:phase1/models/Productt.dart';
import 'package:stepo/stepo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glass_container/glass_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'models/Cart.dart';

class IB extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const IB({
    required this.link,
  });
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: Image.asset(link).image,
        fit: BoxFit.cover,
      )),
    );
  }
}

class TransCard extends StatelessWidget {
  TransCard(
      {required this.link,
      this.width = 200,
      this.height = 200,
      this.glasswidth = 150,
      this.glassheight = 150,
      this.container = 350});
  final String link;
  double? width;
  double? height;
  double? glasswidth;
  double? glassheight;
  double? container;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: container,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Rec(
                  content: Text(
                "The Cantiene",
                textDirection: TextDirection.ltr,
                style: GoogleFonts.cinzelDecorative(
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
                textScaleFactor: 2.2,
              )),
              SizedBox(height: 70),
              Stack(children: [
                Center(
                  child: GlassContainer(
                      contHeight: glassheight,
                      contWidth: glasswidth,
                      contColor: Colors.black12.withOpacity(0.1),
                      sigmax: 1.5,
                      sigmay: 1.5,
                      radius: BorderRadius.all(
                        Radius.circular(366),
                      )),
                ),
                Center(
                    child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: Image.asset(link).image)),
                )),
              ])
            ])));
  }
}

class Rec extends StatelessWidget {
  const Rec({required this.content});
  final Widget content;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      GlassContainer(
        borderRadiusColor: Colors.grey,
        contHeight: 40,
        contWidth: 420,
        contColor: Colors.black54.withOpacity(0.75),
        radius: BorderRadius.all(Radius.circular(66)),
        child: Center(child: content),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          color: Colors.white,
          icon: Icon(Icons.shopping_cart_checkout_outlined),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CartScreen()));
          },
        ),
      )
    ]);
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  // ignore: dead_code, dead_code
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //contHeight: size.height * 0.52,

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: []));
  }
}

class IndieCard extends StatelessWidget {
  IndieCard(
      {this.iconpath = '',
      required this.image,
      required this.title,
      this.height = 250,
      this.width = 200,
      this.onclick});
  final String iconpath;
  final String image;
  double height;
  double width;
  String title;
  Function? onclick;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: width,
        height: height,
        child: Ink(
          color: Colors.black12,
          child: Stack(children: [
            GlassContainer(
                contColor: Colors.white10.withOpacity(0.1),
                sigmax: 0.5,
                sigmay: 0.5,
                shadowBlurRadius: 100.0,
                radius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  child: Stack(
                    children: [
                      Center(
                          child: Image.asset(image,
                              fit: BoxFit.contain, width: 150, height: 150)),
                    ],
                  ),
                )),
            Container(
              width: size.width * 0.08,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment(-1.0, -1.0),
                      image: Image.asset(iconpath).image)),
            ),
            Positioned(
                bottom: 1,
                child: GlassContainer(
                  borderRadiusColor: Colors.white.withOpacity(0),
                  contHeight: height * 0.25,
                  contWidth: width - 1.5,
                  contColor: Colors.white10.withOpacity(0),
                  sigmax: 0.5,
                  sigmay: 0.5,
                  shadowBlurRadius: 100.0,
                  radius: BorderRadius.all(Radius.circular(10)),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white70,
                  ),
                )),
            Positioned(
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.lato(color: Colors.white),
                ),
              ),
              top: 1,
              left: 0,
              right: 0,
            )
          ]),
        ));
  }
}

class Scroll extends StatelessWidget {
  const Scroll({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final String icon;

  @override
  Widget build(BuildContext context) {
    CollectionReference db = FirebaseFirestore.instance.collection('Products');

    double height = 180;
    double width = 180;
    double sizedboxwidth = 8;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [],
      ),
    );
  }
}

class PaddedText extends StatelessWidget {
  const PaddedText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: GoogleFonts.jura(
              fontWeight: FontWeight.w600, color: Colors.white60),
          textScaleFactor: 1.5,
        ),
      ),
    ]);
  }
}

class Focusfood extends StatelessWidget {
  Focusfood({Key? key, required this.link}) : super(key: key);

  String link;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: GlassContainer(
            contHeight: 150,
            contWidth: 150,
            contColor: Colors.black12.withOpacity(0.1),
            sigmax: 1.5,
            sigmay: 1.5,
            radius: BorderRadius.all(
              Radius.circular(366),
            )),
      ),
      Center(
          child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight, image: Image.asset(link).image)),
      )),
    ]);
  }
}

class Details extends StatefulWidget {
  Details(
      {Key? key,
      required this.picture,
      required this.title,
      required this.price,
      required this.time})
      : super(key: key);

  String picture;
  String title;
  double? price;
  double time;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double quantity = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
        child: Container(
      width: width,
      height: height * 0.9 * 1,
      child: Stack(children: [
        GlassContainer(
          borderRadiusColor: Colors.black87,
          shadowColor: Colors.black38,
          contWidth: width,
          contHeight: height * 0.9 * 1,
          contColor: Colors.white10.withOpacity(0.05),
          sigmax: 1.0,
          sigmay: 1.0,
          shadowBlurRadius: 10.0,
          radius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "${widget.title}",
                  style: GoogleFonts.jua(color: Colors.white),
                  textScaleFactor: 1.35,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    Center(
                      child: StarDisplay(
                        value: 4,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(
                                          context,
                                          widget.title,
                                          widget.price,
                                          quantity,
                                          widget.picture));
                            },
                            splashColor: Colors.white,
                            child: Ink(
                              color: Colors.white,
                              child: Image.asset(
                                "assets/images/Icons/Bag_plus.png",
                              ),
                              height: 100,
                              width: 100,
                            ))),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SpinBox(
                        decoration: InputDecoration(fillColor:Colors.white10 , filled: true),
                        onChanged: (value) {
                        setState(() {
                          quantity = value + 0.01;
                          
                        });
                      }),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black54,
                              shadowColor: Colors.white.withOpacity(0.1)),
                          child: Text("Add to cart"),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(
                                        context,
                                        widget.title,
                                        widget.price,
                                        quantity,
                                        widget.picture));
                          },
                        )),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GlassContainer(
                              borderRadiusColor:
                                  Colors.white24.withOpacity(0.02),
                              shadowSpreadRadius: 0,
                              shadowColor: Colors.white30.withOpacity(0.01),
                              sigmax: 1,
                              sigmay: 1,
                              contHeight: 90,
                              contWidth: 80,
                              radius: BorderRadius.circular(20),
                              contColor: Colors.white70.withOpacity(0.1),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                    "assets/images/Icons/price_icon.png",
                                    height: 50,
                                    width: 50),
                              )),
                          GlassContainer(
                              borderRadiusColor:
                                  Colors.white24.withOpacity(0.02),
                              shadowSpreadRadius: 0,
                              shadowColor: Colors.white30.withOpacity(0.01),
                              contHeight: 90,
                              contWidth: 80,
                              sigmax: 1,
                              sigmay: 1,
                              radius: BorderRadius.circular(20),
                              contColor: Colors.white70.withOpacity(0.1),
                              child: Center(
                                  child: Text(
                                "${widget.price}",
                                textScaleFactor: 1.5,
                              )))
                        ]),
                    SizedBox(height: 60),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GlassContainer(
                            borderRadiusColor: Colors.white24.withOpacity(0.02),
                            shadowSpreadRadius: 0,
                            shadowColor: Colors.white30.withOpacity(0.01),
                            contHeight: 90,
                            contWidth: 80,
                            radius: BorderRadius.circular(20),
                            contColor: Colors.white70.withOpacity(0.1),
                            child: Image.asset(
                                "assets/images/Icons/timeicon.png",
                                height: 50,
                                width: 50),
                          ),
                          GlassContainer(
                              borderRadiusColor:
                                  Colors.white24.withOpacity(0.02),
                              shadowSpreadRadius: 0,
                              shadowColor: Colors.white30.withOpacity(0.01),
                              contHeight: 90,
                              contWidth: 80,
                              radius: BorderRadius.circular(20),
                              contColor: Colors.white70.withOpacity(0.1),
                              child: Center(
                                  child: Text(
                                "${widget.time}",
                                textScaleFactor: 1.5,
                              )))
                        ])
                  ])))
            ],
          ),
        ),
      ]),
    ));
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key? key, this.value = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          color: Colors.black54.withOpacity(0.75),
        );
      }),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, String title, double? price,
    double quantity, String picture) {
  return new AlertDialog(
    title: const Text('We know you want it :)'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Add to cart?"),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Close'),
      ),
      ElevatedButton(
        child: Text('add'),
        onPressed: () {
          
          var updated = false;
          var options = SetOptions(merge: true);

          var current = FirebaseAuth.instance.currentUser?.uid;
          
           FirebaseFirestore.instance
                .collection("Cart/${current}/Items")
                .doc(title)
                .set({"Title": title, "Price": price, "Picture": picture,"Quantity": quantity},
                    options);
          Navigator.of(context).pop();
            
          }
    ),
        
      
    ],
  );
}

//lost classes

Widget glassview(image, title, double width, double height, {iconpath = ''}) {
  return IndieCard(
    image: image,
    title: title,
    width: width,
    iconpath: iconpath,
    height: height,
  );
}
