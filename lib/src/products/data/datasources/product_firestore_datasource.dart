abstract class IProductDataSource {

  Stream<List<Map<String, dynamic>>> getFirstList();

  Future<void> removeProduct(String id);

  Future<void> updateProduct(Map<String, dynamic> product);

  Stream<List<Map<String, dynamic>>> getNextProducts();
}
