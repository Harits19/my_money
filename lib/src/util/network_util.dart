import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_money/src/services/debug_service.dart';

Future<bool> hasInternet() async {
  try {
    final response = await http
        .get(
          Uri.parse('https://www.google.com'),
        )
        .timeout(
          const Duration(
            seconds: 5,
          ),
        ); // Or another reliable URL
    if (response.statusCode == 200) {
      // Connection successful
      return true;
    } else {
      // Server returned an error, but we have internet
      return true; //Or false, depending on the need.
    }
  } on SocketException catch (e) {
    // No internet connection
    myLog.e('hasInternet - SocketException: $e');

    return false;
  } catch (e) {
    // Other errors (e.g., DNS lookup failed)
    myLog.e('hasInternet - Unexpected Exception: $e');
    return false;
  }
}
