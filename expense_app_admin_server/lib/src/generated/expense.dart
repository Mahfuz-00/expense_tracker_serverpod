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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Expense
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Expense._({
    required this.id,
    required this.userId,
    required this.amount,
    required this.category,
    this.description,
    required this.createdAt,
  });

  factory Expense({
    required String id,
    required String userId,
    required double amount,
    required String category,
    String? description,
    required DateTime createdAt,
  }) = _ExpenseImpl;

  factory Expense.fromJson(Map<String, dynamic> jsonSerialization) {
    return Expense(
      id: jsonSerialization['id'] as String,
      userId: jsonSerialization['userId'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  String id;

  String userId;

  double amount;

  String category;

  String? description;

  DateTime createdAt;

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Expense copyWith({
    String? id,
    String? userId,
    double? amount,
    String? category,
    String? description,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Expense',
      'id': id,
      'userId': userId,
      'amount': amount,
      'category': category,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Expense',
      'id': id,
      'userId': userId,
      'amount': amount,
      'category': category,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExpenseImpl extends Expense {
  _ExpenseImpl({
    required String id,
    required String userId,
    required double amount,
    required String category,
    String? description,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         amount: amount,
         category: category,
         description: description,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Expense copyWith({
    String? id,
    String? userId,
    double? amount,
    String? category,
    Object? description = _Undefined,
    DateTime? createdAt,
  }) {
    return Expense(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
