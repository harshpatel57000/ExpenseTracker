import 'package:flutter/material.dart';

class FarmExpensePage extends StatefulWidget {
  const FarmExpensePage({super.key});

  @override
  State<FarmExpensePage> createState() => _FarmExpensePageState();
}

class _FarmExpensePageState extends State<FarmExpensePage> {
  // --------------------------------------------------
  // Controllers
  // --------------------------------------------------

  final TextEditingController laborController =
      TextEditingController();

  final TextEditingController amountPerLaborController =
      TextEditingController();

  final TextEditingController extraExpenseController =
      TextEditingController();

  // --------------------------------------------------
  // Selected values
  // --------------------------------------------------

  String selectedRegion = 'ઉત્તર વિસ્તાર';
  String selectedFarm = 'ખેતર 1';

  String selectedCrop = 'ઘઉં';

  String selectedWorkType = 'ખેતર તૈયાર કરવું';

  DateTime selectedDate = DateTime.now();

  // --------------------------------------------------
  // Crop → Work list
  // --------------------------------------------------

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

  // --------------------------------------------------
  // Calculated values
  // --------------------------------------------------

  double laborExpense = 0;
  double totalExpense = 0;

  @override
  void initState() {
    super.initState();

    laborController.addListener(calculateExpense);
    amountPerLaborController.addListener(calculateExpense);
    extraExpenseController.addListener(calculateExpense);
  }

  @override
  void dispose() {
    laborController.dispose();
    amountPerLaborController.dispose();
    extraExpenseController.dispose();

    super.dispose();
  }

  // ==================================================
  // CALCULATE EXPENSE
  // ==================================================

  void calculateExpense() {
    final double labor =
        double.tryParse(laborController.text) ?? 0;

    final double amountPerLabor =
        double.tryParse(amountPerLaborController.text) ?? 0;

    final double extra =
        double.tryParse(extraExpenseController.text) ?? 0;

    setState(() {
      laborExpense = labor * amountPerLabor;

      totalExpense = laborExpense + extra;
    });
  }

  // ==================================================
  // DATE
  // ==================================================

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
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

  String get formattedDate {
    return '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  // ==================================================
  // ADD EXPENSE
  // ==================================================

  void addExpense() {
    final int labor =
        int.tryParse(laborController.text) ?? 0;

    final double amountPerLabor =
        double.tryParse(amountPerLaborController.text) ?? 0;

    final double extra =
        double.tryParse(extraExpenseController.text) ?? 0;

    if (labor <= 0) {
      showMessage('મજૂરોની સંખ્યા દાખલ કરો');
      return;
    }

    if (amountPerLabor <= 0) {
      showMessage('એક મજૂરનો ખર્ચ દાખલ કરો');
      return;
    }

    final Map<String, dynamic> farmExpense = {
      'region': selectedRegion,
      'farm': selectedFarm,
      'crop': selectedCrop,
      'workType': selectedWorkType,
      'laborCount': labor,
      'amountPerLabor': amountPerLabor,
      'laborExpense': laborExpense,
      'extraExpense': extra,
      'totalExpense': totalExpense,
      'date': selectedDate.toIso8601String(),
    };

    // TODO:
    // Later send this data to Spring Boot.
    //
    // POST /api/farm-expenses

    debugPrint('Farm Expense: $farmExpense');

    showMessage('ખર્ચ સફળતાપૂર્વક ઉમેરાયો');

    Navigator.pop(context);
  }

  // ==================================================
  // MESSAGE
  // ==================================================

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ==================================================
  // BUILD
  // ==================================================

  @override
  Widget build(BuildContext context) {
    final List<String> workTypes =
        cropWorkTypes[selectedCrop] ?? ['અન્ય'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ખેતરનો ખર્ચ ઉમેરો'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const Text(
                'ખેતરના કામનો ખર્ચ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'ચોક્કસ ખેતર અને પાક માટે થયેલ ખર્ચ ઉમેરો.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // REGION
              // ------------------------------------------------

              _buildDropdown(
                label: 'વિસ્તાર (Region)',
                value: selectedRegion,
                items: const [
                  'ઉત્તર વિસ્તાર',
                  'દક્ષિણ વિસ્તાર',
                  'પૂર્વ વિસ્તાર',
                  'પશ્ચિમ વિસ્તાર',
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedRegion = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // ------------------------------------------------
              // FARM
              // ------------------------------------------------

              _buildDropdown(
                label: 'ખેતર (Farm)',
                value: selectedFarm,
                items: const [
                  'ખેતર 1',
                  'ખેતર 2',
                  'ખેતર 3',
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedFarm = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // ------------------------------------------------
              // CROP
              // ------------------------------------------------

              _buildDropdown(
                label: 'પાક (Crop)',
                value: selectedCrop,
                items: cropWorkTypes.keys.toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCrop = value;

                      // Change work automatically
                      // according to selected crop.
                      final works =
                          cropWorkTypes[value] ?? ['અન્ય'];

                      selectedWorkType = works.first;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // ------------------------------------------------
              // WORK TYPE
              // ------------------------------------------------

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

              const SizedBox(height: 16),

              // ------------------------------------------------
              // LABOR COUNT
              // ------------------------------------------------

              _buildNumberField(
                controller: laborController,
                label: 'મજૂરોની સંખ્યા',
                hint: 'ઉદાહરણ: 5',
                icon: Icons.groups_outlined,
                decimal: false,
              ),

              const SizedBox(height: 16),

              // ------------------------------------------------
              // AMOUNT PER LABOR
              // ------------------------------------------------

              _buildNumberField(
                controller: amountPerLaborController,
                label: 'એક મજૂરનો ખર્ચ',
                hint: 'ઉદાહરણ: ₹400',
                icon: Icons.currency_rupee,
              ),

              const SizedBox(height: 16),

              // ------------------------------------------------
              // EXTRA EXPENSE
              // ------------------------------------------------

              _buildNumberField(
                controller: extraExpenseController,
                label: 'વધારાનો ખર્ચ',
                hint: 'ચા, પાન મસાલા, નાસ્તો વગેરે',
                icon: Icons.add_circle_outline,
              ),

              const SizedBox(height: 10),

              const Text(
                'ચા / પાન મસાલા / નાસ્તો / અન્ય ખર્ચ',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // EXPENSE SUMMARY
              // ------------------------------------------------

              _buildSummaryCard(),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // DATE
              // ------------------------------------------------

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

                borderRadius: BorderRadius.circular(12),

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 16,
                  ),

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(12),
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

              // ------------------------------------------------
              // ADD EXPENSE BUTTON
              // ------------------------------------------------

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

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  // ==================================================
  // SUMMARY CARD
  // ==================================================

  Widget _buildSummaryCard() {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ખર્ચનો હિસાબ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            _summaryRow(
              'મજૂરનો ખર્ચ',
              '₹${laborExpense.toStringAsFixed(2)}',
            ),

            const Divider(height: 25),

            _summaryRow(
              'વધારાનો ખર્ચ',
              '₹${(double.tryParse(
                        extraExpenseController.text,
                      ) ??
                      0)
                  .toStringAsFixed(2)}',
            ),

            const Divider(height: 25),

            _summaryRow(
              'કુલ ખર્ચ',
              '₹${totalExpense.toStringAsFixed(2)}',
              bold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontWeight:
                bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 20 : 16,
            fontWeight:
                bold ? FontWeight.bold : FontWeight.w600,
            color: bold
                ? Colors.green.shade700
                : Colors.black,
          ),
        ),
      ],
    );
  }

  // ==================================================
  // DROPDOWN
  // ==================================================

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
          borderRadius: BorderRadius.circular(12),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.green.shade700,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ==================================================
  // NUMBER FIELD
  // ==================================================

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
          borderRadius: BorderRadius.circular(12),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.green.shade700,
            width: 2,
          ),
        ),
      ),
    );
  }
}
