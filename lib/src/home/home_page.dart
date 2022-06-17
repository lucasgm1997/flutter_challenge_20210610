import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchallange/src/home/bloc/home_bloc.dart';
import 'package:flutterchallange/src/home/models/product_model.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/usecases/get_all_products_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/remove_product_use_case.dart';
import 'package:flutterchallange/src/products/domain/usecases/update_product_use_case.dart';
import 'package:group_radio_button/group_radio_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;
  String? _value = "dairy";

  @override
  void initState() {
    super.initState();

    bloc = HomeBloc(
        context.read<IGetAllProductsUseCase>(),
        context.read<IRemoveProductUsecase>(),
        context.read<IUpdateProductUsecase>());
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
      return const CircularProgressIndicator();
    } else if (state is LoadedHomeState) {
      return localListView(context, state);
    } else if (state is ExcpetionHomeState) {
      return Text(state.message);
    } else {
      return const SizedBox();
    }
  }

  Widget localListView(BuildContext context, LoadedHomeState state) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6,
            child: Card(
              color: Colors.grey,
              elevation: 2.0,
              child: Stack(
                children: [
                  infosProduct(state.products[index]),
                  popUpMenu(state.products[index]),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
                  //   child: Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: Text('${state.products[index].price}'),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }

  Widget infosProduct(ProductEntity product) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.width / 4,
          color: Colors.blue,
          child: Image.network(product.filename, fit: BoxFit.cover),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(product.title),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(product.type.name),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('${product.price}'),
            ),
          ],
        )
      ]),
    );
  }

  Widget popUpMenu(ProductEntity product) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 10.0),
      child: Align(
        alignment: Alignment.topRight,
        child: PopupMenuButton(
          icon: const Icon(Icons.more_horiz),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: ListTile(
                title: const Text('Edit'),
                onTap: () {
                  _addNewQueueDialog(product);
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                title: const Text('Remove'),
                onTap: () {
                  Navigator.of(context).pop();
                  bloc.add(RemoveProductHomeEvent(product));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewQueueDialog(ProductEntity product) {
    showDialog(
        context: context,
        builder: (context) {
          String verticalGroupValue = "Pending";

          List<String> status =
              EProductType.values.map((element) => element.name).toList();

          var toUpdateProduct = ProductModel.empty();

          toUpdateProduct =
              toUpdateProduct.copyWith(description: product.description);
          toUpdateProduct =
              toUpdateProduct.copyWith(filename: product.filename);
          toUpdateProduct = toUpdateProduct.copyWith(height: product.height);
          toUpdateProduct = toUpdateProduct.copyWith(price: product.price);
          toUpdateProduct = toUpdateProduct.copyWith(title: product.title);
          toUpdateProduct = toUpdateProduct.copyWith(id: product.id);
          toUpdateProduct = toUpdateProduct.copyWith(rating: product.rating);
          toUpdateProduct = toUpdateProduct.copyWith(width: product.width);
          toUpdateProduct = toUpdateProduct.copyWith(type: product.type);

          return StatefulBuilder(builder: (context, localSetState) {
            return AlertDialog(
              title: const Text('Update product'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      bloc.add(UpdateProductHomeEvent(toUpdateProduct));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Update')),
              ],
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Title'),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        toUpdateProduct =
                            toUpdateProduct.copyWith(title: value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Price'),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        toUpdateProduct = toUpdateProduct.copyWith(
                            price: double.tryParse(value));
                      },
                    ),
                    RadioGroup<String>.builder(
                      groupValue: verticalGroupValue,
                      onChanged: (value) => localSetState(() {
                        verticalGroupValue = value!;
                        toUpdateProduct = toUpdateProduct.copyWith(
                            type: EProductType.values.firstWhere(
                                (element) => element.name == value));
                      }),
                      items: status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
