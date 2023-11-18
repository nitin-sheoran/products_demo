import 'package:flutter/material.dart';
import 'package:products_demo/products/model/product_model.dart';
import 'package:products_demo/products/provider/product_provider.dart';
import 'package:products_demo/products/service/products_service.dart';
import 'package:products_demo/products/shared/colors_const.dart';
import 'package:products_demo/products/ui/favorite_products_screen.dart';
import 'package:products_demo/products/ui/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductsProvider productsProvider;
  List<Products> productsList = [];

  @override
  void initState() {
    addData();
    productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    super.initState();
  }

  addData() async {
    productsList = await ProductApiService.getProductInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConst.purpleColor,
        title: const Text(
          'Products List',
          style: TextStyle(color: ColorsConst.whiteColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteProductsScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.favorite,
                color: ColorsConst.whiteColor,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProductsProvider>(
          builder: (create, productsProvider, widget) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            Products product = productsList[index];
            if (product.images != null && product.images!.isNotEmpty) {
              String firstImageUrl = product.images![0];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        products: product,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 12,
                  surfaceTintColor: ColorsConst.whiteColor,
                  color: ColorsConst.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            firstImageUrl,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Text(
                          product.title.toString(),
                          maxLines: 2,
                        ),
                        Text(
                          "\u0024${product.rating.toString()}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Card(
                child: Column(
                  children: [
                    const Text("No Image"),
                    Text(product.rating.toString()),
                  ],
                ),
              );
            }
          },
        );
      }),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:products_demo/products/model/product_model.dart';
// import 'package:products_demo/products/provider/product_provider.dart';
// import 'package:products_demo/products/service/products_service.dart';
// import 'package:products_demo/products/ui/product_detail_screen.dart';
// import 'package:provider/provider.dart';
//
// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProductListScreen> createState() => _ProductListScreenState();
// }
//
// class _ProductListScreenState extends State<ProductListScreen> {
//   late ProductsProvider productsProvider;
//   late List<Products> productsList;
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   Future<void> loadData() async {
//     productsList = await ProductApiService.getProductInfo();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: loadData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error loading data'),
//             );
//           } else {
//             return Consumer<ProductsProvider>(
//               builder: (context, productsProvider, widget) {
//                 return GridView.builder(
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                   ),
//                   itemCount: productsList.length,
//                   itemBuilder: (context, index) {
//                     Products product = productsList[index];
//                     if (product.images != null && product.images!.isNotEmpty) {
//                       String firstImageUrl = product.images![0];
//
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductDetailScreen(
//                                 products: product,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           elevation: 8,
//                           surfaceTintColor: Colors.white,
//                           color: Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Center(
//                                   child: Image.network(
//                                     firstImageUrl,
//                                     height: 80,
//                                     width: 80,
//                                   ),
//                                 ),
//                                 Text(
//                                   product.title.toString(),
//                                   maxLines: 2,
//                                 ),
//                                 Text(
//                                   "\u0024${product.rating.toString()}",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return Card(
//                         child: Column(
//                           children: [
//                             const Text("No Image"),
//                             Text(product.rating.toString()),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
