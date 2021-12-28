import 'package:flutter/material.dart';

import 'Product.dart';
import 'constants.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
     this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        product.description,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
