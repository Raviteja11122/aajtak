import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:india_today_task/core/constants/constants.dart';
import 'package:india_today_task/core/models/models.dart';

class Api{

  // Set default configs
  static var options = BaseOptions(
    responseType: ResponseType.json,
  );

  Dio dio = Dio(options);

  Future<List<Places>> getPlaces(String pattern)async{
    Response res = await dio.get("https://www.astrotak.com/astroapi/api/location/place?inputPlace=$pattern");
    if(res.data["httpStatusCode"] == Constants.API_SUCCESS_CODE && res.data["message"] != "No suggestions found.") {
      return placesFromJson(jsonEncode(res.data["data"]));
    } else {
      return null;
    }
  }

  Future<List<AgentModel>> getAgents()async{
    Response res = await dio.get("https://www.astrotak.com/astroapi/api/agent/all");
    if(res.data["httpStatusCode"] == Constants.API_SUCCESS_CODE) {
      return agentModelFromJson(jsonEncode(res.data["data"]));
    } else {
      return null;
    }
  }

  Future<PanchangModel> getPanchang(Map<String, dynamic> body)async{
    Response res = await dio.post("https://www.astrotak.com/astroapi/api/horoscope/daily/panchang", data: body);
    if(res.data["httpStatusCode"] == Constants.API_SUCCESS_CODE) {
      return panchangModelFromJson(jsonEncode(res.data["data"]));
    } else {
      return null;
    }
  }
}