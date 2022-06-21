part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class EmptyHomeState implements HomeState {}

class LoadingHomeState implements HomeState {}

class LoadedHomeState implements HomeState {
  final List<ProductEntity> products;

  LoadedHomeState(this.products);
}

class NextLoadedHomeState implements HomeState {
  final List<ProductEntity> products;

  NextLoadedHomeState(this.products);
}

class ExcpetionHomeState implements HomeState {
  final String message;

  ExcpetionHomeState(this.message);
}
