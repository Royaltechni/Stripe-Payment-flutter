import 'package:flutter/material.dart';
import 'Product.dart';
import 'add_to_cart.dart';
import 'TotalSubscriptionPriceAndPeriod.dart';
import 'constants.dart';
import 'description.dart';
import 'SubscripeSaleWithImage.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key,  this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      TotalSubscriptionPriceAndPeriod(product: product),
                      SizedBox(height: kDefaultPaddin / 2),
                      Description(product: product),
                      SizedBox(height: kDefaultPaddin / 2),
                      SizedBox(height: kDefaultPaddin / 2),
                       AddToCart(product: product)
                    ],
                  ),
                ),
                SubscripeSaleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
