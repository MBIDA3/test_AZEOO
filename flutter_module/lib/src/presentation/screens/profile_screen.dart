// ============================================================================
// FICHIER : profile_screen.dart
// RÔLE : Écran principal d'affichage du profil utilisateur
// COUCHE : Presentation Layer
// ============================================================================
//
// Fonctionnalités :
// - Affichage du profil (avatar, nom, prénom)
// - Gestion des états : loading, data, error
// - Pull-to-refresh pour rafraîchir les données
// - Navigation avec go_router
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    Future.microtask(() => _loadProfile());
  }

  /// Charge le profil de l'utilisateur
  Future<void> _loadProfile() async {
    await ref.read(profileNotifierProvider.notifier).loadProfile(widget.userId);
  }

  /// Rafraîchit le profil (appelé par pull-to-refresh)
  Future<void> _refreshProfile() async {
    // Invalider le cache et recharger
    await ref.read(profileNotifierProvider.notifier).refreshProfile(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Utilisateur'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          // Bouton de rafraîchissement dans l'AppBar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshProfile,
            tooltip: 'Rafraîchir',
          ),
        ],
      ),
      body: profileState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Aucun profil'));
          }
          // RefreshIndicator pour le pull-to-refresh
          return RefreshIndicator(
            onRefresh: _refreshProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 
                        AppBar().preferredSize.height - 
                        MediaQuery.of(context).padding.top,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileAvatar(avatarUrl: user.avatarUrl),
                      const SizedBox(height: 20),
                      ProfileInfo(firstName: user.firstName, lastName: user.lastName),
                      const SizedBox(height: 30),
                      Text(
                        'User ID: ${widget.userId}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '↓ Tirez pour rafraîchir',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, _) => custom.ErrorWidget(
          message: error.toString(),
          onRetry: _loadProfile,
        ),
      ),
    );
  }
}
