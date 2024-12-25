import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          dividerColor: Colors.white24,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 31, 31, 31),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          listTileTheme: const ListTileThemeData(iconColor: Colors.white),
          textTheme: TextTheme(
            bodyMedium: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
            labelSmall: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontWeight: FontWeight.w700,
                fontSize: 14),
          )),
      routes: {
        "/": (context) => CryptoListScreen(title: 'Crypto Logic'),
        "/coin": (context) => CryptoCoinScreen()
      },
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});
  final String title;
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, i) => Divider(
          color: theme.dividerColor,
        ),
        itemBuilder: (context, i) {
          const coinName = "Bitcoin";
          return ListTile(
            leading: SvgPicture.asset(
              "assets/svg/bitcoin-logo.svg",
              height: 35,
              width: 35,
            ),
            title: Text(coinName, style: theme.textTheme.bodyMedium),
            subtitle: Text("100 000\$", style: theme.textTheme.labelSmall),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/coin", arguments: coinName);
            },
          );
        },
      ),
    );
  }
}

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, "Ошибка, не передали arguments");
    coinName = args as String;
    setState(() {});
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? "..."),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
    );
  }
}
