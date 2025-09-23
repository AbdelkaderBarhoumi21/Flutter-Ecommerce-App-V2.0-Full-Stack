import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/product_variation_model.dart';

import 'brand_model.dart';
import 'product_attribute_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel(
      {required this.id,
      required this.title,
      required this.stock,
      required this.price,
      required this.thumbnail,
      required this.productType,
      this.sku,
      this.brand,
      this.date,
      this.images,
      this.salePrice = 0.0,
      this.isFeatured,
      this.productVariations,
      this.description,
      this.productAttributes,
      this.categoryId});

  static ProductModel empty() => ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'title': title,
      'stock': stock,
      'price': price,
      'images': images ?? [],
      'thumbnail': thumbnail,
      'salePrice': salePrice,
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'brand': brand!.toJson(),
      'description': description,
      'productType': productType,
      'productAttributes': productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [],
      'productVariations': productVariations != null ? productVariations!.map((e) => e.toJson()).toList() : [],
      'date' : date
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data()!.isEmpty && document.data() == null) return ProductModel.empty();

    final data = document.data()!;
    return ProductModel(
        id: document.id,
        title: data['title'] ?? '',
        stock: data['stock'] ?? 0,
        price: double.parse((data['price'] ?? 0.0).toString()),
        thumbnail: data['thumbnail'] ?? '',
        productType: data['productType'] ?? '',
        sku: data['sku'] ?? '',
        salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
        isFeatured: data['isFeatured'] ?? false,
        brand: BrandModel.fromJson(data['brand']),
        description: data['description'] ?? '',
        categoryId: data['categoryId'] ?? '',
        images: data['images'] != null ? List<String>.from(data['images']) : [],
        productAttributes:
            (data['productAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
        productVariations:
            (data['productVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),
        date: data['date'] != null ? (data['date'] as Timestamp).toDate() : null
    );
  }

  // Map json-oriented document snapshot from firebase to model
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data()! as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data['title'] ?? '',
      stock: data['stock'] ?? 0,
      price: double.parse((data['price'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      productType: data['productType'] ?? '',
      sku: data['sku'] ?? '',
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      isFeatured: data['isFeatured'] ?? false,
      brand: BrandModel.fromJson(data['brand']),
      description: data['description'] ?? '',
      categoryId: data['categoryId'] ?? '',
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      productAttributes:
          (data['productAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
      productVariations:
          (data['productVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),
        date: data['date'] != null ? (data['date'] as Timestamp).toDate() : null
    );
  }
}
/*
final product = ProductModel(
  id: "p1",
  title: "T-shirt coton premium",
  stock: 100,
  price: 20.0,
  thumbnail: "https://example.com/thumbnail.jpg",
  productType: "variable", // produit à variations
  description: "Un T-shirt confortable en coton bio.",
  categoryId: "clothes",
  brand: BrandModel(id: "b1", name: "Nike"),
  productAttributes: [
    ProductAttributeModel(
      name: "Color",
      values: ["Red", "Blue", "Black"],
    ),
    ProductAttributeModel(
      name: "Size",
      values: ["S", "M", "L"],
    ),
  ],
  productVariations: [
    ProductVariationModel(
      id: "v1",
      sku: "TS-RED-S",
      image: "https://example.com/red-s.jpg",
      description: "T-shirt rouge taille S",
      price: 20.0,
      salePrice: 15.0,
      stock: 10,
      attributeValues: {
        "Color": "Red",
        "Size": "S",
      },
    ),
    ProductVariationModel(
      id: "v2",
      sku: "TS-BLUE-M",
      image: "https://example.com/blue-m.jpg",
      description: "T-shirt bleu taille M",
      price: 20.0,
      stock: 8,
      attributeValues: {
        "Color": "Blue",
        "Size": "M",
      },
    ),
    ProductVariationModel(
      id: "v3",
      sku: "TS-BLACK-L",
      image: "https://example.com/black-l.jpg",
      description: "T-shirt noir taille L",
      price: 22.0,
      stock: 5,
      attributeValues: {
        "Color": "Black",
        "Size": "L",
      },
    ),
  ],
);

*/