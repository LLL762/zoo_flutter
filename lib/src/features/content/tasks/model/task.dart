// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:zoo_flutter/src/features/content/app_users/model/app_user.dart';

class Task {
  String? id;
  String? name;
  String? description;
  String? type;
  String? status;
  int? priority;
  AppUser? createdBy;
  List<AppUser> assignTo;
  DateTime createdAt;

  Task({
    this.id,
    this.name,
    this.description,
    this.type,
    this.status,
    this.priority,
    this.createdBy,
    this.assignTo = const <AppUser>[],
    required this.createdAt,
  });

  static List<Task> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray.map((e) => Task.fromMap(e)).toList();
  }

  Task copyWith({
    String? id,
    String? name,
    String? description,
    String? type,
    String? status,
    int? priority,
    AppUser? createdBy,
    List<AppUser>? assignTo,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdBy: createdBy ?? this.createdBy,
      assignTo: assignTo ?? this.assignTo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'status': status,
      'priority': priority,
      'createdBy': createdBy?.toMap(),
      'assignTo': assignTo.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      priority: map['priority'] != null ? map['priority'] as int : null,
      createdBy: map['createdBy'] != null
          ? AppUser.fromMap(map['createdBy'] as Map<String, dynamic>)
          : null,
      assignTo: List<AppUser>.from(
        (map['assignTo'] as List<dynamic>).map<AppUser>(
          (x) => AppUser.fromMap(x as Map<String, dynamic>),
        ),
      ),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, name: $name, description: $description, type: $type, status: $status, priority: $priority, createdBy: $createdBy, assignTo: $assignTo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.type == type &&
        other.status == status &&
        other.priority == priority &&
        other.createdBy == createdBy &&
        listEquals(other.assignTo, assignTo) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        type.hashCode ^
        status.hashCode ^
        priority.hashCode ^
        createdBy.hashCode ^
        assignTo.hashCode ^
        createdAt.hashCode;
  }
}
