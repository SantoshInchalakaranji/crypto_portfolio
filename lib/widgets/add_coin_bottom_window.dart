import 'package:crypto_portfolio/db/crypto_database.dart';
import 'package:crypto_portfolio/db/screens/signup_page.dart';
import 'package:crypto_portfolio/modal/coins.dart';
import 'package:flutter/material.dart';

class AddCoinBottomWindow extends StatefulWidget {
  final Function addCoin;
  const AddCoinBottomWindow(this.addCoin);

  @override
  State<AddCoinBottomWindow> createState() => _AddCoinBottomWindowState();
}

class _AddCoinBottomWindowState extends State<AddCoinBottomWindow> {
  final coinNameInput = TextEditingController();
  final coinPriceInput = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    void submitData()  {
      final enteredCoinName = coinNameInput.text;
      final enteredCoinPrice = double.parse(coinPriceInput.text);
     

      if (enteredCoinName.isEmpty || enteredCoinPrice <= 0) return;

      widget.addCoin( enteredCoinName, enteredCoinPrice);
     
     
      Navigator.of(context).pop();
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                10), //to make bottom sheet bottom sheet go up from keyboard
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: coinNameInput,
              decoration: InputDecoration(
                  labelText: 'Coin Name',
                  labelStyle: Theme.of(context).textTheme.bodyText2),
            ),
            TextField(
              controller: coinPriceInput,
              decoration: InputDecoration(
                  labelText: 'Coin Price',
                  labelStyle: Theme.of(context).textTheme.bodyText2),
              keyboardType: TextInputType.number,
              //flutter returns value
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: submitData,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Coin',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.button!.color,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

 
}
