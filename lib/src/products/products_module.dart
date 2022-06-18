
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterchallange/src/products/data/datasources/product_firestore_datasource.dart';
import 'package:flutterchallange/src/products/data/repositories/product_repository_imp.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';
import 'package:flutterchallange/src/products/domain/usecases/get_all_products_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/remove_product_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/update_product_use_case.dart';
import 'package:flutterchallange/src/products/external/product_firestore_datasource.dart';
import 'package:provider/provider.dart';

final productsModule = [
  Provider<FirebaseFirestore>.value(value: FirebaseFirestore.instance,),
  
  Provider<FirebaseStorage>.value(value: FirebaseStorage.instance,),

  Provider<IProductDataSource>(create: (context) => ProductFirestoreDatasourceImp(context.read<FirebaseFirestore>(),)),
  Provider<IProductRepository>(create: (context) => ProductRepositoryImp(context.read<IProductDataSource>()),),
  Provider<IGetAllProductsUseCase>(create: (context) => GetAllProductsUseCaseImp(context.read<IProductRepository>()),),
  Provider<IRemoveProductUsecase>(create: (context) => RemoveProductUsecaseImp(context.read<IProductRepository>()),),
  Provider<IUpdateProductUsecase>(create: (context) => UpdateProductUsecaseImp(context.read<IProductRepository>()),)
];