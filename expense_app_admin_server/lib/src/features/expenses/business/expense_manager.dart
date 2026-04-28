import '../data/supabase_expense_source.dart';
import '../../../generated/protocol.dart';

class ExpenseManager {
  final source = SupabaseExpenseSource();

  Future<List<Expense>> getAllExpenses() async {
    final data = await source.fetchRawExpenses();
    return data.map((e) => Expense(
      id: e['id']?.toString() ?? '',
      userId: e['user_id'],
      amount: (e['amount'] as num).toDouble(),
      category: e['category'],
      description: e['description'] ?? '',
      createdAt: DateTime.parse(e['created_at']),
    )).toList();
  }

  Future<Map<String, double>> getCategoryStats() async {
    final data = await source.fetchRawExpenses();
    Map<String, double> stats = {};
    for (var item in data) {
      String cat = item['category'] ?? 'Other';
      double amt = (item['amount'] as num).toDouble();
      stats[cat] = (stats[cat] ?? 0.0) + amt;
    }
    return stats;
  }
}