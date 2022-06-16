import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchallange/src/home/bloc/home_bloc.dart';
import 'package:flutterchallange/src/products/domain/usecases/get_all_products_use_case.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = HomeBloc(context.read<IGetAllProductsUseCase>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (_) => bloc,
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: ((context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Home'),
                ),
                body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: getBody(context, state),
                  ),
                ));
          }),
        ));
  }
}

Widget getBody(BuildContext context, Object? state) {
  if (state is LoadingHomeState) {
    return const CircularProgressIndicator();
  } else if (state is LoadedHomeState) {
    return localListView(state, context);
  } else if (state is ExcpetionHomeState) {
    return Text(state.message);
  } else {
    return const SizedBox();
  }
}

Widget localListView(LoadedHomeState state, context) {
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.width / 4,
                            color: Colors.blue,
                            child: Image.network(state.products[index].filename, fit: BoxFit.cover),
                            ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(state.products[index].title),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(state.products[index].type.name),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('${state.products[index].price}'),
                            ),
                          ],
                        )
                      ]),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 10.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.more_horiz),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text('${state.products[index].price}'),
                  ),
                ),
                
              ],
            ),
          ),
        );
      });
}
