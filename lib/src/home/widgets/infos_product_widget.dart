import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InfosProductWidget extends StatelessWidget {
  final ProductEntity product;
  const InfosProductWidget(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return infosProduct(product, context);
  }

  Widget infosProduct(ProductEntity product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FutureBuilder<String>(
            future: getURL(product.filename, context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 4,
                  color: Colors.blue,
                  child: Image.network(snapshot.data!, fit: BoxFit.cover),
                );
              }

              if (snapshot.hasError) {
                return const Text('Erro ao pegar imagem');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(product.title),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Type: ${product.type.name}'),
            ),
            RatingBarIndicator(
              itemSize: 15.0,
              itemCount: 5,
              direction: Axis.horizontal,
              rating: product.rating.toDouble(),
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(DateFormat('MM/dd/yyyy').format(product.dateTime)),
            ),
          ],
        )
      ]),
    );
  }

  Future<String> getURL(String filename, BuildContext context) async {
    final storageRef = context.read<FirebaseStorage>().ref();

    final reference = storageRef.child('images/$filename');

    final url = await reference.getDownloadURL();

    return url;
  }
}
