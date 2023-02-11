import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class Game {
  Game({
    required this.code,
    required this.status,
    required this.jokes,
  });

  Game.fromJson(Map<String, Object?> json)
      : this(
          code: json['code']! as String,
          status: json['status'] as Bool,
          jokes: json['jokes'] as List<String>,
        );

  final String code;
  final Bool status;
  final List<String> jokes;

  Map<String, Object?> toJson() {
    return {
      'code': code,
      'status': status,
      'jokes': jokes,
    };
  }
}
