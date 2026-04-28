import '../../../services/supabase_client.dart';
import '../../../generated/protocol.dart';

class UserRepository {
  final client = SupabaseService.client;

  Future<List<AppUser>> fetchAllUsers() async {
    final res = await client.from('user_listing').select();
    return res.map((e) => AppUser(
      id: e['id'],
      email: e['email'],
      createdAt: DateTime.parse(e['created_at']),
    )).toList();
  }

  Future<List<Map<String, dynamic>>> fetchUserListings() async {
    final res = await client.from('user_listing').select('id, email, full_name');
    return List<Map<String, dynamic>>.from(res);
  }
}