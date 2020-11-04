import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/componenets/auth.dart';
import 'package:shopapp/componenets/constant.dart';
import 'package:lottie/lottie.dart';

var name;
var address;
var mobileNo;
var pinCode;
FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
Random random= Random();

class Information extends StatefulWidget {
  final orderName;
  final orderPrice;
  Information({this.orderName, this.orderPrice});
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  DateTime date = DateTime.utc(2000);
  DateTime now = DateTime.now();
  String time = "0 to 0";
  String payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Detail Information"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Customer Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Card(
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  TextField(
                    style: TextStyle(color: Colors.blue),
                    decoration:
                        kInputDecoration.copyWith(hintText: "Enter the Name:"),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: Colors.blue),
                    decoration: kInputDecoration.copyWith(
                        hintText: "Enter the Mobile No:"),
                    onChanged: (value) {
                      mobileNo = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: Colors.blue),
                    decoration: kInputDecoration.copyWith(
                        hintText: "Enter the Address:"),
                    onChanged: (value) {
                      address = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: Colors.blue),
                    decoration: kInputDecoration.copyWith(
                      hintText: "Enter the PinCode",
                    ),
                    onChanged: (value) {
                      pinCode = value;
                    },
                  ),
                ],
              ),
            ),
            Text(
              "Order Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Text(
                        "Name of Order :${widget.orderName}",
                        style: TextStyle(color: Colors.blue, fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: kInputDecoration.copyWith(
                      hintText: "Total Price of Order : ${widget.orderPrice}",
                      hintStyle: TextStyle(color: Colors.blue),
                    ),
                    enabled: false,
                  ),
                  Divider(),
                  ListTile(
                    hoverColor: Colors.greenAccent,
                    title: Text(
                      "Order Schedule Date :${date.day}/${date.month}/${date.year}",
                      style: TextStyle(color: Colors.blue),
                    ),
                    subtitle: Text(
                      "(Select the Date Before proceed)",
                      style: TextStyle(fontSize: 11),
                    ),
                    trailing: Icon(
                      Icons.date_range,
                      color: Colors.blue,
                    ),
                    onTap: () => _pickedDate(),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Order Schedule Time : $time",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  date.year != 2000 ? radioButtons() : Divider(),
                  ListTile(
                    title: Text(
                      "Select the Payment Method : ",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  RadioListTile(
                    value: "Cash On Delivery",
                    title: Text("Cash on Delivery"),
                    activeColor: Colors.blue,
                    groupValue: payment,
                    onChanged: (pay) {
                      setState(() {
                        payment = pay;
                      });
                    },
                  ),
                  RaisedButton(
                    child: Center(
                      child: Text("Submit"),
                    ),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            actions: [
                              RaisedButton(
                                child: Text("Confirm"),
                                color: Colors.greenAccent,
                                onPressed: () async {
                                  await _firebaseFirestore.collection("Order").add({
                                    "CustomerName": name,
                                    "CustomerMobileNo": mobileNo,
                                    "CustomerAddress": address,
                                    "CustomerPinCode": pinCode,
                                    "CustomerOrder": widget.orderName,
                                    "CustomerOrderPrice": widget.orderPrice,
                                    "CustomerOrderDate":
                                        "${date.day}/${date.month}/${date.year}",
                                    "CustomerOrderTime": time,
                                    "CustomerOrderMethod": payment,
                                    "CustomerOrderTiming":DateTime.now(),
                                  });
                                  await _firebaseFirestore.collection("users").doc(Provider.of<AuthProvider>(context,listen: false).user.uid).collection("Order").add({
                                    "CustomerOrder":widget.orderName,
                                    "CustomerOrderDate":
                                    "${date.day}/${date.month}/${date.year}",
                                    "CustomerOrderTime": time,
                                    "CustomerOneTimeOtp":random.nextInt(1000000)+100000,
                                    "CustomerOrderTiming":DateTime.now(),
                                  });
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Your Request is Processed Successfully For Given Service"),
                                        content: Lottie.network(
                                            "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/intro%2Fdelivery.json?alt=media&token=2eaaf7b2-f490-4f7e-a283-6203a4b2c5c3"),
                                        actions: [
                                          FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            color: Colors.red,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              RaisedButton(
                                child: Text("Cancel"),
                                color: Colors.red,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _pickedDate() async {
    DateTime sample = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: (DateTime.now()).add(
        Duration(days: 3),
      ),
    );
    if (sample != null) {
      setState(() {
        date = sample;
      });
    }
  }

  Widget radioButtons() {
    if (date.day == now.day) {
      return Column(
        children: [
          now.hour <= 10
              ? Column(
                  children: [
                    RadioListTile(
                      value: "9am to 12pm",
                      activeColor: Colors.blue,
                      title: Text("9am to 12pm"),
                      groupValue: time,
                      onChanged: (t) {
                        setState(() {
                          time = t;
                        });
                      },
                    ),
                    RadioListTile(
                      value: "12pm to 3pm",
                      activeColor: Colors.blue,
                      title: Text("12pm to 3pm"),
                      groupValue: time,
                      onChanged: (t) {
                        setState(() {
                          time = t;
                        });
                      },
                    ),
                    RadioListTile(
                      value: "3pm to 6pm",
                      activeColor: Colors.blue,
                      title: Text("3pm to 6pm"),
                      groupValue: time,
                      onChanged: (t) {
                        setState(() {
                          time = t;
                        });
                      },
                    ),
                  ],
                )
              : now.hour <= 13
                  ? Column(
                      children: [
                        RadioListTile(
                          value: "12pm to 3pm",
                          activeColor: Colors.blue,
                          title: Text("12pm to 3pm"),
                          groupValue: time,
                          onChanged: (t) {
                            setState(() {
                              time = t;
                            });
                          },
                        ),
                        RadioListTile(
                          value: "3pm to 6pm",
                          activeColor: Colors.blue,
                          title: Text("3pm to 6pm"),
                          groupValue: time,
                          onChanged: (t) {
                            setState(() {
                              time = t;
                            });
                          },
                        ),
                      ],
                    )
                  : now.hour <= 17
                      ? RadioListTile(
                          value: "3pm to 6pm",
                          activeColor: Colors.blue,
                          title: Text("3pm to 6pm"),
                          groupValue: time,
                          onChanged: (t) {
                            setState(() {
                              time = t;
                            });
                          },
                        )
                      : Text("Please Select Next Date")
        ],
      );
    } else {
      return Column(
        children: [
          RadioListTile(
            value: "9am to 12pm",
            activeColor: Colors.blue,
            title: Text("9am to 12pm"),
            groupValue: time,
            onChanged: (t) {
              setState(() {
                time = t;
              });
            },
          ),
          RadioListTile(
            value: "12pm to 3pm",
            activeColor: Colors.blue,
            title: Text("12pm to 3pm"),
            groupValue: time,
            onChanged: (t) {
              setState(() {
                time = t;
              });
            },
          ),
          RadioListTile(
            value: "3pm to 6pm",
            activeColor: Colors.blue,
            title: Text("3pm to 6pm"),
            groupValue: time,
            onChanged: (t) {
              setState(() {
                time = t;
              });
            },
          ),
        ],
      );
    }
  }
}
