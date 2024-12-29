import 'dart:developer';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../functions/validators/validators.dart';
import 'custom_text_form_field.dart';

class CountryInputField extends StatefulWidget {
  final Function(String?)? onInputChanged;
  final Function(String)? onSelectCode;

  const CountryInputField({
    super.key,
    this.onInputChanged,
    this.onSelectCode,
  });

  @override
  State<CountryInputField> createState() => _CountryInputFieldState();
}

class _CountryInputFieldState extends State<CountryInputField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.text = 'Egypt';
    widget.onInputChanged?.call('Egypt');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Country _selectedCountry = Country(
    isoCode: 'EG',
    iso3Code: 'EGY',
    phoneCode: '20',
    name: 'Egypt',
  );

  void _openCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final locale = S.of(context);
        return Theme(
          data: Theme.of(context),
          child: CountryPickerDialog(
            title: Text(locale.country),
            titlePadding: EdgeInsets.all(4.0.r),
            searchCursorColor: Theme.of(context).primaryColor,
            searchInputDecoration:
                InputDecoration(hintText: '${locale.search}...'),
            isSearchable: true,
            onValuePicked: (Country country) {
              if (kDebugMode) {
                log(country.isoCode, name: 'isoCode');
                log(country.iso3Code, name: 'iso3Code');
                log(country.phoneCode, name: 'phoneCode');
                log(country.name, name: 'name');
              }
              widget.onSelectCode?.call(country.phoneCode);
              widget.onInputChanged?.call(country.name);
              controller.text = country.name;
              _selectedCountry = country;
              setState(() {});
            },
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('EG'),
            ],
            itemBuilder: (country) {
              return _buildDialogItem(country, false);
            },
          ),
        );
      },
    );
  }

  Widget _buildDialogItem(Country country, bool isSelected) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 40.w,
          height: 25.h,
          child: CountryPickerUtils.getDefaultFlagImage(country),
        ),
        isSelected ? 4.horizontalSpace : 8.horizontalSpace,
        Flexible(
          child: Text(country.name),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);

    return CustomTextFormField(
      controller: controller,
      hintText: locale.country,
      labelText: locale.country,
      validator: (value) => Validators.validateNotEmpty(
        title: locale.country,
        value: value,
      ),
      keyBordType: TextInputType.phone,
      onChanged: widget.onInputChanged,
      isFilled: true,
      readOnly: true,
      suffixIcon: GestureDetector(
        onTap: () => _openCountryPickerDialog(),
        child: const Icon(Icons.keyboard_arrow_down_rounded),
      ),
      prefixIcon: GestureDetector(
        onTap: () => _openCountryPickerDialog(),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
          ),
          child: IntrinsicWidth(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 35.w,
                  height: 20.h,
                  child:
                      CountryPickerUtils.getDefaultFlagImage(_selectedCountry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
