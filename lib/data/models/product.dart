import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nectar/data/enums/unit.dart';

class Product extends Equatable {
  final String name;
  final DocumentReference store;
  final String? description;
  final double price;
  final Unit unit;
  final List<String>? images;
  final DocumentReference? category;
  final String? brand;
  final Map<String, double>? nutritions;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Product({
    required this.name,
    required this.store,
    this.description,
    required this.price,
    required this.unit,
    this.images,
    this.category,
    this.brand,
    this.nutritions,
    required this.createdAt,
    required this.updatedAt,
  });

  Product copyWith({
    String? name,
    DocumentReference? store,
    String? description,
    double? price,
    Unit? unit,
    List<String>? images,
    DocumentReference? category,
    String? brand,
    Map<String, double>? nutritions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      name: name ?? this.name,
      store: store ?? this.store,
      description: description ?? this.description,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      images: images ?? this.images,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      nutritions: nutritions ?? this.nutritions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'store': store,
      'description': description,
      'price': price,
      'unit': unit.name, // enum to string
      'images': images,
      'category': category,
      'brand': brand,
      'nutritions': nutritions,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      store: map['store'] as DocumentReference,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] as double,
      unit: unitFromName(map['unit'] as String),
      images: map['images'] != null
          ? List<String>.from((map['images'] as List<String>))
          : null,
      category:
          map['category'] != null ? map['category'] as DocumentReference : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      nutritions: map['nutritions'] != null
          ? Map<String, double>.from(map['nutritions'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      name,
      store,
      description,
      price,
      unit,
      images,
      category,
      brand,
      nutritions,
      createdAt,
      updatedAt,
    ];
  }
}
