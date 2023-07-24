class OrderInputModel {
  int cartId;
  int code;
  String error;
  String message;
  String orderId;
  int paidAmount;
  String paymentId;
  String signature;
  String status;
  String userId;

  OrderInputModel(
      {required this.cartId,
      required this.code,
      required this.error,
      required this.message,
      required this.orderId,
      required this.paidAmount,
      required this.paymentId,
      required this.signature,
      required this.status,
      required this.userId});

  Map toJson() => {
        'cartId': cartId,
        'code': code,
        'error': error,
        'message': message,
        'orderId': orderId,
        'paidAmount': paidAmount,
        'paymentId': paymentId,
        'signature': signature,
        'status': status,
        'userId': userId,
      };
}
