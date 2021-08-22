//This 'main.dart' file is our entry point. In here, we runApp() with 'MyApp' when the app launches, 'MyApp' is a StatelessWidget which in
// the end simply instantiates the 'MyHomePage()' widget. The MyHomePage widget has created its state by
// '_MyHomePageState createState() => _MyHomePageState();'
//  When the state is created, the build method in the state runs & that's why we see 'MyHomePageState' first. Then the build method executes
//  and therefore, the Flutter instantiates all the widgets there.

// 'final' variables or properties are created dynamically at the run time but which then never change.
// 'Const' variables or properties that are holding a certain value which is already known when the code compiles and which would never
// change after the compilation.

import 'dart:io';  //by using this, we can find out on which platform our app is running.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  //This is for 'SystemChrome' object in main() function
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //This 'SystemChrome' allows us to set some application wide or system wide settings for our app.
  /*
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  */
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      //This theme allows us to set up a global application wide theme
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        accentColor: Colors.green,
        errorColor: Colors.redAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'Quicksand' ,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize : 25,
                  fontWeight: FontWeight.bold,
                )
            )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.redAccent,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


//This 'WidgetsBindingObserver' is a mixin. after adding this class, we can add a new method called 'didChangeAppLifecycleState()'
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  // This 'transactions' is a list of transactions. To that, we can use the 'Transaction' class that we have created as a type of
  // this list here.
  // In here, each transaction should be mapped in to a widget that outputs the data of that transaction.
  //final List<Transaction> transactions = [];

  //All the inputting values are strings by default. If we want to get them in another format, then we have to do it by manually.
  //String titleInput;
  //String amountInput;

  //final titleController = TextEditingController();  // Here,the heavy liftings of savings are done by flutter by 'TextEditingController()'
  //final amountController = TextEditingController(); // Here,the heavy liftings of savings are done by flutter by 'TextEditingController()'

  final List<Transaction> _userTransactions = [
    /*
    Transaction(
      id: 't1' ,
      title: 'New shoes',
      amount: 950.99 ,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2' ,
      title: 'Weekly groceries',
      amount: 1530.00 ,
      date: DateTime.now(),
    ),
    */
  ];

  bool _showChart = false;


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }


  //This method will be called whenever our lifecycles state changes (whenever the app reaches a new state in lifecycle)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
  }


  @override
  dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  //This getter is a dynamically calculated property. There's no any argument list for a getter.
  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      // This subtracts 7 days from today. In this '_recentTransactions' list, only transactions that are younger than 7 days are included.
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),));
    }).toList();
  }


  //This is a method
  // Me method eka connect wenne 'new_transaction.dart' file eke 'addTx' function pointer ekata.
  void _addNewTransaction(String txTitle, double txAmount , DateTime chosenDate) {
    //So this new transaction should be added to the _userTransactions list
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    //So this new transaction should be added to the _userTransactions list
    setState(() {
      _userTransactions.add(newTx); //This manipulates the existing list by adding a new transaction
    });
  }



  //This method starts the process by showing the input area for that new transaction data. (ara popup wena sheet eka pennanne meeken)
  void _startAddNewTransaction(BuildContext ctx) {
    //This 'showModalBottomSheet' is a function provided by Flutter
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(  // By doing this, the sheet will be hidden only by taping the background, not by tapping the sheet itself.
        onTap: () {},
        child : NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }



  //This method will delete an already added transaction
  void _deleteTransaction(String id) {
    setState(() { //We are calling setState method bcz we should rebuild our UI after the deletion of a transaction
      //This manipulates the existing list by removing an existing transaction, just like 'add'
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }



  //THIS IS A BUILDER METHOD. We create this builder method in order to clean up our widget tree down in the build() method.
  // Idea of these builder method is that we can simply call these builder methods from inside our 'build()' method. And we outsource
  // the content which we had in our build() method previously.
  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [Row( //So this 'Show Chart' switch will be displayed only if the 'isLandscape' is true.
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Show Chart',
          style: Theme.of(context).textTheme.title,
        ),
        //Thankfully we are in a statefulwidget. otherwise we have to transform it into one. bcz this below switch value
        // changes its state and it reflects to the changing of UI
        Switch.adaptive(
          value : _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        ),
      ],
    ),
      _showChart
        ? Container(
            height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
            child : Chart(_recentTransactions),
        ) : txListWidget
    ];
  }



  //THIS IS ALSO A BUILDER METHOD. We create this builder method in order to clean up our widget tree down in the build() method.
  // Idea of these buikder method is that we can simply call these builder methods from inside our 'build()' method. And we outsource
  // the content which we had in our build() method previously.
  // Since we rely on the media query and on the appbar in this '_buildPortraitContent' method, we should accept both of them as the inputs
  // of this method.
  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return  [Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
      child : Chart(_recentTransactions),
    ), txListWidget];
  }




  @override
  Widget build(BuildContext context) {
    print('build() MyHomePageState');

    final mediaQuery = MediaQuery.of(context);
    //We want to find out that we are in what orientation mode ( in portrait or landscape)
    final isLandscape = mediaQuery.orientation == Orientation.landscape;


    //Type of this 'appBar' variable is a PreferredSizeWidget. Bcz it applies to both android & ios
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child : Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            //backgroundColor: Colors.red,
            title : Text(
              'Personal Expenses' ,
              //style: TextStyle(
              //  fontFamily: 'Open Sans' ,
              //  color : Colors.white,
              //  fontSize: 25,
              //),
            ),
            actions:<Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed:() => _startAddNewTransaction(context),
              ),
            ],
        );



    final txListWidget = Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
      child : TransactionList(_userTransactions, _deleteTransaction),
    );



    final pageBody = SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // 'mainAxisAlignment' is the 'y' akshaya in a column
              mainAxisAlignment: MainAxisAlignment.start,
              // 'crossAxisAlignment' is the 'x' akshaya in a column
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children : <Widget>[
                //Here we don't use curly braces {} to the if statement in this case. It is a special "if inside of a list" syntax.
                if (isLandscape) // WE CAN RETURN LIST OF WIDGETS HERE WITH THE HELP OF THE SPREAD OPERATOR (...)
                  ..._buildLandscapeContent(mediaQuery, appBar, txListWidget), //Here we must give the parenthesis. Bcz when dart parses this,
                                                    // this method should be executed & then returns a widget
                //This will check if the '_showChart' is true. Then it will display the chart. Otherwise, we want to show the list.
                //This ... (3 dots) will tell dart, that we want to pull all the elements out of that list and merge them as single elements
                // into that surrounding element. (which we have a widget list as the children of this column.)
                if (!isLandscape) // WE CAN RETURN LIST OF WIDGETS HERE WITH THE HELP OF THE SPREAD OPERATOR (...)
                  ..._buildPortraitContent(mediaQuery, appBar, txListWidget), //Here we must give the parenthesis. Bcz when dart parses this,
                                                      // this method should be executed & then returns a widget
              ]
          ),
        )
    );



    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
        )
        : Scaffold(
            appBar: appBar,
            body : pageBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
              ? Container()   //This container renders nothing on an iOS platform
              : FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => _startAddNewTransaction(context),
                ),
        );
  }
}

