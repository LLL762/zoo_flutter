// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Role {
  String? name;
  int? accessLevel;
  Role({
    this.name,
    this.accessLevel,
  });

  Role copyWith({
    String? name,
    int? accessLevel,
  }) {
    return Role(
      name: name ?? this.name,
      accessLevel: accessLevel ?? this.accessLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'accessLevel': accessLevel,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      name: map['name'] != null ? map['name'] as String : null,
      accessLevel:
          map['accessLevel'] != null ? map['accessLevel'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) =>
      Role.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Role(name: $name, accessLevel: $accessLevel)';

  @override
  bool operator ==(covariant Role other) {
    if (identical(this, other)) return true;

    return other.name == name && other.accessLevel == accessLevel;
  }

  @override
  int get hashCode => name.hashCode ^ accessLevel.hashCode;
}
