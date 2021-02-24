import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:movies_app/app/styles/palette.dart';
import 'package:movies_app/core/domain/filter_type.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function onClear;
  final bool clearButtonEnabled;
  final Function() showFilter;
  final Function() hideFilter;
  final Function(FilterType) onFilterSelected;
  final bool isShowingFilter;

  SearchBar({
    @required this.controller,
    @required this.onClear,
    this.clearButtonEnabled = false,
    @required this.showFilter,
    @required this.hideFilter,
    @required this.onFilterSelected,
    this.isShowingFilter = false,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _showingFilter;
  FilterType _filterType;

  @override
  void initState() {
    super.initState();
    _showingFilter = widget.isShowingFilter;
    _filterType = FilterType.all;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Theme(
                    data: ThemeData.dark().copyWith(
                      accentColor: Palette.grey,
                    ),
                    child: TextField(
                      controller: widget.controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(width: 0.0, color: Palette.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.grey),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.grey),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        hintText: "Search",
                        prefixIcon: Icon(
                          LineIcons.search,
                          color: Palette.light,
                        ),
                        suffix: GestureDetector(
                          onTap: widget.clearButtonEnabled ? widget.onClear : null,
                          child: Icon(LineIcons.times, color: Palette.light),
                        ),
                        filled: true,
                        fillColor: Palette.grey,
                      ),
                      cursorColor: Palette.primary,
                      cursorHeight: 20,
                      style: TextStyle(color: Palette.light, fontSize: 15),
                      autocorrect: false,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(LineIcons.filter, color: Palette.light),
                  onPressed: () {
                    setState(() {
                      if (!_showingFilter) {
                        widget.showFilter();
                      } else {
                        widget.hideFilter();
                      }
                      _showingFilter = !_showingFilter;
                    });
                  },
                  disabledColor: Palette.grey,
                  color: Palette.light,
                ),
              ],
            ),
            if (_showingFilter) ...[
              SizedBox(height: 16),
              Text(
                "Filter by",
                style: TextStyle(fontSize: 18, color: Palette.light),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FilterChip(
                    current: _filterType,
                    value: FilterType.movies,
                    onSelected: _updateFilter,
                    text: "Movies",
                  ),
                  SizedBox(width: 16),
                  _FilterChip(
                    current: _filterType,
                    value: FilterType.series,
                    onSelected: _updateFilter,
                    text: "Series",
                  ),
                  SizedBox(width: 16),
                  _FilterChip(
                    current: _filterType,
                    value: FilterType.episodes,
                    onSelected: _updateFilter,
                    text: "Episodes",
                  ),
                  SizedBox(width: 16),
                  _FilterChip(
                    current: _filterType,
                    value: FilterType.all,
                    onSelected: _updateFilter,
                    text: "All",
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  void _updateFilter(FilterType type) {
    setState(() {
      _filterType = type;
      widget.onFilterSelected(type);
    });
  }
}

class _FilterChip extends StatelessWidget {
  final String text;
  final FilterType current;
  final FilterType value;
  final Function(FilterType) onSelected;

  _FilterChip({
    @required this.current,
    @required this.value,
    @required this.onSelected,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(text),
      selected: current == value,
      onSelected: (state) {
        if (state) {
          onSelected(value);
        }
      },
    );
  }
}
