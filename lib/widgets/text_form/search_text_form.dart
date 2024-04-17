import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/themes_provider.dart';
import 'package:social/widgets/text_form/custom_text_form.dart';

class SearchTextForm extends StatelessWidget {
  const SearchTextForm({
    super.key,
    required TextEditingController searchController,
    this.onChanged,
    this.onFieldSubmitted,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final void Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Color color = themeProvider.getIsDarkTheme ? Colors.white : Colors.black;
    return CustomTextForm(
      filled: false,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      hintText: 'Search ...',
      controller: _searchController,
      prefixIcon: Icon(
        IconlyBroken.search,
        color: color,
      ),
      suffixIcon: IconButton(
        onPressed: () => _searchController.clear(),
        icon: Icon(
          IconlyBroken.delete,
          color: color,
        ),
      ),
    );
  }
}
