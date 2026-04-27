import 'package:flutter/services.dart';

enum MezoSettingsStoreType {
  system(0),
  secure(1),
  global(2);

  const MezoSettingsStoreType(this.value);

  final int value;
}

class ResizeStatusbarService {
  ResizeStatusbarService._();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');
  static const String cutoutIntentAction = 'my.settings.intent.element_position_cutout.CHANGE';
  static const Set<String> _selectionKeys = <String>{
    'status_bar_element_cutout_type',
    'status_bar_element_cutout_center',
    'status_bar_element_cutout_left',
    'status_bar_element_cutout_left_not_calculate',
  };

  static const Map<String, _ResizeBinding> _bindings = <String, _ResizeBinding>{
    'custom_status_bar_height': _ResizeBinding.intSetting(defaultValue: 99, storeType: MezoSettingsStoreType.global),
    'status_bar_elem_center_in_island': _ResizeBinding.boolSetting(defaultValue: true),
    'custom_status_bar_top': _ResizeBinding.intSetting(defaultValue: 2),
    'custom_status_bar_left_right': _ResizeBinding.intSetting(defaultValue: 0),
    'status_bar_element_cutout_padding': _ResizeBinding.intSetting(defaultValue: 35, intentAction: cutoutIntentAction),
    'status_bar_element_cutout_type': _ResizeBinding.intSetting(defaultValue: 1, intentAction: cutoutIntentAction),
    'status_bar_element_cutout_center': _ResizeBinding.intSetting(defaultValue: 2, intentAction: cutoutIntentAction),
    'status_bar_element_cutout_camera_width': _ResizeBinding.intSetting(defaultValue: 80, intentAction: cutoutIntentAction),
    'status_bar_element_cutout_left': _ResizeBinding.intSetting(defaultValue: 2, intentAction: cutoutIntentAction),
    'status_bar_element_cutout_padding_left_camera': _ResizeBinding.intSetting(defaultValue: 75, intentAction: cutoutIntentAction),
    'status_bar_element_cutout_left_not_calculate': _ResizeBinding.intSetting(defaultValue: 2, intentAction: cutoutIntentAction),
  };

  static Future<Map<String, Object?>> loadAll() async {
    final values = <String, Object?>{};
    for (final entry in _bindings.entries) {
      final key = entry.key;
      final binding = entry.value;
      switch (binding.valueType) {
        case _ResizeValueType.boolValue:
          values[key] = await _readBool(key, binding.defaultValue as bool, binding.storeType);
        case _ResizeValueType.intValue:
          final current = await _readInt(key, binding.defaultValue as int, binding.storeType);
          values[key] = _selectionKeys.contains(key) ? '$current' : current.toDouble();
      }
    }
    return values;
  }

  static Future<void> write(String key, Object? value) async {
    final binding = _bindings[key];
    if (binding == null || value == null) {
      return;
    }

    try {
      switch (binding.valueType) {
        case _ResizeValueType.boolValue:
          await _writeBool(key, value as bool, binding.storeType);
        case _ResizeValueType.intValue:
          final intValue = value is String ? int.tryParse(value) ?? binding.defaultValue as int : (value as num).round();
          await _writeInt(key, intValue, binding.storeType);
      }

      if (binding.intentAction != null) {
        await _sendIntent(binding.intentAction!);
      }
    } catch (_) {
      // Keep UI responsive even when write permissions are unavailable.
    }
  }


  static Future<int> readInt({
    required String key,
    required int fallback,
    MezoSettingsStoreType storeType = MezoSettingsStoreType.system,
  }) {
    return _readInt(key, fallback, storeType);
  }

  static Future<bool> readBool({
    required String key,
    required bool fallback,
    MezoSettingsStoreType storeType = MezoSettingsStoreType.system,
  }) {
    return _readBool(key, fallback, storeType);
  }

  static Future<void> writeInt({
    required String key,
    required int value,
    MezoSettingsStoreType storeType = MezoSettingsStoreType.system,
  }) {
    return _writeInt(key, value, storeType);
  }

  static Future<void> writeBool({
    required String key,
    required bool value,
    MezoSettingsStoreType storeType = MezoSettingsStoreType.system,
  }) {
    return _writeBool(key, value, storeType);
  }


  static Future<String> readString({
    required String key,
    required String fallback,
    MezoSettingsStoreType storeType = MezoSettingsStoreType.system,
  }) async {
    final current = await _channel.invokeMethod<String>(
      'readString',
      <String, Object>{'key': key, 'defaultValue': fallback, 'storeType': storeType.value},
    );
    return current ?? fallback;
  }

  static Future<void> writeString({
    required String key,
    required String value,
    MezoSettingsStoreType storeType = MezoSettingsStoreType.system,
  }) async {
    await _channel.invokeMethod<void>(
      'writeString',
      <String, Object>{'key': key, 'value': value, 'storeType': storeType.value},
    );
  }

  static Future<void> sendBroadcastIntent(String action) {
    return _sendIntent(action);
  }

  static Future<bool> canWriteSystemSettings() async {
    final current = await _channel.invokeMethod<bool>('canWriteSystemSettings');
    return current ?? false;
  }

  static Future<void> openWriteSettingsPanel() async {
    await _channel.invokeMethod<void>('openWriteSettingsPanel');
  }

  static Future<int> _readInt(String key, int fallback, MezoSettingsStoreType storeType) async {
    final current = await _channel.invokeMethod<int>(
      'readInt',
      <String, Object>{'key': key, 'defaultValue': fallback, 'storeType': storeType.value},
    );
    return current ?? fallback;
  }

  static Future<bool> _readBool(String key, bool fallback, MezoSettingsStoreType storeType) async {
    final current = await _channel.invokeMethod<bool>(
      'readBool',
      <String, Object>{'key': key, 'defaultValue': fallback, 'storeType': storeType.value},
    );
    return current ?? fallback;
  }

  static Future<void> _writeInt(String key, int value, MezoSettingsStoreType storeType) async {
    await _channel.invokeMethod<void>(
      'writeInt',
      <String, Object>{'key': key, 'value': value, 'storeType': storeType.value},
    );
  }

  static Future<void> _writeBool(String key, bool value, MezoSettingsStoreType storeType) async {
    await _channel.invokeMethod<void>(
      'writeBool',
      <String, Object>{'key': key, 'value': value, 'storeType': storeType.value},
    );
  }

  static Future<void> _sendIntent(String action) async {
    await _channel.invokeMethod<void>('sendBroadcast', <String, Object>{'action': action});
  }
}

enum _ResizeValueType { intValue, boolValue }

class _ResizeBinding {
  const _ResizeBinding({
    required this.valueType,
    required this.defaultValue,
    this.storeType = MezoSettingsStoreType.system,
    this.intentAction,
  });

  const _ResizeBinding.intSetting({
    required int defaultValue,
    MezoSettingsStoreType storeType = MezoSettingsStoreType.system,
    String? intentAction,
  }) : this(
          valueType: _ResizeValueType.intValue,
          defaultValue: defaultValue,
          storeType: storeType,
          intentAction: intentAction,
        );

  const _ResizeBinding.boolSetting({
    required bool defaultValue,
    MezoSettingsStoreType storeType = MezoSettingsStoreType.system,
    String? intentAction,
  }) : this(
          valueType: _ResizeValueType.boolValue,
          defaultValue: defaultValue,
          storeType: storeType,
          intentAction: intentAction,
        );

  final _ResizeValueType valueType;
  final Object defaultValue;
  final MezoSettingsStoreType storeType;
  final String? intentAction;
}
