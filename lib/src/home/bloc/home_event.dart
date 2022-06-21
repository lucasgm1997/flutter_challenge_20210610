part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}


class GetFirstListProductsHomeEvent implements HomeEvent {}

class NextProductsHomeEvent implements HomeEvent {
 
}


class RemoveProductHomeEvent implements HomeEvent {
  final ProductEntity productEntity;
  RemoveProductHomeEvent(this.productEntity);
}

class UpdateProductHomeEvent implements HomeEvent {
  final ProductEntity productEntity;
  UpdateProductHomeEvent(this.productEntity);
}
