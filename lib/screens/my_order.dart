import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/componenets/auth.dart';

FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
class MyOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
        backgroundColor: Colors.blue,
      ),
      body: Element(),
    );
  }
}

class Element extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore
          .collection('user')
          .doc(Provider.of<AuthProvider>(context).user.uid)
          .collection("Order")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final content = snapshot.data.docs;

        List<Abc> cart = [];

        for (var message in content) {
          final orderName = message.data()["CustomerOrder"];
          final orderDate = message.data()["CustomerOrderDate"];
          final orderTime = message.data()["CustomerOrderTime"];
          final oneTimeOtp = message.data()["CustomerOneTimeOtp"];
          final orderTiming = message.data()["CustomerOrderTiming"];
          final all = Abc(
            orderName: orderName,
            orderDate: orderDate,
            orderTime: orderTime,
            oneTimeOtp: oneTimeOtp,
            orderTiming: orderTiming,
          );
          cart.add(all);
        }
        return ListView(
          children: cart,
        );
      },
    );
  }
}


class Abc extends StatelessWidget {
  final  orderName;
  final orderDate;
  final orderTime;
  final  oneTimeOtp;
  final orderTiming;
  Abc({
    this.orderTiming,
    this.oneTimeOtp,
    this.orderTime,
    this.orderDate,
    this.orderName,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Colors.green,
        margin: EdgeInsets.all(7),
        child: ListTile(
          title: Text("$orderName"),

        ),
      ),
    );
  }
}
