import 'package:flutter/material.dart';
import 'package:komik/assets/palette.dart';
import 'package:komik/assets/typography.dart';
import 'package:komik/service/states/search_filter_type/search_filter_type.dart';

class CheckMode extends StatelessWidget {
  final SearchFilterType type;
  final SearchFilterType group;
  final String label;
  final ValueChanged<SearchFilterType> onChanged;

  const CheckMode({
    super.key,
    required this.label,
    required this.type,
    required this.group,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool checked = type == group;
    return InkWell(
      onTap: () {
        onChanged(type);
        print('type selected: ${type.value}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: checked ? Palette.details : Palette.items,
          borderRadius: BorderRadius.circular(9999)
        ),
        child: Text(label, style: KomikTypography.base),
      ),
    );
  }
}