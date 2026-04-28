import 'package:serverpod/serverpod.dart';
import '../../../generated/protocol.dart';

class PushService {
  // Static utility to send the message through the global bus
  static void sendBudgetAlert(Session session, String userId, String type) {
    final notification = BudgetNotification(
      title: type == 'over' ? 'Budget Warning' : 'Budget Goal Met',
      message: type == 'over'
          ? 'You have exceeded your monthly limit!'
          : 'Great job staying in budget!',
      isOverspending: type == 'over',
    );

    session.messages.postMessage('user_channel_$userId', notification);
  }
}