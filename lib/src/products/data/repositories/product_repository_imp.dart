import 'package:flutter_challenge_20210610/src/products/data/adapters/json_to_product.dart';
import 'package:flutter_challenge_20210610/src/products/data/datasources/product_firestore_datasource.dart';
import 'package:flutter_challenge_20210610/src/products/domain/entities/product_entity.dart';
import 'package:flutter_challenge_20210610/src/products/domain/repositories/products_repository.dart';

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
}
