import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Note {
  int? id;
  final String title;
  final String content;
  Color color;
  RxBool isFavourite;
  RxBool isSelected;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.color,
    bool isFavourite = false,
    bool isSelected = false,
  }) : isFavourite = isFavourite.obs,isSelected = isSelected.obs;

  factory Note.empty() {
    return Note(
      id: 0,
      title: '',
      content: '',
      color: Colors.white,
      isFavourite: false,
    );
  }

  static Color colorFromInt(int colorValue) {
    return Color(colorValue);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color.value,
      'isFavourite': isFavourite.value ? 1 : 0,
    };
  }
}
