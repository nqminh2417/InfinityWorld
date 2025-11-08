import 'package:http/http.dart' as http;
import 'package:infinity_world/core/config/constants.dart';
import 'package:infinity_world/screens/summertime_saga/models/smts_progress_model.dart';

class SmtsService {
  static String _baseUrl = Cfg.smtsBaseUrl;
  static String _progressUrl = '$_baseUrl/data/progress.json';

  static Future<SmtsProgressModel?> getProgress() async {
    try {
      final response = await http.get(Uri.parse(_progressUrl));
      if (response.statusCode == 200) {
        SmtsProgressModel data = SmtsProgressModel.fromJson(response.body);
        return data;
      } else {
        print('Failed to load progress: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching progress: $e');
      return null;
    }
  }
}
