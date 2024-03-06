import 'package:dio/dio.dart';

const nasaApiKey = "e6vTbGqmR1cgXiYFG28nLJm5gxEQK30csKuzDhEg";

Future<Map<String, dynamic>> getNasaData() async {
  final dio = Dio();
  final resp = await dio.get("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=$nasaApiKey");

  if (resp.statusCode == 200) {
    return resp.data;
  } else {
    throw Exception('Err: ${resp.statusMessage}');
  }
}