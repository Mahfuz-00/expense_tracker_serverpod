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
import 'dart:async' as _i2;
import 'package:expense_app_admin_client/src/protocol/app_user.dart' as _i3;
import 'package:expense_app_admin_client/src/protocol/expense.dart' as _i4;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i5;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i6;
import 'protocol.dart' as _i7;

/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<List<_i3.AppUser>> getUsers() =>
      caller.callServerEndpoint<List<_i3.AppUser>>(
        'admin',
        'getUsers',
        {},
      );

  _i2.Future<List<_i4.Expense>> getExpenses() =>
      caller.callServerEndpoint<List<_i4.Expense>>(
        'admin',
        'getExpenses',
        {},
      );

  _i2.Future<void> sendBudgetAlert(
    String userId,
    String type,
  ) => caller.callServerEndpoint<void>(
    'admin',
    'sendBudgetAlert',
    {
      'userId': userId,
      'type': type,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i5.Caller(client);
    serverpod_auth_core = _i6.Caller(client);
  }

  late final _i5.Caller serverpod_auth_idp;

  late final _i6.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i7.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    admin = EndpointAdmin(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {'admin': admin};

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
