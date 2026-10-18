import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class SecurityService {
  static final SecurityService instance = SecurityService._internal();
  SecurityService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final LocalAuthentication _auth = LocalAuthentication();

  static const String _pinHashKey = 'user_pin_hash';
  static const String _pinSaltKey = 'user_pin_salt';
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _lockEnabledKey = 'app_lock_enabled';

  Future<bool> isLockEnabled() async {
    final val = await _storage.read(key: _lockEnabledKey);
    return val == 'true';
  }

  Future<void> setLockEnabled(bool enabled) async {
    await _storage.write(key: _lockEnabledKey, value: enabled.toString());
  }

  Future<bool> isBiometricEnabled() async {
    final val = await _storage.read(key: _biometricEnabledKey);
    return val == 'true';
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(key: _biometricEnabledKey, value: enabled.toString());
  }

  Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics && await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticateBiometrics() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Desbloqueá Aula para acceder a tus datos académicos',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  Future<void> setPin(String pin) async {
    final salt = DateTime.now().microsecondsSinceEpoch.toString();
    final hash = sha256.convert(utf8.encode('$salt$pin')).toString();
    await _storage.write(key: _pinSaltKey, value: salt);
    await _storage.write(key: _pinHashKey, value: hash);
    await setLockEnabled(true);
  }

  Future<bool> verifyPin(String pin) async {
    final salt = await _storage.read(key: _pinSaltKey);
    final storedHash = await _storage.read(key: _pinHashKey);
    if (salt == null || storedHash == null) return false;

    final computedHash = sha256.convert(utf8.encode('$salt$pin')).toString();
    return computedHash == storedHash;
  }

  Future<bool> hasPin() async {
    final storedHash = await _storage.read(key: _pinHashKey);
    return storedHash != null && storedHash.isNotEmpty;
  }

  Future<void> clearSecurity() async {
    await _storage.delete(key: _pinSaltKey);
    await _storage.delete(key: _pinHashKey);
    await _storage.delete(key: _biometricEnabledKey);
    await _storage.delete(key: _lockEnabledKey);
  }
}
