class CartItemModel {
  final int? id;
  final int slabId;
  final String slab;
 final double buyPrice;
  final double sellPrice;
  final double qty;
  final double amount;
  final String createdAt;

  CartItemModel({
    this.id,
    required this.slabId,
    required this.slab,
    required this.buyPrice,
    required this.sellPrice,
    required this.qty,
    required this.amount,
    required this.createdAt,
  });

  /// Create object from DB map
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as int?,
       slabId: map['slabId'] as int,
      slab: map['slab'] as String,
       buyPrice: (map['buyPrice'] as num).toDouble(),
      sellPrice: (map['sellPrice'] as num).toDouble(),
      qty: (map['qty'] as num).toDouble(),
      amount: (map['amount'] as num).toDouble(),
      createdAt: map['createdAt'] as String,
    );
  }

  /// Convert object to DB map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slabId': slabId,
      'slab': slab,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'qty': qty,
      'amount': amount,
      'createdAt': createdAt,
    };
  }

  /// Helper for recalculating amount
  CartItemModel copyWith({
    int? id,
    double? qty,
  }) {
    final newQty = qty ?? this.qty;
    return CartItemModel(
     id: id ?? this.id,
      slabId: slabId,
      slab: slab,
      buyPrice: buyPrice,
      sellPrice: sellPrice,
      qty: newQty,
      amount:buyPrice * newQty,
      createdAt: createdAt,
    );
  }
}