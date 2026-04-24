import 'package:deadzon/features/mount/domain/mount_config.dart';

class MountProfile {
  const MountProfile({
    required this.id,
    required this.name,
    required this.config,
  });

  final String id;
  final String name;
  final MountConfig config;
}
