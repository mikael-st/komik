import 'package:flutter/material.dart';
import 'package:komik/components/tool-bars/search_bar.dart';
import 'package:komik/components/utils/checkboxes/check_mode.dart';
import 'package:komik/service/states/search_filter_type/search_filter_type.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void _onChangeType(SearchFilterType type){
    setState(() {
      SearchFilterTypeState.mode.value = type;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchToolBar(),
        body: Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            spacing: 20,
            children: [
              _filter()
            ],
          )
        )
      ),
    );
  }

  Widget _filter(){
    return Row(
      spacing: 12,
      children: [
        CheckMode(
          label: 'Tudo',
          type: SearchFilterType.all,
          group: SearchFilterTypeState.mode.value,
          onChanged: _onChangeType,
        ),
        CheckMode(
          label: 'Quadrinhos',
          type: SearchFilterType.comics,
          group: SearchFilterTypeState.mode.value,
          onChanged: _onChangeType,
        ),
        CheckMode(
          label: 'Coleções',
          type: SearchFilterType.collections,
          group: SearchFilterTypeState.mode.value,
          onChanged: _onChangeType,
        )
      ],
    );
  }
}