import 'package:supabase/supabase.dart';
import '../generated/protocol.dart';

class SupabaseService {
  static final client = SupabaseClient(
    'https://ingztgndbckkyxvwadhv.supabase.co',
    'sb_secret_NsAvTL1abTpGVm1YnwPYZA_kf4fNK4V',
  );

  static Future<List<AppUser>> getUsers() async {
    final res = await client.from('user_listing').select();
    return res.map((e) => AppUser(
      id: e['id'],
      email: e['email'],
      createdAt: DateTime.parse(e['created_at']),
    )).toList();
  }

  static Future<List<Expense>> getExpenses() async {
    final res = await client.from('expenses').select();
    return res.map((e) => Expense(
      id: e['id'].toString(),
      userId: e['user_id'],
      amount: (e['amount'] as num).toDouble(),
      category: e['category'],
      description: e['description'],
      createdAt: DateTime.parse(e['created_at']),
    )).toList();
  }

  static Future<int> getUserCount() async {
    final res = await client.from('user_listing').select('id');
    return (res as List).length;
  }

  static Future<double> getMonthlyTotal() async {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1).toIso8601String();

    // 1. Get the data
    final res = await client
        .from('expenses')
        .select('amount')
        .gte('created_at', firstDay);

    final List<dynamic> data = res as List<dynamic>;

    // 2. Explicitly type the fold method <double>
    return data.fold<double>(0.0, (double sum, item) {
      final amount = (item['amount'] as num?)?.toDouble() ?? 0.0;
      return sum + amount;
    });
  }

  static Future<Map<String, double>> getCategoryStats() async {
    final res = await client.from('expenses').select('category, amount');
    final List<dynamic> data = res as List<dynamic>;

    Map<String, double> stats = {};
    for (var item in data) {
      String cat = item['category'] ?? 'Other';
      // Use 'as num' and then 'toDouble' to be safe with integers/doubles from DB
      double amt = (item['amount'] as num?)?.toDouble() ?? 0.0;
      stats[cat] = (stats[cat] ?? 0.0) + amt;
    }
    return stats;
  }

  static Future<List<Map<String, dynamic>>> getLeaderboard() async {
    // 1. Get all users from our new view
    final usersRes = await client.from('user_listing').select('id, email, full_name');
    final allUsers = List<Map<String, dynamic>>.from(usersRes);

    // 2. Get all expenses
    final expRes = await client.from('expenses').select('amount, user_id');
    final allExpenses = List<Map<String, dynamic>>.from(expRes);

    // 3. Map total spending to User IDs
    Map<String, double> spendMap = {};
    for (var exp in allExpenses) {
      String uid = exp['user_id'];
      double amt = (exp['amount'] as num).toDouble();
      spendMap[uid] = (spendMap[uid] ?? 0) + amt;
    }

    // 4. Combine: Use Full Name if available, otherwise Email
    return allUsers.map((u) {
      String displayName = u['full_name'] ?? u['email']?.split('@')[0] ?? 'Unknown';
      return {
        'id': u['id'],
        'name': displayName,
        'email': u['email'],
        'total': spendMap[u['id']] ?? 0.0,
      };
    }).toList()..sort((a, b) => b['total'].compareTo(a['total']));
  }

  static Future<List<Map<String, dynamic>>> getExpensesWithUsers() async {
    // We pull full_name from the view join
    final res = await client
        .from('expenses')
        .select('*, user_listing(email, full_name)');
    return List<Map<String, dynamic>>.from(res);
  }
}