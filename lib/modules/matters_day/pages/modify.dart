import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/matters_day.dart';

class MattersDayModifyPage extends StatefulWidget {
  final DocumentReference<MattersDay>? dayRef;

  const MattersDayModifyPage({super.key, this.dayRef});

  @override
  State<MattersDayModifyPage> createState() => _MattersDayModifyPageState();
}

class _MattersDayModifyPageState extends State<MattersDayModifyPage> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat('yyyy-MM-dd');
  final _description = TextEditingController(text: '');
  final _targetDate = TextEditingController(text: '');
  late final DocumentReference<MattersDay> _dayRef;
  MattersDay _day = MattersDay(description: '', targetDate: DateTime.now());

  @override
  void initState() {
    super.initState();
    _description.addListener(() => setState(() {}));
    _dayRef = widget.dayRef ?? MattersDay.collectionRef.doc();
    _dayRef.get().then((daySnapshot) {
      final dayFromSnapshot = daySnapshot.data();
      if (dayFromSnapshot != null) _day = dayFromSnapshot;
      setState(() {
        _description.text = _day.description;
        _targetDate.text = _dateFormat.format(_day.targetDate);
      });
    });
  }

  @override
  void dispose() {
    _description.dispose();
    _targetDate.dispose();
    super.dispose();
  }

  void _saveDay() {
    if (!_formKey.currentState!.validate()) return;
    _day.description = _description.text;
    _dayRef.set(_day).then((value) => Navigator.of(context).pop(_day));
  }

  void _onDateFieldTapped() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _day.targetDate,
      firstDate: DateTime(1970),
      lastDate: _day.targetDate.add(const Duration(days: 36500)),
    );

    if (date == null) return;

    _targetDate.text = _dateFormat.format(date);
    _day.targetDate = date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倒数日'),
        elevation: 2,
        scrolledUnderElevation: 4,
        actions: [
          if (_description.text.isNotEmpty)
            TextButton(
              onPressed: _saveDay,
              child: Text(
                '保存',
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _description,
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
              const SizedBox(height: 8),
              TextFormField(
                controller: _targetDate,
                onTap: () => _onDateFieldTapped(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  labelText: '目标日',
                  border: OutlineInputBorder(),
                ),
                showCursor: false,
              ),
              Container(
                padding: const EdgeInsets.only(top: 12),
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saveDay,
                  child: const Text('保存'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
