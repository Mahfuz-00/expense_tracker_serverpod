import '../../../services/supabase_client.dart';

class SupabaseExpenseSource {
  final client = SupabaseService.client;

  Future<List<Map<String, dynamic>>> fetchExpensesWithUsers() async {
    final res = await client
        .from('expenses')
        .select('*, user_listing(email, full_name)');
    return List<Map<String, dynamic>>.from(res);
  }

  Future<List<Map<String, dynamic>>> fetchRawExpenses() async {
    return List<Map<String, dynamic>>.from(
        await client.from('expenses').select('amount, user_id, category, created_at')
    );
  }
}