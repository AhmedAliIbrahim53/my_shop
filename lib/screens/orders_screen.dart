import 'package:flutter/material.dart';
import 'package:myshop/components/app_drawer.dart';
import 'package:myshop/components/order_item.dart';
import 'package:myshop/providers/orders.dart' show Orders;
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const String id = 'orders-screen';

//  var _isLoading = false;
//  @override
//  void initState() {
//    setState(() {
//      _isLoading = true;
//    });
//    Future.delayed(Duration.zero).then((_) async {
//      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
//      setState(() {
//        _isLoading = false;
//      });
//    });
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
//    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapShot.error != null) {
                //...
                // handling error
                return Center(
                  child: Text('an error has been occurred!'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) =>
                        OrderItem(order: orderData.orders[i]),
                  ),
                );
              }
            }
          },
        ));
  }
}
