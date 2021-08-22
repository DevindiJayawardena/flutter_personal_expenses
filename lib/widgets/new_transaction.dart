import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //This import gives us the date formatting functionality
import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx; // This is a function type property to get a pointer to a function in another file

  NewTransaction(this.addTx) { //This 'addTx' is a pointer to a function called '_addNewTransaction' in the main.dart file
    print('Constructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('createState in NewTransaction Widget');
    return _NewTransactionState();
  }
}


class _NewTransactionState extends State<NewTransaction>{
  final _titleController = TextEditingController(); //Title eka ghnna ona text field eke ghla tyna value eka gnnawa '_titleController' ta.
  final _amountController = TextEditingController();//Amount eka ghnna ona text field eke ghla tyna value eka gnnawa '_amountController' ta.
  DateTime _selectedDate;  //This doesn't have a value initially. It will get a value once a user choose a date. So it's not in 'final' type.


  _NewTransactionState () {
    print('Constructor NewTransaction State');
  }


  // This 'initState' is used for fetching some initial data that we need in our app or in a widget of our app.
  //This override is added bcz 'initState' is implemented by the 'State' class that we are inheriting from (23rd line's)
  //This 'initState()' method is often called to make a HTTP request & load some data from a server or from a database.
  @override
  void initState() {
    print('initState()');
    // The keyword 'super' refers to the parent class. When the '_NewTransactionState' is created, the 'State' object will also be created.
    super.initState();
  }


  //This 'didUpdateWidget' method gets called when the widget that is attached to the state changes, which means if there's something
  // changed in our parent widget  & then flutter gives us the old widget
  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }


  // The state also can get removed at some point of time, for that we can add this 'dispose()' method here. So this is used for cleaning up data
  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }



  void _submitData(){
    if (_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null ){
      return; //if this condition is true, then the addTx() will not be executed. The execution stopes there.
    }

    //with this 'widget' keyword, we can access the properties and methods of our widget class above, inside in our state class.
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }


  //This method should show a date picker on the screen
  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null){
        return; //If this 'pickedDate' is null or if user cancels it, then the execution of this '_presentDatePicker' method will be stopped.
      }
      setState(() {
        //This will be wrap-up in a setState, bcz we have to tell flutter that it will change a property in the class and also
        // update the UI & rerun the build method. That's why we wrap it in the 'setState' method.
        _selectedDate = pickedDate;
      });
    });
  }



  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
        child : Card(
          margin: EdgeInsets.all(10),
          elevation: 6,
          child: Container(  // TextField walata paddings danna ona nisai egollonwa Container ekaka wrap-up krnne
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right : 10,
              //This 'viewInsets' property gives the information about anything that lapping into our view. Typically that's the soft keyboard.
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                //TextField() widget is responsible for receiving user inputs
                TextField(
                  decoration: InputDecoration(labelText: 'Title',),
                  controller: _titleController, // We can assign a controller to our TextField
                  onSubmitted: (_) => _submitData(),
                  //onChanged: (val){
                  //  titleInput = val;
                  //},
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount',),
                  keyboardType: TextInputType.number,
                  controller : _amountController, // We can assign a controller to our TextField
                  onSubmitted: (_) => _submitData(),
                  //onChanged: (val) => amountInput = val,
                ),
                Container(
                  height: 50,
                  child : Row(
                    children: <Widget>[
                      Expanded(
                        child : Text(
                          _selectedDate == null ? 'No Date Choosen!' : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}' ,
                        ),
                      ),
                      AdaptiveFlatButton('Choose Date' , _presentDatePicker),
                    ],
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Add Transaction' ,
                    style : TextStyle(color: Theme.of(context).textTheme.button.color , fontWeight: FontWeight.bold, ),
                  ),
                  color: Theme.of(context).primaryColorDark,
                  onPressed: _submitData, // we want to create a new element/transaction based on user inputs. And it has to be displayed in UI,
                ),
              ],
            ),
          ),
        ),
    );
  }
}

