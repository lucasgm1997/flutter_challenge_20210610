import 'package:flutter_challenge_20210610/src/products/data/datasources/product_firestore_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductFirestoreDatasourceImp implements IProductDataSource {
  FirebaseFirestore firestore;

  ProductFirestoreDatasourceImp(this.firestore);

  @override
  Stream<List<Map<String, dynamic>>> getAllProducts() {
    final collection = firestore.collection('products');
    final snapShotProduct =
        collection.orderBy('priority', descending: true).snapshots();

    return snapShotProduct
        .map((QuerySnapshot<Map<String, dynamic>> query) => query.docs)
        .map((list) => _convert(list));
  }

  List<Map<String, dynamic>> _convert( List<QueryDocumentSnapshot<Map<String, dynamic>>> listDocs) {
    return listDocs.map((document) {
      return {'id': document.id, ...document.data()};
    }).toList();
  }


}
