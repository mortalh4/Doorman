class receivedPaymentModel{
  final int? paymentId;
  final double payment;
  final int createdTime;
  final int? id;

  receivedPaymentModel({this.paymentId,required this.payment,required this.createdTime,this.id});

  factory receivedPaymentModel.fromMap(Map<String,dynamic>json) => new receivedPaymentModel(
    paymentId: json['paymentId'],
      payment: json['payment'],
    createdTime: json['createdTime'],
    id: json['id']
  );

  Map<String,dynamic> toMap() {
    return{
      'paymentId':paymentId,
      'payment':payment,
      'createdTime' : createdTime,
      'id':id,
    };
  }
}