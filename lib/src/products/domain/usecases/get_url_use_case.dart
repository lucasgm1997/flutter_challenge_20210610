import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';

abstract class IGetUrlUseCase {
  Future<String> call(String filename);
}

class GetUrlUseCaseImp implements IGetUrlUseCase {
  final IProductRepository _repository;
  GetUrlUseCaseImp(this._repository);

  @override
  Future<String> call(String filename) {
    return _repository.getUrl(filename);
  }
}
