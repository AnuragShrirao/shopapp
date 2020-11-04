import 'package:avatar_glow/avatar_glow.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/componenets/cart_products.dart';
import 'package:shopapp/order/info.dart';
import 'package:shopapp/screens/home_page.dart';

import 'cart.dart';

var no = 1;
var total = 0;
var charge = 20;
var discountPrice = 0;
var offer;

class ProductDetails extends StatefulWidget {
  final productDetailDetails;
  final productDetailName;
  final productDetailPrice;
  final productDetailOldPrice;
  final productDetailPicture;
  ProductDetails(
      {this.productDetailName,
      this.productDetailOldPrice,
      this.productDetailPicture,
      this.productDetailPrice,
      this.productDetailDetails});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    discountPrice = int.parse(widget.productDetailOldPrice) -
        int.parse(widget.productDetailPrice);
    charge = 20;
    offer = (100 -
            ((int.parse(widget.productDetailPrice) /
                    int.parse(widget.productDetailOldPrice)) *
                100))
        .round();
    total = int.parse(widget.productDetailPrice) * no + charge;
    if (total <= 300) {
      charge = 20;
      total = int.parse(widget.productDetailPrice) * no + charge;
    } else {
      charge = 0;
      total = int.parse(widget.productDetailPrice) * no;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Center(
          child: InkWell(
            child: Text("ETROPLUS"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(),
                  ));
            },
            child: Badge(
              child: Icon(Icons.shopping_cart),
              badgeContent: Text(
                "${Provider.of<CartProduct>(context).taskCount}",
                style: TextStyle(color: Colors.white),
              ),
              position: BadgePosition(start: 12, top: 1),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 250,
                  child: Container(
                    color: Colors.white,
                    child: Hero(
                        tag: widget.productDetailName,
                        child: Image.network(widget.productDetailPicture)),
                  ),
                ),
                Text(
                  widget.productDetailName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(
                        Icons.local_offer,
                        color: Colors.green,
                      ),
                      Text(
                        widget.productDetailPrice,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          widget.productDetailOldPrice,
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        "Save ${discountPrice.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.greenAccent),
                      )),
                      AvatarGlow(
                        endRadius: 40,
                        glowColor: Colors.red,
                        child: CircleAvatar(
                          child: Text(
                            "$offer% off",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          radius: 20,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Product details :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    widget.productDetailDetails,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Text("    "),
                    Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("                                                  "),
                    IconButton(
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          if (no == 1) {
                          } else {
                            no--;
                          }
                        });
                      },
                    ),
                    Text(
                      no.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          no++;
                        });
                      },
                    ),
                  ],
                ),
                Divider(),
                Text(
                  "   Items Total : ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "    item price             =",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.productDetailPrice,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "    No of items          =",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      no.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "    Service Charge    =",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      charge.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "    Total                =",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      total.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                Divider(),
                Text(
                  "Similar Products ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 400,
                  child: SimilarProduct(),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  splashColor: Colors.black,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Proceed to Order"),
                            actions: [
                              RaisedButton(
                                child: Text("Continue"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Information(
                                        orderName: widget.productDetailName,
                                        orderPrice: total,
                                      ),
                                    ),
                                  );
                                },
                                color: Colors.greenAccent,
                              ),
                              RaisedButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Colors.red,
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text("Buy Now"),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  splashColor: Colors.black,
                  onPressed: () {
                    showToast(
                      "Successfully Added to Cart",
                      context: context,
                      backgroundColor: Colors.lightBlueAccent,
                      position: StyledToastPosition.center,
                    );
                    Provider.of<CartProduct>(context, listen: false).addTask(
                        image: widget.productDetailPicture,
                        quantity: no.toString(),
                        price: int.parse(widget.productDetailPrice) * no,
                        name: widget.productDetailName);
                  },
                  color: Colors.orangeAccent,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text("Add to Cart"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SimilarProduct extends StatefulWidget {
  @override
  _SimilarProductState createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  var productList = [
    {
      "name": "Face massage",
      "picture":
          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/beautician%2Fbeautician1.jpg?alt=media&token=7b6c2f76-6fde-4206-9ff8-6cbddcb57d44",
      "old_price": "250",
      "price": "200",
      "details": "sdfghjkcvbn"
    },
    {
      "name": "Black Forest",
      "picture":
          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/cake%2Fcake6.jpg?alt=media&token=7c59a4fc-2277-44b4-bf52-d40492bb105a",
      "old_price": "250",
      "price": "250",
      "details": "sdfghjkcvbn"
    },
    {
      "name": "Plumber",
      "picture":
          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/plumber%2Fplum7.jpg?alt=media&token=02214679-34a3-4db8-8a21-6593ea132d5f",
      "old_price": "250",
      "price": "250",
      "details": "sdfghjkcvbn"
    },
    {
      "name": "Carpenter",
      "picture":
          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/carpenter%2Fcarpenter2.jpg?alt=media&token=f7abfbac-f0e6-44ed-a8a4-4d449fe19d1d",
      "old_price": "250",
      "price": "250",
      "details": "sdfghjkcvbn"
    },
    {
      "name": "electrician",
      "picture":
          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/electrician%2Felectrician1.jpg?alt=media&token=2d579f38-be8e-43ca-aa27-35da614c661e",
      "old_price": "250",
      "price": "250",
      "details": "sdfghjkcvbn"
    },
    {
      "name": "laundry",
      "picture":
          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/laundry%2Flaundry2.jpg?alt=media&token=c78c3704-a18f-4006-82ad-2ecf17546fc2",
      "old_price": "250",
      "price": "250",
      "details": "sdfghjkcvbn"
    },
    {
      "name": "painter",
      "picture":
          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/painter%2Fpaint4.jpg?alt=media&token=abc31695-4db8-409e-907b-933ebf4a1121",
      "old_price": "250",
      "price": "250",
      "details": "sdfghjkcvbn"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SimilarSingleProduct(
            productName: productList[index]['name'],
            productOldPrice: productList[index]['old_price'],
            productPrice: productList[index]['price'],
            productPicture: productList[index]['picture'],
            productDetails: productList[index]['details'],
          );
        });
  }
}

class SimilarSingleProduct extends StatelessWidget {
  final productName;
  final productPicture;
  final productOldPrice;
  final productPrice;
  final productDetails;
  SimilarSingleProduct(
      {this.productName,
      this.productOldPrice,
      this.productPicture,
      this.productDetails,
      this.productPrice});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: Text("hero1"),
        child: InkWell(
            onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      productDetailName: productName,
                      productDetailOldPrice: productOldPrice,
                      productDetailPicture: productPicture,
                      productDetailPrice: productPrice,
                      productDetailDetails: productDetails,
                    ),
                  ),
                ),
            child: GridTile(
              footer: Container(
                  color: Colors.white54,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          productName,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Text(
                        productPrice,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              child: Image.network(
                productPicture,
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}
