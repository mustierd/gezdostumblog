import 'dart:convert';

import 'package:gezdostumblog/models/equipment_json_model.dart';
import 'package:http/http.dart' as http;

Future<List<EquipmentJson>> getEquipment() async {
  final response = await http.get(Uri.parse(
      'https://gist.githubusercontent.com/mustierd/a86f754b54879f8e49cc57bbe9c6c935/raw/95ebc86cec334c2822d989d4f9649d41bcfb36b2/kampEkipmanlari.json'));

  if (response.statusCode == 200) {
    //return Equipment.fromJson(json.decode(response.body));
    return (json.decode(response.body) as List).map((sendData) {
      return EquipmentJson.fromJson(sendData);
    }).toList();
  } else {
    throw Exception("HATA VERDİ LOOO");
  }
}
