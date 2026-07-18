import 'package:flutter/material.dart';

enum SidebarItemType { conversation, folder }

class SidebarItem {
  final String id;
  final String title;
  final SidebarItemType type;

  const SidebarItem({
    required this.id,
    required this.title,
    required this.type,
  });
}

class CollapsibleSidebar extends StatefulWidget {
  final List<SidebarItem> items;
  final ValueChanged<SidebarItem>? onItemTap;
  final double expandedWidth;
  final double collapsedWidth;
  final Widget Function(bool collapsed)? footerBuilder;

  const CollapsibleSidebar({
    super.key,
    required this.items,
    this.onItemTap,
    this.expandedWidth = 240,
    this.collapsedWidth = 64,
    this.footerBuilder,
  });

  @override
  State<CollapsibleSidebar> createState() => _CollapsibleSidebarState();
}

class _CollapsibleSidebarState extends State<CollapsibleSidebar> {
  bool _collapsed = false;

  IconData _iconFor(SidebarItemType type) {
    switch (type) {
      case SidebarItemType.conversation:
        return Icons.chat_bubble_outline;
      case SidebarItemType.folder:
        return Icons.folder_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = _collapsed ? widget.collapsedWidth : widget.expandedWidth;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: width,
      color: const Color(0xFF2B2B2B),
      child: Column(
        children: [
          // Botão de recolher/expandir
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                _collapsed ? Icons.chevron_right : Icons.chevron_left,
                color: Colors.white70,
              ),
              onPressed: () => setState(() => _collapsed = !_collapsed),
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return _SidebarTile(
                  item: item,
                  collapsed: _collapsed,
                  icon: _iconFor(item.type),
                  onTap: () => widget.onItemTap?.call(item),
                );
              },
            ),
          ),
          if (widget.footerBuilder != null) ...[
            const Divider(color: Colors.white24, height: 1),
            widget.footerBuilder!(_collapsed),
          ],
        ],
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  final SidebarItem item;
  final bool collapsed;
  final IconData icon;
  final VoidCallback? onTap;

  const _SidebarTile({
    required this.item,
    required this.collapsed,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: [
        SizedBox(
          width: collapsed ? 64 : 40,
          child: Icon(icon, color: Colors.white70, size: 20),
        ),
        if (!collapsed)
          Expanded(
            child: Text(
              item.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
      ],
    );

    final content = InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: row,
      ),
    );

    // Tooltip prévia assunto
    if (collapsed) {
      return Tooltip(
        message: item.title,
        preferBelow: false,
        verticalOffset: 12,
        waitDuration: const Duration(milliseconds: 300),
        child: content,
      );
    }

    return content;
  }
}