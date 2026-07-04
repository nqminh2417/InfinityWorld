import 'package:flutter/material.dart';

import '../data/fox_api_service.dart';
import '../domain/fox_model.dart';

class FoxRandomScreen extends StatefulWidget {
  const FoxRandomScreen({super.key, FoxApiService? service})
    : _service = service;

  final FoxApiService? _service;

  @override
  State<FoxRandomScreen> createState() => _FoxRandomScreenState();
}

class _FoxRandomScreenState extends State<FoxRandomScreen> {
  late final FoxApiService _service;
  late Future<FoxModel> _foxFuture;

  @override
  void initState() {
    super.initState();
    _service = widget._service ?? FoxApiService();
    _foxFuture = _service.getRandomFox();
  }

  void _refresh() {
    setState(() {
      _foxFuture = _service.getRandomFox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Fox'), centerTitle: true),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageHeight =
                (constraints.maxHeight * 0.62).clamp(220.0, 420.0).toDouble();
            final minContentHeight =
                constraints.maxHeight > 32 ? constraints.maxHeight - 32 : 0.0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minContentHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: imageHeight,
                      width: double.infinity,
                      child: FutureBuilder<FoxModel>(
                        future: _foxFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Lỗi: ${snapshot.error}',
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  OutlinedButton.icon(
                                    onPressed: _refresh,
                                    icon: const Icon(Icons.refresh),
                                    label: const Text('Thử lại'),
                                  ),
                                ],
                              ),
                            );
                          }

                          final fox = snapshot.data!;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: InteractiveViewer(
                              maxScale: 4,
                              minScale: 0.5,
                              child: Image.network(
                                fox.image,
                                key: ValueKey(fox.image),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder:
                                    (_, __, ___) => const Center(
                                      child: Text('Không thể hiển thị ảnh'),
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _refresh,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Làm mới'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
