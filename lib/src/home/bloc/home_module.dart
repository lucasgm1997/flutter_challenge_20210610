import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchallange/src/home/bloc/home_bloc.dart';

import 'package:flutterchallange/src/products/domain/usecases/get_first_list_products_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/next_product_usecase.dart';
import 'package:flutterchallange/src/products/domain/usecases/remove_product_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/update_product_use_case.dart';

final homeModule = [
  BlocProvider(
    create: (context) => HomeBloc(
        context.read<IGetFirstListProductUseCase>(),
        context.read<IRemoveProductUsecase>(),
        context.read<IUpdateProductUsecase>(),
        context.read<INextProductUsecase>(),
        ),
  )
];
