import 'dart:convert';

import 'package:http/http.dart' as http;

List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Uri url;

  CoinData({required this.url});

  Future<double> getCoinPrice() async {
    final http.Response response = await http.get(url);
    double price;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      price = data['rate'];
    } else {
      price = 0;
      print(response.statusCode);
    }

    return price;
  }
}
