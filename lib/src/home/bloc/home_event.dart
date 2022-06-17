part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetAllProducts implements HomeEvent {}

class FetchProductsHomeEvent implements HomeEvent {}

class AddNewProductHomeEvent implements HomeEvent {
  final ProductEntity productEntity;
  AddNewProductHomeEvent(this.productEntity);
}

class RemoveProductHomeEvent implements HomeEvent {
  final ProductEntity productEntity;
  RemoveProductHomeEvent(this.productEntity);
}

class UpdateProductHomeEvent implements HomeEvent {
  final ProductEntity productEntity;
  UpdateProductHomeEvent(this.productEntity);
}
