import 'package:flutter/foundation.dart';

//This 'Transaction' is not a widget. Its just a class / object. Bcz it doesn;t extends from a StatelessWidget or StatefullWidget
class Transaction{
  // Here we give 'final', these properties get values when a transaction is created. But thereafter, those values are never change.
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  //By using this constructor, we can crete an object based on this 'Transaction' class in anywhere
  // Here we can use positional or named arguments. But since here it has 4 fields that need to be populated (id, title, amount, date)
  // i'll go for named arguments. When we are giving named arguments,then we have to go with curly braces. {}
  Transaction({
    @required this.id ,
    @required this.title ,
    @required this.amount ,
    @required this.date,
  });
}
