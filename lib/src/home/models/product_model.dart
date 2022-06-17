import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required filename,
      required description,
      required height,
      required width,
      required id,
      required title,
      required type,
      required rating,
      required price})
      : super(
            id: id,
            description: description,
            filename: filename,
            title: title,
            type: type,
            price: price,
            height: height,
            rating: rating,
            width: width);

  factory ProductModel.empty() => ProductModel(
        title: '',
        description: '',
        filename: '',
        height: 0,
        id: '',
        price: 0.0,
        rating: 0,
        type: EProductType.bakery,
        width: 0,
      );

  ProductModel copyWith(
    { String? filename,
      String? description,
      int? height,
      int? width,
      String? id,
      String? title,
      EProductType? type,
      int? rating,
      double? price}) {
        
    return ProductModel(
      description: description?? this.description,
      filename: filename?? this.filename,
      height: height?? this.height,
      id: id?? this.id,
      price: price?? this.price,
      rating: rating?? this.rating,
      title: title?? this.title,
      type: type?? this.type,
      width: width?? this.width,
    );
  }
}
