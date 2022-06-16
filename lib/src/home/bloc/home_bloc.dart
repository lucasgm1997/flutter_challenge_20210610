// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/usecases/get_all_products_use_case.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IGetAllProductsUseCase getAllProductsUsecase;

  HomeBloc(this.getAllProductsUsecase) : super(HomeInitial()) {
    on<FetchProductsHomeEvent>(
      _fetchProducts,
    );
  }

  Future<void> _fetchProducts(
      FetchProductsHomeEvent event, Emitter<HomeState> emit) async {
    emit(LoadingHomeState());

    await Future.delayed(const Duration(seconds: 1));

    await emit.onEach<List<ProductEntity>>(getAllProductsUsecase.call(),
        onData: (products) => emit(LoadedHomeState(products)),
        onError: (error, StackTrace stack) =>
            emit(ExcpetionHomeState(error.toString())));
  }
}
