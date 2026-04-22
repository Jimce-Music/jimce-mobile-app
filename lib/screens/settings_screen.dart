import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jimce/screens/onboarding/onboarding_screen.dart';
import 'package:jimce/gen_l10n/app_localizations.dart';
import 'package:jimce/utils/init_api.dart';

enum _SettingsSection {
  account,
  design,
  language,
  autoplay,
  crossfade,
  downloads,
  aboutJimce,
  help,
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isNewPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _autoplayEnabled = false;
  double _crossfadeSeconds = 0;
  _SettingsSection _selectedSection = _SettingsSection.account;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetApp(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Löscht alle gespeicherten Daten (Onboarding-Status, Server-URL, etc.)
    await prefs.clear();
    await resetApiToDefault();

    if (!context.mounted) return;

    // Schickt den Nutzer zurück zum Anfang und löscht den gesamten Navigations-Stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      (route) => false,
    );
  }

  void _showResetDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(l10n.resetAppTitle, style: const TextStyle(color: Colors.white)),
        content: Text(
          l10n.resetAppMessage,
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetApp(context);
            },
            child: Text(l10n.reset, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _sectionLabel(AppLocalizations l10n, _SettingsSection section) {
    switch (section) {
      case _SettingsSection.account:
        return l10n.settingsMenuAccount;
      case _SettingsSection.design:
        return l10n.settingsMenuDesign;
      case _SettingsSection.language:
        return l10n.settingsMenuLanguage;
      case _SettingsSection.autoplay:
        return l10n.settingsMenuAutoplay;
      case _SettingsSection.crossfade:
        return l10n.settingsMenuCrossfade;
      case _SettingsSection.downloads:
        return l10n.settingsMenuDownloads;
      case _SettingsSection.aboutJimce:
        return l10n.settingsMenuAboutJimce;
      case _SettingsSection.help:
        return l10n.settingsMenuHelp;
    }
  }

  Widget _sidebarMenu(AppLocalizations l10n) {
    Widget menuItem(_SettingsSection section) {
      final isSelected = _selectedSection == section;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              _selectedSection = section;
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _sectionLabel(l10n, section),
              style: const TextStyle(fontSize: 26, color: Colors.white),
            ),
          ),
        ),
      );
    }

    Widget group(String title, List<_SettingsSection> sections) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            for (final section in sections) menuItem(section),
            const SizedBox(height: 8),
            Divider(color: Colors.white.withValues(alpha: 0.12), height: 1),
          ],
        ),
      );
    }

    return Container(
      width: 220,
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          group(l10n.settingsGroupGeneral, const [
            _SettingsSection.account,
            _SettingsSection.design,
            _SettingsSection.language,
          ]),
          group(l10n.settingsGroupPlayback, const [
            _SettingsSection.autoplay,
            _SettingsSection.crossfade,
          ]),
          group(l10n.settingsGroupLibrary, const [
            _SettingsSection.downloads,
          ]),
          const SizedBox(height: 12),
          menuItem(_SettingsSection.aboutJimce),
          menuItem(_SettingsSection.help),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
    );
  }

  Widget _subSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(color: Colors.white.withValues(alpha: 0.12), height: 1),
    );
  }

  Widget _outlineChip({required String text, required VoidCallback onTap}) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  InputDecoration _inputDecoration(String hint, {required IconData icon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.white54),
      suffixIcon: suffixIcon,
      hintStyle: const TextStyle(color: Colors.white30),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.06),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFF0BA00), width: 1.5),
      ),
    );
  }

  Widget _content(AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subSectionHeading(l10n.settingsMenuAccount),
        _sectionTitle(l10n.settingsChangePasswordTitle),
        const SizedBox(height: 16),
        TextField(
          controller: _newPasswordController,
          obscureText: _isNewPasswordHidden,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration(
            l10n.settingsPasswordHint,
            icon: Icons.lock_outline,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isNewPasswordHidden = !_isNewPasswordHidden;
                });
              },
              icon: Icon(
                _isNewPasswordHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _confirmPasswordController,
          obscureText: _isConfirmPasswordHidden,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration(
            l10n.settingsConfirmPasswordHint,
            icon: Icons.lock_outline,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                });
              },
              icon: Icon(
                _isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF0BA00),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              l10n.settingsChangePasswordButton,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        _divider(),
        _subSectionHeading(l10n.settingsMenuDesign),
        _outlineChip(
          text: l10n.settingsThemeBlack,
          onTap: () {},
        ),
        _divider(),
        _subSectionHeading(l10n.settingsMenuLanguage),
        _outlineChip(
          text: l10n.settingsLanguageGerman,
          onTap: () {},
        ),
        _divider(),
        _subSectionHeading(l10n.settingsMenuAutoplay),
        _sectionTitle(l10n.settingsAutoplayTitle),
        const SizedBox(height: 12),
        SwitchListTile.adaptive(
          value: _autoplayEnabled,
          onChanged: (value) {
            setState(() {
              _autoplayEnabled = value;
            });
          },
          activeThumbColor: const Color(0xFFF0BA00),
          activeTrackColor: const Color(0xFFF0BA00).withValues(alpha: 0.4),
          title: Text(
            l10n.settingsAutoplayDescription,
            style: textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        _divider(),
        _subSectionHeading(l10n.settingsMenuCrossfade),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.settingsCrossfadeSongs,
                style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Text('${_crossfadeSeconds.round()}s'),
          ],
        ),
        Slider(
          min: 0,
          max: 12,
          divisions: 12,
          value: _crossfadeSeconds,
          activeColor: const Color(0xFFF0BA00),
          inactiveColor: Colors.white24,
          onChanged: (value) {
            setState(() {
              _crossfadeSeconds = value;
            });
          },
        ),
        _divider(),
        _subSectionHeading(l10n.settingsMenuDownloads),
        _sectionTitle(l10n.settingsDownloadsTitle),
        const SizedBox(height: 12),
        SwitchListTile.adaptive(
          value: true,
          onChanged: (_) {},
          activeThumbColor: const Color(0xFFF0BA00),
          activeTrackColor: const Color(0xFFF0BA00).withValues(alpha: 0.4),
          title: Text(
            l10n.settingsDownloadsWifiOnly,
            style: textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 8),
        _outlineChip(
          text: l10n.settingsDownloadQualityHigh,
          onTap: () {},
        ),
        _divider(),
        _subSectionHeading(l10n.settingsMenuAboutJimce),
        _sectionTitle(l10n.settingsAboutJimceTitle),
        const SizedBox(height: 12),
        Text(
          l10n.settingsAboutJimceDescription,
          style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 8),
        _outlineChip(
          text: l10n.settingsAboutJimceAction,
          onTap: () {},
        ),
        _divider(),
        _subSectionHeading(l10n.settingsMenuHelp),
        _sectionTitle(l10n.settingsHelpTitle),
        const SizedBox(height: 12),
        _outlineChip(
          text: l10n.settingsHelpFaq,
          onTap: () {},
        ),
        const SizedBox(height: 8),
        _outlineChip(
          text: l10n.settingsHelpContact,
          onTap: () {},
        ),
        _divider(),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _showResetDialog(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(l10n.resetAppButton),
          ),
        ),
      ],
    );
  }

  double _contentBottomPadding(BuildContext context) {
    final systemInset = MediaQuery.of(context).padding.bottom;
    // Floating nav bar: 70 height + 20 bottom margin + little extra breathing room
    return 100 + systemInset;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWideLayout = MediaQuery.sizeOf(context).width >= 900;
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(l10n.settingsTab),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isWideLayout) _sidebarMenu(l10n),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      isWideLayout ? 24 : 12,
                      0,
                      isWideLayout ? 24 : 12,
                      _contentBottomPadding(context),
                    ),
                    child: _content(l10n),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}