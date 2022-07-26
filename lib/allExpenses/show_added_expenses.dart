import 'package:flutter/cupertino.dart';

class showAddedExpenses extends StatelessWidget {
  double toplamGoster;
   showAddedExpenses({Key? key,required this.toplamGoster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(

        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child:Text("Toplam",style: TextStyle(
              fontWeight: FontWeight.w500,

            ),), ),
          ),
          Text(toplamGoster > 0? "$toplamGoster":"0",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),),
        ],
      ),
    );
  }
}
