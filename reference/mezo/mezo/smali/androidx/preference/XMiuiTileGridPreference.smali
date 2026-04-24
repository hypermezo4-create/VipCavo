# classes10.dex

.class public Landroidx/preference/XMiuiTileGridPreference;
.super Landroidx/preference/Preference;
.source "XMiuiTileGridPreference.java"


# instance fields
.field private Helper:Landroidx/preference/XMiuiPreferenceHelper;

.field private mDialogEntries:[Ljava/lang/String;

.field private mDialogValues:[Ljava/lang/String;

.field private mEntries:[Ljava/lang/String;

.field private mLastState:Ljava/lang/String;

.field private mSlots:[Ljava/lang/String;

.field private mTileCount:I

.field private mTileTexts:[Landroid/widget/TextView;

.field private mValues:[Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 16

    invoke-direct {p0, p1, p2}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance v0, Landroidx/preference/XMiuiPreferenceHelper;

    invoke-direct {v0, p1, p2}, Landroidx/preference/XMiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const/16 v0, 0x1a

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "No tile"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    const-string v3, "Wi-FI"

    aput-object v3, v1, v2

    const/4 v2, 0x2

    const-string v3, "SIM"

    aput-object v3, v1, v2

    const/4 v2, 0x3

    const-string v3, "Bluetooth"

    aput-object v3, v1, v2

    const/4 v2, 0x4

    const-string v3, "Weather"

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "Flashlight"

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "Airplane mode"

    aput-object v3, v1, v2

    const/4 v2, 0x7

    const-string v3, "Mute"

    aput-object v3, v1, v2

    const/16 v2, 0x8

    const-string v3, "Lock auto-rotate"

    aput-object v3, v1, v2

    const/16 v2, 0x9

    const-string v3, "Scanner"

    aput-object v3, v1, v2

    const/16 v2, 0xa

    const-string v3, "Settings"

    aput-object v3, v1, v2

    const/16 v2, 0xb

    const-string v3, "Access point"

    aput-object v3, v1, v2

    const/16 v2, 0xc

    const-string v3, "Vibration"

    aput-object v3, v1, v2

    const/16 v2, 0xd

    const-string v3, "Location"

    aput-object v3, v1, v2

    const/16 v2, 0xe

    const-string v3, "Dark mode"

    aput-object v3, v1, v2

    const/16 v2, 0xf

    const-string v3, "NFC"

    aput-object v3, v1, v2

    const/16 v2, 0x10

    const-string v3, "Signal type"

    aput-object v3, v1, v2

    const/16 v2, 0x11

    const-string v3, "RestartUI"

    aput-object v3, v1, v2

    const/16 v2, 0x12

    const-string v3, "Screenshot"

    aput-object v3, v1, v2

    const/16 v2, 0x13

    const-string v3, "Energy saving"

    aput-object v3, v1, v2

    const/16 v2, 0x14

    const-string v3, "Mute"

    aput-object v3, v1, v2

    const/16 v2, 0x15

    const-string v3, "Sync"

    aput-object v3, v1, v2

    const/16 v2, 0x16

    const-string v3, "Lock"

    aput-object v3, v1, v2

    const/16 v2, 0x17

    const-string v3, "Auto brightness"

    aput-object v3, v1, v2

    const/16 v2, 0x18

    const-string v3, "Floating windows"

    aput-object v3, v1, v2

    const/16 v2, 0x19

    const-string v3, "Screen Recording"

    aput-object v3, v1, v2

    iput-object v1, p0, Landroidx/preference/XMiuiTileGridPreference;->mEntries:[Ljava/lang/String;

    const/16 v0, 0x1a

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, ""

    aput-object v3, v1, v2

    const/4 v2, 0x1

    const-string v3, "wifi"

    aput-object v3, v1, v2

    const/4 v2, 0x2

    const-string v3, "cell"

    aput-object v3, v1, v2

    const/4 v2, 0x3

    const-string v3, "bt"

    aput-object v3, v1, v2

    const/4 v2, 0x4

    const-string v3, "miuiweather"

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "flashlight"

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "airplane"

    aput-object v3, v1, v2

    const/4 v2, 0x7

    const-string v3, "mute"

    aput-object v3, v1, v2

    const/16 v2, 0x8

    const-string v3, "rotation"

    aput-object v3, v1, v2

    const/16 v2, 0x9

    const-string v3, "scanner"

    aput-object v3, v1, v2

    const/16 v2, 0xa

    const-string v3, "settings"

    aput-object v3, v1, v2

    const/16 v2, 0xb

    const-string v3, "hotspot"

    aput-object v3, v1, v2

    const/16 v2, 0xc

    const-string v3, "vibrate"

    aput-object v3, v1, v2

    const/16 v2, 0xd

    const-string v3, "gps"

    aput-object v3, v1, v2

    const/16 v2, 0xe

    const-string v3, "night"

    aput-object v3, v1, v2

    const/16 v2, 0xf

    const-string v3, "nfc"

    aput-object v3, v1, v2

    const/16 v2, 0x10

    const-string v3, "signaltype"

    aput-object v3, v1, v2

    const/16 v2, 0x11

    const-string v3, "restartui"

    aput-object v3, v1, v2

    const/16 v2, 0x12

    const-string v3, "screenshot"

    aput-object v3, v1, v2

    const/16 v2, 0x13

    const-string v3, "batterysaver"

    aput-object v3, v1, v2

    const/16 v2, 0x14

    const-string v3, "quietmode"

    aput-object v3, v1, v2

    const/16 v2, 0x15

    const-string v3, "sync"

    aput-object v3, v1, v2

    const/16 v2, 0x16

    const-string v3, "screenlock"

    aput-object v3, v1, v2

    const/16 v2, 0x17

    const-string v3, "autobrightness"

    aput-object v3, v1, v2

    const/16 v2, 0x18

    const-string v3, "freeformhang"

    aput-object v3, v1, v2

    const/16 v2, 0x19

    const-string v3, "custom(com.miui.screenrecorder/.service.QuickService)"

    aput-object v3, v1, v2

    iput-object v1, p0, Landroidx/preference/XMiuiTileGridPreference;->mValues:[Ljava/lang/String;

    const/16 v0, 0x14

    new-array v1, v0, [Ljava/lang/String;

    iput-object v1, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    new-array v1, v0, [Landroid/widget/TextView;

    iput-object v1, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileTexts:[Landroid/widget/TextView;

    const/4 v0, 0x2

    iput v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    invoke-virtual {p0}, Landroidx/preference/Preference;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    invoke-virtual {p0}, Landroidx/preference/Preference;->getKey()Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0}, Landroidx/preference/XMiuiTileGridPreference;->syncTileCountFromSettings()V

    if-eqz v6, :cond_16c

    invoke-static {v5, v6}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    if-eqz v7, :cond_16c

    invoke-direct {p0, v7}, Landroidx/preference/XMiuiTileGridPreference;->ensureSlots(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Landroidx/preference/XMiuiTileGridPreference;->mLastState:Ljava/lang/String;

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->parseIntoSlots(Ljava/lang/String;)V

    goto :goto_189

    :cond_16c
    iget-object v1, p0, Landroidx/preference/XMiuiTileGridPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey()Z

    move-result v2

    if-eqz v2, :cond_182

    invoke-virtual {v1}, Landroidx/preference/XMiuiPreferenceHelper;->getStr()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->ensureSlots(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Landroidx/preference/XMiuiTileGridPreference;->mLastState:Ljava/lang/String;

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->parseIntoSlots(Ljava/lang/String;)V

    goto :goto_189

    :cond_182
    const-string v3, "wifi,cell"

    iput-object v3, p0, Landroidx/preference/XMiuiTileGridPreference;->mLastState:Ljava/lang/String;

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->parseIntoSlots(Ljava/lang/String;)V

    :goto_189
    invoke-direct {p0}, Landroidx/preference/XMiuiTileGridPreference;->updateSummaryFromSlots()V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiTileGridPreference;->setPersistent(Z)V

    return-void
.end method

.method static synthetic access$000(Landroidx/preference/XMiuiTileGridPreference;I)V
    .registers 2

    invoke-direct {p0, p1}, Landroidx/preference/XMiuiTileGridPreference;->showPickerDialog(I)V

    return-void
.end method

.method static synthetic access$100(Landroidx/preference/XMiuiTileGridPreference;I)V
    .registers 2

    invoke-direct {p0, p1}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    return-void
.end method

.method static synthetic access$200(Landroidx/preference/XMiuiTileGridPreference;)V
    .registers 1

    invoke-direct {p0}, Landroidx/preference/XMiuiTileGridPreference;->saveAndNotify()V

    return-void
.end method

.method static synthetic access$300(Landroidx/preference/XMiuiTileGridPreference;)[Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$400(Landroidx/preference/XMiuiTileGridPreference;)[Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mValues:[Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$500(Landroidx/preference/XMiuiTileGridPreference;)[Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mDialogValues:[Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$600(Landroidx/preference/XMiuiTileGridPreference;)[Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mDialogEntries:[Ljava/lang/String;

    return-object v0
.end method

.method public static synthetic access$700(Landroidx/preference/XMiuiTileGridPreference;I)V
    .registers 12

    iget v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    add-int v1, v0, p1

    const/4 v2, 0x2

    if-ge v1, v2, :cond_8

    const/4 v1, 0x2

    :cond_8
    const/16 v3, 0x14

    if-gt v1, v3, :cond_d

    goto :goto_f

    :cond_d
    const/16 v1, 0x14

    :goto_f
    and-int/lit8 v4, v1, 0x1

    if-eqz v4, :cond_1a

    add-int/lit8 v1, v1, 0x1

    if-gt v1, v3, :cond_18

    goto :goto_1a

    :cond_18
    add-int/lit8 v1, v1, -0x1

    :cond_1a
    :goto_1a
    if-eq v1, v0, :cond_59

    iput v1, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    invoke-virtual {p0}, Landroidx/preference/Preference;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    invoke-virtual {p0}, Landroidx/preference/Preference;->getKey()Ljava/lang/String;

    move-result-object v7

    if-eqz v7, :cond_40

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v9, "_count"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :cond_40
    iget-object v5, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    const-string v6, ""

    if-le v1, v0, :cond_4e

    move v7, v0

    :goto_47
    if-ge v7, v1, :cond_56

    aput-object v6, v5, v7

    add-int/lit8 v7, v7, 0x1

    goto :goto_47

    :cond_4e
    move v7, v1

    :goto_4f
    if-ge v7, v0, :cond_56

    aput-object v6, v5, v7

    add-int/lit8 v7, v7, 0x1

    goto :goto_4f

    :cond_56
    invoke-direct {p0}, Landroidx/preference/XMiuiTileGridPreference;->saveAndNotify()V

    :cond_59
    return-void
.end method

.method static synthetic access$710(Landroidx/preference/XMiuiTileGridPreference;)I
    .registers 2

    iget v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    return v0
.end method

.method private applyThemeColors(Landroid/view/ViewGroup;)V
    .registers 16

    invoke-virtual {p0}, Landroidx/preference/XMiuiTileGridPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget v3, v2, Landroid/content/res/Configuration;->uiMode:I

    and-int/lit8 v4, v3, 0x30

    const/16 v5, 0x20

    if-ne v4, v5, :cond_1b

    const v6, -0xd5d5d6

    const v7, -0x19191a

    goto :goto_21

    :cond_1b
    const v6, -0xd0d0e

    const v7, -0xe5e5e6

    :goto_21
    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v8

    iget v9, v8, Landroid/util/DisplayMetrics;->density:F

    const/high16 v10, 0x41a00000  # 20.0f

    mul-float v10, v10, v9

    const/high16 v11, 0x40800000  # 4.0f

    mul-float v11, v11, v9

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v12

    const/4 v13, 0x0

    :goto_34
    if-ge v13, v12, :cond_55

    invoke-virtual {p1, v13}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    instance-of v3, v2, Lcom/google/android/material/card/MaterialCardView;

    if-eqz v3, :cond_49

    check-cast v2, Lcom/google/android/material/card/MaterialCardView;

    invoke-virtual {v2, v6}, Lcom/google/android/material/card/MaterialCardView;->setCardBackgroundColor(I)V

    invoke-virtual {v2, v10}, Lcom/google/android/material/card/MaterialCardView;->setRadius(F)V

    invoke-virtual {v2, v11}, Lcom/google/android/material/card/MaterialCardView;->setCardElevation(F)V

    :cond_49
    instance-of v3, v2, Landroid/widget/TextView;

    if-eqz v3, :cond_52

    check-cast v2, Landroid/widget/TextView;

    invoke-virtual {v2, v7}, Landroid/widget/TextView;->setTextColor(I)V

    :cond_52
    add-int/lit8 v13, v13, 0x1

    goto :goto_34

    :cond_55
    return-void
.end method

.method private bindGrid(Landroid/view/ViewGroup;)V
    .registers 16

    invoke-direct {p0}, Landroidx/preference/XMiuiTileGridPreference;->syncTileCountFromSettings()V

    new-instance v0, Landroidx/preference/XMiuiTileGridPreference$TileClickListener;

    invoke-direct {v0, p0}, Landroidx/preference/XMiuiTileGridPreference$TileClickListener;-><init>(Landroidx/preference/XMiuiTileGridPreference;)V

    invoke-virtual {p1}, Landroid/view/ViewGroup;->removeAllViews()V

    instance-of v1, p1, Landroid/widget/GridLayout;

    if-eqz v1, :cond_1d

    move-object v1, p1

    check-cast v1, Landroid/widget/GridLayout;

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/widget/GridLayout;->setColumnCount(I)V

    iget v3, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    div-int/lit8 v4, v3, 0x2

    invoke-virtual {v1, v4}, Landroid/widget/GridLayout;->setRowCount(I)V

    :cond_1d
    invoke-virtual {p0}, Landroidx/preference/XMiuiTileGridPreference;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v7

    iget v8, v7, Landroid/util/DisplayMetrics;->density:F

    const/high16 v9, 0x42900000  # 72.0f

    mul-float v9, v9, v8

    float-to-int v10, v9

    const/high16 v9, 0x42400000  # 48.0f

    mul-float v9, v9, v8

    float-to-int v11, v9

    const/high16 v9, 0x41000000  # 8.0f

    mul-float v9, v9, v8

    float-to-int v12, v9

    const/4 v13, 0x0

    :goto_3b
    iget v1, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    if-ge v13, v1, :cond_92

    new-instance v1, Lcom/google/android/material/card/MaterialCardView;

    invoke-direct {v1, v5}, Lcom/google/android/material/card/MaterialCardView;-><init>(Landroid/content/Context;)V

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/android/material/card/MaterialCardView;->setTag(Ljava/lang/Object;)V

    invoke-virtual {v1, v0}, Lcom/google/android/material/card/MaterialCardView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/google/android/material/card/MaterialCardView;->setClickable(Z)V

    invoke-virtual {v1, v2}, Lcom/google/android/material/card/MaterialCardView;->setFocusable(Z)V

    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, v5}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const/high16 v3, 0x41400000  # 12.0f

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setMaxLines(I)V

    sget-object v3, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v4, -0x1

    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2, v3}, Lcom/google/android/material/card/MaterialCardView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v3, Landroid/widget/GridLayout$LayoutParams;

    invoke-direct {v3}, Landroid/widget/GridLayout$LayoutParams;-><init>()V

    iput v10, v3, Landroid/view/ViewGroup$LayoutParams;->width:I

    iput v11, v3, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-virtual {v3, v12, v12, v12, v12}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    invoke-virtual {v1, v3}, Lcom/google/android/material/card/MaterialCardView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    iget-object v4, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileTexts:[Landroid/widget/TextView;

    aput-object v2, v4, v13

    invoke-direct {p0, v13}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    add-int/lit8 v13, v13, 0x1

    goto :goto_3b

    :cond_92
    new-instance v1, Lcom/google/android/material/card/MaterialCardView;

    invoke-direct {v1, v5}, Lcom/google/android/material/card/MaterialCardView;-><init>(Landroid/content/Context;)V

    const-string v2, "minus"

    invoke-virtual {v1, v2}, Lcom/google/android/material/card/MaterialCardView;->setTag(Ljava/lang/Object;)V

    new-instance v0, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;

    const/4 v2, -0x2

    invoke-direct {v0, p0, v2}, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;-><init>(Landroidx/preference/XMiuiTileGridPreference;I)V

    invoke-virtual {v1, v0}, Lcom/google/android/material/card/MaterialCardView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/google/android/material/card/MaterialCardView;->setClickable(Z)V

    invoke-virtual {v1, v2}, Lcom/google/android/material/card/MaterialCardView;->setFocusable(Z)V

    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, v5}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const/high16 v3, 0x41400000  # 12.0f

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setMaxLines(I)V

    sget-object v3, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    const-string v3, "-"

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v4, -0x1

    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2, v3}, Lcom/google/android/material/card/MaterialCardView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v3, Landroid/widget/GridLayout$LayoutParams;

    invoke-direct {v3}, Landroid/widget/GridLayout$LayoutParams;-><init>()V

    iput v10, v3, Landroid/view/ViewGroup$LayoutParams;->width:I

    iput v11, v3, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-virtual {v3, v12, v12, v12, v12}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    invoke-virtual {v1, v3}, Lcom/google/android/material/card/MaterialCardView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    new-instance v1, Lcom/google/android/material/card/MaterialCardView;

    invoke-direct {v1, v5}, Lcom/google/android/material/card/MaterialCardView;-><init>(Landroid/content/Context;)V

    const-string v2, "plus"

    invoke-virtual {v1, v2}, Lcom/google/android/material/card/MaterialCardView;->setTag(Ljava/lang/Object;)V

    new-instance v0, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;

    const/4 v2, 0x2

    invoke-direct {v0, p0, v2}, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;-><init>(Landroidx/preference/XMiuiTileGridPreference;I)V

    invoke-virtual {v1, v0}, Lcom/google/android/material/card/MaterialCardView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/google/android/material/card/MaterialCardView;->setClickable(Z)V

    invoke-virtual {v1, v2}, Lcom/google/android/material/card/MaterialCardView;->setFocusable(Z)V

    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, v5}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const/high16 v3, 0x41400000  # 12.0f

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setGravity(I)V

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setMaxLines(I)V

    sget-object v3, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    const-string v3, "+"

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v4, -0x1

    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2, v3}, Lcom/google/android/material/card/MaterialCardView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v3, Landroid/widget/GridLayout$LayoutParams;

    invoke-direct {v3}, Landroid/widget/GridLayout$LayoutParams;-><init>()V

    iput v10, v3, Landroid/view/ViewGroup$LayoutParams;->width:I

    iput v11, v3, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-virtual {v3, v12, v12, v12, v12}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    invoke-virtual {v1, v3}, Lcom/google/android/material/card/MaterialCardView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-void
.end method

.method private ensureEvenPairs()V
    .registers 16

    iget v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    const/4 v1, 0x0

    :goto_3
    add-int/lit8 v2, v1, 0x1

    if-ge v2, v0, :cond_57

    iget-object v3, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aget-object v4, v3, v1

    aget-object v5, v3, v2

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    xor-int v8, v6, v7

    if-eqz v8, :cond_54

    if-eqz v6, :cond_1e

    move v9, v1

    move-object v10, v5

    goto :goto_20

    :cond_1e
    move v9, v2

    move-object v10, v4

    :goto_20
    iget-object v11, p0, Landroidx/preference/XMiuiTileGridPreference;->mValues:[Ljava/lang/String;

    array-length v12, v11

    const/4 v13, 0x0

    :goto_24
    if-ge v13, v12, :cond_4f

    aget-object v14, v11, v13

    invoke-static {v14}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_4c

    invoke-virtual {v14, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_4c

    const/4 v4, 0x0

    :goto_35
    if-ge v4, v0, :cond_46

    if-eq v4, v9, :cond_43

    aget-object v2, v3, v4

    if-eqz v2, :cond_43

    invoke-virtual {v14, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_4c

    :cond_43
    add-int/lit8 v4, v4, 0x1

    goto :goto_35

    :cond_46
    aput-object v14, v3, v9

    invoke-direct {p0, v9}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    goto :goto_54

    :cond_4c
    add-int/lit8 v13, v13, 0x1

    goto :goto_24

    :cond_4f
    aput-object v10, v3, v9

    invoke-direct {p0, v9}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    :cond_54
    :goto_54
    add-int/lit8 v1, v1, 0x2

    goto :goto_3

    :cond_57
    return-void
.end method

.method private ensureEvenSlots12()V
    .registers 16

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    const/4 v1, 0x0

    aget-object v2, v0, v1

    const/4 v3, 0x1

    aget-object v4, v0, v3

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int v7, v5, v6

    if-eqz v7, :cond_55

    if-eqz v5, :cond_18

    move v8, v1

    goto :goto_19

    :cond_18
    move v8, v3

    :goto_19
    iget-object v9, p0, Landroidx/preference/XMiuiTileGridPreference;->mValues:[Ljava/lang/String;

    array-length v10, v9

    const/4 v11, 0x0

    :goto_1d
    if-ge v11, v10, :cond_47

    aget-object v12, v9, v11

    invoke-static {v12}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_44

    const/4 v14, 0x0

    :goto_28
    const/4 v13, 0x6

    if-ge v14, v13, :cond_3c

    if-eq v14, v8, :cond_39

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aget-object v2, v0, v14

    if-eqz v2, :cond_39

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_44

    :cond_39
    add-int/lit8 v14, v14, 0x1

    goto :goto_28

    :cond_3c
    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aput-object v12, v0, v8

    invoke-direct {p0, v8}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    goto :goto_55

    :cond_44
    add-int/lit8 v11, v11, 0x1

    goto :goto_1d

    :cond_47
    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    const-string v12, ""

    aput-object v12, v0, v1

    aput-object v12, v0, v3

    invoke-direct {p0, v1}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    :cond_55
    :goto_55
    return-void
.end method

.method private ensureEvenSlots34()V
    .registers 16

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    const/4 v1, 0x2

    aget-object v2, v0, v1

    const/4 v3, 0x3

    aget-object v4, v0, v3

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int v7, v5, v6

    if-eqz v7, :cond_55

    if-eqz v5, :cond_18

    move v8, v1

    goto :goto_19

    :cond_18
    move v8, v3

    :goto_19
    iget-object v9, p0, Landroidx/preference/XMiuiTileGridPreference;->mValues:[Ljava/lang/String;

    array-length v10, v9

    const/4 v11, 0x0

    :goto_1d
    if-ge v11, v10, :cond_47

    aget-object v12, v9, v11

    invoke-static {v12}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_44

    const/4 v14, 0x0

    :goto_28
    const/4 v13, 0x6

    if-ge v14, v13, :cond_3c

    if-eq v14, v8, :cond_39

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aget-object v2, v0, v14

    if-eqz v2, :cond_39

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_44

    :cond_39
    add-int/lit8 v14, v14, 0x1

    goto :goto_28

    :cond_3c
    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aput-object v12, v0, v8

    invoke-direct {p0, v8}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    goto :goto_55

    :cond_44
    add-int/lit8 v11, v11, 0x1

    goto :goto_1d

    :cond_47
    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    const-string v12, ""

    aput-object v12, v0, v1

    aput-object v12, v0, v3

    invoke-direct {p0, v1}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    :cond_55
    :goto_55
    return-void
.end method

.method private ensureEvenSlots56()V
    .registers 16

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    const/4 v1, 0x4

    aget-object v2, v0, v1

    const/4 v3, 0x5

    aget-object v4, v0, v3

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int v7, v5, v6

    if-eqz v7, :cond_55

    if-eqz v5, :cond_18

    move v8, v1

    goto :goto_19

    :cond_18
    move v8, v3

    :goto_19
    iget-object v9, p0, Landroidx/preference/XMiuiTileGridPreference;->mValues:[Ljava/lang/String;

    array-length v10, v9

    const/4 v11, 0x0

    :goto_1d
    if-ge v11, v10, :cond_47

    aget-object v12, v9, v11

    invoke-static {v12}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_44

    const/4 v14, 0x0

    :goto_28
    const/4 v13, 0x6

    if-ge v14, v13, :cond_3c

    if-eq v14, v8, :cond_39

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aget-object v2, v0, v14

    if-eqz v2, :cond_39

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_44

    :cond_39
    add-int/lit8 v14, v14, 0x1

    goto :goto_28

    :cond_3c
    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aput-object v12, v0, v8

    invoke-direct {p0, v8}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    goto :goto_55

    :cond_44
    add-int/lit8 v11, v11, 0x1

    goto :goto_1d

    :cond_47
    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    const-string v12, ""

    aput-object v12, v0, v1

    aput-object v12, v0, v3

    invoke-direct {p0, v1}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->updateTileText(I)V

    :cond_55
    :goto_55
    return-void
.end method

.method private ensureSlots(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    if-eqz p1, :cond_7

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_7
    const-string v0, ""

    return-object v0
.end method

.method private joinSlots()Ljava/lang/String;
    .registers 9

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_7
    iget v3, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    if-ge v1, v3, :cond_26

    iget-object v4, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aget-object v5, v4, v1

    if-eqz v5, :cond_23

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    if-lez v6, :cond_23

    if-lez v2, :cond_1e

    const-string v7, ","

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1e
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v2, v2, 0x1

    :cond_23
    add-int/lit8 v1, v1, 0x1

    goto :goto_7

    :cond_26
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    return-object v7
.end method

.method private parseIntoSlots(Ljava/lang/String;)V
    .registers 9

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    if-eqz p1, :cond_24

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_24

    const-string v1, ","

    invoke-virtual {p1, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    :goto_11
    iget v4, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    if-ge v3, v4, :cond_30

    array-length v4, v2

    if-ge v3, v4, :cond_1d

    aget-object v5, v2, v3

    aput-object v5, v0, v3

    goto :goto_21

    :cond_1d
    const-string v5, ""

    aput-object v5, v0, v3

    :goto_21
    add-int/lit8 v3, v3, 0x1

    goto :goto_11

    :cond_24
    const/4 v3, 0x0

    :goto_25
    iget v4, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    if-ge v3, v4, :cond_30

    const-string v5, ""

    aput-object v5, v0, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_25

    :cond_30
    return-void
.end method

.method private saveAndNotify()V
    .registers 15

    invoke-direct {p0}, Landroidx/preference/XMiuiTileGridPreference;->ensureEvenPairs()V

    invoke-direct {p0}, Landroidx/preference/XMiuiTileGridPreference;->joinSlots()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mLastState:Ljava/lang/String;

    invoke-virtual {p0}, Landroidx/preference/Preference;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-virtual {p0}, Landroidx/preference/Preference;->getKey()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_51

    invoke-static {v2, v3, v0}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    const-string v6, "use_control_panel"

    const/4 v7, 0x0

    invoke-static {v2, v6, v7}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v7

    xor-int/lit8 v8, v7, 0x1

    invoke-static {v2, v6, v8}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    invoke-static {v2, v6, v8}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    invoke-static {v6}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v9

    const/4 v10, 0x0

    invoke-virtual {v2, v9, v10}, Landroid/content/ContentResolver;->notifyChange(Landroid/net/Uri;Landroid/database/ContentObserver;)V

    invoke-static {v6}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v9

    invoke-virtual {v2, v9, v10}, Landroid/content/ContentResolver;->notifyChange(Landroid/net/Uri;Landroid/database/ContentObserver;)V

    const-wide/16 v12, 0x14

    invoke-static {v12, v13}, Landroid/os/SystemClock;->sleep(J)V

    invoke-static {v2, v6, v7}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    invoke-static {v2, v6, v7}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    invoke-static {v6}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v9

    invoke-virtual {v2, v9, v10}, Landroid/content/ContentResolver;->notifyChange(Landroid/net/Uri;Landroid/database/ContentObserver;)V

    invoke-static {v6}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v9

    invoke-virtual {v2, v9, v10}, Landroid/content/ContentResolver;->notifyChange(Landroid/net/Uri;Landroid/database/ContentObserver;)V

    :cond_51
    iget-object v4, p0, Landroidx/preference/XMiuiTileGridPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v4}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey()Z

    move-result v5

    if-eqz v5, :cond_5f

    invoke-virtual {v4, v0}, Landroidx/preference/XMiuiPreferenceHelper;->putStr(Ljava/lang/String;)V

    invoke-virtual {v4}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    :cond_5f
    invoke-direct {p0}, Landroidx/preference/XMiuiTileGridPreference;->updateSummaryFromSlots()V

    invoke-virtual {p0}, Landroidx/preference/XMiuiTileGridPreference;->notifyChanged()V

    return-void
.end method

.method private showPickerDialog(I)V
    .registers 16

    invoke-virtual {p0}, Landroidx/preference/XMiuiTileGridPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget v3, v2, Landroid/content/res/Configuration;->uiMode:I

    and-int/lit16 v3, v3, 0x30

    const/16 v4, 0x20

    if-ne v3, v4, :cond_17

    sget v5, Landroid/R$style;->Theme_DeviceDefault_Dialog_Alert:I

    goto :goto_19

    :cond_17
    sget v5, Landroid/R$style;->Theme_DeviceDefault_Light_Dialog_Alert:I

    :goto_19
    new-instance v6, Landroid/app/AlertDialog$Builder;

    invoke-direct {v6, v0, v5}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Translate "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v9, p1, 0x1

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v6, v10}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    const/4 v9, 0x2

    if-lt p1, v9, :cond_4b

    const-string v10, "No tile"

    invoke-virtual {v7, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const-string v10, ""

    invoke-virtual {v8, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_4b
    iget-object v11, p0, Landroidx/preference/XMiuiTileGridPreference;->mValues:[Ljava/lang/String;

    iget-object v12, p0, Landroidx/preference/XMiuiTileGridPreference;->mEntries:[Ljava/lang/String;

    const/4 v9, 0x1

    :goto_50
    array-length v10, v11

    if-ge v9, v10, :cond_60

    aget-object v10, v12, v9

    invoke-virtual {v7, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    aget-object v13, v11, v9

    invoke-virtual {v8, v13}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v9, v9, 0x1

    goto :goto_50

    :cond_60
    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v2, v1, [Ljava/lang/String;

    invoke-virtual {v7, v2}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Ljava/lang/String;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v3, v1, [Ljava/lang/String;

    invoke-virtual {v8, v3}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [Ljava/lang/String;

    iput-object v2, p0, Landroidx/preference/XMiuiTileGridPreference;->mDialogEntries:[Ljava/lang/String;

    iput-object v3, p0, Landroidx/preference/XMiuiTileGridPreference;->mDialogValues:[Ljava/lang/String;

    const/4 v4, -0x1

    iget-object v1, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aget-object v1, v1, p1

    const/4 v5, 0x0

    :goto_82
    array-length v7, v3

    if-ge v5, v7, :cond_92

    aget-object v7, v3, v5

    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_8f

    move v4, v5

    goto :goto_92

    :cond_8f
    add-int/lit8 v5, v5, 0x1

    goto :goto_82

    :cond_92
    :goto_92
    new-instance v7, Landroidx/preference/XMiuiTileGridPreference$PickerClickListener;

    invoke-direct {v7, p0, p1}, Landroidx/preference/XMiuiTileGridPreference$PickerClickListener;-><init>(Landroidx/preference/XMiuiTileGridPreference;I)V

    invoke-virtual {v6, v2, v4, v7}, Landroid/app/AlertDialog$Builder;->setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v6}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void
.end method

.method private syncTileCountFromSettings()V
    .registers 12

    invoke-virtual {p0}, Landroidx/preference/Preference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {p0}, Landroidx/preference/Preference;->getKey()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_3e

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "_count"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    iget v6, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    invoke-static {v1, v5, v6}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v7

    const/4 v8, 0x2

    if-ge v7, v8, :cond_29

    const/4 v7, 0x2

    :cond_29
    const/16 v9, 0x14

    if-gt v7, v9, :cond_2e

    goto :goto_30

    :cond_2e
    const/16 v7, 0x14

    :goto_30
    and-int/lit8 v10, v7, 0x1

    if-eqz v10, :cond_3c

    add-int/lit8 v7, v7, 0x1

    if-gt v7, v9, :cond_39

    goto :goto_3b

    :cond_39
    add-int/lit8 v7, v7, -0x1

    :goto_3b
    nop

    :cond_3c
    iput v7, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    :cond_3e
    return-void
.end method

.method private updateSummaryFromSlots()V
    .registers 12

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_7
    iget v3, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileCount:I

    if-ge v1, v3, :cond_2a

    iget-object v3, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aget-object v4, v3, v1

    if-eqz v4, :cond_27

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_27

    invoke-direct {p0, v4}, Landroidx/preference/XMiuiTileGridPreference;->valueToLabel(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-lez v2, :cond_22

    const-string v7, " • "

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_22
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v2, v2, 0x1

    :cond_27
    add-int/lit8 v1, v1, 0x1

    goto :goto_7

    :cond_2a
    if-lez v2, :cond_34

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Landroidx/preference/XMiuiTileGridPreference;->setSummary(Ljava/lang/CharSequence;)V

    return-void

    :cond_34
    const-string v9, "to default"

    invoke-virtual {p0, v9}, Landroidx/preference/XMiuiTileGridPreference;->setSummary(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private updateTileText(I)V
    .registers 6

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mTileTexts:[Landroid/widget/TextView;

    aget-object v1, v0, p1

    if-eqz v1, :cond_11

    iget-object v2, p0, Landroidx/preference/XMiuiTileGridPreference;->mSlots:[Ljava/lang/String;

    aget-object v3, v2, p1

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->valueToLabel(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_11
    return-void
.end method

.method private valueToLabel(Ljava/lang/String;)Ljava/lang/String;
    .registers 6

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference;->mValues:[Ljava/lang/String;

    iget-object v1, p0, Landroidx/preference/XMiuiTileGridPreference;->mEntries:[Ljava/lang/String;

    const/4 v2, 0x0

    :goto_5
    array-length v3, v0

    if-ge v2, v3, :cond_16

    aget-object v3, v0, v2

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_13

    aget-object p0, v1, v2

    return-object p0

    :cond_13
    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    :cond_16
    return-object p1
.end method


# virtual methods
.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 10

    invoke-super {p0, p1}, Landroidx/preference/Preference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    const v0, 0x1020018

    invoke-virtual {p1, v0}, Landroidx/preference/PreferenceViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v1

    instance-of v2, v1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_44

    check-cast v1, Landroid/view/ViewGroup;

    const-string v2, "tile_container"

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    instance-of v4, v3, Landroid/view/ViewGroup;

    if-eqz v4, :cond_44

    check-cast v3, Landroid/view/ViewGroup;

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->bindGrid(Landroid/view/ViewGroup;)V

    invoke-direct {p0, v3}, Landroidx/preference/XMiuiTileGridPreference;->applyThemeColors(Landroid/view/ViewGroup;)V

    const-string v4, "btn_plus"

    invoke-virtual {v1, v4}, Landroid/view/ViewGroup;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_33

    new-instance v6, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;

    const/4 v7, 0x2

    invoke-direct {v6, p0, v7}, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;-><init>(Landroidx/preference/XMiuiTileGridPreference;I)V

    invoke-virtual {v5, v6}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_33
    const-string v4, "btn_minus"

    invoke-virtual {v1, v4}, Landroid/view/ViewGroup;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    if-eqz v5, :cond_44

    new-instance v6, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;

    const/4 v7, -0x2

    invoke-direct {v6, p0, v7}, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;-><init>(Landroidx/preference/XMiuiTileGridPreference;I)V

    invoke-virtual {v5, v6}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_44
    return-void
.end method
