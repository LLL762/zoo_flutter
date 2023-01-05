// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RefreshRequest {
  final String refreshToken;

  RefreshRequest(
    this.refreshToken,
  );

  RefreshRequest copyWith({
    String? refreshToken,
  }) {
    return RefreshRequest(
      refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'refreshToken': refreshToken,
    };
  }

  factory RefreshRequest.fromMap(Map<String, dynamic> map) {
    return RefreshRequest(
      map['refreshToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshRequest.fromJson(String source) =>
      RefreshRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RefreshRequest(refreshToken: $refreshToken)';

  @override
  bool operator ==(covariant RefreshRequest other) {
    if (identical(this, other)) return true;

    return other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => refreshToken.hashCode;
}
