// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorialModel _$TutorialModelFromJson(Map<String, dynamic> json) =>
    TutorialModel(
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$TutorialModelToJson(TutorialModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
    };
