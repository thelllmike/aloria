class CartItem {
  final int userId;
  final int productId;
  int quantity; // Make quantity non-final
  final int cartId;
  final DateTime addedAt;

  CartItem({
    required this.userId,
    required this.productId,
    required this.quantity, // Remove 'final' here
    required this.cartId,
    required this.addedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: json['user_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      cartId: json['cart_id'],
      addedAt: DateTime.parse(json['added_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'cart_id': cartId,
      'added_at': addedAt.toIso8601String(),
    };
  }
}
