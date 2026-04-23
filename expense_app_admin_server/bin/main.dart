import 'package:expense_app_admin_server/server.dart';

/// This is the starting point for your Serverpod server. Typically, there is
/// no need to modify this file.
void main(List<String> args) {
  print("\n==============================");
  print("🚀 EXPENSE ADMIN SERVER STARTING");
  print("==============================\n");

  print("⚙️ Boot arguments: $args");

  run(args);

  print("\n==============================");
  print("✅ SERVER STARTED SUCCESSFULLY");
  print("🌐 Visit: http://localhost:8082");
  print("📡 Endpoints ready (admin, greeting, auth)");
  print("==============================\n");
}
