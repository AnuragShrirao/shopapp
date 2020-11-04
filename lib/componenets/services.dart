import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/productDetails.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  var productList = [
    {
      "name": "Simple day site makeup ",
      "picture": "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/beautician%2Fbeautician1.jpg?alt=media&token=7b6c2f76-6fde-4206-9ff8-6cbddcb57d44",
      "old_price":  "1200",
      "price":  "200",
      "details":"sdfghjkcvbn",

    },
    {
      "name": "Black Forest",
      "picture": "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/cake%2Fcake6.jpg?alt=media&token=7c59a4fc-2277-44b4-bf52-d40492bb105a",
      "old_price":  "250",
      "price":  "250",
      "details":"sdfghjkcvbn"

    },
    {
      "name": "Plumber",
      "picture": "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/plumber%2Fplum7.jpg?alt=media&token=02214679-34a3-4db8-8a21-6593ea132d5f",
      "old_price":  "250",
      "price":  "250",
      "details":"sdfghjkcvbn"

    },
    {
      "name": "Carpenter",
      "picture": "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/carpenter%2Fcarpenter2.jpg?alt=media&token=f7abfbac-f0e6-44ed-a8a4-4d449fe19d1d",
      "old_price":  "250",
      "price":  "250",
      "details":"sdfghjkcvbn"

    },
    {
      "name": "electrician",
      "picture": "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/electrician%2Felectrician1.jpg?alt=media&token=2d579f38-be8e-43ca-aa27-35da614c661e",
      "old_price":  "250",
      "price":  "250",
      "details":"sdfghjkcvbn"

    },
    {
      "name": "laundry",
      "picture": "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/laundry%2Flaundry2.jpg?alt=media&token=c78c3704-a18f-4006-82ad-2ecf17546fc2",
      "old_price":  "250",
      "price":  "250",
      "details":"sdfghjkcvbn"

    },
    {
      "name": "painter",
      "picture": "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/painter%2Fpaint4.jpg?alt=media&token=abc31695-4db8-409e-907b-933ebf4a1121",
      "old_price":  "250",
      "price":  "250",
      "details":"sdfghjkcvbn"

    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            productName: productList[index]['name'],
            productOldPrice: productList[index]['old_price'],
            productPrice: productList[index]['price'],
            productPicture: productList[index]['picture'],
            productDetails: productList[index]['details'],
          );
        });
  }
}

class SingleProduct extends StatelessWidget {
  final productName;
  final productPicture;
  final productOldPrice;
  final productPrice;
  final productDetails;
  SingleProduct(
      {this.productName,
      this.productOldPrice,
      this.productPicture,
      this.productDetails,
      this.productPrice});
  @override
  Widget build(BuildContext context) {
    return Card(
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
              child: Row(children: <Widget>[
                Expanded(
                  child: Text(productName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                ),
                Text("\$$productPrice",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
              ],)
            ),
            child: Hero(
              tag: productName,
              child: Image.network(
                productPicture,
                fit: BoxFit.cover,
              ),
            ),
          )),
    );
  }
}
