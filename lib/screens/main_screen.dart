import 'package:flutter/material.dart';
import 'package:lab2261/components/main_app_bar.dart';
import 'package:lab2261/components/main_floating_button.dart';
import 'package:lab2261/pages/playlist_page.dart';
import 'package:lab2261/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<String> _titles = ['Profile', 'Playlists'];
  final List<String> _buttonText = ['Editar', 'Crear'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MainAppBar(title: _titles[_currentIndex]),
      body: IndexedStack(
        index: _currentIndex,
        children: const [ProfilePage(), PlaylistPage()],
      ),
      floatingActionButton: MainFloatingButton(
        text: _buttonText[_currentIndex],
        onPressed: () {
          Navigator.pushNamed(context, '/playlist/new');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_outlined),
            label: 'Playlists',
          ),
        ],
      ),
    );
  }
}
