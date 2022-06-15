import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutterchallange/src/products/external/product_firestore_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return a map stream product from firestore datasource.',
      () async {
    final firestore = FakeFirebaseFirestore();

    await firestore.collection('product').add({
      'id': 'any_id',
      'title': 'any_title',
      'photo': 'any_photo',
      'rating': 0.0,
      'type': 'type1',
      'price': 0.0,
    });

    final dataSource = ProductFirestoreDatasourceImp(firestore);

    final result = dataSource.getAllProducts();

    expect(result, emits(isA<List<Map<String, dynamic>>>()));
  });

}
