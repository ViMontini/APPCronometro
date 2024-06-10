import 'package:flutter/material.dart';
import 'cronometro_page.dart';
import 'timer_page.dart';
import 'local_clock_page.dart'; // Importando a nova página

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          TimerPage(),
          TimerScreen(),
          LocalClockPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Cor dos ícones selecionados
        unselectedItemColor: Colors.grey, // Cor dos ícones não selecionados
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined), // Ícone de relógio para representar o cronômetro
            label: 'Cronômetro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_top), // Ícone de relógio com uma seta para representar o timer
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time), // Ícone do relógio para o horário local
            label: 'Horário Local',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
