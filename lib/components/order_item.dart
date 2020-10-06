import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myshop/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem({@required this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
//  AnimationController _controller;
//  Animation<double> _opacityAnimation;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _controller = AnimationController(
//      vsync: this,
//      duration: Duration(milliseconds: 300),
//    );
//    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
//      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//    );
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//    _controller.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
//                if (_isExpanded) {
//                  _controller.forward();
//                } else {
//                  _controller.reverse();
//                }
              },
            ),
          ),
//          if(_isExpanded)
//          FadeTransition(
//            opacity: _opacityAnimation,
//            child:
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            height: _isExpanded
                ? max(widget.order.products.length * 20.0 + 10, 20)
                : 0,
            child: ListView(
              children: widget.order.products
                  .map(
                    (prod) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          prod.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${prod.quantity} x \$${prod.price}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
//          ),
        ],
      ),
    );
  }
}
