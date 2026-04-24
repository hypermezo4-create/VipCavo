# classes10.dex

.class public Landroidx/preference/XMiuiColorPickerPreference;
.super Landroidx/preference/Preference;
.source "XMiuiColorPickerPreference.java"

# interfaces
.implements Landroidx/preference/MiuiColorPicker/ColorPickerDialog$OnColorChangedListener;


# static fields
.field private static mDefValue:I


# instance fields
.field private Helper:Landroidx/preference/XMiuiPreferenceHelper;

.field private mAlphaEnabled:Z

.field private mDensity:F

.field private mHexEnabled:Z

.field private mPresetEnabled:Z

.field private mValue:I

.field private mView:Landroid/view/View;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    const/high16 v0, -0x1000000

    sput v0, Landroidx/preference/XMiuiColorPickerPreference;->mDefValue:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 4

    invoke-direct {p0, p1, p2}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 v0, 0x0

    iput v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mDensity:F

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiColorPickerPreference;->setPersistent(Z)V

    invoke-direct {p0, p1, p2}, Landroidx/preference/XMiuiColorPickerPreference;->init(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method private convertToARGB(I)Ljava/lang/String;
    .registers 9

    invoke-static {p1}, Landroid/graphics/Color;->alpha(I)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Landroid/graphics/Color;->red(I)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1}, Landroid/graphics/Color;->green(I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1}, Landroid/graphics/Color;->blue(I)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    const-string v5, "0"

    const/4 v6, 0x1

    if-ne v4, v6, :cond_38

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_38
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v4, v6, :cond_4d

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_4d
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v4, v6, :cond_62

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :cond_62
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-ne v4, v6, :cond_77

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :cond_77
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "#"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    return-object v4
.end method

.method private convertToColorInt(Ljava/lang/String;)I
    .registers 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    const-string v0, "#"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_17

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_17
    invoke-static {p1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private convertToRGB(I)Ljava/lang/String;
    .registers 8

    invoke-static {p1}, Landroid/graphics/Color;->red(I)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Landroid/graphics/Color;->green(I)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1}, Landroid/graphics/Color;->blue(I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    const-string v4, "0"

    const/4 v5, 0x1

    if-ne v3, v5, :cond_30

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_30
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    if-ne v3, v5, :cond_45

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_45
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-ne v3, v5, :cond_5a

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :cond_5a
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "#"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method private getPreviewBitmap()Landroid/graphics/Bitmap;
    .registers 14

    invoke-virtual {p0}, Landroidx/preference/XMiuiColorPickerPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->uiMode:I

    and-int/lit8 v0, v0, 0x30

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/16 v3, 0x20

    if-ne v0, v3, :cond_18

    move v0, v2

    goto :goto_19

    :cond_18
    move v0, v1

    :goto_19
    iget v3, p0, Landroidx/preference/XMiuiColorPickerPreference;->mDensity:F

    const/high16 v4, 0x41f80000  # 31.0f

    mul-float/2addr v4, v3

    float-to-int v4, v4

    new-instance v5, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;

    const/high16 v6, 0x40a00000  # 5.0f

    mul-float/2addr v3, v6

    float-to-int v3, v3

    invoke-direct {v5, v3}, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;-><init>(I)V

    move-object v3, v5

    add-int/lit8 v5, v4, 0x2

    add-int/lit8 v6, v4, 0x2

    sget-object v7, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v5, v6, v7}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v5

    new-instance v6, Landroid/graphics/Canvas;

    invoke-direct {v6, v5}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    new-instance v7, Landroid/graphics/Paint;

    invoke-direct {v7}, Landroid/graphics/Paint;-><init>()V

    invoke-virtual {v7, v2}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    if-nez v0, :cond_46

    const v8, -0x919192

    goto :goto_47

    :cond_46
    const/4 v8, -0x1

    :goto_47
    invoke-virtual {v7, v8}, Landroid/graphics/Paint;->setColor(I)V

    new-instance v8, Landroid/graphics/Rect;

    add-int/lit8 v9, v4, 0x2

    add-int/lit8 v10, v4, 0x2

    invoke-direct {v8, v1, v1, v9, v10}, Landroid/graphics/Rect;-><init>(IIII)V

    move-object v1, v8

    new-instance v8, Landroid/graphics/RectF;

    invoke-direct {v8, v1}, Landroid/graphics/RectF;-><init>(Landroid/graphics/Rect;)V

    const/high16 v9, 0x41c80000  # 25.0f

    invoke-virtual {v6, v8, v9, v9, v7}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    add-int/lit8 v10, v4, 0x1

    add-int/lit8 v11, v4, 0x1

    invoke-virtual {v3, v2, v2, v10, v11}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    invoke-virtual {v3, v6}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    iget v10, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    invoke-virtual {v7, v10}, Landroid/graphics/Paint;->setColor(I)V

    new-instance v10, Landroid/graphics/Rect;

    add-int/lit8 v11, v4, 0x1

    add-int/lit8 v12, v4, 0x1

    invoke-direct {v10, v2, v2, v11, v12}, Landroid/graphics/Rect;-><init>(IIII)V

    move-object v1, v10

    new-instance v2, Landroid/graphics/RectF;

    invoke-direct {v2, v1}, Landroid/graphics/RectF;-><init>(Landroid/graphics/Rect;)V

    invoke-virtual {v6, v2, v9, v9, v7}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    return-object v5
.end method

.method private init(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 6

    new-instance v0, Landroidx/preference/XMiuiPreferenceHelper;

    invoke-direct {v0, p1, p2}, Landroidx/preference/XMiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const/4 v1, 0x1

    const-string v2, "hexValue"

    invoke-virtual {v0, v2, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeBool(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mHexEnabled:Z

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v2, "alphaSlider"

    invoke-virtual {v0, v2, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeBool(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mAlphaEnabled:Z

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v2, "presetView"

    invoke-virtual {v0, v2, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeBool(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mPresetEnabled:Z

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mDensity:F

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    sget v2, Landroidx/preference/XMiuiColorPickerPreference;->mDefValue:I

    invoke-virtual {v0, v2}, Landroidx/preference/XMiuiPreferenceHelper;->getInt(I)I

    move-result v0

    iput v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    iget v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    iget-object v2, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v2}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey()Z

    move-result v2

    xor-int/2addr v1, v2

    invoke-direct {p0, v0, v1}, Landroidx/preference/XMiuiColorPickerPreference;->onColorChanged(IZ)V

    return-void
.end method

.method private onColorChanged(IZ)V
    .registers 5

    if-nez p2, :cond_6

    iget v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    if-eq v0, p1, :cond_20

    :cond_6
    iput p1, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget v1, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    invoke-virtual {v0, v1}, Landroidx/preference/XMiuiPreferenceHelper;->setInt(I)V

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    invoke-direct {p0}, Landroidx/preference/XMiuiColorPickerPreference;->setPreviewColor()V

    iget v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    invoke-direct {p0, v0}, Landroidx/preference/XMiuiColorPickerPreference;->convertToARGB(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiColorPickerPreference;->setSummary(Ljava/lang/CharSequence;)V

    :cond_20
    return-void
.end method

.method private setPreviewColor()V
    .registers 8

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mView:Landroid/view/View;

    if-eqz v0, :cond_49

    new-instance v0, Landroid/widget/ImageView;

    invoke-virtual {p0}, Landroidx/preference/XMiuiColorPickerPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Landroidx/preference/XMiuiColorPickerPreference;->mView:Landroid/view/View;

    const v2, 0x1020018

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    if-eqz v1, :cond_49

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getPaddingLeft()I

    move-result v3

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getPaddingTop()I

    move-result v4

    iget v5, p0, Landroidx/preference/XMiuiColorPickerPreference;->mDensity:F

    const/high16 v6, 0x41000000  # 8.0f

    mul-float/2addr v5, v6

    float-to-int v5, v5

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getPaddingBottom()I

    move-result v6

    invoke-virtual {v1, v3, v4, v5, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v3

    if-lez v3, :cond_3c

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->removeViews(II)V

    :cond_3c
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setMinimumWidth(I)V

    invoke-direct {p0}, Landroidx/preference/XMiuiColorPickerPreference;->getPreviewBitmap()Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    :cond_49
    return-void
.end method


# virtual methods
.method public getView()Landroid/view/View;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mView:Landroid/view/View;

    return-object v0
.end method

.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 2

    invoke-super {p0, p1}, Landroidx/preference/Preference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    invoke-virtual {p0, p1}, Landroidx/preference/XMiuiColorPickerPreference;->onMyBindViewHolder(Ljava/lang/Object;)V

    return-void
.end method

.method protected onClick()V
    .registers 4

    invoke-super {p0}, Landroidx/preference/Preference;->onClick()V

    new-instance v0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    invoke-virtual {p0}, Landroidx/preference/XMiuiColorPickerPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    iget v2, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    invoke-direct {v0, v1, v2}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;-><init>(Landroid/content/Context;I)V

    iget-boolean v1, p0, Landroidx/preference/XMiuiColorPickerPreference;->mAlphaEnabled:Z

    invoke-virtual {v0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->setAlphaSliderVisible(Z)Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    move-result-object v0

    iget-boolean v1, p0, Landroidx/preference/XMiuiColorPickerPreference;->mHexEnabled:Z

    invoke-virtual {v0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->setHexValueEnabled(Z)Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    move-result-object v0

    iget-boolean v1, p0, Landroidx/preference/XMiuiColorPickerPreference;->mPresetEnabled:Z

    invoke-virtual {v0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->setPresetColorEnable(Z)Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->setOnColorChangedListener(Landroidx/preference/MiuiColorPicker/ColorPickerDialog$OnColorChangedListener;)Landroidx/preference/MiuiColorPicker/ColorPickerDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->show()Lmiuix/appcompat/app/AlertDialog;

    return-void
.end method

.method public onColorChanged(I)V
    .registers 4

    iget v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    if-eq v0, p1, :cond_1e

    iput p1, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget v1, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    invoke-virtual {v0, v1}, Landroidx/preference/XMiuiPreferenceHelper;->setInt(I)V

    iget-object v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    invoke-direct {p0}, Landroidx/preference/XMiuiColorPickerPreference;->setPreviewColor()V

    iget v0, p0, Landroidx/preference/XMiuiColorPickerPreference;->mValue:I

    invoke-direct {p0, v0}, Landroidx/preference/XMiuiColorPickerPreference;->convertToARGB(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiColorPickerPreference;->setSummary(Ljava/lang/CharSequence;)V

    :cond_1e
    return-void
.end method

.method protected onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Object;
    .registers 7

    invoke-virtual {p1, p2}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_34

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_34

    invoke-direct {p0, v0}, Landroidx/preference/XMiuiColorPickerPreference;->convertToColorInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0}, Landroidx/preference/XMiuiColorPickerPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {p0}, Landroidx/preference/XMiuiColorPickerPreference;->getKey()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2b

    invoke-virtual {p0}, Landroidx/preference/XMiuiColorPickerPreference;->getKey()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;)I

    move-result v2

    sput v2, Landroidx/preference/XMiuiColorPickerPreference;->mDefValue:I

    goto :goto_2d

    :cond_2b
    sput v1, Landroidx/preference/XMiuiColorPickerPreference;->mDefValue:I

    :goto_2d
    sget v2, Landroidx/preference/XMiuiColorPickerPreference;->mDefValue:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    return-object v2

    :cond_34
    const/high16 v1, -0x1000000

    invoke-virtual {p1, p2, v1}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    return-object v1
.end method

.method public onMyBindViewHolder(Ljava/lang/Object;)V
    .registers 7

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    :try_start_4
    const-string v1, "itemView"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    invoke-virtual {v1, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2
    :try_end_12
    .catch Ljava/lang/NoSuchFieldException; {:try_start_4 .. :try_end_12} :catch_1f
    .catch Ljava/lang/IllegalAccessException; {:try_start_4 .. :try_end_12} :catch_1d

    move-object v1, v2

    nop

    move-object v2, v1

    check-cast v2, Landroid/view/View;

    iput-object v2, p0, Landroidx/preference/XMiuiColorPickerPreference;->mView:Landroid/view/View;

    invoke-direct {p0}, Landroidx/preference/XMiuiColorPickerPreference;->setPreviewColor()V

    return-void

    :catch_1d
    move-exception v1

    goto :goto_20

    :catch_1f
    move-exception v1

    :goto_20
    sget-object v2, Landroidx/preference/XMiuiPreferenceHelper;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onMyBindViewHolder: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v4, "   "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
