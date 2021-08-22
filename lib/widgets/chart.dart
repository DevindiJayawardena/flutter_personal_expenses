//This Chart widget will display a chart about our recent transactions
//This is a StatelessWidget bcz we don't need to change any data in there.
// This will just output some visual data about the transactions we added to our app.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';


class Chart extends StatelessWidget{
  final List<Transaction> recentTransactions;  // This 'recentTransactions' is the all transactions in the last week

  Chart(this.recentTransactions){
    print('Constructor Chart');
  }

  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      var totalSum = 0.0;

      for(var i = 0; i < recentTransactions.length ; i++){
        if  (recentTransactions[i].date.day == weekDay.day &&
             recentTransactions[i].date.month == weekDay.month &&
             recentTransactions[i].date.year == weekDay.year){
                totalSum += recentTransactions[i].amount;
        }
      }


      //print(DateFormat.E().format(weekDay));
      //print(totalSum);


      //In here,we are returning a map
      return {
        'day' : DateFormat.E().format(weekDay).substring(0, 2) ,
        'amount' : totalSum
      };

    }).reversed.toList();
  }



  //This is another getter to calculate the total spends of that particular week
  double get totalSpending{
    //bcz here we want to sum up all the amounts, the sum of all the total sums of each day gives us the total sum for aentire week
    //the method 'fold()' allows us to change a list to another type
    //0.0 is the starting value
    return groupedTransactionValues.fold(0.0, (sum ,item) {
      return sum + item['amount'];
    });
  }


  @override
  Widget build(BuildContext context){
    print('build() Chart');
    //print(groupedTransactionValues);
    // We are going to wrap our chart in a card. That's why we return a card here.
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(4),
        child: Row( //In order to apply a padding in to this row, we should wrap-up this with a container/ Padding.
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Here we are mapping this 'groupedTransactionValues' list in to a list of widgets
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'] ,
                data['amount'] ,
                totalSpending == 0.0 ? 0.0 : (data['amount'] as double)/totalSpending,
              ),
            );
            //return Text('${data['day']}: ${data['amount']}'); //return Text(data['day'] + ' : ' + data['amount'].toString(),);
          }).toList(),
        ),
      ),
    );
  }
}