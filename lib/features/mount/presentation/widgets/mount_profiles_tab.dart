import 'package:deadzon/features/mount/domain/mount_profile.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountProfilesTab extends StatelessWidget {
  const MountProfilesTab({
    required this.profiles,
    required this.activeProfileId,
    required this.onProfileTap,
    required this.onResetProfile,
    required this.onEditProfile,
    super.key,
  });

  final List<MountProfile> profiles;
  final String activeProfileId;
  final ValueChanged<String> onProfileTap;
  final VoidCallback onResetProfile;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    return MountGlassCard(
      child: Column(
        children: <Widget>[
          ...profiles.map(
            (p) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(p.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              subtitle: Text(p.id, style: TextStyle(color: Colors.white.withValues(alpha: 0.68))),
              trailing: p.id == activeProfileId ? const Icon(Icons.check_circle, color: Color(0xFF8CEFD2)) : null,
              onTap: () => onProfileTap(p.id),
            ),
          ),
          Row(
            children: <Widget>[
              TextButton(onPressed: onResetProfile, child: const Text('Reset profile')),
              TextButton(onPressed: onEditProfile, child: const Text('Edit profile')),
            ],
          ),
        ],
      ),
    );
  }
}
