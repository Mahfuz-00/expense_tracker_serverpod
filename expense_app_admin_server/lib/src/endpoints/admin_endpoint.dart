import 'package:serverpod/serverpod.dart';
import '../services/supabase_service.dart';
import '../generated/protocol.dart';

class AdminEndpoint extends Endpoint {

  @override
  bool get requireLogin => false;

  Future<List<AppUser>> getUsers(Session session) async {
    try {
      return await SupabaseService.getUsers();
    } catch (e) {
      session.log("Error fetching users: $e");
      rethrow;
    }
  }

  Future<List<Expense>> getExpenses(Session session) async {
    try {
      return await SupabaseService.getExpenses();
    } catch (e) {
      session.log("Error fetching expenses: $e");
      rethrow;
    }
  }

  @override
  Future<void> streamOpened(StreamingSession session) async {
    print("🔌 Stream opened. Waiting for user identification...");
    // Keep the session alive manually if needed
    session.log("Streaming session started for anonymous user");
  }

  @override
  Future<void> handleStreamMessage(StreamingSession session, SerializableModel message) async {
    // 1. Check if the incoming meta-data is a Map
    if (message is UserIdentity) {
      // 2. SEPARATE the ID from the rest of the garbage
      String supabaseUserId = message.uuid;

      print("🎯 ID SEPARATED FROM PROTOCOL: $supabaseUserId");

      if (supabaseUserId != null) {
        print("🎯 ID SEPARATED: $supabaseUserId");

        // 3. Only listen to the channel for this specific ID
        session.messages.addListener('user_channel_$supabaseUserId', (msg) {
          sendStreamMessage(session, msg);
        });
      } else {
        print("❌ Error: No 'id' key found in the meta-data");
      }
    } else if (message is String) {
      // Fallback if you just send the raw ID string
      session.messages.addListener('user_channel_$message', (msg) {
        sendStreamMessage(session, msg);
      });
    }
  }

  Future<void> sendBudgetAlert(Session session, String userId, String type) async {
    final notification = BudgetNotification(
      title: type == 'over' ? 'Budget Warning' : 'Budget Goal Met',
      message: type == 'over'
          ? 'You have exceeded your monthly limit!'
          : 'Great job staying in budget!',
      isOverspending: type == 'over',
    );

    // This posts to the internal bus.
    // The listener we created in handleStreamMessage will catch it.
    session.messages.postMessage('user_channel_$userId', notification);
  }
}