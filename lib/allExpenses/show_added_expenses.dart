import 'package:flutter/cupertino.dart';
import 'package:doorman_app/Constants.dart';

class showAddedExpenses extends StatelessWidget {
 Future <double> toplamGoster;

   showAddedExpenses({Key? key,required this.toplamGoster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(

        children: [
          Padding(
            padding: Constants.cardPadding,
            child: Center(child:Text("Toplam",style: TextStyle(
              fontWeight: FontWeight.w500,

            ),), ),
          ),
          Text("$toplamGoster",style: Constants.addedExpensesStyle,),
        ],
      ),
    );
  }
}
