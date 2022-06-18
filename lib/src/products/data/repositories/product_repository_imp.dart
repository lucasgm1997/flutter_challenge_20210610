import 'package:flutterchallange/src/products/data/adapters/json_to_product.dart';
import 'package:flutterchallange/src/products/data/datasources/product_firestore_datasource.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';

class ProductRepositoryImp implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepositoryImp(this.dataSource);

  @override
  Stream<List<ProductEntity>> getAllProducts() {
    final stream = dataSource.getAllProducts();

    return stream.map((list) => _convert(list));
  }

  List<ProductEntity> _convert(List<Map<String, dynamic>> list) {
    return list.map((item) => JsonToProduct.fromJson(item)).toList();
  }

  @override
  Future<void> removeProduct(ProductEntity product) async {
    dataSource.removeProduct(product.id);
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    dataSource.updateProduct(JsonToProduct.toJson(product));
  }
  
  @override
  Future<String> getUrl(String filename) async {
     return await dataSource.getURL(filename);
  }

  
}
