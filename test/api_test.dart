import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:obviously_test_final/features/currency_converter/data/currency_api_client.dart';
import 'dart:convert';

// Generate a MockHttpClient class using the @GenerateMocks annotation
import 'api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('CurrencyApiClient', () {
    late CurrencyApiClient currencyApiClient;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      currencyApiClient = CurrencyApiClient();
    });

    test(
        'returns currency conversion data if the http call completes successfully',
        () async {
      // Mock a successful response
      final mockResponse = {
        "result": "success",
        "provider": "https://www.exchangerate-api.com",
        "documentation": "https://www.exchangerate-api.com/docs/free",
        "terms_of_use": "https://www.exchangerate-api.com/terms",
        "time_last_update_unix": 1725494552,
        "time_last_update_utc": "Thu, 05 Sep 2024 00:02:32 +0000",
        "time_next_update_unix": 1725581902,
        "time_next_update_utc": "Fri, 06 Sep 2024 00:18:22 +0000",
        "time_eol_unix": 0,
        "base_code": "GBP",
        "rates": {
          "GBP": 1,
          "AED": 4.824914,
          "AFN": 92.262382,
          "ALL": 118.45555,
          "AMD": 508.08749,
          "ANG": 2.351694,
          "AOA": 1230.906608,
          "ARS": 1254.017811,
          "AUD": 1.955612,
          "AWG": 2.351694,
          "AZN": 2.229856,
          "BAM": 2.320024,
          "BBD": 2.627591,
          "BDT": 156.991239,
          "BGN": 2.320186,
          "BHD": 0.493987,
          "BIF": 3773.886792,
          "BMD": 1.313796,
          "BND": 1.713895,
          "BOB": 9.076318,
          "BRL": 7.410112,
          "BSD": 1.313796,
          "BTN": 110.192485,
          "BWP": 17.544631,
          "BYN": 4.232355,
          "BZD": 2.627591,
          "CAD": 1.776227,
          "CDF": 3704,
          "CHF": 1.113347,
          "CLP": 1217.85369,
          "CNY": 9.339627,
          "COP": 5484.769313,
          "CRC": 679.535424,
          "CUP": 31.531092,
          "CVE": 130.797394,
          "CZK": 29.741301,
          "DJF": 233.489051,
          "DKK": 8.849117,
          "DOP": 78.227315,
          "DZD": 174.789456,
          "EGP": 63.686511,
          "ERN": 19.706933,
          "ETB": 143.25274,
          "EUR": 1.186211,
          "FJD": 2.908105,
          "FKP": 1,
          "FOK": 8.849142,
          "GEL": 3.532455,
          "GGP": 1,
          "GHS": 20.77147,
          "GIP": 1,
          "GMD": 92.585343,
          "GNF": 11383.516775,
          "GTQ": 10.141004,
          "GYD": 274.37037,
          "HKD": 10.240275,
          "HNL": 32.489009,
          "HRK": 8.937496,
          "HTG": 172.8,
          "HUF": 466.37427,
          "IDR": 20365.44916,
          "ILS": 4.859531,
          "IMP": 1,
          "INR": 110.19265,
          "IQD": 1716.875536,
          "IRR": 55713.026305,
          "ISK": 182.217586,
          "JEP": 1,
          "JMD": 204.634155,
          "JOD": 0.931481,
          "JPY": 189.348957,
          "KES": 169.192752,
          "KGS": 111.545952,
          "KHR": 5333.76,
          "KID": 1.955609,
          "KMF": 583.576834,
          "KRW": 1758.454519,
          "KWD": 0.400642,
          "KYD": 1.094829,
          "KZT": 634.293003,
          "LAK": 28735.96529,
          "LBP": 117584.697851,
          "LKR": 391.128855,
          "LRD": 255.593157,
          "LSL": 23.490496,
          "LYD": 6.241625,
          "MAD": 12.80944,
          "MDL": 22.863943,
          "MGA": 5960.294076,
          "MKD": 73.1343,
          "MMK": 3610.72087,
          "MNT": 4494.343305,
          "MOP": 10.548583,
          "MRU": 52.155411,
          "MUR": 60.619965,
          "MVR": 20.253232,
          "MWK": 2287.84185,
          "MXN": 26.129276,
          "MYR": 5.715992,
          "MZN": 83.872435,
          "NAD": 23.490496,
          "NGN": 2081.246129,
          "NIO": 48.266877,
          "NOK": 13.991597,
          "NPR": 176.307977,
          "NZD": 2.121864,
          "OMR": 0.50515,
          "PAB": 1.313796,
          "PEN": 4.982278,
          "PGK": 5.178282,
          "PHP": 74.185807,
          "PKR": 366.460863,
          "PLN": 5.074767,
          "PYG": 10035.438115,
          "QAR": 4.782216,
          "RON": 5.903073,
          "RSD": 138.844822,
          "RUB": 116.037889,
          "RWF": 1794.00975,
          "SAR": 4.926733,
          "SBD": 11.102334,
          "SCR": 18.234866,
          "SDG": 586.557185,
          "SEK": 13.509903,
          "SGD": 1.713895,
          "SHP": 1,
          "SLE": 29.576249,
          "SLL": 29576.911042,
          "SOS": 749.123596,
          "SRD": 38.328255,
          "SSP": 4417.325537,
          "STN": 29.062134,
          "SYP": 16868.065697,
          "SZL": 23.490496,
          "THB": 44.810901,
          "TJS": 13.96527,
          "TMT": 4.591017,
          "TND": 4.000923,
          "TOP": 3.049877,
          "TRY": 44.763491,
          "TTD": 9.154793,
          "TVD": 1.955609,
          "TWD": 42.212564,
          "TZS": 3560.812021,
          "UAH": 54.094314,
          "UGX": 4880.089203,
          "USD": 1.313797,
          "UYU": 52.872003,
          "UZS": 16541.673994,
          "VES": 48.142266,
          "VND": 32708.820565,
          "VUV": 154.893122,
          "WST": 3.543937,
          "XAF": 778.102446,
          "XCD": 3.547248,
          "XDR": 0.975779,
          "XOF": 778.102446,
          "XPF": 141.552756,
          "YER": 328.31166,
          "ZAR": 23.490507,
          "ZMW": 34.619632,
          "ZWL": 18.1879
        }
      };

      when(mockClient.get(Uri.parse(currencyApiClient.apiUrl))).thenAnswer(
          (_) async => http.Response(json.encode(mockResponse), 200));

      // Call the method
      final result = await CurrencyApiClient(client: mockClient).fetchConversions();

      // Validate the result
      expect(result, isNotEmpty);
      expect(result['result'], 'success');
      expect(result, mockResponse);
      expect(result['rates']['GBP'], 1);
      expect(result['rates']['EUR'], 1.186211);
    });

    test('returns an empty map if the http call fails with non-200 status', () async {
      // Mock a failed response
      when(mockClient.get(Uri.parse(currencyApiClient.apiUrl)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Call the method
      final result = await CurrencyApiClient(client: mockClient).fetchConversions();

      // Validate the result
      expect(result, isEmpty);
    });

    test('returns an empty map if the http call throws an exception', () async {
      // Mock an exception
      when(mockClient.get(Uri.parse(currencyApiClient.apiUrl)))
          .thenThrow(Exception('Failed to fetch data'));

      // Call the method
      final result = await CurrencyApiClient(client: mockClient).fetchConversions();

      // Validate the result
      expect(result, isEmpty);
    });
  });

  
}
