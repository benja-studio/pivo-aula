import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/pressable_scale.dart';
import '../../../core/services/security_service.dart';

class LockScreen extends StatefulWidget {
  final VoidCallback onUnlocked;
  const LockScreen({super.key, required this.onUnlocked});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  String _pin = '';
  String? _error;
  bool _canUseBiometrics = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final service = SecurityService.instance;
    final isBiometricOn = await service.isBiometricEnabled();
    final canCheck = await service.canCheckBiometrics();
    if (isBiometricOn && canCheck) {
      setState(() => _canUseBiometrics = true);
      _authenticateWithBiometrics();
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    final authenticated = await SecurityService.instance.authenticateBiometrics();
    if (authenticated && mounted) {
      HapticFeedback.mediumImpact();
      widget.onUnlocked();
    }
  }

  void _onKeyPress(String digit) {
    if (_pin.length >= 4) return;
    setState(() {
      _pin += digit;
      _error = null;
    });

    if (_pin.length == 4) {
      _verifyPin();
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _error = null;
      });
    }
  }

  Future<void> _verifyPin() async {
    final valid = await SecurityService.instance.verifyPin(_pin);
    if (valid) {
      HapticFeedback.lightImpact();
      widget.onUnlocked();
    } else {
      HapticFeedback.heavyImpact();
      setState(() {
        _error = 'PIN incorrecto';
        _pin = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: 72,
              height: 72,
              decoration: ShapeDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
                shape: AppRadius.continuousLg(),
              ),
              child: Icon(Icons.lock_rounded, size: 36, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text('Aula Protegida', style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Ingresá tu PIN para desbloquear',
              style: AppTypography.caption.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // PIN Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isFilled = index < _pin.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: isFilled
                        ? theme.colorScheme.primary
                        : (isDark ? const Color(0xFF262A32) : const Color(0xFFD1D5DB)),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),

            if (_error != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
            ],
            const Spacer(),

            // Keypad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  for (int row = 0; row < 3; row++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int col = 1; col <= 3; col++)
                            _KeypadButton(
                              label: (row * 3 + col).toString(),
                              onTap: () => _onKeyPress((row * 3 + col).toString()),
                            ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_canUseBiometrics)
                        _KeypadIconButton(
                          icon: Icons.fingerprint_rounded,
                          onTap: _authenticateWithBiometrics,
                        )
                      else
                        const SizedBox(width: 72),
                      _KeypadButton(
                        label: '0',
                        onTap: () => _onKeyPress('0'),
                      ),
                      _KeypadIconButton(
                        icon: Icons.backspace_outlined,
                        onTap: _onBackspace,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _KeypadButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PressableScale(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E222A) : const Color(0xFFF3F4F6),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTypography.display.copyWith(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _KeypadIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _KeypadIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        height: 72,
        child: Icon(icon, size: 28),
      ),
    );
  }
}
