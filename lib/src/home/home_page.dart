
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterchallange/src/home/bloc/home_bloc.dart';
import 'package:flutterchallange/src/home/widgets/infos_product_widget.dart';
import 'package:flutterchallange/src/home/widgets/pop_up_widget.dart';
import 'package:flutterchallange/src/products/data/datasources/product_firestore_datasource.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/usecases/get_first_list_products_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/next_product_usecase.dart';
import 'package:flutterchallange/src/products/domain/usecases/remove_product_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/update_product_use_case.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;
  final ScrollController _litView = ScrollController();
  late IProductDataSource datasourceImp;

  void _scrollListener() {
    if (_litView.offset == _litView.position.maxScrollExtent) {
      bloc.add(NextProductsHomeEvent());
    }
  }

  @override
  void initState() {
    super.initState();

    datasourceImp = context.read<IProductDataSource>();

    // controller.addListener(_scrollListener);
    _litView.addListener(_scrollListener);

    bloc = HomeBloc(
        context.read<IGetFirstListProductUseCase>(),
        context.read<IRemoveProductUsecase>(),
        context.read<IUpdateProductUsecase>(),
        context.read<INextProductUsecase>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (_) => bloc,
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (localContext, state) {},
          builder: ((localContext, state) {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Home'),
                ),
                body: SizedBox(
                  width: MediaQuery.of(localContext).size.width,
                  child: SingleChildScrollView(
                    child: getBody(localContext, state),
                  ),
                ));
          }),
        ));
  }

  Widget getBody(BuildContext context, Object? state) {
    if (state is LoadingHomeState) {
      return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Center(child: CircularProgressIndicator()));
    } else if (state is LoadedHomeState) {
      return localListView(state);
    } else if (state is ExcpetionHomeState) {
      return excepetion(state);
    } else {
      return const SizedBox();
    }
  }

  Widget localListView(LoadedHomeState state) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Color.fromARGB(244, 0, 246, 86),
            ],
          )),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
            onRefresh: () async {
              bloc.add(GetFirstListProductsHomeEvent());
            },
            child: ListView.builder(
                controller: _litView,
                shrinkWrap: true,
                itemCount: state.products.length,
                padding: const EdgeInsets.only(bottom: 80.0),
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.onSecondary,
                    elevation: 2.0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 6,
                      child: Stack(
                        children: [
                          InfosProductWidget(state.products[index]),
                          ratingProduct(state.products[index]),
                          productPrice(state.products[index]),
                          PopUpButtonWidget(state.products[index],
                              onRemove: (localProduct) {
                            bloc.add(RemoveProductHomeEvent(localProduct));
                          }, onUpdate: (localProduct) {
                            bloc.add(UpdateProductHomeEvent(localProduct));
                          }),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Widget excepetion(ExcpetionHomeState state) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(state.message)),
            InkWell(
              onTap: () async {
                bloc.add(GetFirstListProductsHomeEvent());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 8,
                child: Center(
                  child: Text(
                    'Press to try reload',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget productPrice(ProductEntity product) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0, right: 20.0),
        child: Text('R\$ ${product.price}'),
      ),
    );
  }

  Widget ratingProduct(ProductEntity product) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10, width: MediaQuery.of(context).size.width / 4),
            RatingBarIndicator(
              itemSize: 15.0,
              itemCount: 5,
              direction: Axis.horizontal,
              rating: product.rating.toDouble(),
              itemPadding: const EdgeInsets.only(right: 2.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
