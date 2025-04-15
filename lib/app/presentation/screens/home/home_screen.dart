import 'package:challenge_mobile_multi/app/core/utils/app_assets.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_fonts.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/button.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedValue = 'Português';
    return DefaultScaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 16,
        backgroundColor: Colors.transparent,
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                AppAssets.svgIconProfile,
              ),
            ),
          ),
        ],
        title: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Idioma', 
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontFamily: AppFonts.montserratMedium,
                ),
              ),
              Row(
                spacing: 4,
                children: [
                  SvgPicture.asset(
                    AppAssets.svgIconLocation,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedValue,
                    underline: const SizedBox(), // tira aquela linha padrão
                    isDense: true, // reduz o tamanho interno
                    dropdownColor: Colors.transparent,
                    style: const TextStyle(color: AppColors.white), 
                    iconEnabledColor: Colors.white,
                    padding: EdgeInsets.zero,
                    onChanged: (String? newValue) {
                      
                    },
                    items: ['Português', 'Inglês'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value, 
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontFamily: AppFonts.montserratMedium,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Button(text: 'Teste', radius: 12, onTap: () {}),
      ),
    );
  }
}
