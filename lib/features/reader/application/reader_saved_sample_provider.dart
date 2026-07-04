import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final readerSavedSampleRepositoryProvider =
    Provider<ReaderSavedSampleRepository>((ref) {
      return ReaderSavedSampleRepository();
    });

final readerSavedSampleProvider =
    AsyncNotifierProvider<ReaderSavedSampleController, bool>(
      ReaderSavedSampleController.new,
    );

class ReaderSavedSampleController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() {
    return ref.watch(readerSavedSampleRepositoryProvider).isSampleSaved();
  }

  Future<void> saveSample() async {
    await ref.read(readerSavedSampleRepositoryProvider).saveSample();
    state = const AsyncData(true);
  }

  Future<void> removeSample() async {
    await ref.read(readerSavedSampleRepositoryProvider).removeSample();
    state = const AsyncData(false);
  }
}

class ReaderSavedSampleRepository {
  ReaderSavedSampleRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String savedSampleKey = 'iw_reader_sample_saved';

  final SharedPreferencesAsync _preferences;

  Future<bool> isSampleSaved() async {
    return await _preferences.getBool(savedSampleKey) ?? false;
  }

  Future<void> saveSample() async {
    await _preferences.setBool(savedSampleKey, true);
  }

  Future<void> removeSample() async {
    await _preferences.remove(savedSampleKey);
  }
}
