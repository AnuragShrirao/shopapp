import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shopapp/componenets/cart_products.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<CartProduct>(
            builder: (context, cartData, child) {
              return ListView.builder(
                itemCount: cartData.taskCount,
                itemBuilder: (context, index) {
                  final task = cartData.tasks[index];
                  return CartTile(
                    image: task.image,
                    name: task.name,
                    quantity: task.quantity,
                    total: task.price,
                    call: () {
                      showToast("Successfully Removed Item",
                          context: context,
                          backgroundColor: Colors.lightBlueAccent,
                          position: StyledToastPosition.center);
                      cartData.deleteData(task);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class CartTile extends StatelessWidget {
  final image;
  final name;
  final quantity;
  final total;
  final Function call;
  CartTile({this.total, this.image, this.quantity, this.name, this.call});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: ListTile(
        leading: Image.network("$image"),
        title: Text("$name"),
        subtitle: Text("$quantity"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 15,
            ),
            Expanded(child: Text("$total")),
            Expanded(
              child: RaisedButton(
                color: Colors.white,
                onPressed: call,
                child: Text(
                  "Remove",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
