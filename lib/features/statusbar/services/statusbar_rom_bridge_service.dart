import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_service.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusbarRomBridgeService {
  StatusbarRomBridgeService._();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');
  static const String positionKey = statusbarBoardSerializedKey;
  static const String defaultPositionString = statusbarBoardSourceDefaultLayout;
  static const String _liveApplyPreferenceKey = 'deadzone_statusbar_rom_live_apply';

  static Future<bool> readLiveApplyEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_liveApplyPreferenceKey) ?? false;
  }

  static Future<void> setLiveApplyEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_liveApplyPreferenceKey, value);
  }

  static Future<StatusbarRomBridgeResult> checkRootStatus() async {
    try {
      final available = await _channel.invokeMethod<bool>('checkSuAvailable') ?? false;
      return StatusbarRomBridgeResult(
        success: available,
        rootAvailable: available,
        confirmed: available,
        key: positionKey,
        message: available
            ? 'Root bridge active. ROM writes are available.'
            : 'Root bridge unavailable. Preview only.',
      );
    } on PlatformException catch (error) {
      return StatusbarRomBridgeResult(
        success: false,
        rootAvailable: false,
        confirmed: false,
        key: positionKey,
        message: error.message ?? 'Root bridge check failed.',
        stderr: error.details?.toString(),
      );
    } catch (error) {
      return StatusbarRomBridgeResult(
        success: false,
        rootAvailable: false,
        confirmed: false,
        key: positionKey,
        message: 'Root bridge check failed.',
        stderr: error.toString(),
      );
    }
  }

  static Future<StatusbarRomBridgeResult> readPosition() async {
    try {
      final raw = await _channel.invokeMapMethod<String, Object?>(
        'readSystemStringWithRoot',
        <String, Object?>{'key': positionKey, 'fallback': defaultPositionString},
      );
      return StatusbarRomBridgeResult.fromMap(raw, fallbackKey: positionKey);
    } catch (error) {
      return StatusbarRomBridgeResult(
        success: false,
        rootAvailable: false,
        confirmed: false,
        key: positionKey,
        message: 'Could not read ROM statusbar key.',
        stderr: error.toString(),
      );
    }
  }

  static Future<StatusbarRomBridgeResult> writeCurrentModules(List<StatusbarBoardModuleState> modules) {
    return writePosition(StatusbarBoardService.encodeSerializedLayout(modules));
  }

  static Future<StatusbarRomBridgeResult> writeDefaultPosition() {
    return writePosition(defaultPositionString);
  }

  static Future<StatusbarRomBridgeResult> writePosition(String value) async {
    try {
      final raw = await _channel.invokeMapMethod<String, Object?>(
        'writeSystemStringWithRoot',
        <String, Object?>{'key': positionKey, 'value': value},
      );
      return StatusbarRomBridgeResult.fromMap(raw, fallbackKey: positionKey);
    } catch (error) {
      return StatusbarRomBridgeResult(
        success: false,
        rootAvailable: false,
        confirmed: false,
        key: positionKey,
        writtenValue: value,
        message: 'Root bridge failed. Preview saved only.',
        stderr: error.toString(),
      );
    }
  }
}

class StatusbarRomBridgeResult {
  const StatusbarRomBridgeResult({
    required this.success,
    required this.rootAvailable,
    required this.confirmed,
    required this.key,
    this.writtenValue,
    this.readback,
    this.message,
    this.stdout,
    this.stderr,
    this.exitCode,
  });

  final bool success;
  final bool rootAvailable;
  final bool confirmed;
  final String key;
  final String? writtenValue;
  final String? readback;
  final String? message;
  final String? stdout;
  final String? stderr;
  final int? exitCode;

  bool get bridgeActive => rootAvailable && success;

  String get displayMessage {
    if (message != null && message!.trim().isNotEmpty) {
      return message!;
    }
    if (confirmed) {
      return 'Statusbar layout written to ROM.';
    }
    if (rootAvailable) {
      return 'ROM key write was not confirmed.';
    }
    return 'Root bridge unavailable. Preview only.';
  }

  factory StatusbarRomBridgeResult.fromMap(Map<String, Object?>? map, {required String fallbackKey}) {
    if (map == null) {
      return StatusbarRomBridgeResult(
        success: false,
        rootAvailable: false,
        confirmed: false,
        key: fallbackKey,
        message: 'Root bridge returned no data.',
      );
    }

    return StatusbarRomBridgeResult(
      success: map['success'] as? bool ?? false,
      rootAvailable: map['rootAvailable'] as? bool ?? false,
      confirmed: map['confirmed'] as? bool ?? false,
      key: map['key']?.toString() ?? fallbackKey,
      writtenValue: map['writtenValue']?.toString(),
      readback: map['readback']?.toString(),
      message: map['message']?.toString(),
      stdout: map['stdout']?.toString(),
      stderr: map['stderr']?.toString(),
      exitCode: map['exitCode'] as? int,
    );
  }
}
