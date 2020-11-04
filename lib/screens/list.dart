import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/screens/productDetails.dart';

FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;

class Lists extends StatelessWidget {
  final listName;
  final cityName;
  Lists({this.listName,this.cityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Element(
            serviceName: listName,
            name: cityName,
          ),
        ],
      ),
    );
  }
}

class Element extends StatelessWidget {
  final serviceName;
  final name;
  Element({this.serviceName,this.name});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore
          .collection('Services')
          .doc(name)
          .collection(serviceName)
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
          final name = message.data()['name'];
          final price = message.data()['price'];
          final oldPrice = message.data()['oldPrice'];
          final details = message.data()['details'];
          final image = message.data()['image'];
          final all = Abc(
            name: name,
            price: price,
            oldPrice: oldPrice,
            details: details,
            image: image,
          );
          cart.add(all);
        }
        return Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: cart,
          ),
        );
      },
    );
  }
}

class Abc extends StatelessWidget {
  final image;
  final name;
  final price;
  final oldPrice;
  final details;
  Abc({
    this.name,
    this.price,
    this.details,
    this.oldPrice,
    this.image,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetails(
          productDetailDetails: details,
          productDetailName: name,
          productDetailPrice: price,
          productDetailPicture: image,
          productDetailOldPrice: oldPrice,
        ),),);
      },
      child: Card(
        margin: EdgeInsets.all(7),
        child: GridTile(
          footer: Container(
              height: 30,
              color: Colors.white70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black),
                    ),
                  ),
                  Text(
                    "\$$price",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15,),
                  Text(
                    "\$$oldPrice",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),
                  )
                ],
              )),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
