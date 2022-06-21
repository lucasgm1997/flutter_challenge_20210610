import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutterchallange/src/products/external/product_firestore_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return a map stream product from firestore datasource.',
      () async {
    final firestore = FakeFirebaseFirestore();
    final dataSource = ProductFirestoreDatasourceImp(firestore);

    await firestore.collection('products').add({
      'id': 'any_id',
      'title': 'any_title',
      'photo': 'any_photo',
      'rating': 0.0,
      'type': 'type1',
      'price': 0.0,
    });

    final result = dataSource.getFirstList();

    expect(result, emits(isA<List<Map<String, dynamic>>>()));
  });

  test('Should remove a product', () async {
    final firestore = FakeFirebaseFirestore();
    final dataSource = ProductFirestoreDatasourceImp(firestore);

    final map = {
      'title': 'any_title',
      'filename': 'any_photo',
      'rating': 0,
      'type': 'dairy',
      'price': 0.0,
      'description': 'any_description',
      'height': 400,
      'width': 200,
    };

    final docReference = await firestore.collection('products').add(map);

    dataSource.removeProduct(docReference.id);

    final collectionReference = firestore.collection('products');

    final snapShot = await collectionReference.get();

    final size = snapShot.docs.length;

    expect(size, 0);
  });

  test('Should update a product', () async {
    final firestore = FakeFirebaseFirestore();
    final datasource = ProductFirestoreDatasourceImp(firestore);

    final oldMap = {
      'title': 'any_title',
      'filename': 'any_photo',
      'rating': 0,
      'type': 'dairy',
      'price': 0.0,
      'description': 'any_description',
      'height': 400,
      'width': 200,
    };

    final reference = await firestore.collection('products').add(oldMap);

    oldMap['id'] = reference.id;
    oldMap['title'] = 'new_title';
    oldMap['width'] = 2002;

    final newMap = oldMap;

    datasource.updateProduct(newMap);

    final collectionReference = firestore.collection('products');
    final doc = await collectionReference.doc(reference.id).get();

    expect(doc.data()?['title'], 'new_title');
    expect(doc.data()?['width'], 2002);
  });

}
