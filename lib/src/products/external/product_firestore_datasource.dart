import 'package:flutterchallange/src/products/data/datasources/product_firestore_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';

class ProductFirestoreDatasourceImp implements IProductDataSource {
  FirebaseFirestore firestore;

  ProductFirestoreDatasourceImp(this.firestore);

  @override
  Stream<List<Map<String, dynamic>>> getAllProducts() {
    final collection = firestore.collection('products');
    final snapShotProduct = collection.snapshots();

    return snapShotProduct
        .map((QuerySnapshot<Map<String, dynamic>> query) => query.docs)
        .map((list) => _convert(list));
  }

  List<Map<String, dynamic>> _convert(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> listDocs) {
    return listDocs.map((document) {
      return {'id': document.id, ...document.data()};
    }).toList();
  }

  @override
  Future<void> removeProduct(String id) async {
    await firestore.collection('products').doc(id).delete();
  }

  @override
  Future<void> updateProduct(Map<String, dynamic> product) async {
    final collectionReference = firestore.collection('products');

    final doc = collectionReference.doc(product['id']);

    product.remove('id');
    
    await doc.set(product);
  }
}
