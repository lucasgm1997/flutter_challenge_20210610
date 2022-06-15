import 'package:flutterchallange/src/products/data/datasources/product_firestore_datasource.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';
import 'package:mocktail/mocktail.dart';

class ProductEntityMock extends Mock implements ProductEntity {}
class ProductRepositoryMock extends Mock implements IProductRepository {}
class ProductDataSourceMock extends Mock implements IProductDataSource {}
