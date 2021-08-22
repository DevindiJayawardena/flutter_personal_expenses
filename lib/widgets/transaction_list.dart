import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';
import 'package:intl/intl.dart';


//This class is created for the list of transactions.
class TransactionList extends StatelessWidget{
  final List<Transaction> transactions;
  final Function deleteTx; //This'deleteTx' is a pointer to that transaction '_deleteTransaction' in the 'main.dart' file

  TransactionList(this.transactions , this.deleteTx);

  @override
  Widget build(BuildContext context){ //This 'context' is a meta data object with some infomation about our widget & its position in the tree
    print('build() TransactionList');
    return transactions.isEmpty ?
      LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Text(
              'No transactions added yet!',
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox( //Here we put 'const' bcz it only has one argument with a compilation time constant value.
              height : 10,
            ),
            Container(
              height : constraints.maxHeight * 0.57,
              child: Image.asset(
                'assets/images/waiting.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      }) : ListView(
        children: transactions
          .map((tx) => TransactionItem(
            key : ValueKey(tx.id), //This automatically creates a unique key for every item
            transaction : tx,
            deleteTx: deleteTx,
          )).toList(),
      );
          //this defines how many items should be build
          //itemCount: transactions.length,

          //Column(children: <Widget>[
          //Now each transaction might now be a Card. So lets add cards and populate them with data of those transactions
          //Card(),
          //Card(),
          //],),

          //But we don't know that how many cards we will need. So our goal should be to take our 'transactions' list & map that into a
          // list of widgets and
          // this 'transactions' is a pointer to the above transactions list. We use 'map()' method to transform this list of objects into
          // a list of widgets.
          // We need to call toList() at the end bcz map will always give an iterable which we need to transform to a list.
          // This map() method takes a function. A function which automatically gets executed on every element in that list. (in every
          // transaction in this case). So we get here a single transaction (tx) as an input to this function we pass to map and
          // this function again executes on every transactions. And inhere, we need to return a new element. That should be a widget that
          // represents our transaction. There we use a Card.
          //children : transactions.map((tx) {

  }
}



