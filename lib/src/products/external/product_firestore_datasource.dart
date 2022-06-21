import 'package:flutterchallange/src/products/data/datasources/product_firestore_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductFirestoreDatasourceImp implements IProductDataSource {
  FirebaseFirestore firestore;

  late DocumentSnapshot lastDocumentSnapshot;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> firstDocumentList;

  ProductFirestoreDatasourceImp(this.firestore);

  @override
  Stream<List<Map<String, dynamic>>> getNextProducts() {
    final aux = firestore
        .collection('products')
        .startAfterDocument(lastDocumentSnapshot)
        .limit(firstDocumentList.length + 7);

    final snapShotNextProduct = aux.snapshots();

    return snapShotNextProduct
        .map((QuerySnapshot<Map<String, dynamic>> query) => query.docs)
        .map((List<QueryDocumentSnapshot<Map<String, dynamic>>> currentList) {
      firstDocumentList.addAll(currentList);

      currentList = firstDocumentList;
      lastDocumentSnapshot = currentList.last;

      return _convert(currentList);
    });
  }

  @override
  Stream<List<Map<String, dynamic>>> getFirstList() {
    final Query<Map<String, dynamic>> collection =
        firestore.collection('products').limit(7);

    final Stream<QuerySnapshot<Map<String, dynamic>>> snapShotProduct =
        collection.snapshots();

    return snapShotProduct
        .map((QuerySnapshot<Map<String, dynamic>> query) => query.docs)
        .map((List<QueryDocumentSnapshot<Map<String, dynamic>>> currentList) {
      firstDocumentList = currentList;
      lastDocumentSnapshot = currentList.last;

      return _convert(currentList);
    });
  }

  List<Map<String, dynamic>> _convert(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> listDocs) {
    return listDocs.map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
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
