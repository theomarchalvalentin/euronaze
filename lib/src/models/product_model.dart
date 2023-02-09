class Product {
  final int productId;
  final String productName;
  final String productDescription;
  final int categoryId;
  final String productImg;
  final double price;

  const Product(this.productId, this.productName, this.productDescription,
      this.categoryId, this.productImg, this.price);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json['id'], json['nom'], json['description'],
        json['category'], json['image'], json['prix']);
  }
}
