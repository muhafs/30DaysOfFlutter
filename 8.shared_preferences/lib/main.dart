import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PreferenceSettings _preferences = PreferenceSettings();

  TextEditingController _controller = TextEditingController();
  Gender _gender = Gender.male;
  Set<Language> _languages = <Language>{};
  bool _employmentStatus = false;

  void _checkPreferenced() async {
    final settings = await _preferences.getSettings();

    setState(() {
      _controller.text = settings.username;
      _gender = settings.gender;
      _languages = settings.languages;
      _employmentStatus = settings.isEmployed;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkPreferenced();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          //! Text Fields
          ListTile(
            title: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
          ),

          //! Radios
          RadioListTile(
            title: const Text('Male'),
            value: Gender.male,
            groupValue: _gender,
            onChanged: _selectGender,
          ),
          RadioListTile(
            title: const Text('Female'),
            value: Gender.female,
            groupValue: _gender,
            onChanged: _selectGender,
          ),
          RadioListTile(
            title: const Text('Other'),
            value: Gender.other,
            groupValue: _gender,
            onChanged: _selectGender,
          ),

          //! Checkboxes
          CheckboxListTile(
            title: const Text('Arabic'),
            value: _languages.contains(Language.arabic),
            onChanged: (_) => _selectLanguage(Language.arabic),
          ),
          CheckboxListTile(
            title: const Text('English'),
            value: _languages.contains(Language.english),
            onChanged: (_) => _selectLanguage(Language.english),
          ),
          CheckboxListTile(
            title: const Text('Indonesian'),
            value: _languages.contains(Language.indonesian),
            onChanged: (_) => _selectLanguage(Language.indonesian),
          ),
          CheckboxListTile(
            title: const Text('Spanish'),
            value: _languages.contains(Language.spanish),
            onChanged: (_) => _selectLanguage(Language.spanish),
          ),
          CheckboxListTile(
            title: const Text('Japanese'),
            value: _languages.contains(Language.japanese),
            onChanged: (_) => _selectLanguage(Language.japanese),
          ),

          //! Swicthes
          SwitchListTile.adaptive(
            title: const Text('is Employed'),
            value: _employmentStatus,
            onChanged: (value) => setState(() => _employmentStatus = value),
          ),

          //! Save Button
          SizedBox(
            child: TextButton(
              onPressed: _saveSettings,
              child: const Text('Save Settings'),
            ),
          )
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Shared Preferences App'),
      centerTitle: true,
    );
  }

  void _selectGender(value) {
    setState(() => _gender = value!);
  }

  void _selectLanguage(Language lang) {
    setState(
      () => _languages.contains(lang)
          ? _languages.remove(lang)
          : _languages.add(lang),
    );
  }

  void _saveSettings() {
    final newSettings = Setting(
      username: _controller.text,
      gender: _gender,
      languages: _languages,
      isEmployed: _employmentStatus,
    );

    _preferences.saveSettings(newSettings);
  }
}

class PreferenceSettings {
  Future saveSettings(Setting setting) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setString('username', setting.username);
    await pref.setBool('isEmployed', setting.isEmployed);

    await pref.setInt('gender', setting.gender.index);

    await pref.setStringList(
      'languages',
      setting.languages.map((lang) => lang.index.toString()).toList(),
    );
  }

  Future<Setting> getSettings() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final String username = pref.getString('username') ?? '';
    final bool isEmployed = pref.getBool('isEmployed') ?? false;
    final Gender gender = Gender.values[pref.getInt('gender') ?? 0];
    final Set<Language> languages = pref
            .getStringList('languages')
            ?.map((str) => Language.values[int.parse(str)])
            .toSet() ??
        <Language>{};

    return Setting(
      username: username,
      gender: gender,
      languages: languages,
      isEmployed: isEmployed,
    );
  }
}
