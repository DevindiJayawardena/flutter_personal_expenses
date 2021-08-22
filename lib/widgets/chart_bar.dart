import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  //We can't make a 'const' constructor to the non-final fields.
  // In this constructor we're going with positional arguments. That's why we don't use {} here.
  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);


  @override
  Widget build(BuildContext context){
    print('build() ChartBar');
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(3),
            height : constraints.maxHeight * 0.1,
            child: FittedBox(
              child : Text(
                'Rs.${spendingAmount.toStringAsFixed(0)}', //The amount that we spend in that day. This is the top most element
                style: TextStyle(
                  fontSize: 10,
                  //fontWeight : FontWeight.bold,
                  color : Colors.blueGrey,
                ),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height : constraints.maxHeight * 0.55,
            width : 10,
            // This 'Stack' widget allows us to place elements on top of each other. (overlapping each other)
            child: Stack(children: <Widget>[
              //First widget is the bottomost widget
              Container(decoration: BoxDecoration(
                border: Border.all(color : Colors.grey , width: 1.0,),
                color: Color.fromRGBO(220, 220, 220, 1), //This is the background color of the container
                borderRadius: BorderRadius.circular(10),
              ),),

              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height : constraints.maxHeight * 0.1,
            child: FittedBox(
              child : Text(label),
            ),
          ),
        ],
      );
    });
  }
}
