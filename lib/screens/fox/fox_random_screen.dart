import 'package:flutter/material.dart';
import '../../../screens/fox/services/fox_api_service.dart';
import '../../../screens/fox/models/fox_model.dart';

class FoxRandomScreen extends StatefulWidget {
  const FoxRandomScreen({super.key});

  @override
  State<FoxRandomScreen> createState() => _FoxRandomScreenState();
}

class _FoxRandomScreenState extends State<FoxRandomScreen> {
  final _service = FoxApiService();
  late Future<FoxModel> _foxFuture;

  @override
  void initState() {
    super.initState();
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
        child: Column(
          children: [
            // Nửa trên: ảnh cáo
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<FoxModel>(
                  future: _foxFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Lỗi: ${snapshot.error}', textAlign: TextAlign.center),
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
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (_, __, ___) => const Center(child: Text('Không thể hiển thị ảnh')),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Nửa dưới: nút Làm mới
            Expanded(
              flex: 4,
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Làm mới'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
