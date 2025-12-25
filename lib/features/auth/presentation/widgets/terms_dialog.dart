// widgets/terms_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsDialog extends StatelessWidget {
  const TermsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E3A8A), Color(0xFF7E22CE)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'شرایط و قوانین ســایـرون',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Yekan',
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTermItem(
                              '1. حریم خصوصی',
                              'ما به حریم خصوصی شما احترام می‌گذاریم و اطلاعات شخصی شما را مطابق با قوانین جمهوری اسلامی ایران محافظت می‌کنیم.',
                            ),

                            _buildTermItem(
                              '2. حساب کاربری',
                              'شما مسئول حفظ امنیت حساب کاربری خود و تمام فعالیت‌هایی هستید که تحت حساب کاربری شما انجام می‌شود.',
                            ),

                            _buildTermItem(
                              '3. خرید و فروش',
                              'تمام معاملات باید مطابق با قوانین جمهوری اسلامی ایران انجام شود. ســایـرون در قبال کالاهای غیرمجاز مسئولیتی ندارد.',
                            ),

                            _buildTermItem(
                              '4. بازگرداندن کالا',
                              'مشتریان می‌توانند طبق ضوابط سایت در صورت عدم رضایت، کالا را مرجوع کنند.',
                            ),

                            _buildTermItem(
                              '5. تغییر شرایط',
                              'ســایـرون حق تغییر این شرایط را در هر زمان با اطلاع قبلی به کاربران محفوظ می‌دارد.',
                            ),

                            _buildTermItem(
                              '6. مسئولیت‌ها',
                              'کاربران موظفند اطلاعات صحیح و به‌روز خود را ارائه دهند.عواقب ثبت اطلاعات نادرست به عهده خود کاربر میباشد.',
                            ),

                            _buildTermItem(
                              '7. محتوای غیرمجاز',
                              'ارسال هرگونه محتوای غیراخلاقی، سیاسی یا مغایر با قوانین جمهوری اسلامی ایران ممنوع است.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF7E22CE),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'فهمیدم',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yekan',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Yekan',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontFamily: 'Yekan',
              height: 1.5,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
