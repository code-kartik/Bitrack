import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key, this.coinPrice});

  final coinPrice;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late String selectedCurrency = 'USD';
  late String apiKey = 'F2207699-AC6B-4F1C-95A7-602C420A6972';
  late String coinApi;

  late Uri url;

  String cryptoValue = '';

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );

      dropDownItem.add(newItem);
    }
    return dropDownItem;
  }

  Future<void> setCryptoValue() async {
    coinApi =
        'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency/apikey-$apiKey';
    url = Uri.parse(coinApi);
    double data = await CoinData(url: url).getCoinPrice();
    print(data);
    setState(() {
      cryptoValue = data.toStringAsFixed(0);
    });
  }

  @override
  void initState() {
    super.initState();
    setCryptoValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $cryptoValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: getDropDownItems(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                  setCryptoValue();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
