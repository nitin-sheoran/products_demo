import 'package:flutter/material.dart';
import 'package:products_demo/products/model/product_model.dart';
import 'package:products_demo/products/shared/colors_const.dart';

class ProductDetailScreen extends StatefulWidget {
  Products products;

  ProductDetailScreen({required this.products, super.key});

  @override
  State<ProductDetailScreen> createState() {
    return _ProductDetailScreenState();
  }
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFavorite = false;
  int likeCount = 0;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        likeCount++;
      } else {
        likeCount--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              ClipRRect(
                child: Column(
                  children: [
                    if (widget.products.images != null &&
                        widget.products.images!.isNotEmpty)
                      Image.network(
                        widget.products.images![0],
                        height: 200,
                        width: 200,
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$likeCount',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 10,),
                          GestureDetector(
                            onTap: toggleFavorite,
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? ColorsConst.redColor : ColorsConst.blackColor,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        widget.products.title.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        "\u0024 ${widget.products.price.toString()}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Column(
                        children: [
                          const Text(
                            'Rating',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\u0024${widget.products.rating.toString()}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        widget.products.description.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
