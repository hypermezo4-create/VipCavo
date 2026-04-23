import 'package:flutter/material.dart';

enum StatusBarControlType {
  toggle,
  slider,
  select,
  color,
}

class StatusBarOption {
  const StatusBarOption({required this.label, required this.value});

  final String label;
  final String value;
}

class StatusBarSettingItem {
  const StatusBarSettingItem({
    required this.legacyKey,
    required this.controlType,
    this.title,
    this.subtitle,
    this.group,
    this.defaultValue,
    this.min,
    this.max,
    this.options = const <StatusBarOption>[],
    this.step,
    this.preferenceType,
    this.intentAction,
    this.entriesReference,
    this.entryValuesReference,
    this.xmlReference,
    this.layoutReferences = const <String>[],
    this.drawableReferences = const <String>[],
  });

  final String legacyKey;
  final String? title;
  final String? subtitle;
  final StatusBarControlType controlType;
  final String? group;
  final Object? defaultValue;
  final double? min;
  final double? max;
  final List<StatusBarOption> options;
  final double? step;
  final String? preferenceType;
  final String? intentAction;
  final String? entriesReference;
  final String? entryValuesReference;
  final String? xmlReference;
  final List<String> layoutReferences;
  final List<String> drawableReferences;
}

class StatusBarSectionDefinition {
  const StatusBarSectionDefinition({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.displayOrder,
    this.previewLabel,
    this.routeSlug,
    this.sourceXmlReference,
    this.legacyPreferenceGroup,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final int displayOrder;
  final String? previewLabel;
  final String? routeSlug;
  final String? sourceXmlReference;
  final String? legacyPreferenceGroup;
}
