import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart';
import 'screens/portfolio_page.dart';
import 'screens/form_page.dart';
import 'screens/polije_page.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  void _goTo(int i) => setState(() => currentIndex = i);

  Widget _currentPage() {
    switch (currentIndex) {
      case 0:
        return HomePage(onNavigate: _goTo);
      case 1:
        return const ProfilePage();
      case 2:
        return const PortfolioPage();
      case 3:
        return FormPage(onSaved: () => _goTo(2));
      default:
        return const PolijePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xff6C63FF),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _goTo,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Portfolio"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Tambah"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "POLIJE"),
        ],
      ),
    );
  }
}