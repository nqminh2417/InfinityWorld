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
}
