part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class EmptyHomeState implements HomeState {}

class LoadingHomeState implements HomeState {}

class LoadedHomeState implements HomeState {
  final List<ProductEntity> queues;

  LoadedHomeState(this.queues);
}

class ExcpetionHomeState implements HomeState {
  final String message;

  ExcpetionHomeState(this.message);
}
