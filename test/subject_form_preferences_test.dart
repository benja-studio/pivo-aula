import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pivo_aula/features/subjects/presentation/subject_form_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('subject form options persist between provider instances', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    final controller = container.read(subjectFormPreferencesProvider.notifier);

    await controller.update(
      showColorPicker: false,
      showIconPicker: false,
      showNotesField: false,
    );

    expect(container.read(subjectFormPreferencesProvider).showColorPicker, isFalse);
    expect(container.read(subjectFormPreferencesProvider).showIconPicker, isFalse);
    expect(container.read(subjectFormPreferencesProvider).showNotesField, isFalse);

    final stored = await SharedPreferences.getInstance();
    expect(stored.getBool(SubjectFormPreferences.showColorPickerKey), isFalse);
    expect(stored.getBool(SubjectFormPreferences.showIconPickerKey), isFalse);
    expect(stored.getBool(SubjectFormPreferences.showNotesFieldKey), isFalse);

    container.dispose();

    final restored = ProviderContainer();
    addTearDown(restored.dispose);
    await restored.read(subjectFormPreferencesProvider.notifier).ready;
    expect(restored.read(subjectFormPreferencesProvider).showColorPicker, isFalse);
    expect(restored.read(subjectFormPreferencesProvider).showIconPicker, isFalse);
    expect(restored.read(subjectFormPreferencesProvider).showNotesField, isFalse);
  });
}
