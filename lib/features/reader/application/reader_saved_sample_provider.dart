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

final readerLastOpenedSampleRepositoryProvider =
    Provider<ReaderLastOpenedSampleRepository>((ref) {
      return ReaderLastOpenedSampleRepository();
    });

final readerLastOpenedSampleProvider =
    AsyncNotifierProvider<ReaderLastOpenedSampleController, String?>(
      ReaderLastOpenedSampleController.new,
    );

final readerFinishedSampleRepositoryProvider =
    Provider<ReaderFinishedSampleRepository>((ref) {
      return ReaderFinishedSampleRepository();
    });

final readerFinishedSampleProvider =
    AsyncNotifierProvider<ReaderFinishedSampleController, Set<String>>(
      ReaderFinishedSampleController.new,
    );

final readerParagraphBookmarkRepositoryProvider =
    Provider<ReaderParagraphBookmarkRepository>((ref) {
      return ReaderParagraphBookmarkRepository();
    });

final readerParagraphBookmarkProvider =
    AsyncNotifierProvider<ReaderParagraphBookmarkController, Map<String, int>>(
      ReaderParagraphBookmarkController.new,
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

class ReaderFinishedSampleController extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() {
    return ref
        .watch(readerFinishedSampleRepositoryProvider)
        .loadFinishedSampleIds();
  }

  Future<void> markFinished([String sampleId = defaultReaderSampleId]) async {
    final finishedIds = await ref
        .read(readerFinishedSampleRepositoryProvider)
        .markFinished(sampleId);
    state = AsyncData(finishedIds);
  }

  Future<void> markUnfinished([String sampleId = defaultReaderSampleId]) async {
    final finishedIds = await ref
        .read(readerFinishedSampleRepositoryProvider)
        .markUnfinished(sampleId);
    state = AsyncData(finishedIds);
  }
}

class ReaderFinishedSampleRepository {
  ReaderFinishedSampleRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String finishedSampleIdsKey = 'iw_reader_finished_sample_ids';

  final SharedPreferencesAsync _preferences;

  Future<Set<String>> loadFinishedSampleIds() async {
    final finishedIds =
        await _preferences.getStringList(finishedSampleIdsKey) ?? <String>[];
    return finishedIds.where(_isKnownSampleId).toSet();
  }

  Future<bool> isSampleFinished([
    String sampleId = defaultReaderSampleId,
  ]) async {
    return (await loadFinishedSampleIds()).contains(sampleId);
  }

  Future<Set<String>> markFinished([
    String sampleId = defaultReaderSampleId,
  ]) async {
    final finishedIds = await loadFinishedSampleIds();
    if (!_isKnownSampleId(sampleId)) {
      return finishedIds;
    }

    final nextIds = {...finishedIds, sampleId};
    await _saveFinishedSampleIds(nextIds);
    return nextIds;
  }

  Future<Set<String>> markUnfinished([
    String sampleId = defaultReaderSampleId,
  ]) async {
    final finishedIds = await loadFinishedSampleIds();
    final nextIds = {...finishedIds}..remove(sampleId);
    await _saveFinishedSampleIds(nextIds);
    return nextIds;
  }

  Future<void> _saveFinishedSampleIds(Set<String> sampleIds) async {
    final sortedIds = sampleIds.toList()..sort();
    await _preferences.setStringList(finishedSampleIdsKey, sortedIds);
  }

  bool _isKnownSampleId(String sampleId) {
    return readerSampleCatalog.any((sample) => sample.id == sampleId);
  }
}

class ReaderParagraphBookmarkController
    extends AsyncNotifier<Map<String, int>> {
  @override
  Future<Map<String, int>> build() {
    return ref
        .watch(readerParagraphBookmarkRepositoryProvider)
        .loadParagraphBookmarks();
  }

  Future<void> bookmarkParagraph(String sampleId, int paragraphIndex) async {
    final bookmarks = await ref
        .read(readerParagraphBookmarkRepositoryProvider)
        .bookmarkParagraph(sampleId, paragraphIndex);
    state = AsyncData(bookmarks);
  }

  Future<void> removeBookmark(String sampleId) async {
    final bookmarks = await ref
        .read(readerParagraphBookmarkRepositoryProvider)
        .removeBookmark(sampleId);
    state = AsyncData(bookmarks);
  }
}

class ReaderParagraphBookmarkRepository {
  ReaderParagraphBookmarkRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String paragraphBookmarkKey = 'iw_reader_paragraph_bookmarks';

  final SharedPreferencesAsync _preferences;

  Future<Map<String, int>> loadParagraphBookmarks() async {
    final values =
        await _preferences.getStringList(paragraphBookmarkKey) ?? <String>[];
    final bookmarks = <String, int>{};

    for (final value in values) {
      final separator = value.lastIndexOf(':');
      if (separator <= 0 || separator == value.length - 1) {
        continue;
      }

      final sampleId = value.substring(0, separator);
      final paragraphIndex = int.tryParse(value.substring(separator + 1));
      if (paragraphIndex == null ||
          !_isValidBookmark(sampleId, paragraphIndex)) {
        continue;
      }

      bookmarks[sampleId] = paragraphIndex;
    }

    return bookmarks;
  }

  Future<int?> loadBookmarkForSample(String sampleId) async {
    return (await loadParagraphBookmarks())[sampleId];
  }

  Future<Map<String, int>> bookmarkParagraph(
    String sampleId,
    int paragraphIndex,
  ) async {
    final bookmarks = await loadParagraphBookmarks();
    if (!_isValidBookmark(sampleId, paragraphIndex)) {
      return bookmarks;
    }

    final nextBookmarks = {...bookmarks, sampleId: paragraphIndex};
    await _saveParagraphBookmarks(nextBookmarks);
    return nextBookmarks;
  }

  Future<Map<String, int>> removeBookmark(String sampleId) async {
    final bookmarks = await loadParagraphBookmarks();
    final nextBookmarks = {...bookmarks}..remove(sampleId);
    await _saveParagraphBookmarks(nextBookmarks);
    return nextBookmarks;
  }

  Future<void> _saveParagraphBookmarks(Map<String, int> bookmarks) async {
    final sortedEntries =
        bookmarks.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    await _preferences.setStringList(paragraphBookmarkKey, [
      for (final entry in sortedEntries) '${entry.key}:${entry.value}',
    ]);
  }

  bool _isValidBookmark(String sampleId, int paragraphIndex) {
    for (final sample in readerSampleCatalog) {
      if (sample.id == sampleId) {
        return paragraphIndex >= 0 && paragraphIndex < sample.paragraphs.length;
      }
    }

    return false;
  }
}

class ReaderLastOpenedSampleController extends AsyncNotifier<String?> {
  @override
  Future<String?> build() {
    return ref
        .watch(readerLastOpenedSampleRepositoryProvider)
        .loadLastOpenedSampleId();
  }

  Future<void> recordSample(String sampleId) async {
    await ref
        .read(readerLastOpenedSampleRepositoryProvider)
        .saveLastOpenedSampleId(sampleId);
    state = AsyncData(sampleId);
  }
}

class ReaderLastOpenedSampleRepository {
  ReaderLastOpenedSampleRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String lastOpenedSampleIdKey = 'iw_reader_last_opened_sample_id';

  final SharedPreferencesAsync _preferences;

  Future<String?> loadLastOpenedSampleId() async {
    final sampleId = await _preferences.getString(lastOpenedSampleIdKey);
    if (_isKnownSampleId(sampleId)) {
      return sampleId;
    }

    return null;
  }

  Future<void> saveLastOpenedSampleId(String sampleId) async {
    if (!_isKnownSampleId(sampleId)) {
      return;
    }

    await _preferences.setString(lastOpenedSampleIdKey, sampleId);
  }

  bool _isKnownSampleId(String? sampleId) {
    return readerSampleCatalog.any((sample) => sample.id == sampleId);
  }
}
