import 'package:flutter/widgets.dart';
import 'package:stepo/stepo.dart';

import 'dart:io';
import 'package:glass_container/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Shorthands.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        IB(link: "assets/images/Breakfas.jpg"),
        Padding(
          child: Rec(
              content: Text(
            "The Cantiene",
            style: GoogleFonts.cinzelDecorative(
                fontWeight: FontWeight.w400, color: Colors.white),
            textScaleFactor: 2,
          )),
          padding: EdgeInsets.only(top: 2),
        ),
        GlassContainer(
            contWidth: MediaQuery.of(context).size.width * double.infinity,
            contHeight: MediaQuery.of(context).size.height * 0.99,
            contColor: Colors.white10.withOpacity(0),
            borderRadiusColor: Colors.black,
            sigmax: 0.5,
            sigmay: 0,
            shadowBlurRadius: 100.0,
            radius: BorderRadius.all(Radius.circular(10)),
            child: Center(child: LogCol())),
      ]),
    ));
  }
}

class LogCol extends StatelessWidget {
  const LogCol({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 200), child: Fields());
  }
}

class Fields extends StatefulWidget {
  const Fields({Key? key}) : super(key: key);

  @override
  State<Fields> createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  late String _username;
  late String _password;
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
        height: s.height * 0.50,
        width: s.width * 0.98,
        child: GlassContainer(
          sigmax: 2,
          sigmay: 0,
          contColor: Colors.white.withOpacity(0.25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                  padding: EdgeInsets.all(25),
                  child: TextField(
                    onChanged: (value) => {_username = value},
                    decoration: InputDecoration(labelText: "Username"),
                  )),
              Padding(
                  padding: EdgeInsets.all(25),
                  child: TextField(
                    onChanged: (value) => {_password = value},
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                  )),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text("Login"),
                  onPressed: () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _username, password: _password)
                        .then((value) =>
                            Navigator.popAndPushNamed(context, "/landingpage"));
                  },
                ),
              ),
              Expanded(child: Text("Not Signed up yet?")),
              Expanded(child: Text("Sign-up Now")),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/signup');
                      },
                      icon: Icon(Icons.signpost_outlined),
                      color: Colors.white))
            ],
          ),
        ));
  }
}

class TextIn extends StatelessWidget {
  TextIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color w = Colors.white;
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.05),
                Colors.black.withOpacity(0.4)
              ])),
          child: GlassContainer(
            contWidth: MediaQuery.of(context).size.width * double.infinity,
            contHeight: MediaQuery.of(context).size.height * 0.265,
            contColor: Colors.white10.withOpacity(0),
            borderRadiusColor: Colors.white.withOpacity(0.0),
            sigmax: 5,
            sigmay: 0,
            shadowBlurRadius: 100.0,
            radius: BorderRadius.all(Radius.circular(25)),
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              style: GoogleFonts.jura(color: Colors.white),
              decoration: InputDecoration(
                  labelStyle: GoogleFonts.jura(color: Colors.white),
                  hintStyle:
                      GoogleFonts.jura(color: Colors.white, fontSize: 15),
                  floatingLabelStyle:
                      GoogleFonts.jura(color: Colors.white, fontSize: 25),
                  filled: false,
                  labelText: 'User Name',
                  hintText: '...'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              style: GoogleFonts.jura(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                  focusColor: Colors.white,
                  labelStyle: GoogleFonts.jura(color: Colors.white),
                  hintStyle:
                      GoogleFonts.jura(color: Colors.white, fontSize: 15),
                  floatingLabelStyle:
                      GoogleFonts.jura(color: Colors.white, fontSize: 25),
                  filled: false,
                  labelText: 'Password',
                  hintText: 'Enter your secure password'),
            ),
          ),
          Center(
              child: ElevatedButton(
            onPressed: (() => {}),
            child: Text("Login"),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.pressed)) return Colors.black;
                return Colors.black;
              }),
            ),
          )),
          Padding(child: TextIn(), padding: EdgeInsets.only(top: 150)),
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
    ]);
  }
}

Text t = Text(
  "Signup?",
  textScaleFactor: 1.65,
  style: GoogleFonts.jura(color: Colors.white),
);
