class ReaderSample {
  const ReaderSample({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.sectionTitle,
    required this.paragraphs,
    this.canBeSaved = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String sectionTitle;
  final List<String> paragraphs;
  final bool canBeSaved;
}

const readerSampleCatalog = <ReaderSample>[
  ReaderSample(
    id: 'first-door',
    title: 'The First Door',
    subtitle: 'Local reading sample',
    description: 'Open and save the built-in local sample.',
    sectionTitle: 'InfinityWorld sample',
    canBeSaved: true,
    paragraphs: [
      'InfinityWorld sample: the first door opened quietly, not with a flash, but with the small certainty that a useful place had finally found its shape.',
      'Inside was a calm room of notes, stories, and saved ideas. Nothing asked to be synced, imported, ranked, or organized yet. It only needed to be readable.',
      'The reader will grow later when the Library earns persistence, bookmarks, and progress. For now, this sample proves the surface can hold text with the same care as the rest of the app.',
    ],
  ),
  ReaderSample(
    id: 'focus-reset',
    title: 'Focus Reset',
    subtitle: 'Short local note',
    description: 'A calm reset for clearing mental tabs before the next task.',
    sectionTitle: 'Three-minute reset',
    paragraphs: [
      'Close the noisy loops first: write the loose tasks down, name the next action, then stop carrying them in memory.',
      'A small system works best when it stays visible. Put the next useful step where you can see it, and move everything else out of the way.',
      'Focus is not a dramatic mode switch. It is one quiet decision repeated until the room starts to feel simple again.',
    ],
  ),
  ReaderSample(
    id: 'night-market-notes',
    title: 'Night Market Notes',
    subtitle: 'Story-style sample',
    description: 'A compact story sample for a slightly longer reading rhythm.',
    sectionTitle: 'After the rain',
    paragraphs: [
      'The night market opened after the rain, all bright signs and wet pavement, each stall reflecting a different color into the street.',
      'Minh followed the warm smell of grilled corn past the book cart, where old paperbacks leaned under a plastic sheet and waited for patient hands.',
      'He bought one with a cracked spine, not because it was rare, but because the first page made the city feel a little wider than it had that morning.',
    ],
  ),
];

ReaderSample readerSampleById(String? id) {
  for (final sample in readerSampleCatalog) {
    if (sample.id == id) {
      return sample;
    }
  }

  return readerSampleCatalog.first;
}
