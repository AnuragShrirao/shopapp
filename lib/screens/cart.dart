import 'package:flutter/material.dart';
import 'package:shopapp/componenets/cart_view.dart';
import 'package:shopapp/componenets/cart_products.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/order/info.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Center(
          child: Text("Shopping Cart"),
        ),
      ),
      body: Provider.of<CartProduct>(context).taskCount == 0
          ? Center(
              child: Text(
                "Nothing To Show You",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )
          : CartView(),
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  "Total:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:
                    Text("${Provider.of<CartProduct>(context).cartTotal}"),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  if(Provider.of<CartProduct>(context,listen: false).cartTotal>0)
                    {
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
                                              orderPrice:
                                                  Provider.of<CartProduct>(
                                                          context)
                                                      .cartTotal,
                                              orderName:
                                                  Provider.of<CartProduct>(
                                                          context)
                                                      .getName(),
                                            )));
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
                      });}
                },
                child: Text(
                  "Checked Out",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
