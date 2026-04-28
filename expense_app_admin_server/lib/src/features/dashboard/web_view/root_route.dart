import 'package:serverpod/serverpod.dart';
import '../../../web/widgets/admin_shell.dart';
import '../../expenses/business/expense_manager.dart';
import '../../admin/data/user_repository.dart';

class RootRoute extends WidgetRoute {

  @override
  Future<WebWidget> build(Session session, Request request) async {
    // 1. Fetch data through the clean layers
    final expenseManager = ExpenseManager();
    final userRepo = UserRepository();
    final userCount = (await userRepo.fetchUserListings()).length;
    final categoryData = await expenseManager.getCategoryStats();

    // Calculate total from categories
    final monthlyTotal = categoryData.values.fold(0.0, (sum, amt) => sum + amt);

    final categories = categoryData.keys.map((e) => "'$e'").join(',');
    final amounts = categoryData.values.join(',');

    String topCategory = categoryData.entries.isNotEmpty
        ? (categoryData.entries.toList()..sort((a,b) => b.value.compareTo(a.value))).first.key
        : "N/A";

    var categoryCards = categoryData.entries.map((e) => '''
      <div class="mini-card">
        <span class="cat-label">${e.key}</span>
        <div class="cat-amt">\$${e.value.toStringAsFixed(2)}</div>
      </div>
    ''').join();

    return AdminShell(
      title: "Market Insights",
      activePage: "dash",
      content: '''
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <div style="padding: 2rem;">
          <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1rem; margin-bottom: 2rem;">
            <div class="info-box"><h3>Healthy Budgets</h3><div class="val">$userCount</div></div>
            <div class="info-box"><h3>Top Category</h3><div class="val">$topCategory</div></div>
            <div class="info-box"><h3>System Total</h3><div class="val" style="color:#10b981">\$${monthlyTotal.toStringAsFixed(2)}</div></div>
          </div>

          <div style="display: grid; grid-template-columns: 250px 1fr; gap: 1.5rem;">
            <div class="scroll-stack">$categoryCards</div>
            <div class="card-white" style="text-align: center; padding: 2rem;">
              <h3 style="margin-bottom:1rem">Expense Distribution</h3>
              <canvas id="pieChart"></canvas>
            </div>
          </div>
        </div>

        <script>
          new Chart(document.getElementById('pieChart'), {
            type: 'doughnut',
            data: {
              labels: [$categories],
              datasets: [{
                data: [$amounts],
                backgroundColor: ['#6366f1', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6'],
                borderWidth: 0
              }]
            },
            options: { cutout: '70%' }
          });
        </script>
      ''',
    );
  }
}