import 'package:flutter/material.dart';

class ActivityListTile extends StatelessWidget {
  String? title;
  double? subtitle;
  String? trailingImage;

  Color? color;
  Color? gradient;

  ActivityListTile(
      {this.title,
      this.color,
      this.gradient,
      this.subtitle,
      this.trailingImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: GestureDetector(
        onTap: () {},
        child: Stack(alignment: Alignment.bottomRight, children: <Widget>[
          Card(
              
              color: Colors.transparent.withOpacity(0.1),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(5.0)),
                      gradient: LinearGradient(
                          colors: [color!, gradient!],
                          begin: Alignment.topCenter,
                          end: Alignment.topRight)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(title!),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "${subtitle!}",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ))),
          
          Padding(
              padding: const EdgeInsets.only(bottom: 4),
              
              child: Container(
                height: 150,
                width: 150,
                
                child: Image.asset(trailingImage!)))
        ]),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, right: 4.0),
      child: Container(
        child: Image.asset(
          'assets/images/Icons/checkout-order-4800475-4014671.png',
          height: 110,
        ),
      ),
    );
  }
}
