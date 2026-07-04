import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_world/features/reader/application/reader_saved_sample_provider.dart';
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

    expect(await container.read(readerSavedSampleProvider.future), isFalse);
  });

  test('reader saved sample provider persists save and remove', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(readerSavedSampleProvider.future);
    await container.read(readerSavedSampleProvider.notifier).saveSample();

    expect(await container.read(readerSavedSampleProvider.future), isTrue);
    expect(await ReaderSavedSampleRepository().isSampleSaved(), isTrue);

    await container.read(readerSavedSampleProvider.notifier).removeSample();

    expect(await container.read(readerSavedSampleProvider.future), isFalse);
    expect(await ReaderSavedSampleRepository().isSampleSaved(), isFalse);
  });
}
