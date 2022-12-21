// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Job {
  String? name;
  String? description;
  Job({
    this.name,
    this.description,
  });

  Job copyWith({
    String? name,
    String? description,
  }) {
    return Job(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) =>
      Job.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Job(name: $name, description: $description)';

  @override
  bool operator ==(covariant Job other) {
    if (identical(this, other)) return true;

    return other.name == name && other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
