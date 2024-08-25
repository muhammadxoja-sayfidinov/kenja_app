import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

class CardPaymentBottomSheet extends StatefulWidget {
  @override
  _CardPaymentBottomSheetState createState() => _CardPaymentBottomSheetState();
}

class _CardPaymentBottomSheetState extends State<CardPaymentBottomSheet> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  String _cardType = '';
  bool _isVisa = false;

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_checkCardType);
  }

  void _checkCardType() {
    String cardNumber = _cardNumberController.text.replaceAll(' ', '');
    if (cardNumber.startsWith('4')) {
      setState(() {
        _cardType = 'assets/images/visa.png';
        _isVisa = true;
      });
    } else if (cardNumber.startsWith('9' '5')) {
      setState(() {
        _cardType = 'assets/images/uzcard.png';
        _isVisa = false;
      });
    } else {
      setState(() {
        _cardType = '';
        _isVisa = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Karta orqali to\'lash',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          _buildCardNumberField(),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildExpiryDateField()),
              SizedBox(width: _isVisa ? 16.w : 0),
              if (_isVisa) Expanded(child: _buildCvvField()),
            ],
          ),
          SizedBox(height: 24.h),
          MyNextBottom(
            onTap: () {
              // To'lash amalini bajarish
            },
            text: 'To\'lash',
          ),
        ],
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextField(
      controller: _cardNumberController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Karta raqami',
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: darkColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        suffixIcon: _cardType.isNotEmpty
            ? Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(_cardType),
              )
            : null,
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildExpiryDateField() {
    return TextField(
      controller: _expiryDateController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Amal qilish muddati',
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: darkColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildCvvField() {
    return TextField(
      controller: _cvvController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'CVV',
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: darkColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
