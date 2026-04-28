import '../../../generated/protocol.dart';
import '../../../services/supabase_client.dart';

class ExpenseRepository {
  final _db = SupabaseService.client;

  Future<List<Expense>> getAllExpenses() async {
    final res = await _db.from('expenses').select();
    return res.map((e) => Expense(
      id: e['id'].toString(),
      userId: e['user_id'],
      amount: (e['amount'] as num).toDouble(),
      category: e['category'],
      description: e['description'],
      createdAt: DateTime.parse(e['created_at']),
    )).toList();
  }

  Future<List<Map<String, dynamic>>> getExpensesWithUsers() async {
    final res = await _db.from('expenses').select('*, user_listing(email, full_name)');
    return List<Map<String, dynamic>>.from(res);
  }
}