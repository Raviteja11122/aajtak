import 'package:meta/meta.dart';
import 'dart:convert';

List<Places> placesFromJson(String str) => List<Places>.from(json.decode(str).map((x) => Places.fromJson(x)));

String placesToJson(List<Places> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Places {
  Places({
    @required this.placeName,
    @required this.placeId,
  });

  final String placeName;
  final String placeId;

  factory Places.fromJson(Map<String, dynamic> json) => Places(
    placeName: json["placeName"],
    placeId: json["placeId"],
  );

  Map<String, dynamic> toJson() => {
    "placeName": placeName,
    "placeId": placeId,
  };
}
