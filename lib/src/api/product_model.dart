class Product {
  final int productId;
  final String productName;
  final String productDescription;
  final int categoryId;
  final String productImg;
  final String productDataLink;
  final double price;

  const Product(this.productId, this.productName, this.productDescription,
      this.categoryId, this.productImg, this.productDataLink, this.price);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['productId'],
      json['productName'],
      json['productDescription'],
      json['categoryId'],
      json['productImg'],
      json['productDataLink'],
      json['price'],
    );
  }
}
