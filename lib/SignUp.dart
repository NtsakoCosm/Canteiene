import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stepo/stepo.dart';
import 'Usermanagement.dart';
import 'dart:io';
import 'package:glass_container/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Shorthands.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String _username;
  late String _password;
  late String _name;
  late String _surname;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        IB(link: "assets/images/Breakfas.jpg"),
        Rec(
            content: Text(
          "The Cantiene",
          style: GoogleFonts.cinzelDecorative(
              fontWeight: FontWeight.w500, color: Colors.white),
          textScaleFactor: 2.1,
        )),
        GlassContainer(
            contWidth: MediaQuery.of(context).size.width * double.infinity,
            contHeight: MediaQuery.of(context).size.height * 0.99,
            contColor: Colors.white10.withOpacity(0),
            borderRadiusColor: Colors.black,
            sigmax: 0.5,
            sigmay: 0,
            shadowBlurRadius: 100.0,
            radius: BorderRadius.all(Radius.circular(10)),
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (name){ setState(() {
                        _name = name;
                      }); },
                      style: TextStyle(),
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.7),
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          hintText: 'Name'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (surname){ setState(() {
                        _surname = surname;
                      }); },
                      style: TextStyle(),
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.7),
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Surname',
                          hintText: 'Surname'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) => {
                        setState(() {
                          _username = value;
                        })
                      },
                      style: TextStyle(),
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.7),
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter Valid Email'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) => {
                        setState(() {
                          _password = value;
                        })
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.7),
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter your secure password'),
                    ),
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: (() => {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _username, password: _password)
                              .then((signInUser) {
                            UserManagement().storeUser(signInUser, context);
                            FirebaseFirestore.instance
                                .collection("Students")
                                .add({"uid": signInUser.user?.uid,"Name":_name,"Surname":_surname});
                          }).catchError((e) {
                            
                          })
                        }),
                    child: Text("Sign-Up"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.black;
                        return Colors.black;
                      }),
                    ),
                  )),
                  SizedBox(height: 35),
                  GlassContainer(
                      contWidth: MediaQuery.of(context).size.width * 0.8,
                      contHeight: MediaQuery.of(context).size.width * 0.3,
                      contColor: Colors.white10.withOpacity(0),
                      sigmax: 15,
                      sigmay: 0,
                      shadowBlurRadius: 100.0,
                      radius: BorderRadius.all(Radius.circular(10)),
                      child: Center(child: t))
                ],
              ),
            )))
      ]),
    ));
  }
}

Text t = Text(
  "Why an App?",
  style: GoogleFonts.jura(color: Colors.white),
);

Rec title = Rec(
    content: Text(
  "The Canteiene",
  style: GoogleFonts.jura(color: Colors.white),
));
