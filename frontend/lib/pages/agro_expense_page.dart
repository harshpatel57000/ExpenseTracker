import 'package:flutter/material.dart';

class AgroExpensePage extends StatefulWidget {
  const AgroExpensePage({super.key});

  @override
  State<AgroExpensePage> createState() => _AgroExpensePageState();
}

class _AgroExpensePageState extends State<AgroExpensePage> {
  // --------------------------------------------------
  // Controllers
  // --------------------------------------------------

  final TextEditingController productNameController =
      TextEditingController();

  final TextEditingController weightController =
      TextEditingController();

  final TextEditingController quantityController =
      TextEditingController();

  final TextEditingController priceController =
      TextEditingController();

  // --------------------------------------------------
  // Selected units
  // --------------------------------------------------

  String selectedWeightUnit = 'kg';
  String selectedQuantityUnit = 'Bag';

  // --------------------------------------------------
  // Purchase date
  // --------------------------------------------------

  DateTime selectedDate = DateTime.now();

  // --------------------------------------------------
  // Calculated values
  // --------------------------------------------------

  double totalWeight = 0;
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();

    // Recalculate whenever user changes values.
    weightController.addListener(calculateTotals);
    quantityController.addListener(calculateTotals);
    priceController.addListener(calculateTotals);
  }

  @override
  void dispose() {
    productNameController.dispose();
    weightController.dispose();
    quantityController.dispose();
    priceController.dispose();

    super.dispose();
  }

  // ==================================================
  // CALCULATE TOTALS
  // ==================================================

  void calculateTotals() {
    final double weight =
        double.tryParse(weightController.text) ?? 0;

    final double quantity =
        double.tryParse(quantityController.text) ?? 0;

    final double price =
        double.tryParse(priceController.text) ?? 0;

    setState(() {
      // Example:
      //
      // Weight per bag = 45 kg
      // Number of bags = 3
      //
      // Total weight = 45 × 3
      //               = 135 kg

      totalWeight = weight * quantity;

      // Example:
      //
      // Price per bag = ₹300
      // Number of bags = 3
      //
      // Total amount = 300 × 3
      //              = ₹900

      totalAmount = price * quantity;
    });
  }

  // ==================================================
  // SELECT DATE
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

  // ==================================================
  // FORMAT DATE
  // ==================================================

  String get formattedDate {
    return '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  // ==================================================
  // ADD AGRO EXPENSE
  // ==================================================

  void addAgroExpense() {
    final String productName =
        productNameController.text.trim();

    final double weight =
        double.tryParse(weightController.text) ?? 0;

    final double quantity =
        double.tryParse(quantityController.text) ?? 0;

    final double price =
        double.tryParse(priceController.text) ?? 0;

    // --------------------------------------------------
    // Validation
    // --------------------------------------------------

    if (productName.isEmpty) {
      showMessage('Please enter product name');
      return;
    }

    if (weight <= 0) {
      showMessage('Please enter valid weight');
      return;
    }

    if (quantity <= 0) {
      showMessage('Please enter valid quantity');
      return;
    }

    if (price <= 0) {
      showMessage('Please enter valid price');
      return;
    }

    // --------------------------------------------------
    // Purchase information
    // --------------------------------------------------

    /*
      Example:

      Product       = Urea
      Weight/unit   = 45 kg
      Quantity      = 3 bags
      Price/unit    = ₹300

      Total quantity = 45 × 3
                     = 135 kg

      Total amount   = 300 × 3
                     = ₹900
    */

    final Map<String, dynamic> agroExpense = {
      'productName': productName,
      'weightPerUnit': weight,
      'weightUnit': selectedWeightUnit,
      'quantity': quantity,
      'quantityUnit': selectedQuantityUnit,
      'pricePerUnit': price,
      'totalWeight': totalWeight,
      'totalAmount': totalAmount,
      'purchaseDate': selectedDate.toIso8601String(),
    };

    // TODO:
    // Later send this object to Spring Boot API.
    //
    // Example:
    //
    // POST /api/agro-expenses
    //
    // The backend will save the purchase
    // and create/update agro-product inventory.

    debugPrint('Agro Expense: $agroExpense');

    showMessage(
      'Agro expense added successfully',
    );

    // Return to previous page.
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Agro Expense'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // ------------------------------------------------
              // HEADER
              // ------------------------------------------------

              const Text(
                'Agro Product Purchase',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Record a product purchased for future farm use.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // PRODUCT NAME
              // ------------------------------------------------

              _buildTextField(
                controller: productNameController,
                label: 'Product Name',
                hint: 'Example: Urea',
                icon: Icons.inventory_2_outlined,
              ),

              const SizedBox(height: 18),

              // ------------------------------------------------
              // WEIGHT PER UNIT
              // ------------------------------------------------

              const Text(
                'Weight per Unit',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [

                  Expanded(
                    child: _buildNumberField(
                      controller: weightController,
                      hint: 'Example: 45',
                      icon: Icons.scale_outlined,
                    ),
                  ),

                  const SizedBox(width: 10),

                  SizedBox(
                    width: 110,
                    child: _buildDropdown(
                      value: selectedWeightUnit,
                      items: const [
                        'kg',
                        'gram',
                        'litre',
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedWeightUnit = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ------------------------------------------------
              // NUMBER OF UNITS
              // ------------------------------------------------

              const Text(
                'Number of Units',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [

                  Expanded(
                    child: _buildNumberField(
                      controller: quantityController,
                      hint: 'Example: 3',
                      icon: Icons.numbers_outlined,
                    ),
                  ),

                  const SizedBox(width: 10),

                  SizedBox(
                    width: 110,
                    child: _buildDropdown(
                      value: selectedQuantityUnit,
                      items: const [
                        'Bag',
                        'Bottle',
                        'Packet',
                        'Box',
                        'Unit',
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedQuantityUnit = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ------------------------------------------------
              // PRICE PER UNIT
              // ------------------------------------------------

              _buildNumberField(
                controller: priceController,
                label: 'Price per Unit',
                hint: 'Example: 300',
                icon: Icons.currency_rupee,
              ),

              const SizedBox(height: 22),

              // ------------------------------------------------
              // CALCULATION CARD
              // ------------------------------------------------

              _buildCalculationCard(),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // PURCHASE DATE
              // ------------------------------------------------

              const Text(
                'Purchase Date',
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
              // ADD BUTTON
              // ------------------------------------------------

              SizedBox(
                height: 54,

                child: ElevatedButton.icon(
                  onPressed: addAgroExpense,

                  icon: const Icon(
                    Icons.add,
                  ),

                  label: const Text(
                    'Add Agro Expense',
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

              const SizedBox(height: 15),

              // ------------------------------------------------
              // INFORMATION
              // ------------------------------------------------

              Container(
                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: Colors.green.shade50,

                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Icon(
                      Icons.info_outline,
                      color: Colors.green,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        'The purchased product can be used later '
                        'on different farms or different crop cycles. '
                        'When the product is used, its quantity and '
                        'cost will be added to the selected farm expense.',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================================================
  // CALCULATION CARD
  // ==================================================

  Widget _buildCalculationCard() {
    return Card(
      elevation: 2,

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Purchase Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Total quantity
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'Total Quantity',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                Text(
                  '${_formatNumber(totalWeight)} $selectedWeightUnit',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const Divider(height: 25),

            // Total amount
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'Total Amount',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                Text(
                  '₹${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green.shade700,
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==================================================
  // TEXT FIELD
  // ==================================================

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
    String? label,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,

      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),

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

  // ==================================================
  // DROPDOWN
  // ==================================================

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,

      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),

      onChanged: onChanged,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ==================================================
  // FORMAT NUMBER
  // ==================================================

  String _formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }
}