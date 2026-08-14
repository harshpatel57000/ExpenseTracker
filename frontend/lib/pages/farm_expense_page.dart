import 'package:flutter/material.dart';

class FarmExpensePage extends StatefulWidget {
  const FarmExpensePage({super.key});

  @override
  State<FarmExpensePage> createState() => _FarmExpensePageState();
}

class _FarmExpensePageState extends State<FarmExpensePage> {
  // ============================================================
  // TEXT CONTROLLERS
  // ============================================================

  final TextEditingController regionController =
      TextEditingController();

  final TextEditingController farmController =
      TextEditingController();

  final TextEditingController laborController =
      TextEditingController();

  final TextEditingController amountPerLaborController =
      TextEditingController();

  // Tea
  final TextEditingController teaQuantityController =
      TextEditingController(text: '0');

  final TextEditingController teaPricePerLiterController =
      TextEditingController(text: '65');

  // Pan Masala
  final TextEditingController panMasalaQuantityController =
      TextEditingController(text: '0');

  final TextEditingController panMasalaPriceController =
      TextEditingController(text: '0');

  // Snacks
  final TextEditingController snackPeopleController =
      TextEditingController(text: '0');

  final TextEditingController snackDishController =
      TextEditingController(text: '1');

  final TextEditingController snackPriceController =
      TextEditingController(text: '15');

  // ============================================================
  // SELECTED VALUES
  // ============================================================

  String selectedCrop = 'ઘઉં';

  String selectedWorkType = 'ખેતર તૈયાર કરવું';

  String teaUnit = 'ml';

  DateTime selectedDate = DateTime.now();

  // ============================================================
  // CHECKBOXES
  // ============================================================

  bool includeTea = false;

  bool includePanMasala = false;

  bool includeSnacks = false;

  // ============================================================
  // CROP → WORK TYPES
  // ============================================================

  final Map<String, List<String>> cropWorkTypes = {
    'ઘઉં': [
      'ખેતર તૈયાર કરવું',
      'વાવણી',
      'પિયત / સિંચાઈ',
      'નિંદામણ',
      'દવા છંટકાવ',
      'ખાતર નાખવું',
      'લણણી',
      'થ્રેશિંગ',
      'અન્ય',
    ],

    'કપાસ': [
      'ખેતર તૈયાર કરવું',
      'વાવણી',
      'પિયત / સિંચાઈ',
      'નિંદામણ',
      'દવા છંટકાવ',
      'ખાતર નાખવું',
      'આંતર ખેડ',
      'કપાસ વીણવો',
      'અન્ય',
    ],

    'મગફળી': [
      'ખેતર તૈયાર કરવું',
      'વાવણી',
      'પિયત / સિંચાઈ',
      'નિંદામણ',
      'દવા છંટકાવ',
      'ખાતર નાખવું',
      'ઉખેડવું',
      'સૂકવવું',
      'લણણી',
      'અન્ય',
    ],

    'ડુંગળી': [
      'ખેતર તૈયાર કરવું',
      'રોપણી',
      'પિયત / સિંચાઈ',
      'નિંદામણ',
      'દવા છંટકાવ',
      'ખાતર નાખવું',
      'ડુંગળી કાઢવી',
      'સાફ સફાઈ',
      'અન્ય',
    ],

    'બાજરી': [
      'ખેતર તૈયાર કરવું',
      'વાવણી',
      'પિયત / સિંચાઈ',
      'નિંદામણ',
      'દવા છંટકાવ',
      'ખાતર નાખવું',
      'લણણી',
      'થ્રેશિંગ',
      'અન્ય',
    ],
  };

  // ============================================================
  // CALCULATED VALUES
  // ============================================================

  double laborExpense = 0;

  double teaExpense = 0;

  double panMasalaExpense = 0;

  double snackExpense = 0;

  double totalExpense = 0;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    regionController.addListener(calculateExpenses);
    farmController.addListener(calculateExpenses);

    laborController.addListener(calculateExpenses);
    amountPerLaborController.addListener(calculateExpenses);

    teaQuantityController.addListener(calculateExpenses);
    teaPricePerLiterController.addListener(calculateExpenses);

    panMasalaQuantityController.addListener(calculateExpenses);
    panMasalaPriceController.addListener(calculateExpenses);

    snackPeopleController.addListener(calculateExpenses);
    snackDishController.addListener(calculateExpenses);
    snackPriceController.addListener(calculateExpenses);
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    regionController.dispose();
    farmController.dispose();

    laborController.dispose();
    amountPerLaborController.dispose();

    teaQuantityController.dispose();
    teaPricePerLiterController.dispose();

    panMasalaQuantityController.dispose();
    panMasalaPriceController.dispose();

    snackPeopleController.dispose();
    snackDishController.dispose();
    snackPriceController.dispose();

    super.dispose();
  }

  // ============================================================
  // CALCULATE ALL EXPENSES
  // ============================================================

  void calculateExpenses() {
    final double labor =
        double.tryParse(laborController.text) ?? 0;

    final double amountPerLabor =
        double.tryParse(amountPerLaborController.text) ?? 0;

    final double teaQuantity =
        double.tryParse(teaQuantityController.text) ?? 0;

    final double teaPrice =
        double.tryParse(teaPricePerLiterController.text) ?? 0;

    final double panQuantity =
        double.tryParse(panMasalaQuantityController.text) ?? 0;

    final double panPrice =
        double.tryParse(panMasalaPriceController.text) ?? 0;

    final double snackPeople =
        double.tryParse(snackPeopleController.text) ?? 0;

    final double snackDishes =
        double.tryParse(snackDishController.text) ?? 0;

    final double snackPrice =
        double.tryParse(snackPriceController.text) ?? 0;

    // ------------------------------------------------------------
    // LABOUR
    // ------------------------------------------------------------

    final double calculatedLabor =
        labor * amountPerLabor;

    // ------------------------------------------------------------
    // TEA
    //
    // If unit = ml:
    //
    // 450 ml / 1000 = 0.45 litre
    //
    // 0.45 × ₹65 = ₹29.25
    // ------------------------------------------------------------

    double calculatedTea = 0;

    if (teaUnit == 'ml') {
      calculatedTea =
          (teaQuantity / 1000) * teaPrice;
    } else {
      calculatedTea =
          teaQuantity * teaPrice;
    }

    // ------------------------------------------------------------
    // PAN MASALA
    //
    // Number of items × price per item
    // ------------------------------------------------------------

    final double calculatedPanMasala =
        panQuantity * panPrice;

    // ------------------------------------------------------------
    // SNACKS
    //
    // People × dishes per person × price per dish
    //
    // 5 people × 1 dish × ₹15 = ₹75
    // ------------------------------------------------------------

    final double calculatedSnacks =
        snackPeople * snackDishes * snackPrice;

    setState(() {
      laborExpense = calculatedLabor;

      teaExpense =
          includeTea ? calculatedTea : 0;

      panMasalaExpense =
          includePanMasala ? calculatedPanMasala : 0;

      snackExpense =
          includeSnacks ? calculatedSnacks : 0;

      totalExpense =
          laborExpense +
          teaExpense +
          panMasalaExpense +
          snackExpense;
    });
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> selectDate() async {
    final DateTime? pickedDate =
        await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String get formattedDate {
    return '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  // ============================================================
  // ADD EXPENSE
  // ============================================================

  void addExpense() {
    final String region =
        regionController.text.trim();

    final String farm =
        farmController.text.trim();

    final double labor =
        double.tryParse(laborController.text) ?? 0;

    final double amountPerLabor =
        double.tryParse(
          amountPerLaborController.text,
        ) ??
        0;

    // ------------------------------------------------------------
    // VALIDATION
    // ------------------------------------------------------------

    if (region.isEmpty) {
      showMessage('વિસ્તારનું નામ દાખલ કરો');
      return;
    }

    if (farm.isEmpty) {
      showMessage('ખેતરનું નામ દાખલ કરો');
      return;
    }

    if (labor <= 0) {
      showMessage('મજૂરોની સંખ્યા દાખલ કરો');
      return;
    }

    if (amountPerLabor <= 0) {
      showMessage('એક મજૂરનો ખર્ચ દાખલ કરો');
      return;
    }

    // ------------------------------------------------------------
    // DATA TO SEND TO BACKEND LATER
    // ------------------------------------------------------------

    final Map<String, dynamic> farmExpense = {
      'region': region,
      'farm': farm,
      'crop': selectedCrop,
      'workType': selectedWorkType,

      // Labour
      'laborCount': labor,
      'amountPerLabor': amountPerLabor,
      'laborExpense': laborExpense,

      // Tea
      'includeTea': includeTea,
      'teaQuantity': includeTea
          ? double.tryParse(
                teaQuantityController.text,
              ) ??
              0
          : 0,
      'teaUnit': teaUnit,
      'teaPricePerLiter': includeTea
          ? double.tryParse(
                teaPricePerLiterController.text,
              ) ??
              0
          : 0,
      'teaExpense': teaExpense,

      // Pan Masala
      'includePanMasala': includePanMasala,
      'panMasalaQuantity': includePanMasala
          ? double.tryParse(
                panMasalaQuantityController.text,
              ) ??
              0
          : 0,
      'panMasalaPrice': includePanMasala
          ? double.tryParse(
                panMasalaPriceController.text,
              ) ??
              0
          : 0,
      'panMasalaExpense': panMasalaExpense,

      // Snacks
      'includeSnacks': includeSnacks,
      'snackPeople': includeSnacks
          ? double.tryParse(
                snackPeopleController.text,
              ) ??
              0
          : 0,
      'snackDishesPerPerson': includeSnacks
          ? double.tryParse(
                snackDishController.text,
              ) ??
              0
          : 0,
      'snackPricePerDish': includeSnacks
          ? double.tryParse(
                snackPriceController.text,
              ) ??
              0
          : 0,
      'snackExpense': snackExpense,

      // Total
      'totalExpense': totalExpense,

      'date': selectedDate.toIso8601String(),
    };

    // ------------------------------------------------------------
    // TODO:
    // Later send this object to Spring Boot API.
    //
    // POST /api/farm-expenses
    // ------------------------------------------------------------

    debugPrint('Farm Expense: $farmExpense');

    showMessage('ખર્ચ સફળતાપૂર્વક ઉમેરાયો');

    Navigator.pop(context);
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final List<String> workTypes =
        cropWorkTypes[selectedCrop] ??
        ['અન્ય'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ખેતરનો ખર્ચ ઉમેરો'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,

            children: [

              // ==================================================
              // TITLE
              // ==================================================

              const Text(
                'ખેતરના કામનો ખર્ચ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'ખેતરમાં પાક માટે થયેલ ખર્ચ અહીં ઉમેરો.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // REGION
              // ==================================================

              _buildTextField(
                controller: regionController,
                label: 'વિસ્તારનું નામ',
                hint: 'ઉદાહરણ: નદી પાસેનો વિસ્તાર',
                icon: Icons.location_on_outlined,
              ),

              const SizedBox(height: 16),

              // ==================================================
              // FARM
              // ==================================================

              _buildTextField(
                controller: farmController,
                label: 'ખેતરનું નામ',
                hint: 'ઉદાહરણ: મારું ખેતર',
                icon: Icons.agriculture_outlined,
              ),

              const SizedBox(height: 16),

              // ==================================================
              // CROP
              // ==================================================

              _buildDropdown(
                label: 'પાક',
                value: selectedCrop,
                items: cropWorkTypes.keys.toList(),

                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCrop = value;

                      final works =
                          cropWorkTypes[value] ??
                          ['અન્ય'];

                      selectedWorkType =
                          works.first;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // ==================================================
              // WORK TYPE
              // ==================================================

              _buildDropdown(
                label: 'કામનો પ્રકાર',
                value: selectedWorkType,
                items: workTypes,

                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedWorkType = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              // ==================================================
              // LABOUR SECTION
              // ==================================================

              _buildSectionTitle(
                'મજૂરીનો ખર્ચ',
                Icons.groups_outlined,
              ),

              const SizedBox(height: 12),

              _buildNumberField(
                controller: laborController,
                label: 'મજૂરોની સંખ્યા',
                hint: 'ઉદાહરણ: 5',
                icon: Icons.groups_outlined,
                decimal: false,
              ),

              const SizedBox(height: 14),

              _buildNumberField(
                controller:
                    amountPerLaborController,
                label: 'એક મજૂરનો ખર્ચ',
                hint: 'ઉદાહરણ: ₹400',
                icon: Icons.currency_rupee,
              ),

              const SizedBox(height: 25),

              // ==================================================
              // EXTRA EXPENSE
              // ==================================================

              _buildSectionTitle(
                'વધારાનો ખર્ચ',
                Icons.add_circle_outline,
              ),

              const SizedBox(height: 5),

              const Text(
                'જરૂર હોય તો નીચેના ખર્ચ પસંદ કરો.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 10),

              // ==================================================
              // TEA CHECKBOX
              // ==================================================

              _buildExpenseCheckbox(
                title: 'ચા',
                icon: Icons.local_cafe_outlined,
                value: includeTea,

                onChanged: (value) {
                  setState(() {
                    includeTea = value;
                  });

                  calculateExpenses();
                },
              ),

              if (includeTea)
                _buildTeaSection(),

              // ==================================================
              // PAN MASALA CHECKBOX
              // ==================================================

              _buildExpenseCheckbox(
                title: 'પાન મસાલા',
                icon: Icons.shopping_bag_outlined,
                value: includePanMasala,

                onChanged: (value) {
                  setState(() {
                    includePanMasala = value;
                  });

                  calculateExpenses();
                },
              ),

              if (includePanMasala)
                _buildPanMasalaSection(),

              // ==================================================
              // SNACKS CHECKBOX
              // ==================================================

              _buildExpenseCheckbox(
                title: 'નાસ્તો',
                icon: Icons.restaurant_outlined,
                value: includeSnacks,

                onChanged: (value) {
                  setState(() {
                    includeSnacks = value;
                  });

                  calculateExpenses();
                },
              ),

              if (includeSnacks)
                _buildSnackSection(),

              const SizedBox(height: 20),

              // ==================================================
              // TOTAL
              // ==================================================

              _buildSummaryCard(),

              const SizedBox(height: 20),

              // ==================================================
              // DATE
              // ==================================================

              const Text(
                'તારીખ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              InkWell(
                onTap: selectDate,

                borderRadius:
                    BorderRadius.circular(12),

                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 16,
                  ),

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),

                    borderRadius:
                        BorderRadius.circular(12),
                  ),

                  child: Row(
                    children: [

                      const Icon(
                        Icons.calendar_today_outlined,
                      ),

                      const SizedBox(width: 12),

                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      const Spacer(),

                      const Icon(
                        Icons.arrow_drop_down,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // ADD EXPENSE
              // ==================================================

              SizedBox(
                height: 54,

                child: ElevatedButton.icon(
                  onPressed: addExpense,

                  icon: const Icon(
                    Icons.add,
                  ),

                  label: const Text(
                    'ખર્ચ ઉમેરો',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style:
                      ElevatedButton.styleFrom(
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TEA SECTION
  // ============================================================

  Widget _buildTeaSection() {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 10),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'ચાનો ખર્ચ',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [

                Expanded(
                  child: _buildNumberField(
                    controller:
                        teaQuantityController,
                    label: 'ચાની માત્રા',
                    hint: 'ઉદાહરણ: 450',
                    icon:
                        Icons.local_cafe_outlined,
                  ),
                ),

                const SizedBox(width: 10),

                SizedBox(
                  width: 100,

                  child: _buildDropdown(
                    label: 'એકમ',
                    value: teaUnit,

                    items: const [
                      'ml',
                      'લિટર',
                    ],

                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          teaUnit = value;
                        });

                        calculateExpenses();
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            _buildNumberField(
              controller:
                  teaPricePerLiterController,
              label: 'એક લિટરનો ભાવ',
              hint: '₹65',
              icon: Icons.currency_rupee,
            ),

            const SizedBox(height: 10),

            Text(
              'ચાનો ખર્ચ: ₹${teaExpense.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PAN MASALA SECTION
  // ============================================================

  Widget _buildPanMasalaSection() {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 10),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'પાન મસાલાનો ખર્ચ',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            _buildNumberField(
              controller:
                  panMasalaQuantityController,
              label: 'કેટલી વસ્તુ?',
              hint: 'ઉદાહરણ: 10',
              icon:
                  Icons.shopping_bag_outlined,
              decimal: false,
            ),

            const SizedBox(height: 14),

            _buildNumberField(
              controller:
                  panMasalaPriceController,
              label: 'એક વસ્તુનો ભાવ',
              hint: 'ઉદાહરણ: ₹5',
              icon: Icons.currency_rupee,
            ),

            const SizedBox(height: 10),

            Text(
              'પાન મસાલાનો ખર્ચ: '
              '₹${panMasalaExpense.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SNACK SECTION
  // ============================================================

  Widget _buildSnackSection() {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 10),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'નાસ્તાનો ખર્ચ',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            _buildNumberField(
              controller:
                  snackPeopleController,
              label: 'કેટલા લોકો / મજૂરો?',
              hint: 'ઉદાહરણ: 5',
              icon: Icons.groups_outlined,
              decimal: false,
            ),

            const SizedBox(height: 14),

            _buildNumberField(
              controller:
                  snackDishController,
              label: 'એક વ્યક્તિ માટે ડિશ',
              hint: 'ઉદાહરણ: 1',
              icon: Icons.restaurant_outlined,
              decimal: false,
            ),

            const SizedBox(height: 14),

            _buildNumberField(
              controller:
                  snackPriceController,
              label: 'એક ડિશનો ભાવ',
              hint: '₹15',
              icon: Icons.currency_rupee,
            ),

            const SizedBox(height: 10),

            Text(
              'નાસ્તાનો ખર્ચ: '
              '₹${snackExpense.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CHECKBOX
  // ============================================================

  Widget _buildExpenseCheckbox({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 8),

      child: CheckboxListTile(
        value: value,

        onChanged: (newValue) {
          onChanged(newValue ?? false);
        },

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        secondary: Icon(icon),

        controlAffinity:
            ListTileControlAffinity.trailing,
      ),
    );
  }

  // ============================================================
  // SUMMARY CARD
  // ============================================================

  Widget _buildSummaryCard() {
    return Card(
      elevation: 3,

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [

            const Align(
              alignment:
                  Alignment.centerLeft,

              child: Text(
                'કુલ ખર્ચ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            _summaryRow(
              'મજૂરી',
              laborExpense,
            ),

            if (includeTea)
              _summaryRow(
                'ચા',
                teaExpense,
              ),

            if (includePanMasala)
              _summaryRow(
                'પાન મસાલા',
                panMasalaExpense,
              ),

            if (includeSnacks)
              _summaryRow(
                'નાસ્તો',
                snackExpense,
              ),

            const Divider(height: 25),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'કુલ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '₹${totalExpense.toStringAsFixed(2)}',

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color:
                        Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SUMMARY ROW
  // ============================================================

  Widget _summaryRow(
    String title,
    double amount,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide(
            color:
                Colors.green.shade700,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NUMBER FIELD
  // ============================================================

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool decimal = true,
  }) {
    return TextField(
      controller: controller,

      keyboardType: decimal
          ? const TextInputType.numberWithOptions(
              decimal: true,
            )
          : TextInputType.number,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide(
            color:
                Colors.green.shade700,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,

      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),

      onChanged: onChanged,

      decoration: InputDecoration(
        labelText: label,

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide(
            color:
                Colors.green.shade700,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle(
    String title,
    IconData icon,
  ) {
    return Row(
      children: [

        Icon(
          icon,
          color: Colors.green.shade700,
        ),

        const SizedBox(width: 8),

        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}