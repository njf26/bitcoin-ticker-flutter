import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '21B39AF0-ECB4-4712-81BF-2B0F1BB05B8B';

class CoinData {
  Future<Map<String, String>> getCoinData(String currencyType) async {
    Map<String, String> dataMap = Map();

    for (String crypto in cryptoList) {
      http.Response response =
          await http.get('$coinAPIURL/$crypto/$currencyType?apikey=$apiKey');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        dataMap[crypto] = data['rate'].toInt().toString();
      } else {
        print(response.statusCode);
      }
    }

    return dataMap;
  }
}
