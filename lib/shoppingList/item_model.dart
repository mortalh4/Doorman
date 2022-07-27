class itemModel{
  final int? urunId;
  final String alinacakUrunAdi;
  final String urunAdedi;

  itemModel({this.urunId, required this.alinacakUrunAdi, required this.urunAdedi});

  factory itemModel.fromMap(Map<String ,dynamic> json) => new itemModel(
    urunId: json['urunId'],
      alinacakUrunAdi: json['alinacakUrunAdi'],
      urunAdedi: json['urunAdedi'],
  );
  Map <String , dynamic> toMap(){
    return{
    'urunId' : urunId,
      'alinacakUrunAdi' : alinacakUrunAdi,
      'urunAdedi' : urunAdedi,
    };
  }
}