import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String resultBTC = '?';
  String resultETH = '?';
  String resultLTC = '?';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDown = List();

    for (String currency in currenciesList) {
      dropDown.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton<String>(
      value: selectedCurrency, //default value
      items: dropDown,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getData();
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> cupertinoList = List();

    for (String currency in currenciesList) {
      cupertinoList.add(Text(
        currency,
        style: TextStyle(color: Colors.white),
      ));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        getData();
      },
      children: cupertinoList,
    );
  }

  void getData() async {
    CoinData coinData = CoinData();
    Map<String, String> dataMap = await coinData.getCoinData(selectedCurrency);
    setState(() {
      if (dataMap['BTC'] == null) {
        resultBTC = '?';
      } else {
        resultBTC = dataMap['BTC'];
      }
      if (dataMap['ETH'] == null) {
        resultETH = '?';
      } else {
        resultETH = dataMap['BTC'];
      }
      if (dataMap['LTC'] == null) {
        resultLTC = '?';
      } else {
        resultLTC = dataMap['BTC'];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC = $resultBTC $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ETH = $resultETH $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 LTC = $resultLTC $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
