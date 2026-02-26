import 'package:flutter/material.dart';

// search_screen.dart

class SearchScreen extends StatefulWidget {
  // Wir machen den Key im Konstruktor explizit nutzbar
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState(); // State öffentlich machen (ohne _)
}

// SearchScreenState ohne Unterstrich, damit MainNavigationWrapper darauf zugreifen kann
class SearchScreenState extends State<SearchScreen> {
  late TextEditingController _inputFieldController;
  final FocusNode _searchFocusNode = FocusNode(); // FocusNode hinzufügen

  @override
  void initState() {
    super.initState();
    _inputFieldController = TextEditingController();
  }

  // Diese Methode wird von außen aufgerufen
  void openKeyboard() {
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _inputFieldController.dispose();
    _searchFocusNode.dispose(); // Wichtig!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Suchen"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _inputFieldController,
                focusNode: _searchFocusNode, // FocusNode hier zuweisen
                autofocus: false,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Song oder Künstler suchen...",
                  hintStyle: TextStyle(color: theme.textTheme.bodySmall?.color),
                  prefixIcon: Icon(
                    Icons.search,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}