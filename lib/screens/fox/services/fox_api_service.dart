import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fox_model.dart';

class FoxApiService {
  static const _baseUrl = 'https://randomfox.ca/floof/';

  Future<FoxModel> getRandomFox() async {
    final res = await http.get(Uri.parse(_baseUrl));
    if (res.statusCode != 200) {
      throw Exception('Lỗi tải dữ liệu: ${res.statusCode}');
    }
    final data = json.decode(res.body);
    return FoxModel.fromJson(data);
  }
}
