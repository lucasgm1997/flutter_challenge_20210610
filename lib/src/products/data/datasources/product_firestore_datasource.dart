abstract class IProductDataSource {
  Stream<List<Map<String, dynamic>>> getAllProducts();

  Future<void> removeProduct(String id);

  Future<void> updateProduct(Map<String, dynamic> product);

  Future<String> getURL(String filename);
}
