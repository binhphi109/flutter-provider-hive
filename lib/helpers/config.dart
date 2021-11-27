import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String? ApiUrl = dotenv.env['API_URL'];
}
