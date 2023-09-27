import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:estoregpt/widgets/height_space.dart';

class ProductGrid extends StatelessWidget {
  final String productName;
  final String image;
  final String productPrice;
  const ProductGrid({
    Key? key,
    required this.productName,
    required this.image,
    required this.productPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      // height: 250,
      // width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: Image.network(
                  image,
                  height: 100,
                ),
              ),
              Positioned(
                right: 20,
                child: Container(
                  height: 25,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: const Text(
                      "-10%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Flexible(
            child: Text(
              productName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          HeightSpace(5),
          Text(
            "\$$productPrice",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          HeightSpace(5),
          RatingBar.builder(
            itemSize: 17,
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ],
      ),
    );
  }
}
