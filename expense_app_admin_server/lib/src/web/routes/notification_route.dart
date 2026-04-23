// import 'package:serverpod/serverpod.dart';
//
// import '../../endpoints/admin_endpoint.dart';
//
// class NotificationRoute extends WidgetRoute {
//   @override
//   Future<WebWidget> build(Session session, Request request) async {
//     final userId = request.queryParameters['userId'];
//     final type = request.queryParameters['type'];
//
//     if (userId != null && type != null) {
//       // 1. Access your endpoint logic
//       final adminEndpoint = AdminEndpoint();
//
//       // 2. Call the logic that posts to the message bus
//       await adminEndpoint.sendBudgetAlert(session, userId, type);
//
//       print("📢 Broadcast sent to user channel: user_channel_$userId");
//     }
//
//     // 3. Redirect back to the users page immediately
//     return AbstractWidget(
//       footer: '<script>window.location.href = "/users";</script>',
//     );
//   }
// }