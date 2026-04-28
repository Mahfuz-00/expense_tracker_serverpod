import 'package:serverpod/serverpod.dart';
import '../../../generated/protocol.dart';
import '../../../web/widgets/admin_shell.dart';
import '../../notification/business/push_service.dart';
import '../data/user_repository.dart';

class UsersRoute extends WidgetRoute {
  @override
  Future<WebWidget> build(Session session, Request request) async {
    final userRepo = UserRepository();
    final params = request.url.queryParameters;

    // 1. Logic still lives here for the background request
    if (params['action'] == 'push') {
      PushService.sendBudgetAlert(session, params['id']!, params['type']!);
      // Return a empty response or status if called via Fetch
      // But for minimum change, we just let the page render normally
    }

    final users = await userRepo.fetchUserListings();

    var rows = users.map((u) {
      final userId = u['id'];
      final name = u['full_name'] ?? u['email'].split('@')[0];

      // 2. Change <a> to <button> with an onclick event
      return '''
      <tr>
        <td>
          <strong>$name</strong><br>
          <small style="color: #64748b;">${u['email']}</small>
        </td>
        <td>
          <button onclick="sendPush('$userId', 'over')" class="btn-s red">Overspend</button>
          <button onclick="sendPush('$userId', 'under')" class="btn-s green">Healthy</button>
        </td>
      </tr>
      ''';
    }).join();

    return AdminShell(
      title: "User Control Center",
      activePage: "users",
      content: '''
        <div id="toast" style="display:none; position:fixed; top:20px; right:20px; background:#10b981; color:white; padding:12px 24px; border-radius:8px; z-index:1000; box-shadow:0 4px 12px rgba(0,0,0,0.1)">
          Notification Sent!
        </div>

        <table>
          <thead>
            <tr><th>User Profile</th><th>Actions</th></tr>
          </thead>
          <tbody>$rows</tbody>
        </table>

        <script>
          async function sendPush(id, type) {
            // This hits the server in the background
            await fetch(`/users?action=push&type=` + type + `&id=` + id);
            
            // Show a "Success" message without changing the URL
            const toast = document.getElementById('toast');
            toast.style.display = 'block';
            
            // Clean up the URL just once to show the "notification=true" state
            window.history.replaceState(null, "", "/users?notification=true");
            
            setTimeout(() => { toast.style.display = 'none'; }, 3000);
          }
        </script>

        <style>
          .btn-s { border: none; cursor: pointer; padding: 6px 12px; border-radius: 6px; color: white; font-size: 0.75rem; font-weight: 600; }
          .red { background: #ef4444; margin-right: 5px; }
          .green { background: #10b981; }
          .btn-s:active { opacity: 0.7; }
        </style>
      ''',
    );
  }
}