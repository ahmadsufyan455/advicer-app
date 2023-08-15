import 'dart:convert';

import 'package:advicer_app/data/exception/exception.dart';
import 'package:http/http.dart' as http;

import '../model/advice_model.dart';

abstract class RemoteDataSource {
  Future<AdviceModel> getRandomAdviceFromApi();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);
      return AdviceModel.fromJson(responseBody);
    }
  }
}
