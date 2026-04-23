/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class AppUser implements _i1.SerializableModel {
  AppUser._({
    required this.id,
    required this.email,
    required this.createdAt,
  });

  factory AppUser({
    required String id,
    required String email,
    required DateTime createdAt,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as String,
      email: jsonSerialization['email'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  String id;

  String email;

  DateTime createdAt;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppUser copyWith({
    String? id,
    String? email,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      'id': id,
      'email': email,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    required String id,
    required String email,
    required DateTime createdAt,
  }) : super._(
         id: id,
         email: email,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppUser copyWith({
    String? id,
    String? email,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
