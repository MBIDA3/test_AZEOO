import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_info.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;

class ProfileScreen extends ConsumerStatefulWidget {
  final String userId;

  const ProfileScreen({required this.userId, Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Charger le profil au démarrage
    Future.microtask(() =>
        ref.read(profileNotifierProvider.notifier).loadProfile(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Utilisateur'),
        backgroundColor: Colors.blue,
      ),
      body: profileState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Aucun profil'));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileAvatar(avatarUrl: user.avatarUrl),
                const SizedBox(height: 20),
                ProfileInfo(firstName: user.firstName, lastName: user.lastName),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, _) => custom.ErrorWidget(message: error.toString()),
      ),
    );
  }
}
