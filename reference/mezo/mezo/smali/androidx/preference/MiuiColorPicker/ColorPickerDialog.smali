# classes10.dex

.class public Landroidx/preference/MiuiColorPicker/ColorPickerDialog;
.super Lmiuix/appcompat/app/AlertDialog$Builder;
.source "ColorPickerDialog.java"

# interfaces
.implements Landroidx/preference/MiuiColorPicker/ColorPickerView$OnColorChangedListener;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/MiuiColorPicker/ColorPickerDialog$OnColorChangedListener;
    }
.end annotation


# instance fields
.field private firstInitial:Z

.field private mBuilder:Lmiuix/appcompat/app/AlertDialog;

.field private mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

.field private mHexDefaultTextColor:Landroid/content/res/ColorStateList;

.field private mHexVal:Landroid/widget/EditText;

.field private mHexValueEnabled:Z

.field private mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

.field private mListener:Landroidx/preference/MiuiColorPicker/ColorPickerDialog$OnColorChangedListener;

.field private mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

.field private mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

.field private mOrientation:I

.field private mPresetColorEnable:Z

.field private mPresetColorLayout:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/content/Context;I)V
    .registers 4

    invoke-direct {p0, p1}, Lmiuix/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexValueEnabled:Z

    iput-boolean v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mPresetColorEnable:Z

    iput-boolean v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->firstInitial:Z

    invoke-direct {p0, p2}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->init(I)V

    return-void
.end method

.method static synthetic access$000(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)Landroid/widget/EditText;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$100(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)Landroidx/preference/MiuiColorPicker/ColorPickerView;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    return-object v0
.end method

.method static synthetic access$200(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)Landroid/content/res/ColorStateList;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexDefaultTextColor:Landroid/content/res/ColorStateList;

    return-object v0
.end method

.method public static convertToARGB(I)Ljava/lang/String;
    .registers 8

    invoke-static {p0}, Landroid/graphics/Color;->alpha(I)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

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

.method public static convertToColorInt(Ljava/lang/String;)I
    .registers 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    const-string v0, "#"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_17

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_17
    invoke-static {p0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static convertToRGB(I)Ljava/lang/String;
    .registers 7

    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

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

.method private init(I)V
    .registers 7

    invoke-direct {p0, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->setUp(I)V

    iget-boolean v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->firstInitial:Z

    if-eqz v0, :cond_49

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->setView(Landroid/view/View;)Lmiuix/appcompat/app/AlertDialog$Builder;

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->create()Lmiuix/appcompat/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lmiuix/appcompat/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    invoke-virtual {v0}, Lmiuix/appcompat/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x50

    invoke-virtual {v0, v1}, Landroid/view/Window;->setGravity(I)V

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "window"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/WindowManager;

    invoke-interface {v2}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v2

    new-instance v3, Landroid/util/DisplayMetrics;

    invoke-direct {v3}, Landroid/util/DisplayMetrics;-><init>()V

    invoke-virtual {v2, v3}, Landroid/view/Display;->getRealMetrics(Landroid/util/DisplayMetrics;)V

    iget v4, v3, Landroid/util/DisplayMetrics;->widthPixels:I

    iput v4, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    invoke-virtual {v0, v1}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    const/4 v4, 0x0

    iput-boolean v4, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->firstInitial:Z

    :cond_49
    return-void
.end method

.method private setUp(I)V
    .registers 6

    new-instance v0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    invoke-virtual {v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->addOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    iput v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mOrientation:I

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    iget-object v0, v0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->colorPickerView:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    iget-object v0, v0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    iget-object v0, v0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    iget-object v0, v0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->presetLayout:Landroid/widget/LinearLayout;

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mPresetColorLayout:Landroid/view/View;

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mPresetColorLayout:Landroid/view/View;

    iget-boolean v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mPresetColorEnable:Z

    const/4 v2, 0x0

    if-eqz v1, :cond_45

    move v1, v2

    goto :goto_47

    :cond_45
    const/16 v1, 0x8

    :goto_47
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    iget-object v0, v0, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->mHexVal:Landroid/widget/EditText;

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    const/high16 v1, 0x80000

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setInputType(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getTextColors()Landroid/content/res/ColorStateList;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexDefaultTextColor:Landroid/content/res/ColorStateList;

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    new-instance v1, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;

    invoke-direct {v1, p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$1;-><init>(Landroidx/preference/MiuiColorPicker/ColorPickerDialog;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v0}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iget-object v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v1}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->getDrawingOffset()F

    move-result v1

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    iget-object v3, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v3}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->getDrawingOffset()F

    move-result v3

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-virtual {v0, v1, v2, v3, v2}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v0, p0}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v0, p0}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v0, p0}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->setOnColorChangedListener(Landroidx/preference/MiuiColorPicker/ColorPickerView$OnColorChangedListener;)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v0, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->setColor(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->setColor(IZ)V

    return-void
.end method

.method private updateHexLengthFilter()V
    .registers 6

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->getAlphaSliderVisible()Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_19

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    new-array v2, v2, [Landroid/text/InputFilter;

    new-instance v3, Landroid/text/InputFilter$LengthFilter;

    const/16 v4, 0x9

    invoke-direct {v3, v4}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v3, v2, v1

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    goto :goto_28

    :cond_19
    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    new-array v2, v2, [Landroid/text/InputFilter;

    new-instance v3, Landroid/text/InputFilter$LengthFilter;

    const/4 v4, 0x7

    invoke-direct {v3, v4}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v3, v2, v1

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    :goto_28
    return-void
.end method

.method private updateHexValue(I)V
    .registers 5

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->getAlphaSliderVisible()Z

    move-result v0

    if-eqz v0, :cond_18

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    invoke-static {p1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->convertToARGB(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_29

    :cond_18
    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    invoke-static {p1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->convertToRGB(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :goto_29
    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    iget-object v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexDefaultTextColor:Landroid/content/res/ColorStateList;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextColor(Landroid/content/res/ColorStateList;)V

    return-void
.end method


# virtual methods
.method public getAlphaSliderVisible()Z
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v0}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->getAlphaSliderVisible()Z

    move-result v0

    return v0
.end method

.method public getColor()I
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v0}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->getColor()I

    move-result v0

    return v0
.end method

.method public getHexValueEnabled()Z
    .registers 2

    iget-boolean v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexValueEnabled:Z

    return v0
.end method

.method public onClick(Landroid/view/View;)V
    .registers 4

    const-string v0, "colorwer"

    const-string v1, "onClick: "

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    if-ne p1, v0, :cond_16

    iget-object v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mListener:Landroidx/preference/MiuiColorPicker/ColorPickerDialog$OnColorChangedListener;

    if-eqz v1, :cond_16

    invoke-virtual {v0}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->getColor()I

    move-result v0

    invoke-interface {v1, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog$OnColorChangedListener;->onColorChanged(I)V

    :cond_16
    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    invoke-virtual {v0}, Lmiuix/appcompat/app/AlertDialog;->cancel()V

    return-void
.end method

.method public onColorChanged(I)V
    .registers 3

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v0, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->setColor(I)V

    iget-boolean v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexValueEnabled:Z

    if-eqz v0, :cond_c

    invoke-direct {p0, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->updateHexValue(I)V

    :cond_c
    return-void
.end method

.method public onGlobalLayout()V
    .registers 4

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    iget v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mOrientation:I

    if-eq v0, v1, :cond_34

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v0}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->getColor()I

    move-result v0

    iget-object v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v1}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->getColor()I

    move-result v1

    iget-object v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mLayout:Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;

    invoke-virtual {v2}, Landroidx/preference/MiuiColorPicker/ColorPickerDialogLayout;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v2

    invoke-virtual {v2, p0}, Landroid/view/ViewTreeObserver;->removeGlobalOnLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    invoke-direct {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->setUp(I)V

    iget-object v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mNewColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v2, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->setColor(I)V

    iget-object v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v2, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->setColor(I)V

    :cond_34
    return-void
.end method

.method public setAlphaSliderVisible(Z)Landroidx/preference/MiuiColorPicker/ColorPickerDialog;
    .registers 3

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    invoke-virtual {v0, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->setAlphaSliderVisible(Z)V

    iget-boolean v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexValueEnabled:Z

    if-eqz v0, :cond_13

    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->updateHexLengthFilter()V

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->getColor()I

    move-result v0

    invoke-direct {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->updateHexValue(I)V

    :cond_13
    return-object p0
.end method

.method public setHexValueEnabled(Z)Landroidx/preference/MiuiColorPicker/ColorPickerDialog;
    .registers 4

    iput-boolean p1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexValueEnabled:Z

    if-eqz p1, :cond_15

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setVisibility(I)V

    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->updateHexLengthFilter()V

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->getColor()I

    move-result v0

    invoke-direct {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->updateHexValue(I)V

    goto :goto_1c

    :cond_15
    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mHexVal:Landroid/widget/EditText;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setVisibility(I)V

    :goto_1c
    return-object p0
.end method

.method public setInitialColor(I)Landroidx/preference/MiuiColorPicker/ColorPickerDialog;
    .registers 4

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mOldColor:Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;

    invoke-virtual {v0, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerPanelView;->setColor(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mColorPicker:Landroidx/preference/MiuiColorPicker/ColorPickerView;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerView;->setColor(IZ)V

    return-object p0
.end method

.method public setOnColorChangedListener(Landroidx/preference/MiuiColorPicker/ColorPickerDialog$OnColorChangedListener;)Landroidx/preference/MiuiColorPicker/ColorPickerDialog;
    .registers 2

    iput-object p1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mListener:Landroidx/preference/MiuiColorPicker/ColorPickerDialog$OnColorChangedListener;

    return-object p0
.end method

.method public setPresetColorEnable(Z)Landroidx/preference/MiuiColorPicker/ColorPickerDialog;
    .registers 4

    iput-boolean p1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mPresetColorEnable:Z

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mPresetColorLayout:Landroid/view/View;

    iget-boolean v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mPresetColorEnable:Z

    if-eqz v1, :cond_a

    const/4 v1, 0x0

    goto :goto_c

    :cond_a
    const/16 v1, 0x8

    :goto_c
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-object p0
.end method

.method public show()Lmiuix/appcompat/app/AlertDialog;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    invoke-virtual {v0}, Lmiuix/appcompat/app/AlertDialog;->show()V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    return-object v0
.end method
