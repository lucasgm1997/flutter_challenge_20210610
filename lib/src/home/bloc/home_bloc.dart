// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/usecases/get_first_list_products_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/next_product_usecase.dart';
import 'package:flutterchallange/src/products/domain/usecases/remove_product_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/update_product_use_case.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IGetFirstListProductUseCase getAllProductsUsecase;
  final IRemoveProductUsecase removeProductUsecase;
  final IUpdateProductUsecase updateProductUsecase;
  final INextProductUsecase nextProductUsecase;

  HomeBloc(this.getAllProductsUsecase, this.removeProductUsecase,
      this.updateProductUsecase, this.nextProductUsecase)
      : super(HomeInitial()) {
    on<GetFirstListProductsHomeEvent>(
      _fetchProducts,
    );

    on<RemoveProductHomeEvent>(
      _removeProduct,
    );

    on<UpdateProductHomeEvent>(
      _updateProduct,
    );

    on<NextProductsHomeEvent>(
      _nextProduct,
    );

    add(GetFirstListProductsHomeEvent());
  }

  Future<void> _nextProduct(
      NextProductsHomeEvent event, Emitter<HomeState> emit) async {

    await emit.onEach<List<ProductEntity>>(nextProductUsecase.call(),
        onData: (products) async {
          emit(LoadedHomeState(products));
        },
        onError: (error, StackTrace stack) =>
            emit(ExcpetionHomeState(error.toString())));
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
      GetFirstListProductsHomeEvent event, Emitter<HomeState> emit) async {
    emit(LoadingHomeState());

    await Future.delayed(const Duration(seconds: 1));

    await emit.onEach<List<ProductEntity>>(getAllProductsUsecase.call(),
        onData: (products) async {
          emit(LoadedHomeState(products));
        },
        onError: (error, StackTrace stack) =>
            emit(ExcpetionHomeState(error.toString())));
  }
}
