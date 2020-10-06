import 'package:flutter/material.dart';
import 'package:myshop/components/app_drawer.dart';
import 'package:myshop/components/badge.dart';
import 'package:myshop/components/products_grid_builder.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:myshop/screens/cart_screen.dart';
import 'package:provider/provider.dart';

enum Filters {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool showFavs = false;
//  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

//  @override
//  void didChangeDependencies() {
//    if (_isInit) {
//      Provider.of<ProductsProvider>(
//        context,
//      ).fetchAndSetProducts();
//      print('done');
//    }
//    _isInit = false;
//    super.didChangeDependencies();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MYSHOP'),
        centerTitle: true,
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.id);
              },
            ),
          ),
          PopupMenuButton(
              onSelected: (Filters selectedValue) {
                setState(() {
                  if (selectedValue == Filters.favorites) {
                    showFavs = true;
                  } else {
                    showFavs = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text('Only Favorites'),
                        value: Filters.favorites),
                    PopupMenuItem(child: Text('Show All'), value: Filters.all),
                  ])
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGridBuilder(showFavs),
    );
  }
}
