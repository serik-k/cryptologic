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
      home: const MyHomePage(title: 'Crypto Logic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(widget.title),
      ),
      body: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, i) => Divider(
                color: theme.dividerColor,
              ),
          itemBuilder: (context, i) => ListTile(
                leading: SvgPicture.asset(
                  "assets/svg/bitcoin-logo.svg",
                  height: 35,
                  width: 35,
                ),
                title: Text("Bitcoin", style: theme.textTheme.bodyMedium),
                subtitle: Text("100 000\$", style: theme.textTheme.labelSmall),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              )),
    );
  }
}
