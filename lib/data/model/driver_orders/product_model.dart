import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entity/drivers_order/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String? id;
  final double? price;

  ProductModel({
    this.id,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      price: price,
    );
  }
}