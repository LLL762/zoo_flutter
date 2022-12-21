import 'dart:convert';
import 'package:zoo_flutter/src/features/content/app_users/model/job.dart';

class AppUser {
  String? id;
  String? username;
  String? firstname;
  String? lastname;
  String? email;
  Job? job;
  AppUser({
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.email,
    this.job,
  });

  AppUser copyWith({
    String? id,
    String? username,
    String? firstname,
    String? lastname,
    String? email,
    Job? job,
  }) {
    return AppUser(
      id: id ?? this.id,
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      job: job ?? this.job,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'job': job?.toMap(),
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['_id'] != null ? map['_id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      firstname: map['firstname'] != null ? map['firstname'] as String : null,
      lastname: map['lastname'] != null ? map['lastname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      job: map['job'] != null
          ? Job.fromMap(map['job'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(id: $id, username: $username, firstname: $firstname, lastname: $lastname, email: $email, job: $job)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.job == job;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        job.hashCode;
  }
}
