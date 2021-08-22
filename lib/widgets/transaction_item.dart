import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


//This class is created for a single transaction. Not for the list of transactions.
class TransactionItem extends StatefulWidget {

  // In this constructor, we have named arguments.
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);


  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}



class _TransactionItemState extends State<TransactionItem>{
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red ,
      Colors.green,
      Colors.blue,
      Colors.purple
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical : 8, horizontal: 5,),
      child: ListTile(
        leading : CircleAvatar(//leading : Container(
          backgroundColor: _bgColor,
          radius : 30,
        //height: 60,
        //width: 60,
        //decoration: BoxDecoration( color: Theme.of(context).primaryColor, shape: BoxShape.circle,),
          child: Padding(
            padding: const EdgeInsets.all(7), //Here we put 'const' bcz value 7 for padding is known at compilation & we never change it.
            child: FittedBox(
              child: Text(
                'Rs.${widget.transaction.amount}',
                style : TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black, ),
              ),
            ),
          ),
        ),

        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360 ? TextButton.icon(
          icon: const Icon(Icons.delete),
          label: Text('Delete' , style: TextStyle(color: Theme.of(context).errorColor),),
          onPressed: () => widget.deleteTx(widget.transaction.id),
        ) : IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTx(widget.transaction.id),
        ),
      ),
    );
  }
}




