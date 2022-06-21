import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InfosProductWidget extends StatefulWidget {
  final ProductEntity product;
  const InfosProductWidget(this.product, {Key? key}) : super(key: key);

  @override
  State<InfosProductWidget> createState() => _InfosProductWidgetState();
}

class _InfosProductWidgetState extends State<InfosProductWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return infosProduct();
  }

  Widget infosProduct() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FutureBuilder<String>(
            future: getURL(widget.product.filename, context)
                .timeout(const Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshotHasData(snapshot);
              }

              if (snapshot.hasError) {
                return snapshotHasError();
              }

              return SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.width / 4,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                title(),
                type(),
                productCreationDate(),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget snapshotHasData(AsyncSnapshot<String> snapshot) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          snapshot.data!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

 
  Widget snapshotHasError() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      child: Center(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: const Text(
              'Error \n getting \n image!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  Widget title() {
    return Text(
      widget.product.title,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16.0,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget type() {
    return Text(
      'Type: ${widget.product.type.name}',
      style: const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget productCreationDate() {
    return Text(
        style: const TextStyle(
          fontSize: 14.0,
          fontFamily: 'Roboto',
        ),
        DateFormat('MM/dd/yyyy').format(widget.product.dateTime));
  }

  Future<String> getURL(String filename, BuildContext context) async {
    final storageRef = context.read<FirebaseStorage>().ref();

    final reference = storageRef.child('images/$filename');

    final url = await reference.getDownloadURL();

    return url;
  }
}
