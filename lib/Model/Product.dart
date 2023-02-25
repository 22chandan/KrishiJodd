class ProductDataModel {
  String? imageUrl, name, description, category, price, ProductUrl;
  int? id;

  ProductDataModel(
      {this.id, this.imageUrl, this.name, this.price, this.description});
  ProductDataModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    price = json['price'];
    ProductUrl = json['ProductUrl'];
  }
}
