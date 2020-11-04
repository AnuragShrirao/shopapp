import 'package:flutter/material.dart';
import 'package:shopapp/componenets/cartInitialise.dart';
import 'dart:collection';

class CartProduct extends ChangeNotifier {
  final List<CartInitialise> _cartInitialise = [];
  int get taskCount {
    return _cartInitialise.length;
  }

  UnmodifiableListView<CartInitialise> get tasks {
    return UnmodifiableListView(_cartInitialise);
  }

  List getName() {
    final List getName = [];
    for (var i in _cartInitialise) {
      getName.add(i.name);
    }
    return getName;
  }

  void addTask({String image, int price, String quantity, String name}) {
    final task = CartInitialise(
        name: name, quantity: quantity, price: price, image: image);
    _cartInitialise.add(task);
    notifyListeners();
  }

  int get cartTotal {
    var amount = 0;
    for (var i in _cartInitialise) {
      amount = i.price + amount;
    }
    if ((amount >= 300) | (amount < 1)) {
      return amount;
    } else {
      return amount + 20;
    }
  }

  void deleteData(CartInitialise task) {
    _cartInitialise.remove(task);
    notifyListeners();
  }
}
