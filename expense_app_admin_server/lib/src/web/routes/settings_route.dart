import 'package:serverpod/serverpod.dart';
import '../widgets/admin_shell.dart';

class SettingsRoute extends WidgetRoute {
  @override
  Future<WebWidget> build(Session session, Request request) async {
    return AdminShell(
      title: "System Settings",
      activePage: "set",
      content: '''
        <div style="padding: 2rem;">
            <h3>Database Configuration</h3>
            <p style="color: #64748b; margin-bottom: 1.5rem;">Manage your Supabase connection and server environment.</p>
            <hr style="border: 0; border-top: 1px solid #e2e8f0; margin-bottom: 1.5rem;">
            <div style="display: flex; gap: 10px;">
                <button style="padding: 10px 20px; background: #6366f1; color: white; border: none; border-radius: 8px; cursor: pointer;">Clear Server Cache</button>
                <button style="padding: 10px 20px; background: #ef4444; color: white; border: none; border-radius: 8px; cursor: pointer;">Reset Migrations</button>
            </div>
        </div>
      ''',
    );
  }
}