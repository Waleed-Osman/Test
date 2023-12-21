import 'dart:ffi';

class Item {
  final String id;
  final String name;
  var price;
  var cost;
  var quantity;
  var sku;
  var packageSize;
  var details;
  var stars;
  final List image;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.cost,
    required this.quantity,
    required this.sku,
    required this.packageSize,
    required this.details,
    required this.stars,
    required this.image
  });
}