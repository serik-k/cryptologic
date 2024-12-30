import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;
  Map<String, dynamic>? coinData;
  bool isLoading = true;
  bool isFirstLoad = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstLoad) {
      final args = ModalRoute.of(context)?.settings.arguments;
      assert(args != null && args is String, "Ошибка, не передали arguments");
      coinName = args as String;
      fetchCoinData(coinName!);
      isFirstLoad = false;
    }
  }

  Future<void> fetchCoinData(String coin) async {
    const apiKey =
        '0885a14d418a03c75df92f830d1019f51d4f69aec4c256d65d6122c69239e1b3';
    final url =
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$coin&tsyms=USD';

    try {
      final dio = Dio();
      final response = await dio.get(
        url,
        options: Options(headers: {'authorization': 'Apikey $apiKey'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final displayData = response.data['DISPLAY'];
        if (displayData != null && displayData[coin] != null) {
          setState(() {
            coinData = displayData[coin]['USD'];
            isLoading = false;
          });
        } else {
          throw Exception('Данные монеты отсутствуют');
        }
      } else {
        throw Exception('Ошибка загрузки данных');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = coinData?['IMAGEURL'] != null
        ? 'https://www.cryptocompare.com${coinData!['IMAGEURL']}'
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? "Loading..."),
        backgroundColor: Colors.black87,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : coinData != null
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.grey[900],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (imageUrl != null)
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(imageUrl),
                            ),
                          const SizedBox(height: 20),
                          Text(
                            coinName ?? "",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Divider(
                            height: 30,
                            thickness: 1.5,
                            color: Colors.grey,
                          ),
                          InfoRow(
                            label: "Цена",
                            value: coinData!['PRICE'] ?? 'N/A',
                          ),
                          InfoRow(
                            label: "24ч изменение",
                            value: coinData!['CHANGE24HOUR'] ?? 'N/A',
                          ),
                          InfoRow(
                            label: "Объём за 24ч",
                            value: coinData!['VOLUME24HOURTO'] ?? 'N/A',
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => fetchCoinData(coinName!),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text("Обновить данные"),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'Нет данных для отображения',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
      backgroundColor: Colors.black,
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.grey[400], fontSize: 16),
          ),
        ],
      ),
    );
  }
}
