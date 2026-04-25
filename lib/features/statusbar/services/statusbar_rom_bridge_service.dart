import 'package:flutter/services.dart';

class StatusbarRomBridgeResult {
  const StatusbarRomBridgeResult({
    required this.success,
    required this.rootAvailable,
    required this.key,
    required this.writtenValue,
    required this.readValue,
    required this.message,
    this.stdout = '',
    this.stderr = '',
    this.exitCode,
  });

  final bool success;
  final bool rootAvailable;
  final String key;
  final String writtenValue;
  final String readValue;
  final String message;
  final String stdout;
  final String stderr;
  final int? exitCode;
}

class StatusbarRomBridgeService {
  StatusbarRomBridgeService._();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');
  static const String key = 'status_bar_elem_position';
  static const String defaultPositionString =
      'elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;';

  static Future<StatusbarRomBridgeResult> checkBridge() async {
    final root = await _runRoot('id');
    final rootOk = root.exitCode == 0 && root.stdout.contains('uid=0');
    final read = rootOk ? await readRomValue() : '';
    return StatusbarRomBridgeResult(
      success: rootOk,
      rootAvailable: rootOk,
      key: key,
      writtenValue: '',
      readValue: read,
      stdout: root.stdout,
      stderr: root.stderr,
      exitCode: root.exitCode,
      message: rootOk ? 'Root bridge active. ROM writes are available.' : 'Root bridge unavailable. Preview only.',
    );
  }

  static Future<String> readRomValue() async {
    final result = await _runRoot('settings get system $key');
    if (result.exitCode != 0) {
      return '';
    }
    final value = result.stdout.trim();
    if (value == 'null') {
      return '';
    }
    return value;
  }

  static Future<StatusbarRomBridgeResult> restoreDefault() {
    return writePosition(defaultPositionString, successMessage: 'Mezo default statusbar layout written to ROM.');
  }

  static Future<StatusbarRomBridgeResult> writePosition(
    String value, {
    String successMessage = 'Statusbar layout written to ROM.',
  }) async {
    final escaped = _shellQuote(value);
    final write = await _runRoot('settings put system $key $escaped');
    final rootOk = write.exitCode == 0;
    final read = rootOk ? await readRomValue() : '';
    final confirmed = rootOk && read == value;
    return StatusbarRomBridgeResult(
      success: confirmed,
      rootAvailable: rootOk,
      key: key,
      writtenValue: value,
      readValue: read,
      stdout: write.stdout,
      stderr: write.stderr,
      exitCode: write.exitCode,
      message: confirmed
          ? successMessage
          : rootOk
              ? 'ROM key write was not confirmed.'
              : 'Root bridge failed. Preview saved only.',
    );
  }

  static Future<_RootCommandResult> _runRoot(String command) async {
    try {
      final raw = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'runRootCommandSafe',
        <String, Object>{'command': command, 'timeoutMs': 1800},
      );
      final map = raw ?? const <dynamic, dynamic>{};
      return _RootCommandResult(
        exitCode: map['exitCode'] is int ? map['exitCode'] as int : -1,
        stdout: map['stdout']?.toString() ?? '',
        stderr: map['stderr']?.toString() ?? '',
      );
    } catch (error) {
      return _RootCommandResult(exitCode: -1, stdout: '', stderr: error.toString());
    }
  }

  static String _shellQuote(String value) {
    return "'${value.replaceAll("'", "'\\''")}'";
  }
}

class _RootCommandResult {
  const _RootCommandResult({required this.exitCode, required this.stdout, required this.stderr});

  final int exitCode;
  final String stdout;
  final String stderr;
}
