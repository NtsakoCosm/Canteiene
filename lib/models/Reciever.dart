import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/generated/google/firestore/v1/document.pb.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/generated/l10n.dart';
import 'package:flutter/material.dart' as ui;
import 'package:flutter/material.dart' as dd;
import 'package:flutter_particle_background/flutter_particle_background.dart';
import 'package:firedart/firedart.dart' as fd;
import 'package:glass_container/glass_container.dart';
import 'tile.dart';
import 'package:getwidget/getwidget.dart' as w;
import 'package:phase1/Shorthands.dart';

class Desk extends StatelessWidget {
  const Desk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
        home: ui.Scaffold(
            body: Content(),
            drawer: ui.Drawer(
                child: DrawerInfi(),
                backgroundColor: Color.fromARGB(255, 182, 209, 231)),
            appBar: ui.AppBar(
              backgroundColor: Color.fromARGB(255, 11, 41, 66),
              title: Text("The Cantiene Tracker "),
            )));
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fd.CollectionReference i = fd.Firestore.instance.collection("Products");
    return Stack(children: [
      GlassContainer(
        contHeight: MediaQuery.of(context).size.height,
        contWidth: MediaQuery.of(context).size.width,
        contColor: Colors.transparent,
      ),
      OrderBar()
    ]);
  }
}

class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.25,
      color: Colors.white,
      child: FutureBuilder(
        future: getproducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(children: [
              w.GFButtonBadge(
                onPressed: () {},
                text: "Incoming Order Stream",
                icon: w.GFBadge(
                  child: Text("${snapshot.data.length}"),
                ),
                shape: w.GFButtonShape.pills,
                type: w.GFButtonType.outline,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                          height: 50,
                        ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var orders = snapshot.data[index].map;
                      var info = [];
                      var profile = fd.Firestore.instance
                          .collection("Students")
                          .where("uid", isEqualTo: orders["uid"])
                          .get();

                      return FutureBuilder(
                          future: profile,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Column(children: [
                                w.GFButtonBadge(
                                  onPressed: () {},
                                  text: "ADD Order to InProgress",
                                ),
                                w.GFAccordion(
                                    contentBackgroundColor: Colors.grey,
                                    title: "${snapshot.data[0].map["Name"]}",
                                    contentChild: ListView.separated(
                                      controller: ScrollController(),
                                      shrinkWrap: true,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                        height: 20,
                                      ),
                                      itemCount: orders["Items"].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(children: [
                                          w.GFListTile(
                                              title: Text(orders["Items"][index]
                                                  ["Title"]),
                                              subTitle: Text(
                                                  "${orders["Items"][index]["Quantity"]}"),
                                              icon: Center(
                                                child: Image.asset(
                                                  orders["Items"][index]
                                                      ["Picture"],
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              ))
                                        ]);
                                      },
                                    ))
                              ]);
                            }

                            if (!snapshot.hasData) {}
                            return ui.CircularProgressIndicator();
                          });
                    }),
              )
            ]);
          } else if (!snapshot.hasData) {}
          return Center(
            child: ui.CircularProgressIndicator(),
            heightFactor: 1,
            widthFactor: 1,
          );
        },
      ),
    );
  }
}

class DrawerInfi extends StatelessWidget {
  const DrawerInfi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
            leading: Text("Live Tracker"),
            trailing: Icon(ui.Icons.stream_outlined)),
        SizedBox(height: 20),
        ListTile(
            leading: Text("Outstanding Orders"),
            trailing: Icon(ui.Icons.unfold_less_outlined)),
      ],
    );
  }
}

getproducts() async {
  List order_list = [];
  var orders = await fd.Firestore.instance
      .collection("Orders")
      .where("is_collected", isEqualTo: false)
      .get();

  return orders;
}

class OrderBar extends StatefulWidget {
  const OrderBar({Key? key}) : super(key: key);

  @override
  State<OrderBar> createState() => _OrderBarState();
}

class _OrderBarState extends State<OrderBar> {
  var notstarted = true;
  var started = false;
  var finished = false;
  var collected = false;
  List<Widget> inProgress = [];
  @override
  Widget build(BuildContext context) {
    var orders = getproducts();

    return Row(children: [
      Container(
        color: Color.fromARGB(234, 242, 242, 255),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.5,
        child: FutureBuilder(
          future: orders,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(children: [
                    ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 50,
                      ),
                      itemCount: snapshot.data.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var items = snapshot.data[index].map["Items"];
                        var data = snapshot.data[index].map;

                        return SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              w.GFAccordion(
                                  title:
                                      "${snapshot.data[index]["Name"]} ${snapshot.data[index]["Surname"]}",
                                  contentChild: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GlassContainer(
                                                contHeight:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height,
                                                contWidth: 1000,
                                                contColor: Colors.transparent
                                                    .withOpacity(0),
                                                child: Column(children: [
                                                  Row(children: [
                                                    Container(
                                                        child: Row(children: [
                                                      Text("Started"),
                                                      w.GFToggle(
                                                          onChanged: (val) {
                                                            setState(() {
                                                              if (val!) {
                                                                notstarted =
                                                                    false;
                                                              }
                                                            });
                                                          },
                                                          value: started,
                                                          type: w.GFToggleType
                                                              .square)
                                                    ])),
                                                    Container(
                                                        child: Row(children: [
                                                      Text("Finished"),
                                                      w.GFToggle(
                                                          onChanged: (val) {
                                                            data["is_completed"] =
                                                                true;
                                                            setState(() {
                                                              fd.Firestore
                                                                  .instance
                                                                  .collection(
                                                                      "Orders")
                                                                  .document(snapshot
                                                                      .data[
                                                                          index]
                                                                      .id)
                                                                  .set(data);
                                                              started = false;
                                                            });
                                                          },
                                                          value: finished,
                                                          type: w.GFToggleType
                                                              .square)
                                                    ])),
                                                    Container(
                                                        child: Row(children: [
                                                      Text("Collected"),
                                                      w.GFToggle(
                                                          onChanged: (val) {
                                                
                                                            

                                                            data["is_collected"] =
                                                                true;

                                                            setState(() {
                                                              w.GFAlert();
                                                              fd.Firestore
                                                                  .instance
                                                                  .collection(
                                                                      "Orders")
                                                                  .document(snapshot
                                                                      .data[
                                                                          index]
                                                                      .id)
                                                                  .set(data);
                                                            });
                                                          },
                                                          value: collected,
                                                          type: w.GFToggleType
                                                              .android)
                                                    ]))
                                                  ]),
                                                  Expanded(
                                                      child: ListView.separated(
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Container(
                                                                child:
                                                                    ActivityListTile(
                                                              trailingImage:
                                                                  items[index][
                                                                      "Picture"],
                                                              subtitle: items[
                                                                      index]
                                                                  ["Quantity"],
                                                              title:
                                                                  items[index]
                                                                      ["Title"],
                                                              color:
                                                                  Colors.white,
                                                              gradient:
                                                                  Colors.white,
                                                            ));
                                                          },
                                                          separatorBuilder:
                                                              (BuildContext
                                                                          context,
                                                                      int
                                                                          index) =>
                                                                  const SizedBox(
                                                                    height: 1,
                                                                  ),
                                                          itemCount:
                                                              items.length))
                                                ])),
                                          ])))
                            ]));
                      },
                    )
                  ]));
            }
            if (!snapshot.hasData) {}
            return ui.CircularProgressIndicator();
          },
        ),
      ),
      Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.25,
          color: Color.fromARGB(255, 175, 183, 185),
          child: Column(
            children: inProgress,
          ))
    ]);
  }
}

class FinishedTarget extends StatelessWidget {
  const FinishedTarget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
