import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import '../../services/supabase_service.dart';
import '../widgets/admin_shell.dart';

class UsersRoute extends WidgetRoute {
  @override
  Future<WebWidget> build(Session session, Request request) async {
    // 1. DIRECT ACCESS: The log proves request.url IS a Uri object (_SimpleUri).
    // No parsing, no casting. Just use it.
    final params = request.url.queryParameters;

    final action = params['action'];
    final targetId = params['id'];
    final type = params['type'];

    // 2. TRIGGER NOTIFICATION
    if (action == 'push' && targetId != null && type != null) {
      final notification = BudgetNotification(
        title: type == 'over' ? 'Budget Warning' : 'Budget Goal Met',
        message: type == 'over'
            ? 'You have exceeded your monthly limit!'
            : 'Great job staying in budget!',
        isOverspending: type == 'over',
      );

      // Post message to the global bus
      session.messages.postMessage('user_channel_$targetId', notification);
    }

    final leaderboard = await SupabaseService.getLeaderboard();

    var rows = leaderboard.map((u) {
      final userId = u['id'];

      return '''
      <tr>
        <td>
          <div style="display: flex; align-items: center; gap: 10px;">
            <div style="width: 32px; height: 32px; background: #e0e7ff; color: #4338ca; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.8rem;">
              ${u['name'][0].toUpperCase()}
            </div>
            <div>
              <strong>${u['name']}</strong><br>
              <small style="color: #64748b;">${u['email']}</small>
            </div>
          </div>
        </td>
        <td style="font-weight:700; color: #1e293b;">\$${u['total'].toStringAsFixed(2)}</td>
        <td>
          <a href="/users?action=push&type=over&id=$userId" class="btn-s red">Overspend</a>
          <a href="/users?action=push&type=under&id=$userId" class="btn-s green">Healthy</a>
        </td>
      </tr>
      ''';
    }).join();

    return AdminShell(
      title: "User Control Center",
      activePage: "users",
      content: '''
        <table style="width:100%">
          <thead>
            <tr><th>User Profile</th><th>Total Lifetime Spend</th><th>Push Notifications</th></tr>
          </thead>
          <tbody>$rows</tbody>
        </table>
        <style>
          .btn-s { 
            text-decoration: none;
            display: inline-block;
            padding: 8px 14px; 
            border: none; 
            border-radius: 8px; 
            cursor: pointer; 
            color: white; 
            font-weight: 600; 
            font-size: 0.75rem; 
            transition: opacity 0.2s; 
          }
          .btn-s:hover { opacity: 0.8; }
          .red { background: #ef4444; margin-right: 4px; }
          .green { background: #10b981; }
        </style>
      ''',
    );
  }
}