import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchallange/src/home/bloc/home_bloc.dart';

import 'package:flutterchallange/src/products/domain/usecases/get_all_products_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/remove_product_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/update_product_use_case.dart';

final homeModule = [
  BlocProvider(
    create: (context) => HomeBloc(context.read<IGetAllProductsUseCase>(), context.read<IRemoveProductUsecase>(), context.read<IUpdateProductUsecase>()),
  )
];
