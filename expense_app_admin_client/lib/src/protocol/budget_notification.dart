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

abstract class BudgetNotification implements _i1.SerializableModel {
  BudgetNotification._({
    required this.title,
    required this.message,
    required this.isOverspending,
  });

  factory BudgetNotification({
    required String title,
    required String message,
    required bool isOverspending,
  }) = _BudgetNotificationImpl;

  factory BudgetNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return BudgetNotification(
      title: jsonSerialization['title'] as String,
      message: jsonSerialization['message'] as String,
      isOverspending: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isOverspending'],
      ),
    );
  }

  String title;

  String message;

  bool isOverspending;

  /// Returns a shallow copy of this [BudgetNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BudgetNotification copyWith({
    String? title,
    String? message,
    bool? isOverspending,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BudgetNotification',
      'title': title,
      'message': message,
      'isOverspending': isOverspending,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BudgetNotificationImpl extends BudgetNotification {
  _BudgetNotificationImpl({
    required String title,
    required String message,
    required bool isOverspending,
  }) : super._(
         title: title,
         message: message,
         isOverspending: isOverspending,
       );

  /// Returns a shallow copy of this [BudgetNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BudgetNotification copyWith({
    String? title,
    String? message,
    bool? isOverspending,
  }) {
    return BudgetNotification(
      title: title ?? this.title,
      message: message ?? this.message,
      isOverspending: isOverspending ?? this.isOverspending,
    );
  }
}
