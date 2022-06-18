import 'package:flutter/material.dart';
import 'package:flutterchallange/src/home/models/product_model.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:group_radio_button/group_radio_button.dart';

class PopUpButtonWidget extends StatelessWidget {
  final ProductEntity product;
  final Function(ProductEntity product) onRemove;
  final Function(ProductEntity product) onUpdate;

  const PopUpButtonWidget(this.product,
      {required this.onRemove, required this.onUpdate, super.key});

  @override
  Widget build(BuildContext context) {
    return popUpMenu(product);
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
                  _addNewProductDialog(product, context);
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                title: const Text('Remove'),
                onTap: () {
                  onRemove(product);
                  Future.delayed(const Duration(milliseconds: 500));
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewProductDialog(ProductEntity product, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          var toUpdateProduct = ProductModel.cloneFrom(product);

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
                      onUpdate(toUpdateProduct);
                      Future.delayed(const Duration(milliseconds: 500));
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Update')),
              ],
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: toUpdateProduct.title,
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
                      initialValue: toUpdateProduct.price.toString(),
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
                      groupValue: toUpdateProduct.type.name,
                      onChanged: (value) => localSetState(() {
                        toUpdateProduct = toUpdateProduct.copyWith(
                            type: EProductType.values.firstWhere(
                                (element) => element.name == value));
                      }),
                      items: EProductType.values
                          .map((element) => element.name)
                          .toList(),
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
