import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price,size, id;
  final Color color;
  Product({
     this.id,
     this.image,
     this.title,
     this.price,
     this.description,
     this.size,
     this.color,
  });
}

List<Product> products = [
  Product(
      id: 2,
      title: "Premium",
      price: 10,
      size: 8,
      description: Text,
      image: "assets/images/credit-card.png",
      color: Color(0xFFD3A984)),
];

String Text =
    "- One Year Full Access on Dashboard \n- Tracking your Level \n- Add Your Favourite Verses On Favourite List \n- Help You Memorize Quran,Hadith and Names Of Allah";
