import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Which optional controls are shown while creating or editing a subject.
/// Hiding a control never removes its saved value from an existing subject.
class SubjectFormPreferences {
  const SubjectFormPreferences({
    this.showColorPicker = true,
    this.showIconPicker = true,
    this.showCodeField = true,
    this.showProfessorField = true,
    this.showClassroomField = true,
    this.showCreditsField = true,
    this.showStatusSelector = true,
    this.showPassingGrade = true,
    this.showNotesField = true,
  });

  static const defaults = SubjectFormPreferences();
  static const showColorPickerKey = 'subject_form.show_color_picker';
  static const showIconPickerKey = 'subject_form.show_icon_picker';
  static const showCodeFieldKey = 'subject_form.show_code_field';
  static const showProfessorFieldKey = 'subject_form.show_professor_field';
  static const showClassroomFieldKey = 'subject_form.show_classroom_field';
  static const showCreditsFieldKey = 'subject_form.show_credits_field';
  static const showStatusSelectorKey = 'subject_form.show_status_selector';
  static const showPassingGradeKey = 'subject_form.show_passing_grade';
  static const showNotesFieldKey = 'subject_form.show_notes_field';

  final bool showColorPicker;
  final bool showIconPicker;
  final bool showCodeField;
  final bool showProfessorField;
  final bool showClassroomField;
  final bool showCreditsField;
  final bool showStatusSelector;
  final bool showPassingGrade;
  final bool showNotesField;

  SubjectFormPreferences copyWith({
    bool? showColorPicker,
    bool? showIconPicker,
    bool? showCodeField,
    bool? showProfessorField,
    bool? showClassroomField,
    bool? showCreditsField,
    bool? showStatusSelector,
    bool? showPassingGrade,
    bool? showNotesField,
  }) {
    return SubjectFormPreferences(
      showColorPicker: showColorPicker ?? this.showColorPicker,
      showIconPicker: showIconPicker ?? this.showIconPicker,
      showCodeField: showCodeField ?? this.showCodeField,
      showProfessorField: showProfessorField ?? this.showProfessorField,
      showClassroomField: showClassroomField ?? this.showClassroomField,
      showCreditsField: showCreditsField ?? this.showCreditsField,
      showStatusSelector: showStatusSelector ?? this.showStatusSelector,
      showPassingGrade: showPassingGrade ?? this.showPassingGrade,
      showNotesField: showNotesField ?? this.showNotesField,
    );
  }
}

class SubjectFormPreferencesController
    extends StateNotifier<SubjectFormPreferences> {
  SubjectFormPreferencesController() : super(SubjectFormPreferences.defaults) {
    _ready = _load();
  }

  late final Future<void> _ready;
  Future<void> _pendingSave = Future<void>.value();
  bool _hasLocalChanges = false;

  Future<void> get ready => _ready;

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_hasLocalChanges) return;

      state = SubjectFormPreferences(
        showColorPicker:
            prefs.getBool(SubjectFormPreferences.showColorPickerKey) ?? true,
        showIconPicker:
            prefs.getBool(SubjectFormPreferences.showIconPickerKey) ?? true,
        showCodeField:
            prefs.getBool(SubjectFormPreferences.showCodeFieldKey) ?? true,
        showProfessorField:
            prefs.getBool(SubjectFormPreferences.showProfessorFieldKey) ?? true,
        showClassroomField:
            prefs.getBool(SubjectFormPreferences.showClassroomFieldKey) ?? true,
        showCreditsField:
            prefs.getBool(SubjectFormPreferences.showCreditsFieldKey) ?? true,
        showStatusSelector:
            prefs.getBool(SubjectFormPreferences.showStatusSelectorKey) ?? true,
        showPassingGrade:
            prefs.getBool(SubjectFormPreferences.showPassingGradeKey) ?? true,
        showNotesField:
            prefs.getBool(SubjectFormPreferences.showNotesFieldKey) ?? true,
      );
    } catch (_) {
      // Keep safe defaults if local preferences are temporarily unavailable.
    }
  }

  Future<void> update({
    bool? showColorPicker,
    bool? showIconPicker,
    bool? showCodeField,
    bool? showProfessorField,
    bool? showClassroomField,
    bool? showCreditsField,
    bool? showStatusSelector,
    bool? showPassingGrade,
    bool? showNotesField,
  }) {
    _hasLocalChanges = true;
    state = state.copyWith(
      showColorPicker: showColorPicker,
      showIconPicker: showIconPicker,
      showCodeField: showCodeField,
      showProfessorField: showProfessorField,
      showClassroomField: showClassroomField,
      showCreditsField: showCreditsField,
      showStatusSelector: showStatusSelector,
      showPassingGrade: showPassingGrade,
      showNotesField: showNotesField,
    );

    // Serialize writes so rapid switch changes cannot save stale values last.
    _pendingSave = _pendingSave.then((_) async {
      await _ready;
      final snapshot = state;
      final prefs = await SharedPreferences.getInstance();
      await Future.wait<bool>([
        prefs.setBool(SubjectFormPreferences.showColorPickerKey, snapshot.showColorPicker),
        prefs.setBool(SubjectFormPreferences.showIconPickerKey, snapshot.showIconPicker),
        prefs.setBool(SubjectFormPreferences.showCodeFieldKey, snapshot.showCodeField),
        prefs.setBool(SubjectFormPreferences.showProfessorFieldKey, snapshot.showProfessorField),
        prefs.setBool(SubjectFormPreferences.showClassroomFieldKey, snapshot.showClassroomField),
        prefs.setBool(SubjectFormPreferences.showCreditsFieldKey, snapshot.showCreditsField),
        prefs.setBool(SubjectFormPreferences.showStatusSelectorKey, snapshot.showStatusSelector),
        prefs.setBool(SubjectFormPreferences.showPassingGradeKey, snapshot.showPassingGrade),
        prefs.setBool(SubjectFormPreferences.showNotesFieldKey, snapshot.showNotesField),
      ]);
    });
    return _pendingSave;
  }
}

final subjectFormPreferencesProvider = StateNotifierProvider<
    SubjectFormPreferencesController, SubjectFormPreferences>(
  (ref) => SubjectFormPreferencesController(),
);
