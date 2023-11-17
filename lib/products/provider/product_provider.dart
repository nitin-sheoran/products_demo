import 'package:products_demo/products/model/products_model.dart';
import 'package:products_demo/products/service/products_service.dart';

class ProductsProvider {
  late ProductService productService;

  ProductsProvider(this.productService);

  static Future<List<Product>> getProductService() async {
    return getProductService();
  }
}
