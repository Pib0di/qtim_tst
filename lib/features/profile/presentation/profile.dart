// features/profile/presentation/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtim_tst/data/models/user.dart';
import 'package:qtim_tst/data/providers/user_provider.dart';
import 'package:qtim_tst/features/profile/presentation/widgets/avatar_carousel.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    await ref.read(userProvider.notifier).getUser();
    user = ref.watch(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: AvatarCarousel(avatarUrls: user!.avatarUrls),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'Почта'),
                          controller: TextEditingController(text: user!.email),
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Телефон'),
                          controller: TextEditingController(text: user!.phone),
                        ),
                        TextField(
                          maxLines: null,
                          decoration: InputDecoration(labelText: '"и т.д"'),
                          controller: TextEditingController(text: user?.data),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
