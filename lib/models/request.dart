import 'package:flutter/material.dart';
import 'dart:convert';

Request requestFromJson(String str) => Request.fromJson(json.decode(str));

String requestToJson(Request data) => json.encode(data.toJson());

class Request {
  String type;
  String fullname;
  String dateOfBirth;
  String description;
  String code;

  Request(
      {@required this.type,
      @required this.fullname,
      @required this.dateOfBirth,
      @required this.description,
      @required this.code});

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        type: json['type'],
        fullname: json['name'],
        dateOfBirth: json['date_of_birth'],
        description: json['description'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'full_name': fullname,
        'date_of_birth': dateOfBirth,
        'description': description,
        'code': code,
      };
}
