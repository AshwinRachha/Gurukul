// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assignment _$AssignmentFromJson(Map<String, dynamic> json) => Assignment(
      id: json['id'] as int?,
      due_date: json['due_date'] as String?,
      files:
          (json['files'] as List<dynamic>?)?.map((e) => e as String).toList(),
      title: json['title'] as String?,
      contents: json['contents'] as String?,
      marks: json['marks'] as int?,
      instructor: (json['instructor'] as List<dynamic>?)
          ?.map((e) => Instructor.fromJson(e as Map<String, dynamic>))
          .toList(),
      course: json['course'] == null
          ? null
          : Course.fromJson(json['course'] as Map<String, dynamic>),
      group: (json['group'] as List<dynamic>?)
          ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      exists: json['exists'] as bool? ?? false,
    );

Map<String, dynamic> _$AssignmentToJson(Assignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'marks': instance.marks,
      'due_date': instance.due_date,
      'files': instance.files,
      'title': instance.title,
      'contents': instance.contents,
      'instructor': instance.instructor,
      'course': instance.course,
      'group': instance.group,
      'exists': instance.exists,
    };
