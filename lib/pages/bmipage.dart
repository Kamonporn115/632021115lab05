import 'package:flutter/material.dart';
import 'package:lab05/showbmi.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  // Form
  final GlobalKey<FormState> _formKey = GlobalKey();

  // TextField
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _text3 = TextEditingController();
  int gender = 0;
  double? _bmi;
  String isRadio = "";
  bool isCheck = false;

  List<Fruit> fruits = [];

  final List<ListItem> _dropdownItems = [
    ListItem(1, 'คณะวิทยาศาสตร์'),
    ListItem(2, 'คณะวิทยาการสุขภาพและการกีฬา'),
    ListItem(3, 'คณะเทคโนโลยีและการพัฒนาชุมชน'),
    ListItem(4, 'คณะนิติศาสตร์'),
    ListItem(5, 'คณะวิศวกรรมศาสตร์'),
    ListItem(6, 'คณะพยาบาลศาสตร์'),
    ListItem(7, 'คณะศึกษาศาสตร์'),
    ListItem(8, 'คณะอุตสาหกรรมเกษตรและชีวภาพ'),
  ];

  late List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    fruits = Fruit.getFruit();
    print(fruits[0].engName);

    _dropdownMenuItems = buildDropdownMenuItem(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropdownMenuItem(
      List<ListItem> dropdownItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in dropdownItems) {
      items.add(DropdownMenuItem(
        child: Text(listItem.name),
        value: listItem,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculation"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            //Center(child: Text("\nHeight")),
            TextFormField(
              controller: _height,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(suffixText: "cm", labelText: "ส่วนสูง"),
              // onChanged: (value) {
              //   setState(() {});
              // },
            ),
            TextFormField(
              controller: _weight,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  suffixText: "kg", labelText: "นํ้าหนัก"),
            ),

            ElevatedButton(
                child: Text('Go to next page.'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(_height.text);
                    print(_weight.text);

                    double weight = double.parse(_weight.text);
                    double height = double.parse(_height.text) / 100;

                    double result = weight / (height * height);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Showbmi(
                              bminew: result,
                              weightnew: _weight.text,
                              heightnew: _height.text),
                        ));
                  }
                }),

            Center(child: Text("\nSex")),
            RadioListTile(
              title: Text("Male"),
              value: "Male",
              groupValue: isRadio,
              onChanged: (value) {
                setState(() {
                  isRadio = value!;
                });
              },
            ),
            RadioListTile(
              title: Text("Female"),
              value: "Female",
              groupValue: isRadio,
              onChanged: (value) {
                setState(() {
                  isRadio = value!;
                });
              },
            ),
            RadioListTile(
              title: Text("Other (LGBT+)"),
              value: "Other",
              groupValue: isRadio,
              onChanged: (value) {
                setState(() {
                  isRadio = value!;
                });
              },
            ),
            RadioListTile(
              title: Text("Not Specify"),
              value: "Not",
              groupValue: isRadio,
              onChanged: (value) {
                setState(() {
                  isRadio = value!;
                });
              },
            ),
            Column(
              children: createFruitCheckbox(),
            ),
            DropdownButton(
              value: _selectedItem,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
                print(_selectedItem!.name);
                print(_selectedItem!.value);
              },
            )
          ],
        ),
      ),
    );
  }

  List<Widget> createFruitCheckbox() {
    List<Widget> myfruit = [];

    for (Fruit fruit in fruits) {
      myfruit.add(
        CheckboxListTile(
          title: Text(fruit.thName),
          value: fruit.isCheck,
          onChanged: (value) {
            setState(() {
              fruit.isCheck = value!;
            });
          },
        ),
      );
    }

    return myfruit;
  }
}

class Fruit {
  String engName;
  String thName;
  bool isCheck;

  Fruit(this.engName, this.thName, this.isCheck);

  static List<Fruit> getFruit() {
    return <Fruit>[
      Fruit("1", "แอปเปิ้ล", false),
      Fruit("2", "เสาวรส", false),
      Fruit("3", "แก้วมังกร", false),
      Fruit("4", "กล้วย", false),
      Fruit("5", "มะพร้าว", false),
    ];
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
