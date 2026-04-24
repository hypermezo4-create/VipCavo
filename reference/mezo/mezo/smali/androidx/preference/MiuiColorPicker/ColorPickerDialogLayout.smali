# classes10.dex

.class public Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;
.super Landroid/widget/LinearLayout;
.source "ColorPickerDialogLayout.java"


# instance fields
.field public colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

.field public isNight:Z

.field public mHexVal:Landroid/widget/EditText;

.field public mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

.field public mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

.field public presetLayout:Landroid/widget/LinearLayout;

.field public textHexWrapper:Landroid/widget/LinearLayout;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-direct {p0, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->init(Landroid/content/Context;)V

    return-void
.end method

.method private getHexWrapperBack()Landroid/graphics/drawable/Drawable;
    .registers 5

    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/high16 v1, 0x41700000  # 15.0f

    invoke-virtual {p0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    iget-boolean v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->isNight:Z

    if-eqz v1, :cond_16

    const-string v1, "#60ffffff"

    goto :goto_18

    :cond_16
    const-string v1, "#60000000"

    :goto_18
    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    sget-object v3, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-virtual {v0, v2, v3}, Landroid/graphics/drawable/GradientDrawable;->setColorFilter(ILandroid/graphics/PorterDuff$Mode;)V

    return-object v0
.end method

.method private getPresetParams()Landroid/widget/LinearLayout$LayoutParams;
    .registers 5

    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v1, 0x42200000  # 40.0f

    invoke-virtual {p0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v2

    invoke-virtual {p0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v1

    invoke-direct {v0, v2, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/high16 v1, 0x40400000  # 3.0f

    invoke-virtual {p0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v2

    invoke-virtual {p0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v1

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3, v1, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    const/16 v1, 0x10

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    const/high16 v1, 0x3f800000  # 1.0f

    iput v1, v0, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    return-object v0
.end method

.method private init(Landroid/content/Context;)V
    .registers 13

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->uiMode:I

    and-int/lit8 v0, v0, 0x30

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/16 v3, 0x20

    if-ne v0, v3, :cond_14

    move v0, v2

    goto :goto_15

    :cond_14
    move v0, v1

    :goto_15
    iput-boolean v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->isNight:Z

    invoke-virtual {p0, v2}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->setOrientation(I)V

    const/high16 v0, 0x40a00000  # 5.0f

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v3

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v4

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v5

    invoke-virtual {p0, v3, v4, v5, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->setPadding(IIII)V

    new-instance v3, Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-direct {v3, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerView;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    const-string v4, "portrait"

    invoke-virtual {v3, v4}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->setTag(Ljava/lang/Object;)V

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    new-instance v4, Landroid/graphics/Paint;

    invoke-direct {v4}, Landroid/graphics/Paint;-><init>()V

    invoke-virtual {v3, v2, v4}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->setLayerType(ILandroid/graphics/Paint;)V

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x2

    invoke-direct {v4, v5, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v3, v4}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->textHexWrapper:Landroid/widget/LinearLayout;

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->textHexWrapper:Landroid/widget/LinearLayout;

    const/16 v4, 0x11

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->textHexWrapper:Landroid/widget/LinearLayout;

    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->getHexWrapperBack()Landroid/graphics/drawable/Drawable;

    move-result-object v6

    invoke-virtual {v3, v6}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    invoke-direct {v3, v6, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/high16 v7, 0x40c00000  # 6.0f

    invoke-virtual {p0, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v8

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v9

    invoke-virtual {p0, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v10

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v0

    invoke-virtual {v3, v8, v9, v10, v0}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->textHexWrapper:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v0, v3}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v0, Landroid/widget/EditText;

    invoke-direct {v0, p1}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    const-string v8, "HEX"

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    const/4 v8, 0x5

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setMinEms(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    const/4 v8, 0x6

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setImeOptions(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->setSingleLine()V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    const/4 v8, 0x7

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setMaxEms(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    const/16 v8, 0x1000

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setInputType(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    const/16 v8, 0x8

    invoke-virtual {v0, v8}, Landroid/widget/EditText;->setVisibility(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->textHexWrapper:Landroid/widget/LinearLayout;

    iget-object v8, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v9, v5, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v8, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/16 v8, 0x10

    invoke-virtual {v0, v8}, Landroid/widget/LinearLayout;->setGravity(I)V

    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v8, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    move-object v3, v8

    invoke-virtual {p0, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v7

    iput v7, v3, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    iput v2, v3, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    iget-object v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->textHexWrapper:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v2, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;

    const/high16 v7, -0x10000

    invoke-direct {v2, p1, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;-><init>(Landroid/content/Context;I)V

    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->getPresetParams()Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v7

    invoke-virtual {v0, v2, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v7, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v2, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->setOnPresetClickListener(Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;)V

    new-instance v7, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;

    const v8, -0xff0100

    invoke-direct {v7, p1, v8}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;-><init>(Landroid/content/Context;I)V

    move-object v2, v7

    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->getPresetParams()Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v7

    invoke-virtual {v0, v2, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v7, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v2, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->setOnPresetClickListener(Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;)V

    new-instance v7, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;

    const v8, -0xffff01

    invoke-direct {v7, p1, v8}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;-><init>(Landroid/content/Context;I)V

    move-object v2, v7

    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->getPresetParams()Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v7

    invoke-virtual {v0, v2, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v7, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v2, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->setOnPresetClickListener(Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;)V

    new-instance v7, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;

    invoke-direct {v7, p1, v6}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;-><init>(Landroid/content/Context;I)V

    move-object v2, v7

    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->getPresetParams()Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v7

    invoke-virtual {v0, v2, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v7, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v2, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->setOnPresetClickListener(Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;)V

    new-instance v7, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;

    const/high16 v8, -0x1000000

    invoke-direct {v7, p1, v8}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;-><init>(Landroid/content/Context;I)V

    move-object v2, v7

    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->getPresetParams()Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v7

    invoke-virtual {v0, v2, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v7, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v2, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->setOnPresetClickListener(Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;)V

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->presetLayout:Landroid/widget/LinearLayout;

    new-instance v7, Landroid/widget/LinearLayout;

    invoke-direct {v7, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    move-object v0, v7

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v7, 0x42200000  # 40.0f

    invoke-virtual {p0, v7}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v7

    invoke-direct {v1, v5, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/high16 v3, 0x41200000  # 10.0f

    invoke-virtual {p0, v3}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v7

    iput v7, v1, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    invoke-virtual {p0, v0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v7, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-direct {v7, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;-><init>(Landroid/content/Context;)V

    iput-object v7, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v7, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    move-object v1, v7

    const/high16 v7, 0x3f000000  # 0.5f

    iput v7, v1, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    iget-object v8, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v0, v8, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v8, Landroid/widget/TextView;

    invoke-direct {v8, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v8, v4}, Landroid/widget/TextView;->setGravity(I)V

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    move-object v1, v4

    invoke-virtual {p0, v3}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v4

    iput v4, v1, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    invoke-virtual {p0, v3}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->pX(F)I

    move-result v3

    iput v3, v1, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    const-string v3, "→"

    invoke-virtual {v8, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v3, 0x2

    const/high16 v4, 0x41a00000  # 20.0f

    invoke-virtual {v8, v3, v4}, Landroid/widget/TextView;->setTextSize(IF)V

    invoke-virtual {v0, v8, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v3, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-direct {v3, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    move-object v1, v3

    iput v7, v1, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    const-string v4, "new"

    invoke-virtual {v3, v4}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->setContentDescription(Ljava/lang/CharSequence;)V

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v0, v3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method


# virtual methods
.method public pX(F)I
    .registers 3

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, p1

    float-to-int v0, v0

    return v0
.end method
