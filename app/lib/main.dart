import 'package:flutter/material.dart';
import 'shared/widgets/collapsible_sidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 29, 29, 29),
        body: Row(
          children: [
            CollapsibleSidebar(
              items: const [
                SidebarItem(id: '3', title: 'Folder-1', type: SidebarItemType.folder),
                SidebarItem(id: '4', title: 'Folder-2', type: SidebarItemType.folder),
                SidebarItem(id: '1', title: 'chat-1', type: SidebarItemType.conversation),
                SidebarItem(id: '2', title: 'chat-2', type: SidebarItemType.conversation),
              ],
              onItemTap: (item) => debugPrint('Clicou em ${item.title}'),
            ),
            const Expanded(
              child: Center(child: Text('Hello World!')),
            ),
          ],
        ),
      ),
    );
  }
}