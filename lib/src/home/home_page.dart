import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterchallange/src/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeBloc>().add(FetchProductsHomeEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final state = bloc.state;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (state is LoadingHomeState)
                  const CircularProgressIndicator(),
                if (state is LoadedHomeState) localListView(state, context),
                if (state is ExcpetionHomeState) Text(state.message)
              ],
            ),
          ),
        ));
  }
}

Widget localListView(LoadedHomeState state, context) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/8,
          child: Card(
            color: Colors.grey,
            elevation: 2.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Text(state.products[index].title),
                    Text(state.products[index].type.name),
                  ]),
                ),
              ],
            ),
          ),
        );
      });
}
