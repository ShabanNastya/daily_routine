import 'dart:convert';

List<Gender> genderModelFromJson(String str) =>
    List<Gender>.from(json.decode(str).map((x) => Gender.fromJson(x)));

String genderModelToJson(List<Gender> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson)));

class Gender {
  final String name;
  final String gender;
  final double probability;
  final int count;

  Gender(
      {required this.name,
      required this.gender,
      required this.probability,
      required this.count});

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      name: json['name'],
      gender: json['gender'],
      probability: json['probability'].toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "probability": probability,
        "count": count,
      };
}
