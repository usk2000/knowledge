# MaterialTimePicker


UnsupportedOperationException MaterialTimePicker getColor

Themeの設定が必要
[MaterialTimePicker as an upgrade of the TimePickerDialog | by Patryk Kubiak | Medium](https://kubiakdev.medium.com/materialtimepicker-as-an-upgrade-of-timepickerdialog-d1d0c92308cc)

MaterialTimePicker.javaを確認すると、原因が分かった
> R.styleable.MaterialTimePicker_backgroundTint
> 


https://stackoverflow.com/questions/62086854/how-to-change-theme-of-materialdatepicker-in-android


> layout/material_time_chip: Error inflating class com.google.android.material.chip.Chip
> 

このエラーになった


> MaterialComponents You need to use a Theme.AppCompat theme (or descendant) with this activity.
> 

[Android - You need to use a Theme.AppCompat theme (or descendant) with this activity - GeeksforGeeks](https://www.geeksforgeeks.org/android-you-need-to-use-a-theme-appcompat-theme-or-descendant-with-this-activity/)

これが解決策？


> 2024-07-22 21:53:59.539 23685-23685 AndroidRuntime          jp.summervacation.shiftkaigo         E  Caused by: android.view.InflateException: Binary XML file line #42 in jp.summervacation.shiftkaigo:layout/material_timepicker: Binary XML file line #36: You must supply a layout_height attribute., theme={InheritanceMap=[id=0x7f12048ajp.summervacation.shiftkaigo:style/Theme.MyApp, id=0x7f12026fjp.summervacation.shiftkaigo:style/Theme.MaterialComponents.DayNight.NoActionBar, id=0x7f120288jp.summervacation.shiftkaigo:style/Theme.MaterialComponents.Light.NoActionBar, id=0x7f12027ajp.summervacation.shiftkaigo:style/Theme.MaterialComponents.Light, id=0x7f120070jp.summervacation.shiftkaigo:style/Base.Theme.MaterialComponents.Light, id=0x7f1200a9jp.summervacation.shiftkaigo:style/Base.V21.Theme.MaterialComponents.Light, id=0x7f120097jp.summervacation.shiftkaigo:style/Base.V14.Theme.MaterialComponents.Light, id=0x7f120098jp.summervacation.shiftkaigo:style/Base.V14.Theme.MaterialComponents.Light.Bridge, id=0x7f12014djp.summervacation.shiftkaigo:style/Platform.MaterialComponents.Light, id=0x7f120231jp.summervacation.shiftkaigo:style/Theme.AppCompat.Light, id=0x7f120054jp.summervacation.shiftkaigo:style/Base.Theme.AppCompat.Light, id=0x7f1200bbjp.summervacation.shiftkaigo:style/Base.V28.Theme.AppCompat.Light, id=0x7f1200b8jp.summervacation.shiftkaigo:style/Base.V26.Theme.AppCompat.Light, id=0x7f1200b2jp.summervacation.shiftkaigo:style/Base.V23.Theme.AppCompat.Light, id=0x7f1200b0jp.summervacation.shiftkaigo:style/Base.V22.Theme.AppCompat.Light, id=0x7f1200a5jp.summervacation.shiftkaigo:style/Base.V21.Theme.AppCompat.Light, id=0x7f1200bejp.summervacation.shiftkaigo:style/Base.V7.Theme.AppCompat.Light, id=0x7f12014ajp.summervacation.shiftkaigo:style/Platform.AppCompat.Light, id=0x7f120155jp.summervacation.shiftkaigo:style/Platform.V25.AppCompat.Light, id=0x1030241android:style/Theme.Material.Light.NoActionBar, id=0x1030237android:style/Theme.Material.Light, id=0x103000candroid:style/Theme.Light, id=0x1030005android:style/Theme], Themes=[jp.summervacation.shiftkaigo:style/Theme.MyApp, forced, jp.summervacation.shiftkaigo:style/Theme.AppCompat.Empty, forced, android:style/Theme.DeviceDefault.Light.DarkActionBar, forced]}

このエラーがまだ出る


[\[MaterialTimePicker\] Error Inflating MaterialTimePicker, missing layout_height attribute · Issue #1955 · material-components/material-components-android · GitHub](https://github.com/material-components/material-components-android/issues/1955)
これが原因？

```
        MaterialTimePicker picker = new MaterialTimePicker.Builder()
                .setTimeFormat(TimeFormat.CLOCK_24H)
                .setHour(10)
                .setMinute(0)
                .setTheme(R.style.ThemeOverlay_MaterialComponents_TimePicker) //これが必要
                .build();
```

で解決