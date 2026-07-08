import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_world/features/reader/application/reader_saved_sample_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() {
    SharedPreferencesAsyncPlatform.instance = null;
  });

  test('reader saved sample provider defaults to not saved', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(await container.read(readerSavedSampleProvider.future), isEmpty);
  });

  test('reader saved sample provider persists selected sample ids', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(readerSavedSampleProvider.future);
    await container
        .read(readerSavedSampleProvider.notifier)
        .saveSample('focus-reset');

    expect(await container.read(readerSavedSampleProvider.future), {
      'focus-reset',
    });
    expect(
      await ReaderSavedSampleRepository().isSampleSaved('focus-reset'),
      isTrue,
    );
    expect(await ReaderSavedSampleRepository().isSampleSaved(), isFalse);

    await container.read(readerSavedSampleProvider.notifier).saveSample();

    expect(await container.read(readerSavedSampleProvider.future), {
      'first-door',
      'focus-reset',
    });

    await container
        .read(readerSavedSampleProvider.notifier)
        .removeSample('focus-reset');

    expect(await container.read(readerSavedSampleProvider.future), {
      'first-door',
    });
    expect(
      await ReaderSavedSampleRepository().isSampleSaved('focus-reset'),
      isFalse,
    );
    expect(await ReaderSavedSampleRepository().isSampleSaved(), isTrue);
  });

  test(
    'reader saved sample repository reads the legacy saved boolean',
    () async {
      await SharedPreferencesAsync().setBool(
        ReaderSavedSampleRepository.legacySavedSampleKey,
        true,
      );

      expect(await ReaderSavedSampleRepository().loadSavedSampleIds(), {
        'first-door',
      });
      expect(await ReaderSavedSampleRepository().isSampleSaved(), isTrue);
    },
  );

  test('reader last opened sample provider defaults to no sample', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(await container.read(readerLastOpenedSampleProvider.future), isNull);
  });

  test(
    'reader last opened sample provider persists selected sample id',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(readerLastOpenedSampleProvider.future);
      await container
          .read(readerLastOpenedSampleProvider.notifier)
          .recordSample('focus-reset');

      expect(
        await container.read(readerLastOpenedSampleProvider.future),
        'focus-reset',
      );
      expect(
        await ReaderLastOpenedSampleRepository().loadLastOpenedSampleId(),
        'focus-reset',
      );
    },
  );

  test(
    'reader last opened sample repository ignores unknown sample ids',
    () async {
      final repository = ReaderLastOpenedSampleRepository();

      await repository.saveLastOpenedSampleId('unknown-sample');

      expect(await repository.loadLastOpenedSampleId(), isNull);
    },
  );

  test(
    'reader finished sample provider defaults to no finished samples',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        await container.read(readerFinishedSampleProvider.future),
        isEmpty,
      );
    },
  );

  test(
    'reader finished sample provider persists selected sample ids',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(readerFinishedSampleProvider.future);
      await container
          .read(readerFinishedSampleProvider.notifier)
          .markFinished('focus-reset');

      expect(await container.read(readerFinishedSampleProvider.future), {
        'focus-reset',
      });
      expect(
        await ReaderFinishedSampleRepository().isSampleFinished('focus-reset'),
        isTrue,
      );
      expect(
        await ReaderFinishedSampleRepository().isSampleFinished(),
        isFalse,
      );

      await container
          .read(readerFinishedSampleProvider.notifier)
          .markFinished();

      expect(await container.read(readerFinishedSampleProvider.future), {
        'first-door',
        'focus-reset',
      });

      await container
          .read(readerFinishedSampleProvider.notifier)
          .markUnfinished('focus-reset');

      expect(await container.read(readerFinishedSampleProvider.future), {
        'first-door',
      });
      expect(
        await ReaderFinishedSampleRepository().isSampleFinished('focus-reset'),
        isFalse,
      );
      expect(await ReaderFinishedSampleRepository().isSampleFinished(), isTrue);
    },
  );

  test(
    'reader finished sample repository ignores unknown persisted sample ids',
    () async {
      await SharedPreferencesAsync().setStringList(
        ReaderFinishedSampleRepository.finishedSampleIdsKey,
        ['unknown-sample', 'focus-reset'],
      );

      expect(await ReaderFinishedSampleRepository().loadFinishedSampleIds(), {
        'focus-reset',
      });
    },
  );

  test('reader paragraph bookmark provider defaults to no bookmarks', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      await container.read(readerParagraphBookmarkProvider.future),
      isEmpty,
    );
  });

  test(
    'reader paragraph bookmark provider persists one slot per sample',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(readerParagraphBookmarkProvider.future);
      await container
          .read(readerParagraphBookmarkProvider.notifier)
          .bookmarkParagraph('focus-reset', 1);

      expect(await container.read(readerParagraphBookmarkProvider.future), {
        'focus-reset': 1,
      });
      expect(
        await ReaderParagraphBookmarkRepository().loadBookmarkForSample(
          'focus-reset',
        ),
        1,
      );

      await container
          .read(readerParagraphBookmarkProvider.notifier)
          .bookmarkParagraph('focus-reset', 2);

      expect(await container.read(readerParagraphBookmarkProvider.future), {
        'focus-reset': 2,
      });

      await container
          .read(readerParagraphBookmarkProvider.notifier)
          .removeBookmark('focus-reset');

      expect(
        await container.read(readerParagraphBookmarkProvider.future),
        isNot(contains('focus-reset')),
      );
      expect(
        await ReaderParagraphBookmarkRepository().loadBookmarkForSample(
          'focus-reset',
        ),
        isNull,
      );
    },
  );

  test(
    'reader paragraph bookmark repository ignores invalid persisted entries',
    () async {
      await SharedPreferencesAsync().setStringList(
        ReaderParagraphBookmarkRepository.paragraphBookmarkKey,
        [
          'unknown-sample:0',
          'focus-reset:99',
          'focus-reset:1',
          'broken',
          'first-door:not-number',
        ],
      );

      expect(
        await ReaderParagraphBookmarkRepository().loadParagraphBookmarks(),
        {'focus-reset': 1},
      );
    },
  );
}
