class Products {
  int id;
  String title;
  String description;
  double price;
  String category;
  String image;

  Products({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'].toDouble(),
      category: json['category'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
    };
  }
}

class GetAllProductsListResponse {
  List<Products> products;

  GetAllProductsListResponse({
    required this.products,
  });

  factory GetAllProductsListResponse.fromJson(List<dynamic> json) {
    List<Products> productList = [];
    for (var productJson in json) {
      productList.add(Products.fromJson(productJson));
    }
    return GetAllProductsListResponse(products: productList);
  }
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productJsonList = products.map((product) => product.toJson()).toList();
    return {
      'products': productJsonList,
    };
  }
}
