import 'package:cuenta/model/admin/profile_model.dart';
import 'package:cuenta/services/admin/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileModel profile = ProfileModel.fromJson({});
  bool _enabled = true;

  void getProfile() async {
    final ProfileModel profile = await ProfileService().getProfile();
    setState(() {
      this.profile = profile;
      this._enabled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Skeletonizer(
          enabled: _enabled,
          enableSwitchAnimation: true,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  backgroundImage:
                      profile.avatar != null && profile.avatar.isNotEmpty
                      ? NetworkImage(profile.avatar)
                      : null,
                  child: (profile.avatar == null || profile.avatar.isEmpty)
                      ? Icon(
                          Icons.person,
                          size: 70,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                profile.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                profile.email,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _item(
                      context: context,
                      icon: Icons.person,
                      label: "Name",
                      value: profile.name,
                    ),
                    const Divider(),
                    _item(
                      context: context,
                      icon: Icons.email,
                      label: "Email",
                      value: profile.email,
                    ),
                    const Divider(),
                    _item(
                      context: context,
                      icon: Icons.person_2_rounded,
                      label: "Role",
                      value: profile.role,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: 26),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
