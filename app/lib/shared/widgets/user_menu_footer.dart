import 'package:flutter/material.dart';

enum UserMenuAction {
  theme,
  language,
  settings,
  help,
  plugins,
  logout,
}

class UserMenuFooter extends StatefulWidget {
  final String userName;
  final bool collapsed;
  final ValueChanged<UserMenuAction> onSelected;

  const UserMenuFooter({
    super.key,
    this.userName = 'User',
    required this.onSelected,
    this.collapsed = false,
  });

  @override
  State<UserMenuFooter> createState() => _UserMenuFooterState();
}

class _UserMenuFooterState extends State<UserMenuFooter> {
  bool _menuOpen = false;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<UserMenuAction>(
      color: const Color(0xFF2B2B2B),
      offset: const Offset(0, -325),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.white12),
      ),
      onOpened: () => setState(() => _menuOpen = true),
      onCanceled: () => setState(() => _menuOpen = false),
      onSelected: (action) {
        setState(() => _menuOpen = false);
        widget.onSelected(action);
      },
      itemBuilder: (context) => [
        _header(),
        const PopupMenuDivider(),
        _item(UserMenuAction.theme, Icons.palette_outlined, 'Temas'),
        _item(UserMenuAction.language, Icons.language_outlined, 'Idioma', hasArrow: true),
        _item(UserMenuAction.help, Icons.help_outline, 'Ajuda'),
        const PopupMenuDivider(),
        _item(UserMenuAction.plugins, Icons.extension_outlined, 'Plugins'),
        _item(UserMenuAction.settings, Icons.settings_outlined, 'Configurações'),
        const PopupMenuDivider(),
        _item(UserMenuAction.logout, Icons.logout, 'Sair'),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white12,
              child: Icon(Icons.person, size: 18, color: Colors.white54),
            ),
            if (!widget.collapsed) ...[
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.userName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              Icon(
                _menuOpen ? Icons.expand_less : Icons.expand_more,
                size: 16,
                color: Colors.white38,
              ),
            ],
          ],
        ),
      ),
    );
  }

  PopupMenuItem<UserMenuAction> _header() {
    return PopupMenuItem<UserMenuAction>(
      enabled: false,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white12,
              child: Icon(Icons.person, size: 16, color: Colors.white54),
            ),
            const SizedBox(width: 6),
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<UserMenuAction> _item(
    UserMenuAction action,
    IconData icon,
    String label, {
    String? trailing,
    bool hasArrow = false,
  }) {
    return PopupMenuItem<UserMenuAction>(
      value: action,
      height: 36,
      child: Row(
        children: [
          Icon(icon, size: 17, color: Colors.white70),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
          if (trailing != null)
            Text(trailing, style: const TextStyle(color: Colors.white38, fontSize: 11)),
          if (hasArrow)
            const Icon(Icons.chevron_right, size: 16, color: Colors.white38),
        ],
      ),
    );
  }
}