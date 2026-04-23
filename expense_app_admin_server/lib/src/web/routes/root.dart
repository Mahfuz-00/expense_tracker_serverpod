import 'package:serverpod/serverpod.dart';
import '../widgets/admin_shell.dart';
import '../../services/supabase_service.dart';

class RootRoute extends WidgetRoute {
  @override
  Future<WebWidget> build(Session session, Request request) async {
    final userCount = await SupabaseService.getUserCount();
    final monthlyTotal = await SupabaseService.getMonthlyTotal();
    final categoryData = await SupabaseService.getCategoryStats();
    final leaderboard = await SupabaseService.getLeaderboard();

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

    // Use name instead of email in the leaderboard
    var leaderboardRows = leaderboard.map((e) => '''
      <div class="leader-row">
        <span>${e['name']}</span>
        <span class="weight-600">\$${e['total'].toStringAsFixed(2)}</span>
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
            <div class="info-box"><h3>System Status</h3><div class="val" style="color:#10b981">Live</div></div>
          </div>

          <div style="display: grid; grid-template-columns: 250px 1fr 300px; gap: 1.5rem; align-items: start;">
            <div class="scroll-stack" style="max-height: 400px; overflow-y: auto;">$categoryCards</div>

            <div class="card-white" style="text-align: center;">
              <h3 style="margin-bottom:1rem">Expense Distribution</h3>
              <div style="max-width: 350px; margin: 0 auto;">
                <canvas id="pieChart"></canvas>
              </div>
            </div>

            <div class="card-white">
              <h3 style="margin-bottom:1rem">Leaderboard</h3>
              $leaderboardRows
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
        <style>
          .info-box { background: #fff; padding: 1.2rem; border-radius: 12px; border: 1px solid #e2e8f0; }
          .info-box h3 { font-size: 0.75rem; color: #64748b; text-transform: uppercase; }
          .info-box .val { font-size: 1.5rem; font-weight: 700; margin-top: 0.4rem; }
          .mini-card { background: white; padding: 1rem; border-radius: 10px; border: 1px solid #e2e8f0; margin-bottom: 0.8rem; }
          .cat-label { font-size: 0.7rem; font-weight: 700; color: #6366f1; text-transform: uppercase; }
          .cat-amt { font-size: 1.1rem; font-weight: 700; color: #1e293b; }
          .leader-row { display: flex; justify-content: space-between; padding: 0.8rem 0; border-bottom: 1px solid #f1f5f9; font-size: 0.85rem; }
          .weight-600 { font-weight: 600; color: #6366f1; }
          .scroll-stack::-webkit-scrollbar { width: 4px; }
          .scroll-stack::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        </style>
      ''',
    );
  }
}