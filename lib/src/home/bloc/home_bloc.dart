// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/usecases/get_all_products_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/remove_product_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/update_product_use_case.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IGetAllProductsUseCase getAllProductsUsecase;
  final IRemoveProductUsecase removeProductUsecase;
  final IUpdateProductUsecase updateProductUsecase;

  HomeBloc(this.getAllProductsUsecase, this.removeProductUsecase,
      this.updateProductUsecase
      )
      : super(HomeInitial()) {
    on<FetchProductsHomeEvent>(
      _fetchProducts,
    );

    on<RemoveProductHomeEvent>(
      _removeProduct,
    );

    on<UpdateProductHomeEvent>(
      _updateProduct,
    );

    add(FetchProductsHomeEvent());
  }

  Future<void> _updateProduct(
      UpdateProductHomeEvent event, Emitter<HomeState> emit) async {
    updateProductUsecase.call(event.productEntity);
  }

  Future<void> _removeProduct(
      RemoveProductHomeEvent event, Emitter<HomeState> emit) async {
    removeProductUsecase.call(event.productEntity);
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
