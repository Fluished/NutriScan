import 'package:flutter/material.dart';
import 'package:nutriscan/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Image.asset("assets/home_screen_asset.png", height: ScreenUtils.imageHeightHalf(context)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                shape: StadiumBorder(),
              ),
              child: const Text("Start Scan", style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.history, size: 18),
                  SizedBox(width: 6),
                  Text("Recent Scans", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: scanItems.length,
                itemBuilder: (context, index) {
                  final item = scanItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text("Barcode #: ${item.barcode}"),
                      subtitle: Text("Product: ${item.product} | Date: ${item.date} | Price: ${item.price}"),
                      trailing: Text(
                        item.isSafe ? "Safe" : "Not Safe",
                        style: TextStyle(
                          color: item.isSafe ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        controller: MobileScannerController(
          facing: CameraFacing.back,
        ),
        onDetect: (capture) {
          final barcode = capture.barcodes.first;
          final value = barcode.rawValue ?? "---";

          // You can also use Navigator.pop(context, value); to return result
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Scanned: $value')),
          );
        },
      ),
    );
  }
}
