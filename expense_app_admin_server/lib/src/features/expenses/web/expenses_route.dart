import 'package:serverpod/serverpod.dart';
import '../data/supabase_expense_source.dart';
import '../../../web/widgets/admin_shell.dart';

class ExpensesRoute extends WidgetRoute {
  @override
  Future<WebWidget> build(Session session, Request request) async {
    final source = SupabaseExpenseSource();
    final expenses = await source.fetchExpensesWithUsers();

    var rows = expenses.map((e) {
      final userData = e['user_listing'];
      final displayName = userData['full_name'] ?? userData['email'].toString().split('@')[0];

      return '''
        <tr>
          <td><strong>$displayName</strong><br><small>${userData['email']}</small></td>
          <td><span class="badge">${e['category']}</span></td>
          <td><strong>\$${e['amount']}</strong></td>
          <td>${e['created_at'].toString().split('T')[0]}</td>
        </tr>
      ''';
    }).join();

    return AdminShell(
      title: "Detailed Expense Log",
      activePage: "exp",
      content: '<table><thead><tr><th>User</th><th>Category</th><th>Amount</th><th>Date</th></tr></thead><tbody>$rows</tbody></table>',
    );
  }
}