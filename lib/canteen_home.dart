import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_canteen/add_times.dart';
import 'package:college_canteen/deleteItems.dart';
import 'package:college_canteen/syllabus.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Color colr = Color(0xffd1d1d1);
bool isloaded = false;
final children = <Widget>[]; // list to store itemcards

List<List>? names = [];
List<int>? total = [];

List<String>? user = [];
List<bool>? ispaid = [];
int orderscount = 0;
int oc2 = 0;
Map<String, dynamic>? userMap;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CanteenHome extends StatefulWidget {
  CanteenHome({Key? key}) : super(key: key);

  @override
  State<CanteenHome> createState() => _CanteenHomeState();
}

class _CanteenHomeState extends State<CanteenHome> {
  getCount() async {
    DocumentSnapshot variab = await FirebaseFirestore.instance
        .collection("Canteen")
        .doc("TotalOrders")
        .get();

    setState(() {
      orderscount = variab["count"];
      oc2 = variab["count2"];
    });
  }

  getItems() async {
    await _firestore
        .collection('Canteen')
        .doc('orders')
        .collection('orderDetails')
        .get()
        .then((value) {
      setState(() {
        for (int i = 0; i < orderscount; i++) {
          userMap = value.docs[i].data();
          names?.add(userMap!["FoodItems"]);
          total?.add(userMap!["Total"]);
          user?.add(userMap!["Person"]);

          //list?.add(value.docs[i].data());
        }
      });
    });
  }

  emptyLists() {
    names?.length = 0;
    user?.length = 0;
    total?.length = 0;
  }

  listoforderscard() {
    children.length = 0;

    for (var i = 0; i < orderscount; i++) {
      children.add(Padding(
        padding: EdgeInsets.fromLTRB(1.w, 1.w, 1.w, 0),
        child: Container(
            width: 92.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.w),
              boxShadow: [
                BoxShadow(
                    color: const Color(0XFFA8B4C5).withOpacity(0.30),
                    spreadRadius: 0,
                    blurRadius: 14,
                    offset: const Offset(0, 6.0)),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50.w,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${user![i]}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500)),
                          Text("${names![i]}",
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12.sp)),
                        ]),
                  ),
                  Column(children: [
                    TextButton(
                        onPressed: () async {
                          // await _firestore
                          //     .collection('Canteen')
                          //     .doc("orders")
                          //     .collection('orderDetails')
                          //     .doc("${i + 1}")
                          //     .delete();
                          // getCount();
                          // await _firestore
                          //     .collection("Canteen")
                          //     .doc("orders")
                          //     .collection("fromCanteen")
                          //     .doc("${orderscount}")
                          //     .set(
                          //   {
                          //     "Person": user![i],
                          //     "FoodItems": "${names![i]}",
                          //     "Total": total![i],
                          //     "isPaid": ispaid![i],
                          //     "status": "Cancelled"
                          //   },
                          // );

                          // await _firestore
                          //     .collection('Canteen')
                          //     .doc("TotalOrders")
                          //     .update(
                          //   {"count": orderscount - 1},
                          // );
                          // emptyLists();
                          // getCount();
                          // Future.delayed(
                          //     const Duration(milliseconds: 500), () {});
                          // getItems();
                        },
                        child: Text("Cancel",
                            style:
                                TextStyle(color: Colors.red, fontSize: 10.sp))),
                    TextButton(
                        onPressed: () async {
                          // await _firestore
                          //     .collection('Canteen')
                          //     .doc("orders")
                          //     .collection('orderDetails')
                          //     .doc("${i + 1}")
                          //     .delete();
                          // getCount();
                          // await _firestore
                          //     .collection("Canteen")
                          //     .doc("orders")
                          //     .collection("fromCanteen")
                          //     .doc("${orderscount}")
                          //     .set(
                          //   {
                          //     "Person": user![i],
                          //     "FoodItems": "${names![i]}",
                          //     "Total": total![i],
                          //     "isPaid": true,
                          //     "status": "Delivered"
                          //   },
                          // );

                          // await _firestore
                          //     .collection('Canteen')
                          //     .doc("TotalOrders")
                          //     .update(
                          //   {"count": orderscount - 1},
                          // );
                          // emptyLists();
                          // getCount();
                          // Future.delayed(
                          //     const Duration(milliseconds: 500), () {});
                          // getItems();
                        },
                        child: Text("Done",
                            style: TextStyle(
                                color: Colors.green, fontSize: 10.sp))),
                  ]),
                  Container(
                    height: 13.w,
                    width: 13.w,
                    child: Center(child: Text("${total![i]}/-")),
                    decoration: BoxDecoration(
                        color: Color(0xffB3F4C0), //: Color(0xffF1B1BC),
                        borderRadius: BorderRadius.circular(2.w)),
                  )
                ],
              ),
            )),
      ));
    }
    return Column(
      children: children,
    );
  }

  @override
  void initState() {
    emptyLists();
    setState(() {
      isloaded = false;
    });

    getCount();
    Future.delayed(const Duration(milliseconds: 700), () {});
    getItems();

    setState(() {
      isloaded = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
              title: Text("COLLEGE CANTEEN",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
              centerTitle: true,
              elevation: 0,
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xff7732B1), Color(0xffC38DDB)])))),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AddItems()));
                      },
                      borderRadius: BorderRadius.circular(5.w),
                      child: Ink(
                          height: 20.w,
                          width: 20.w,
                          child: Center(
                            child: Expanded(
                              child: Text("Add       items",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.sp)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFffffff).withOpacity(1),
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: Offset(-3, -3.0)),
                                BoxShadow(
                                    color: Color(0XFFC091E7).withOpacity(0.36),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(3, 5.0)),
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffC38DDB),
                                    Color(0xff7732B1)
                                  ]))),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => deleteItems()));
                      },
                      borderRadius: BorderRadius.circular(5.w),
                      child: Ink(
                          height: 20.w,
                          width: 20.w,
                          child: Center(
                            child: Expanded(
                              child: Text("Delete items",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.sp)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFffffff).withOpacity(1),
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: Offset(-3, -3.0)),
                                BoxShadow(
                                    color: Color(0XFFC091E7).withOpacity(0.36),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(3, 5.0)),
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffC38DDB),
                                    Color(0xff7732B1)
                                  ]))),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(5.w),
                      child: Ink(
                          height: 20.w,
                          width: 20.w,
                          child: Center(
                            child: Expanded(
                              child: Text("Orders Summary",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.sp)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFffffff).withOpacity(1),
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: Offset(-3, -3.0)),
                                BoxShadow(
                                    color: Color(0XFFC091E7).withOpacity(0.36),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(3, 5.0)),
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffC38DDB),
                                    Color(0xff7732B1)
                                  ]))),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Syllabus()));
                      },
                      borderRadius: BorderRadius.circular(5.w),
                      child: Ink(
                          height: 20.w,
                          width: 20.w,
                          child: Center(
                            child: Expanded(
                              child: Text("Add items",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.sp)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFffffff).withOpacity(1),
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: Offset(-3, -3.0)),
                                BoxShadow(
                                    color: Color(0XFFC091E7).withOpacity(0.36),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(3, 5.0)),
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffC38DDB),
                                    Color(0xff7732B1)
                                  ]))),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6.w, 3.w, 60.w, 3.w),
                    child: Text("ORDERS",
                        style: TextStyle(
                            color: Colors.indigo[800], fontSize: 14.sp)),
                  ),
                  IconButton(
                    onPressed: () async {
                      emptyLists();
                      setState(() {
                        isloaded = false;
                      });

                      getCount();
                      Future.delayed(const Duration(milliseconds: 700), () {});
                      getItems();

                      setState(() {
                        isloaded = true;
                      });
                    },
                    icon: Icon(Icons.refresh_rounded, size: 7.w),
                  )
                ],
              ),
              Container(
                height: 50.h,
                width: 90.w,
                child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.vertical,
                    children: [isloaded ? listoforderscard() : SizedBox()]),
              )
            ],
          ));
    });
  }
}
