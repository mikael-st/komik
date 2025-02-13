import 'package:flutter/material.dart';
import 'package:komik/components/buttons/confirm_btn%20.dart';
import 'package:komik/components/fields/select_type_dropdown.dart';
import 'package:komik/components/fields/text_input_field.dart';
import 'package:komik/components/tool-bars/comic_edit_toolbar.dart';

class EditComicInfos extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController editionNumberController = TextEditingController();
  
  EditComicInfos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComicEditToolbar(),
      body: _content(),
      floatingActionButton: ConfirmBtn(
        action: () => debugPrint('SAVED')
      ),
    );
  }

  Widget _content(){
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children: [
          TextInputField(
            label: 'Titulo',
            controller: titleController,
          ),
          TextInputField(
            label: 'Sub-titulo',
            controller: subtitleController,
          ),
          _editionInfos()
        ],
      ),
    );
  }

  Widget _editionInfos(){
    return Row(
      spacing: 16,
      children: [
        Flexible(child: TextInputField(
          label: 'Edição nº',
          controller: editionNumberController,
        )),
        SelectTypeDropdown()
      ],
    );
  }
}