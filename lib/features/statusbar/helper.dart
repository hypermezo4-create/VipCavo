import 'package:deadzon/features/statusbar/statusbar_models.dart';
import 'package:deadzon/features/statusbar/statusbar_section_configs.dart';

class StatusBarHelper {
  const StatusBarHelper._();

  static List<StatusBarSectionDefinition> orderedSections() {
    final ordered = List<StatusBarSectionDefinition>.from(StatusbarSectionConfigs.values);
    ordered.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return ordered;
  }
}
