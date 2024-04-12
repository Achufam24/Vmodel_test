import 'package:flutter/material.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';
import 'package:vmodel/src/core/widgets/text.dart';
import 'package:vmodel/src/presentation/widgets/shimmer.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(         
                  elevation: 1,   
                  color: AppColors.white,               
                    child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmer(
                          baseColor: Colors.grey[700],
                          highlightColor: Colors.grey[400],
                          child: TextBold(
                            'jknejknewkjlkmklmlkwmlkwm',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextSemiBold("", fontWeight: FontWeight.w400, color: AppColors.textPrimaryColor2,),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextSemiBold('Read More', fontSize: 14,),
                            Center(child: Icon(Icons.arrow_right_alt))
                          ],
                        ),
                      
                      ],
                    ),
                      ),
                ),
                SizedBox(height: 10,),
                  ],
                );
              },
                
            ),
            );
  }
}