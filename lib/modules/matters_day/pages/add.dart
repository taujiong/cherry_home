import 'package:cherry_home/modules/matters_day/models/matters_day.dart';
import 'package:cherry_home/modules/matters_day/models/matters_day_repo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MattersDayAddPage extends StatefulWidget {
  const MattersDayAddPage({super.key});

  @override
  State<MattersDayAddPage> createState() => _MattersDayAddPageState();
}

class _MattersDayAddPageState extends State<MattersDayAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController(text: '');
  final _dateFormat = DateFormat('yyyy-MM-dd');
  var _targetDate = DateTime.now();
  late final TextEditingController _targetDateController;

  void _saveDay() {
    if (!_formKey.currentState!.validate()) return;
    final day = MattersDay.fromDto(_descriptionController.text, _targetDate);
    mattersDayRepo.insertDay(day).then((value) => Navigator.pop(context));
  }

  void _onDateFieldTapped() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _targetDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    _targetDateController.text = _dateFormat.format(date);
    setState(() {
      _targetDate = date;
    });
  }

  @override
  void initState() {
    super.initState();
    _targetDateController =
        TextEditingController(text: _dateFormat.format(_targetDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倒数日'),
        elevation: 2,
        scrolledUnderElevation: 4,
        actions: [
          if (_descriptionController.text.isNotEmpty)
            TextButton(
              onPressed: _saveDay,
              child: const Text('保存'),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return '请输入描述';
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.feed_outlined),
                    labelText: '描述',
                    hintText: '点击这里输入事件描述',
                    helperText: '',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextFormField(
                  controller: _targetDateController,
                  onTap: () => _onDateFieldTapped(),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    labelText: '目标日',
                    border: OutlineInputBorder(),
                  ),
                  showCursor: false,
                ),
              ),
              FilledButton(onPressed: _saveDay, child: const Text('保存'))
            ],
          ),
        ),
      ),
    );
  }
}
