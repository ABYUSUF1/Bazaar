import 'package:bazaar/core/utils/app_assets.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_text_styles.dart';

class LocationButton extends StatefulWidget {
  const LocationButton({super.key});

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  // Initial selected country
  String selectedCountry = 'Egypt';

  // List of countries with flags
  final List<Map<String, String>> countries = [
    {
      'name': 'Egypt',
      'flag': AppAssets.imagesFlagsEgyptFlag,
    },
    {
      'name': 'UAE',
      'flag': AppAssets.imagesFlagsUaeFlag,
    },
    {
      'name': 'Saudi Arabia',
      'flag': AppAssets.imagesFlagsSaudiFlag,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize:
          MainAxisSize.min, // Ensures row takes only the necessary space
      children: [
        SvgPicture.asset(AppAssets.imagesIconsLocation, width: 20, height: 20),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '  ${LocaleKeys.home_deliver_to.tr()}',
              style: AppTextStyles.style12Normal,
            ),
            // DropdownButton for selecting country
            SizedBox(
              height: 30,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    focusColor: Colors.transparent,
                    value: selectedCountry,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountry = newValue!;
                      });
                    },
                    items: countries.map<DropdownMenuItem<String>>((country) {
                      return DropdownMenuItem<String>(
                        value: country['name'],
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              country['flag']!,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              country['name']!,
                              style: AppTextStyles.style14Normal,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
