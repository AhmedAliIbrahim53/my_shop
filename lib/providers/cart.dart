import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount{
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, double price){
    if(_items.containsKey(productId)){
      // change quantity ...
      _items.update(productId, (value) => CartItem(id: value.id, title: value.title, quantity: value.quantity +1, price: value.price,),);
    }else{
      _items.putIfAbsent(productId, () => CartItem(id: DateTime.now().toString(), title: title, quantity: 1, price: price,),);
    }
    notifyListeners();
  }

  void plusQuantity(String productId) {
    _items[productId].quantity ++;
    notifyListeners();
  }

  void minusQuantity(String productId) {
    _items[productId].quantity --;
    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId].quantity > 1){
      _items.update(productId, (existingCartItem) => CartItem(id: existingCartItem.id,price: existingCartItem.price,title: existingCartItem.title,quantity: existingCartItem.quantity - 1));
    }else{
      _items.remove(productId);
    }
    notifyListeners();
  }
}
