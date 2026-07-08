import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_world/features/reader/domain/reader_sample.dart';
import 'package:shared_preferences/shared_preferences.dart';

final readerSavedSampleRepositoryProvider =
    Provider<ReaderSavedSampleRepository>((ref) {
      return ReaderSavedSampleRepository();
    });

final readerSavedSampleProvider =
    AsyncNotifierProvider<ReaderSavedSampleController, Set<String>>(
      ReaderSavedSampleController.new,
    );

class ReaderSavedSampleController extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() {
    return ref.watch(readerSavedSampleRepositoryProvider).loadSavedSampleIds();
  }

  Future<void> saveSample([String sampleId = defaultReaderSampleId]) async {
    final savedIds = await ref
        .read(readerSavedSampleRepositoryProvider)
        .saveSample(sampleId);
    state = AsyncData(savedIds);
  }

  Future<void> removeSample([String sampleId = defaultReaderSampleId]) async {
    final savedIds = await ref
        .read(readerSavedSampleRepositoryProvider)
        .removeSample(sampleId);
    state = AsyncData(savedIds);
  }
}

class ReaderSavedSampleRepository {
  ReaderSavedSampleRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String legacySavedSampleKey = 'iw_reader_sample_saved';
  static const String savedSampleIdsKey = 'iw_reader_saved_sample_ids';

  final SharedPreferencesAsync _preferences;

  Future<Set<String>> loadSavedSampleIds() async {
    final savedIds = await _preferences.getStringList(savedSampleIdsKey);
    if (savedIds != null) {
      return savedIds.toSet();
    }

    final legacySaved =
        await _preferences.getBool(legacySavedSampleKey) ?? false;
    return legacySaved ? {defaultReaderSampleId} : <String>{};
  }

  Future<bool> isSampleSaved([String sampleId = defaultReaderSampleId]) async {
    return (await loadSavedSampleIds()).contains(sampleId);
  }

  Future<Set<String>> saveSample([
    String sampleId = defaultReaderSampleId,
  ]) async {
    final savedIds = await loadSavedSampleIds();
    final nextIds = {...savedIds, sampleId};
    await _saveSavedSampleIds(nextIds);
    return nextIds;
  }

  Future<Set<String>> removeSample([
    String sampleId = defaultReaderSampleId,
  ]) async {
    final savedIds = await loadSavedSampleIds();
    final nextIds = {...savedIds}..remove(sampleId);
    await _saveSavedSampleIds(nextIds);
    return nextIds;
  }

  Future<void> _saveSavedSampleIds(Set<String> sampleIds) async {
    final sortedIds = sampleIds.toList()..sort();
    await _preferences.setStringList(savedSampleIdsKey, sortedIds);
    await _preferences.remove(legacySavedSampleKey);
  }
}
