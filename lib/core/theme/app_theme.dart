import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness_app/core/constants/app_constants.dart';

class AppTheme {
  static const _pL = Color(0xFF2E7D32);
  static const _pD = Color(0xFF4CAF50);
  static const _sL = Color(0xFF0288D1);
  static const _sD = Color(0xFF29B6F6);
  static const _aL = Color(0xFFFF9800);
  static const _aD = Color(0xFFFFB74D);
  static const _eL = Color(0xFFD32F2F);
  static const _eD = Color(0xFFEF5350);
  static const _bL = Color(0xFFF5F7FA);
  static const _bD = Color(0xFF121212);
  static const _sfL = Color(0xFFFFFFFF);
  static const _sfD = Color(0xFF1E1E1E);
  static const _svL = Color(0xFFF0F2F5);
  static const _svD = Color(0xFF2C2C2C);
  static const _onPL = Color(0xFFFFFFFF);
  static const _onPD = Color(0xFF000000);
  static const _onSL = Color(0xFFFFFFFF);
  static const _onSD = Color(0xFF000000);
  static const _onBL = Color(0xFF1A1A2E);
  static const _onBD = Color(0xFFFFFFFF);
  static const _onSfL = Color(0xFF1A1A2E);
  static const _onSfD = Color(0xFFFFFFFF);
  static const _onSvL = Color(0xFF4A4A5A);
  static const _onSvD = Color(0xFFB0B0B0);
  static const _outL = Color(0xFFE0E0E0);
  static const _outD = Color(0xFF404040);
  static const _shL = Color(0x1A000000);
  static const _shD = Color(0x33000000);

  static ThemeData get lightTheme {
    const cs = ColorScheme(
      brightness: Brightness.light, primary: _pL, onPrimary: _onPL,
      primaryContainer: Color(0xFFE8F5E9), onPrimaryContainer: Color(0xFF1B5E20),
      secondary: _sL, onSecondary: _onSL, secondaryContainer: Color(0xFFE3F2FD),
      onSecondaryContainer: Color(0xFF01579B), tertiary: _aL, onTertiary: _onPL,
      tertiaryContainer: Color(0xFFFFF3E0), onTertiaryContainer: Color(0xFFE65100),
      error: _eL, onError: _onPL, errorContainer: Color(0xFFFFEBEE),
      onErrorContainer: Color(0xFFC62828), surface: _sfL, onSurface: _onSfL,
      surfaceContainerHighest: _svL, onSurfaceVariant: _onSvL,
      outline: _outL, outlineVariant: _outL, shadow: _shL, scrim: _shL,
      inverseSurface: _sfD, onInverseSurface: _onSfD, inversePrimary: _pD,
    );

    return ThemeData(useMaterial3: true, colorScheme: cs, fontFamily: GoogleFonts.cairo().fontFamily,
      textTheme: _tt(false), appBarTheme: AppBarTheme(elevation: 0, centerTitle: true, scrolledUnderElevation: 1,
        backgroundColor: _sfL, foregroundColor: _onSfL, titleTextStyle: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: _onSfL),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark)),
      cardTheme: CardThemeData(elevation: AppConstants.defaultElevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        color: _sfL, shadowColor: _shL, surfaceTintColor: Colors.transparent),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: AppConstants.largePadding, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _pL, foregroundColor: _onPL, textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600))
        .copyWith(overlayColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.pressed) ? _pL.withValues(alpha: 0.1) : null))),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.largePadding, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        side: BorderSide(color: _pL, width: 1.5), foregroundColor: _pL, textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600))),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        foregroundColor: _pL, textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600))),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.largePadding, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _pL, foregroundColor: _onPL, textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: _svL,
        contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide(color: _outL, width: 1)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide(color: _pL, width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide(color: _eL, width: 1)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide(color: _eL, width: 2)),
        labelStyle: GoogleFonts.cairo(color: _onSvL, fontSize: 16), hintStyle: GoogleFonts.cairo(color: _onSvL.withValues(alpha: 0.6), fontSize: 16),
        errorStyle: GoogleFonts.cairo(color: _eL, fontSize: 12), floatingLabelStyle: GoogleFonts.cairo(color: _pL, fontSize: 14),
        prefixIconColor: _onSvL, suffixIconColor: _onSvL),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(elevation: AppConstants.highElevation, selectedItemColor: _pL, unselectedItemColor: _onSvL,
        selectedLabelStyle: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed, backgroundColor: _sfL, landscapeLayout: BottomNavigationBarLandscapeLayout.centered),
      navigationBarTheme: NavigationBarThemeData(elevation: AppConstants.highElevation, indicatorColor: _pL.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((s) => GoogleFonts.cairo(fontSize: 12, fontWeight: s.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w400, color: s.contains(WidgetState.selected) ? _pL : _onSvL)),
        backgroundColor: _sfL, surfaceTintColor: Colors.transparent),
      tabBarTheme: TabBarThemeData(labelColor: _pL, unselectedLabelColor: _onSvL, indicatorColor: _pL, indicatorSize: TabBarIndicatorSize.label,
        labelStyle: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w400), dividerColor: Colors.transparent),
      chipTheme: ChipThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        labelStyle: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w500), padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: 8),
        backgroundColor: _svL, selectedColor: _pL.withValues(alpha: 0.1), checkmarkColor: _pL, side: BorderSide(color: _outL)),
      dialogTheme: DialogThemeData(elevation: AppConstants.highElevation, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius)),
        backgroundColor: _sfL, surfaceTintColor: Colors.transparent, titleTextStyle: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: _onSfL),
        contentTextStyle: GoogleFonts.cairo(fontSize: 16, color: _onSvL)),
      bottomSheetTheme: BottomSheetThemeData(elevation: AppConstants.highElevation, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppConstants.largeBorderRadius))),
        backgroundColor: _sfL, surfaceTintColor: Colors.transparent, modalBackgroundColor: _sfL, showDragHandle: true, dragHandleColor: _outL, dragHandleSize: Size(40, 4)),
      snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _onSfL.withValues(alpha: 0.9), contentTextStyle: GoogleFonts.cairo(fontSize: 14, color: _sfL), actionTextColor: _aL, elevation: AppConstants.highElevation),
      floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: AppConstants.highElevation, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _pL, foregroundColor: _onPL, extendedTextStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600)),
      dividerTheme: DividerThemeData(color: _outL, thickness: 1, space: 1),
      listTileTheme: ListTileThemeData(contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        titleTextStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600, color: _onSfL), subtitleTextStyle: GoogleFonts.cairo(fontSize: 14, color: _onSvL),
        leadingAndTrailingTextStyle: GoogleFonts.cairo(fontSize: 14, color: _onSvL), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        tileColor: Colors.transparent, selectedTileColor: _pL.withValues(alpha: 0.1)),
      expansionTileTheme: ExpansionTileThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _svL, collapsedBackgroundColor: _svL, textColor: _onSfL, iconColor: _onSvL, collapsedTextColor: _onSfL, collapsedIconColor: _onSvL,
        tilePadding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding)),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: _pL, linearTrackColor: _svL, circularTrackColor: _svL),
      sliderTheme: SliderThemeData(activeTrackColor: _pL, inactiveTrackColor: _svL, thumbColor: _pL, overlayColor: _pL.withValues(alpha: 0.1), valueIndicatorColor: _pL,
        valueIndicatorTextStyle: GoogleFonts.cairo(color: _onPL, fontSize: 12)),
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pL : _outL),
        trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pL.withValues(alpha: 0.5) : _svL),
        trackOutlineColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pL : _outL)),
      checkboxTheme: CheckboxThemeData(fillColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pL : Colors.transparent),
        checkColor: WidgetStateProperty.all(_onPL), side: BorderSide(color: _outL, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pL : _outL)),
      datePickerTheme: DatePickerThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius)), backgroundColor: _sfL, surfaceTintColor: Colors.transparent,
        headerBackgroundColor: _pL, headerForegroundColor: _onPL, dayBackgroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pL : Colors.transparent),
        dayForegroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _onPL : _onSfL), yearBackgroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pL : Colors.transparent),
        yearForegroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _onPL : _onSfL)),
      timePickerTheme: TimePickerThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius)), backgroundColor: _sfL,
        hourMinuteTextColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _onPL : _onSfL).resolve({}),
        hourMinuteColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pL : Colors.transparent).resolve({}),
        dayPeriodTextColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _onPL : _onSfL).resolve({}),
        dayPeriodColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pL : Colors.transparent).resolve({}),
        dialHandColor: _pL, dialBackgroundColor: _svL, entryModeIconColor: _pL),
      popupMenuTheme: PopupMenuThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)), color: _sfL, surfaceTintColor: Colors.transparent, elevation: AppConstants.highElevation, textStyle: GoogleFonts.cairo(fontSize: 14, color: _onSfL)),
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: _onSfL.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius)), textStyle: GoogleFonts.cairo(fontSize: 12, color: _sfL), padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      extensions: [_CustomColorsLight()],
    );
  }

  static ThemeData get darkTheme {
    const cs = ColorScheme(
      brightness: Brightness.dark, primary: _pD, onPrimary: _onPD,
      primaryContainer: Color(0xFF1B5E20), onPrimaryContainer: Color(0xFFC8E6C9),
      secondary: _sD, onSecondary: _onSD, secondaryContainer: Color(0xFF01579B),
      onSecondaryContainer: Color(0xFFBBDEFB), tertiary: _aD, onTertiary: _onPD,
      tertiaryContainer: Color(0xFFE65100), onTertiaryContainer: Color(0xFFFFF3E0),
      error: _eD, onError: _onPD, errorContainer: Color(0xFFC62828), onErrorContainer: Color(0xFFFFEBEE),
      surface: _sfD, onSurface: _onSfD, surfaceContainerHighest: _svD, onSurfaceVariant: _onSvD,
      outline: _outD, outlineVariant: _outD, shadow: _shD, scrim: _shD,
      inverseSurface: _sfL, onInverseSurface: _onSfL, inversePrimary: _pL,
    );

    return ThemeData(useMaterial3: true, colorScheme: cs, fontFamily: GoogleFonts.cairo().fontFamily,
      textTheme: _tt(true), appBarTheme: AppBarTheme(elevation: 0, centerTitle: true, scrolledUnderElevation: 1,
        backgroundColor: _sfD, foregroundColor: _onSfD, titleTextStyle: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: _onSfD),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light)),
      cardTheme: CardThemeData(elevation: AppConstants.defaultElevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        color: _sfD, shadowColor: _shD, surfaceTintColor: Colors.transparent),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: AppConstants.largePadding, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _pD, foregroundColor: _onPD, textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600))
        .copyWith(overlayColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.pressed) ? _pD.withValues(alpha: 0.1) : null))),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.largePadding, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        side: BorderSide(color: _pD, width: 1.5), foregroundColor: _pD, textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600))),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        foregroundColor: _pD, textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600))),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.largePadding, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _pD, foregroundColor: _onPD, textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: _svD,
        contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide(color: _outD, width: 1)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide(color: _pD, width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide(color: _eD, width: 1)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius), borderSide: BorderSide(color: _eD, width: 2)),
        labelStyle: GoogleFonts.cairo(color: _onSvD, fontSize: 16), hintStyle: GoogleFonts.cairo(color: _onSvD.withValues(alpha: 0.6), fontSize: 16),
        errorStyle: GoogleFonts.cairo(color: _eD, fontSize: 12), floatingLabelStyle: GoogleFonts.cairo(color: _pD, fontSize: 14),
        prefixIconColor: _onSvD, suffixIconColor: _onSvD),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(elevation: AppConstants.highElevation, selectedItemColor: _pD, unselectedItemColor: _onSvD,
        selectedLabelStyle: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed, backgroundColor: _sfD, landscapeLayout: BottomNavigationBarLandscapeLayout.centered),
      navigationBarTheme: NavigationBarThemeData(elevation: AppConstants.highElevation, indicatorColor: _pD.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((s) => GoogleFonts.cairo(fontSize: 12, fontWeight: s.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w400, color: s.contains(WidgetState.selected) ? _pD : _onSvD)),
        backgroundColor: _sfD, surfaceTintColor: Colors.transparent),
      tabBarTheme: TabBarThemeData(labelColor: _pD, unselectedLabelColor: _onSvD, indicatorColor: _pD, indicatorSize: TabBarIndicatorSize.label,
        labelStyle: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w400), dividerColor: Colors.transparent),
      chipTheme: ChipThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        labelStyle: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w500), padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: 8),
        backgroundColor: _svD, selectedColor: _pD.withValues(alpha: 0.1), checkmarkColor: _pD, side: BorderSide(color: _outD)),
      dialogTheme: DialogThemeData(elevation: AppConstants.highElevation, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius)),
        backgroundColor: _sfD, surfaceTintColor: Colors.transparent, titleTextStyle: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w700, color: _onSfD),
        contentTextStyle: GoogleFonts.cairo(fontSize: 16, color: _onSvD)),
      bottomSheetTheme: BottomSheetThemeData(elevation: AppConstants.highElevation, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppConstants.largeBorderRadius))),
        backgroundColor: _sfD, surfaceTintColor: Colors.transparent, modalBackgroundColor: _sfD, showDragHandle: true, dragHandleColor: _outD, dragHandleSize: Size(40, 4)),
      snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _onSfD.withValues(alpha: 0.9), contentTextStyle: GoogleFonts.cairo(fontSize: 14, color: _sfD), actionTextColor: _aD, elevation: AppConstants.highElevation),
      floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: AppConstants.highElevation, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _pD, foregroundColor: _onPD, extendedTextStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600)),
      dividerTheme: DividerThemeData(color: _outD, thickness: 1, space: 1),
      listTileTheme: ListTileThemeData(contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        titleTextStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600, color: _onSfD), subtitleTextStyle: GoogleFonts.cairo(fontSize: 14, color: _onSvD),
        leadingAndTrailingTextStyle: GoogleFonts.cairo(fontSize: 14, color: _onSvD), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        tileColor: Colors.transparent, selectedTileColor: _pD.withValues(alpha: 0.1)),
      expansionTileTheme: ExpansionTileThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)),
        backgroundColor: _svD, collapsedBackgroundColor: _svD, textColor: _onSfD, iconColor: _onSvD, collapsedTextColor: _onSfD, collapsedIconColor: _onSvD,
        tilePadding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding)),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: _pD, linearTrackColor: _svD, circularTrackColor: _svD),
      sliderTheme: SliderThemeData(activeTrackColor: _pD, inactiveTrackColor: _svD, thumbColor: _pD, overlayColor: _pD.withValues(alpha: 0.1), valueIndicatorColor: _pD,
        valueIndicatorTextStyle: GoogleFonts.cairo(color: _onPD, fontSize: 12)),
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pD : _outD),
        trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pD.withValues(alpha: 0.5) : _svD),
        trackOutlineColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pD : _outD)),
      checkboxTheme: CheckboxThemeData(fillColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pD : Colors.transparent),
        checkColor: WidgetStateProperty.all(_onPD), side: BorderSide(color: _outD, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pD : _outD)),
      datePickerTheme: DatePickerThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius)), backgroundColor: _sfD, surfaceTintColor: Colors.transparent,
        headerBackgroundColor: _pD, headerForegroundColor: _onPD, dayBackgroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pD : Colors.transparent),
        dayForegroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _onPD : _onSfD), yearBackgroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pD : Colors.transparent),
        yearForegroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _onPD : _onSfD)),
      timePickerTheme: TimePickerThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius)), backgroundColor: _sfD,
        hourMinuteTextColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _onPD : _onSfD).resolve({}),
        hourMinuteColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pD : Colors.transparent).resolve({}),
        dayPeriodTextColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _onPD : _onSfD).resolve({}),
        dayPeriodColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? _pD : Colors.transparent).resolve({}),
        dialHandColor: _pD, dialBackgroundColor: _svD, entryModeIconColor: _pD),
      popupMenuTheme: PopupMenuThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius)), color: _sfD, surfaceTintColor: Colors.transparent, elevation: AppConstants.highElevation, textStyle: GoogleFonts.cairo(fontSize: 14, color: _onSfD)),
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: _onSfD.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius)), textStyle: GoogleFonts.cairo(fontSize: 12, color: _sfD), padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      extensions: [_CustomColorsDark()],
    );
  }

  static TextTheme _tt(bool d) {
    final os = d ? _onSfD : _onSfL;
    final osv = d ? _onSvD : _onSvL;
    return TextTheme(
      displayLarge: GoogleFonts.cairo(fontSize: 57, fontWeight: FontWeight.w700, color: os, letterSpacing: -0.25),
      displayMedium: GoogleFonts.cairo(fontSize: 45, fontWeight: FontWeight.w700, color: os),
      displaySmall: GoogleFonts.cairo(fontSize: 36, fontWeight: FontWeight.w600, color: os),
      headlineLarge: GoogleFonts.cairo(fontSize: 32, fontWeight: FontWeight.w700, color: os),
      headlineMedium: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w600, color: os),
      headlineSmall: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.w600, color: os),
      titleLarge: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w600, color: os),
      titleMedium: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600, color: os, letterSpacing: 0.15),
      titleSmall: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: os, letterSpacing: 0.1),
      labelLarge: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: os, letterSpacing: 0.1),
      labelMedium: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w500, color: osv, letterSpacing: 0.5),
      labelSmall: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.w500, color: osv, letterSpacing: 0.5),
      bodyLarge: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w400, color: os, letterSpacing: 0.15, height: 1.5),
      bodyMedium: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w400, color: os, letterSpacing: 0.25, height: 1.5),
      bodySmall: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w400, color: osv, letterSpacing: 0.4, height: 1.5),
    );
  }
}

class _CustomColorsLight extends ThemeExtension<_CustomColorsLight> {
  const _CustomColorsLight();
  @override _CustomColorsLight copyWith() => const _CustomColorsLight();
  @override _CustomColorsLight lerp(ThemeExtension<_CustomColorsLight>? o, double t) => this;
  Color get primaryGradientStart => const Color(0xFF2E7D32);
  Color get primaryGradientEnd => const Color(0xFF4CAF50);
  Color get secondaryGradientStart => const Color(0xFF0288D1);
  Color get secondaryGradientEnd => const Color(0xFF29B6F6);
  Color get accentGradientStart => const Color(0xFFFF9800);
  Color get accentGradientEnd => const Color(0xFFFFB74D);
  Color get successColor => const Color(0xFF388E3C);
  Color get warningColor => const Color(0xFFF57C00);
  Color get infoColor => const Color(0xFF0288D1);
  Color get cardGradientStart => const Color(0xFFFFFFFF);
  Color get cardGradientEnd => const Color(0xFFF5F7FA);
  Color get shimmerBase => const Color(0xFFE0E0E0);
  Color get shimmerHighlight => const Color(0xFFF5F5F5);
}

class _CustomColorsDark extends ThemeExtension<_CustomColorsDark> {
  const _CustomColorsDark();
  @override _CustomColorsDark copyWith() => const _CustomColorsDark();
  @override _CustomColorsDark lerp(ThemeExtension<_CustomColorsDark>? o, double t) => this;
  Color get primaryGradientStart => const Color(0xFF1B5E20);
  Color get primaryGradientEnd => const Color(0xFF4CAF50);
  Color get secondaryGradientStart => const Color(0xFF01579B);
  Color get secondaryGradientEnd => const Color(0xFF29B6F6);
  Color get accentGradientStart => const Color(0xFFE65100);
  Color get accentGradientEnd => const Color(0xFFFFB74D);
  Color get successColor => const Color(0xFF66BB6A);
  Color get warningColor => const Color(0xFFFFB74D);
  Color get infoColor => const Color(0xFF29B6F6);
  Color get cardGradientStart => const Color(0xFF1E1E1E);
  Color get cardGradientEnd => const Color(0xFF2C2C2C);
  Color get shimmerBase => const Color(0xFF2C2C2C);
  Color get shimmerHighlight => const Color(0xFF3C3C3C);
}