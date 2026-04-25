# classes10.dex

.class public Landroidx/preference/MyXPreference;
.super Ljava/lang/Object;
.source "MyXPreference.java"


# instance fields
.field protected mDisableLongClick:Z

.field private mIntent:Ljava/lang/String;

.field private mIntentExtra:Ljava/lang/String;

.field private mMargin:I

.field protected mOnLongClickListener:Landroid/view/View$OnLongClickListener;

.field private mStorage:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 6

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v1, 0x0

    iput-object v1, p0, Landroidx/preference/MyXPreference;->mOnLongClickListener:Landroid/view/View$OnLongClickListener;

    const-string v0, "disableLongClick"

    invoke-interface {p2, v1, v0, v1}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/MyXPreference;->mDisableLongClick:Z

    const-string v0, "intent"

    invoke-interface {p2, v1, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/MyXPreference;->mIntent:Ljava/lang/String;

    const-string v0, "intentExtra"

    invoke-interface {p2, v1, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/MyXPreference;->mIntentExtra:Ljava/lang/String;

    const-string v0, "margin"

    invoke-interface {p2, v1, v0, v1}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/MyXPreference;->mMargin:I

    const-string v0, "storage"

    invoke-interface {p2, v1, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_45

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "global"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v1, 0x1

    if-nez v2, :cond_45

    const-string v1, "secure"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v1, 0x2

    if-nez v2, :cond_45

    const/4 v1, 0x0

    :cond_45
    iput v1, p0, Landroidx/preference/MyXPreference;->mStorage:I

    return-void
.end method

.method public static LaunchMyApp(Landroid/content/Context;Ljava/lang/String;)V
    .registers 4

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-static {v0, p1}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1c

    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_1c

    const/high16 v1, 0x10200000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :cond_1c
    return-void
.end method

.method public static drawableLightDarkColor(Landroid/graphics/drawable/Drawable;II)Landroid/graphics/drawable/Drawable;
    .registers 10

    move-object v0, p0

    move v1, p1

    move v2, p2

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorder(Landroid/graphics/drawable/Drawable;IIIIFF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static drawableLightDarkColorAndBorder(Landroid/graphics/drawable/Drawable;IIIIFF)Landroid/graphics/drawable/Drawable;
    .registers 18

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static/range {v0 .. v10}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderAndPadding(Landroid/graphics/drawable/Drawable;IIIIFFIIII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static drawableLightDarkColorAndBorderAndBottomLevel(Landroid/graphics/drawable/Drawable;IIIIFFI)Landroid/graphics/drawable/Drawable;
    .registers 17

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    move/from16 v7, p7

    const/4 v8, 0x2

    invoke-static/range {v0 .. v8}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderAndLevel(Landroid/graphics/drawable/Drawable;IIIIFFII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static drawableLightDarkColorAndBorderAndLevel(Landroid/graphics/drawable/Drawable;IIIIFFII)Landroid/graphics/drawable/Drawable;
    .registers 24

    if-eqz p0, :cond_51

    instance-of v1, p0, Landroid/graphics/drawable/StateListDrawable;

    if-eqz v1, :cond_51

    check-cast p0, Landroid/graphics/drawable/StateListDrawable;

    invoke-virtual {p0}, Landroid/graphics/drawable/StateListDrawable;->getStateCount()I

    move-result v0

    const/4 v1, 0x0

    new-instance v13, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v13}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    move/from16 v8, p6

    :goto_14
    if-ge v1, v0, :cond_50

    move/from16 v3, p1

    move/from16 v4, p2

    move/from16 v5, p3

    move/from16 v6, p4

    move/from16 v7, p5

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/StateListDrawable;->getStateDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-static/range {v2 .. v8}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderSimple(Landroid/graphics/drawable/Drawable;IIIIFF)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    new-instance v2, Landroid/graphics/drawable/ClipDrawable;

    move/from16 v5, p8

    const v4, 0x10

    if-eqz v5, :cond_3b

    const v4, 0xb0

    add-int/lit8 v5, v5, -0x1

    if-eqz v5, :cond_3b

    const v4, 0xd0

    :cond_3b
    const v5, 0x2

    invoke-direct/range {v2 .. v5}, Landroid/graphics/drawable/ClipDrawable;-><init>(Landroid/graphics/drawable/Drawable;II)V

    move/from16 v4, p7

    invoke-virtual {v2, v4}, Landroid/graphics/drawable/ClipDrawable;->setLevel(I)Z

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/StateListDrawable;->getStateSet(I)[I

    move-result-object v14

    invoke-virtual {v13, v14, v2}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_14

    :cond_50
    return-object v13

    :cond_51
    invoke-static/range {p0 .. p6}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderSimple(Landroid/graphics/drawable/Drawable;IIIIFF)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    new-instance v2, Landroid/graphics/drawable/ClipDrawable;

    move/from16 v5, p8

    const v4, 0x10

    if-eqz v5, :cond_68

    const v4, 0xb0

    add-int/lit8 v5, v5, -0x1

    if-eqz v5, :cond_68

    const v4, 0xd0

    :cond_68
    const v5, 0x2

    invoke-direct/range {v2 .. v5}, Landroid/graphics/drawable/ClipDrawable;-><init>(Landroid/graphics/drawable/Drawable;II)V

    move/from16 v4, p7

    invoke-virtual {v2, v4}, Landroid/graphics/drawable/ClipDrawable;->setLevel(I)Z

    return-object v2
.end method

.method public static drawableLightDarkColorAndBorderAndMiddleLevel(Landroid/graphics/drawable/Drawable;IIIIFFI)Landroid/graphics/drawable/Drawable;
    .registers 17

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    move/from16 v7, p7

    const/4 v8, 0x0

    invoke-static/range {v0 .. v8}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderAndLevel(Landroid/graphics/drawable/Drawable;IIIIFFII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static drawableLightDarkColorAndBorderAndPadding(Landroid/graphics/drawable/Drawable;IIIIFFI)Landroid/graphics/drawable/Drawable;
    .registers 19

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p7

    move/from16 v9, p7

    move/from16 v10, p7

    invoke-static/range {v0 .. v10}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderAndPadding(Landroid/graphics/drawable/Drawable;IIIIFFIIII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static drawableLightDarkColorAndBorderAndPadding(Landroid/graphics/drawable/Drawable;IIIIFFIIII)Landroid/graphics/drawable/Drawable;
    .registers 26

    if-eqz p0, :cond_52

    instance-of v1, p0, Landroid/graphics/drawable/StateListDrawable;

    if-eqz v1, :cond_52

    check-cast p0, Landroid/graphics/drawable/StateListDrawable;

    invoke-virtual {p0}, Landroid/graphics/drawable/StateListDrawable;->getStateCount()I

    move-result v0

    const/4 v1, 0x0

    new-instance v13, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v13}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    move/from16 v8, p6

    :goto_14
    if-ge v1, v0, :cond_51

    move/from16 v3, p1

    move/from16 v4, p2

    move/from16 v5, p3

    move/from16 v6, p4

    move/from16 v7, p5

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/StateListDrawable;->getStateDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-static/range {v2 .. v8}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderSimple(Landroid/graphics/drawable/Drawable;IIIIFF)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    if-nez p7, :cond_3a

    if-nez p8, :cond_3a

    if-nez p9, :cond_3a

    if-nez p10, :cond_3a

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/StateListDrawable;->getStateSet(I)[I

    move-result-object v14

    invoke-virtual {v13, v14, v3}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_14

    :cond_3a
    new-instance v2, Landroid/graphics/drawable/InsetDrawable;

    move/from16 v4, p7

    move/from16 v5, p8

    move/from16 v6, p9

    move/from16 v7, p10

    invoke-direct/range {v2 .. v7}, Landroid/graphics/drawable/InsetDrawable;-><init>(Landroid/graphics/drawable/Drawable;IIII)V

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/StateListDrawable;->getStateSet(I)[I

    move-result-object v14

    invoke-virtual {v13, v14, v2}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_14

    :cond_51
    return-object v13

    :cond_52
    invoke-static/range {p0 .. p6}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderSimple(Landroid/graphics/drawable/Drawable;IIIIFF)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    new-instance v2, Landroid/graphics/drawable/InsetDrawable;

    move/from16 v4, p7

    move/from16 v5, p8

    move/from16 v6, p9

    move/from16 v7, p10

    invoke-direct/range {v2 .. v7}, Landroid/graphics/drawable/InsetDrawable;-><init>(Landroid/graphics/drawable/Drawable;IIII)V

    return-object v2
.end method

.method public static drawableLightDarkColorAndBorderAndTopLevel(Landroid/graphics/drawable/Drawable;IIIIFFI)Landroid/graphics/drawable/Drawable;
    .registers 17

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    move/from16 v7, p7

    const/4 v8, 0x1

    invoke-static/range {v0 .. v8}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderAndLevel(Landroid/graphics/drawable/Drawable;IIIIFFII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static drawableLightDarkColorAndBorderSimple(Landroid/graphics/drawable/Drawable;IIIIFF)Landroid/graphics/drawable/Drawable;
    .registers 13

    const/4 v5, 0x0

    if-nez p0, :cond_c

    const/4 v5, 0x1

    new-instance p0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {p0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {p0, p2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    :cond_c
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    const/4 p0, 0x1

    instance-of v2, v1, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v2, :cond_1d

    invoke-virtual {v1, p3, p4}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    invoke-static {v1, p5, p6}, Landroidx/preference/MyXPreference;->setCornerTopBottomRadius(Landroid/graphics/drawable/GradientDrawable;FF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    goto :goto_43

    :cond_1d
    instance-of v2, v1, Landroid/graphics/drawable/PaintDrawable;

    if-eqz v2, :cond_2a

    invoke-virtual {v1}, Landroid/graphics/drawable/PaintDrawable;->getPaint()Landroid/graphics/Paint;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/Paint;->getColor()I

    move-result v2

    goto :goto_32

    :cond_2a
    instance-of v2, v1, Landroid/graphics/drawable/ColorDrawable;

    if-eqz v2, :cond_42

    invoke-virtual {v1}, Landroid/graphics/drawable/ColorDrawable;->getColor()I

    move-result v2

    :goto_32
    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {v1, p3, p4}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    invoke-static {v1, p5, p6}, Landroidx/preference/MyXPreference;->setCornerTopBottomRadius(Landroid/graphics/drawable/GradientDrawable;FF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    goto :goto_43

    :cond_42
    const/4 p0, 0x0

    :goto_43
    if-lez p1, :cond_4a

    div-int/lit16 v3, p1, 0x2

    add-int/lit16 v3, v3, 0x7f

    goto :goto_51

    :cond_4a
    add-int/lit16 v3, p1, 0xff

    invoke-virtual {v1, v3}, Landroid/graphics/drawable/Drawable;->setAlpha(I)V

    div-int/lit16 v3, v3, 0x2

    :goto_51
    if-nez v5, :cond_b3

    invoke-static {p2}, Landroid/graphics/Color;->alpha(I)I

    move-result v0

    if-eqz v0, :cond_b3

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    instance-of v2, v0, Landroid/graphics/drawable/NinePatchDrawable;

    if-nez v2, :cond_72

    invoke-virtual {v0, v3}, Landroid/graphics/drawable/Drawable;->setAlpha(I)V

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->MULTIPLY:Landroid/graphics/PorterDuff$Mode;

    invoke-virtual {v0, p2, v2}, Landroid/graphics/drawable/Drawable;->setColorFilter(ILandroid/graphics/PorterDuff$Mode;)V

    goto :goto_85

    :cond_72
    check-cast v0, Landroid/graphics/drawable/NinePatchDrawable;

    invoke-virtual {v0, v3}, Landroid/graphics/drawable/NinePatchDrawable;->setAlpha(I)V

    invoke-static {p2}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/NinePatchDrawable;->setTintList(Landroid/content/res/ColorStateList;)V

    invoke-virtual {v0}, Landroid/graphics/drawable/NinePatchDrawable;->getPaint()Landroid/graphics/Paint;

    move-result-object v2

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setAlpha(I)V

    :goto_85
    if-lez p3, :cond_a9

    const/4 v2, 0x3

    if-eqz p0, :cond_8b

    const/4 v2, 0x2

    :cond_8b
    new-array v4, v2, [Landroid/graphics/drawable/Drawable;

    const/4 v2, 0x0

    aput-object v1, v4, v2

    const/4 v2, 0x1

    aput-object v0, v4, v2

    if-nez p0, :cond_d0

    const/4 v3, 0x2

    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/4 v2, 0x0

    invoke-static {v0, p5, p6}, Landroidx/preference/MyXPreference;->setCornerTopBottomRadius(Landroid/graphics/drawable/GradientDrawable;FF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v0, p3, p4}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    aput-object v0, v4, v3

    goto :goto_d0

    :cond_a9
    const/4 v2, 0x2

    new-array v4, v2, [Landroid/graphics/drawable/Drawable;

    const/4 v2, 0x0

    aput-object v1, v4, v2

    const/4 v3, 0x1

    aput-object v0, v4, v3

    goto :goto_d0

    :cond_b3
    if-nez p0, :cond_cf

    const/4 v2, 0x2

    new-array v4, v2, [Landroid/graphics/drawable/Drawable;

    const/4 v2, 0x0

    aput-object v1, v4, v2

    const/4 v3, 0x1

    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/4 v2, 0x0

    invoke-static {v0, p5, p6}, Landroidx/preference/MyXPreference;->setCornerTopBottomRadius(Landroid/graphics/drawable/GradientDrawable;FF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v0, p3, p4}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    aput-object v0, v4, v3

    goto :goto_d0

    :cond_cf
    return-object v1

    :cond_d0
    :goto_d0
    new-instance v1, Landroid/graphics/drawable/LayerDrawable;

    invoke-direct {v1, v4}, Landroid/graphics/drawable/LayerDrawable;-><init>([Landroid/graphics/drawable/Drawable;)V

    const/4 v4, 0x1

    invoke-virtual {v1, v4}, Landroid/graphics/drawable/LayerDrawable;->setPaddingMode(I)V

    const/4 v4, 0x0

    invoke-virtual {v1, v4, v4, v4, v4}, Landroid/graphics/drawable/LayerDrawable;->setPadding(IIII)V

    return-object v1
.end method

.method public static drawableLightDarkColorAndPadding(Landroid/graphics/drawable/Drawable;IIIIII)Landroid/graphics/drawable/Drawable;
    .registers 18

    move-object v0, p0

    move v1, p1

    move v2, p2

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move/from16 v7, p3

    move/from16 v8, p4

    move/from16 v9, p5

    move/from16 v10, p6

    invoke-static/range {v0 .. v10}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderAndPadding(Landroid/graphics/drawable/Drawable;IIIIFFIIII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static drawableLightDarkColorAndRadius(Landroid/graphics/drawable/Drawable;IIFF)Landroid/graphics/drawable/Drawable;
    .registers 12

    move-object v0, p0

    move v1, p1

    move v2, p2

    const/4 v3, 0x0

    const/4 v4, 0x0

    move v5, p3

    move v6, p4

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorder(Landroid/graphics/drawable/Drawable;IIIIFF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static drawableLightDarkColorAndRadiusAndPadding(Landroid/graphics/drawable/Drawable;IIFFIIII)Landroid/graphics/drawable/Drawable;
    .registers 20

    move-object v0, p0

    move v1, p1

    move v2, p2

    const/4 v3, 0x0

    const/4 v4, 0x0

    move v5, p3

    move v6, p4

    move/from16 v7, p5

    move/from16 v8, p6

    move/from16 v9, p7

    move/from16 v10, p8

    invoke-static/range {v0 .. v10}, Landroidx/preference/MyXPreference;->drawableLightDarkColorAndBorderAndPadding(Landroid/graphics/drawable/Drawable;IIIIFFIIII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getColorDrawableWithPadding(IIIII)Landroid/graphics/drawable/Drawable;
    .registers 11

    move v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    const/4 v5, 0x0

    invoke-static/range {v0 .. v5}, Landroidx/preference/MyXPreference;->getColorDrawableWithPaddingAndRadius(IIIIIF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getColorDrawableWithPaddingAndRadius(IIIIIF)Landroid/graphics/drawable/Drawable;
    .registers 12

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v1, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {v1, p5}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    new-instance v0, Landroid/graphics/drawable/InsetDrawable;

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Landroid/graphics/drawable/InsetDrawable;-><init>(Landroid/graphics/drawable/Drawable;IIII)V

    return-object v0
.end method

.method public static getColorDrawableWithPaddingAndTopBottomRadius(IIIIIFF)Landroid/graphics/drawable/Drawable;
    .registers 13

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v1, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const v3, 0x8

    new-array v2, v3, [F

    const/4 v3, 0x0

    aput p5, v2, v3

    const/4 v3, 0x1

    aput p5, v2, v3

    const/4 v3, 0x2

    aput p5, v2, v3

    const/4 v3, 0x3

    aput p5, v2, v3

    const/4 v3, 0x4

    aput p6, v2, v3

    const/4 v3, 0x5

    aput p6, v2, v3

    const/4 v3, 0x6

    aput p6, v2, v3

    const/4 v3, 0x7

    aput p6, v2, v3

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadii([F)V

    new-instance v0, Landroid/graphics/drawable/InsetDrawable;

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Landroid/graphics/drawable/InsetDrawable;-><init>(Landroid/graphics/drawable/Drawable;IIII)V

    return-object v0
.end method

.method public static getColorDrawableWith_LR_TB_Padding(III)Landroid/graphics/drawable/Drawable;
    .registers 9

    move v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p2

    const/4 v5, 0x0

    invoke-static/range {v0 .. v5}, Landroidx/preference/MyXPreference;->getColorDrawableWithPaddingAndRadius(IIIIIF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getColorDrawableWith_LR_TB_PaddingAndRadius(IIIF)Landroid/graphics/drawable/Drawable;
    .registers 10

    move v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p2

    move v5, p3

    invoke-static/range {v0 .. v5}, Landroidx/preference/MyXPreference;->getColorDrawableWithPaddingAndRadius(IIIIIF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getColorDrawableWith_LR_TB_PaddingAndTopBottomRadius(IIIFF)Landroid/graphics/drawable/Drawable;
    .registers 12

    move v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->getColorDrawableWithPaddingAndTopBottomRadius(IIIIIFF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getColorDrawableWith_LR_TopBottomPaddingAndBottomRadius(IIIIF)Landroid/graphics/drawable/Drawable;
    .registers 12

    move v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p3

    const/4 v5, 0x0

    move v6, p4

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->getColorDrawableWithPaddingAndTopBottomRadius(IIIIIFF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getColorDrawableWith_LR_TopBottomPaddingAndRadius(IIIIF)Landroid/graphics/drawable/Drawable;
    .registers 11

    move v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p3

    move v5, p4

    invoke-static/range {v0 .. v5}, Landroidx/preference/MyXPreference;->getColorDrawableWithPaddingAndRadius(IIIIIF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getColorDrawableWith_LR_TopBottomPaddingAndTopRadius(IIIIF)Landroid/graphics/drawable/Drawable;
    .registers 12

    move v0, p0

    move v1, p1

    move v2, p2

    move v3, p1

    move v4, p3

    move v5, p4

    const/4 v6, 0x0

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->getColorDrawableWithPaddingAndTopBottomRadius(IIIIIFF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static getKeyInt(Landroid/content/Context;Ljava/lang/String;)I
    .registers 4

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public static getKeyInt(Landroid/content/Context;Ljava/lang/String;I)I
    .registers 4

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public static getKeyInt1(Landroid/content/Context;Ljava/lang/String;)I
    .registers 4

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, p1, v1}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public static getKeyString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 4

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-static {v0, p1}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_b

    move-object v0, p2

    :cond_b
    return-object v0
.end method

.method private getMyClipboardValue(Landroidx/preference/MiuiXColorPickerPreference;)Ljava/lang/String;
    .registers 8

    const/4 v4, 0x0

    const-string/jumbo v1, "clipboard"

    invoke-virtual {p1}, Landroidx/preference/MiuiXColorPickerPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    invoke-virtual {v0}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object v0

    if-eqz v0, :cond_69

    invoke-virtual {v0}, Landroid/content/ClipData;->getItemCount()I

    move-result v3

    const-string v5, "\u0000"

    :cond_1a
    add-int/lit8 v3, v3, -0x1

    if-ltz v3, :cond_69

    invoke-virtual {v0, v3}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v1

    if-eqz v1, :cond_1a

    invoke-virtual {v1}, Landroid/content/ClipData$Item;->getHtmlText()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1a

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1a

    invoke-virtual {v1}, Landroid/content/ClipData$Item;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    const v1, 0x0

    invoke-virtual {v2, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    if-ltz v1, :cond_1a

    const v4, 0x0

    invoke-virtual {v2, v4, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v2, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1}, Landroidx/preference/MiuiXColorPickerPreference;->getKey()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_61

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_69

    const-string v4, "<>"

    goto :goto_69

    :cond_61
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_69

    const-string v4, "!"

    :cond_69
    :goto_69
    return-object v4
.end method

.method public static getPadding(Landroid/view/View;)[I
    .registers 4

    const/4 v1, 0x4

    new-array v0, v1, [I

    invoke-virtual {p0}, Landroid/view/View;->getPaddingStart()I

    move-result v1

    const/4 v2, 0x0

    aput v1, v0, v2

    invoke-virtual {p0}, Landroid/view/View;->getPaddingTop()I

    move-result v1

    const/4 v2, 0x1

    aput v1, v0, v2

    invoke-virtual {p0}, Landroid/view/View;->getPaddingEnd()I

    move-result v1

    const/4 v2, 0x2

    aput v1, v0, v2

    invoke-virtual {p0}, Landroid/view/View;->getPaddingBottom()I

    move-result v1

    const/4 v2, 0x3

    aput v1, v0, v2

    return-object v0
.end method

.method public static lightDarkColor(IF)I
    .registers 7

    const/4 v4, 0x0

    invoke-static {p0}, Landroid/graphics/Color;->alpha(I)I

    move-result v0

    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v1

    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v2

    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

    move-result v3

    int-to-float v1, v1

    mul-float/2addr v1, p1

    float-to-int v1, v1

    invoke-static {v1, v4}, Ljava/lang/Math;->max(II)I

    move-result v1

    int-to-float v2, v2

    mul-float/2addr v2, p1

    float-to-int v2, v2

    invoke-static {v2, v4}, Ljava/lang/Math;->max(II)I

    move-result v2

    int-to-float v3, v3

    mul-float/2addr v3, p1

    float-to-int v3, v3

    invoke-static {v3, v4}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-static {v0, v1, v2, v3}, Landroid/graphics/Color;->argb(IIII)I

    move-result v0

    return v0
.end method

.method public static setAlpha(II)I
    .registers 4

    move v0, p1

    if-gez v0, :cond_4

    const/4 v0, 0x0

    :cond_4
    const v1, 0xff

    if-le v0, v1, :cond_c

    const v0, 0xff

    :cond_c
    const v1, 0xffffff

    and-int/2addr v1, p0

    shl-int/lit8 v0, v0, 0x18

    or-int/2addr v1, v0

    return v1
.end method

.method public static setBackcolorToViewWithLeftRightPadding(ILandroid/view/View;II)V
    .registers 11

    move v0, p0

    move-object v1, p1

    move v2, p2

    const/4 v3, 0x0

    move v4, p3

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->setBackcolorToViewWithPaddingAndRadius(ILandroid/view/View;IIIIF)V

    return-void
.end method

.method public static setBackcolorToViewWithPadding(ILandroid/view/View;IIII)V
    .registers 13

    move v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    const/4 v6, 0x0

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->setBackcolorToViewWithPaddingAndRadius(ILandroid/view/View;IIIIF)V

    return-void
.end method

.method public static setBackcolorToViewWithPaddingAndRadius(ILandroid/view/View;IIIIF)V
    .registers 13

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v1, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {v1, p6}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    new-instance v0, Landroid/graphics/drawable/InsetDrawable;

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-direct/range {v0 .. v5}, Landroid/graphics/drawable/InsetDrawable;-><init>(Landroid/graphics/drawable/Drawable;IIII)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method public static setBackcolorToViewWithTopBottomPadding(ILandroid/view/View;II)V
    .registers 11

    move v0, p0

    move-object v1, p1

    const/4 v2, 0x0

    move v3, p2

    const/4 v4, 0x0

    move v5, p3

    const/4 v6, 0x0

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->setBackcolorToViewWithPaddingAndRadius(ILandroid/view/View;IIIIF)V

    return-void
.end method

.method public static setBackcolorToViewWith_LR_TB_Padding(ILandroid/view/View;II)V
    .registers 11

    move v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p2

    move v5, p3

    const/4 v6, 0x0

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->setBackcolorToViewWithPaddingAndRadius(ILandroid/view/View;IIIIF)V

    return-void
.end method

.method public static setBackcolorToViewWith_LR_TB_PaddingAndRadius(ILandroid/view/View;IIF)V
    .registers 12

    move v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p2

    move v5, p3

    move v6, p4

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->setBackcolorToViewWithPaddingAndRadius(ILandroid/view/View;IIIIF)V

    return-void
.end method

.method public static setBackcolorToViewWith_TB_PaddingAndRadius(ILandroid/view/View;IF)V
    .registers 11

    move v0, p0

    move-object v1, p1

    const/4 v2, 0x0

    move v3, p2

    const/4 v4, 0x0

    move v5, p2

    move v6, p3

    invoke-static/range {v0 .. v6}, Landroidx/preference/MyXPreference;->setBackcolorToViewWithPaddingAndRadius(ILandroid/view/View;IIIIF)V

    return-void
.end method

.method public static setCornerTopBottomRadius(Landroid/graphics/drawable/GradientDrawable;FF)Landroid/graphics/drawable/GradientDrawable;
    .registers 5

    const v0, 0x8

    new-array v1, v0, [F

    const/4 v0, 0x0

    aput p1, v1, v0

    const/4 v0, 0x1

    aput p1, v1, v0

    const/4 v0, 0x2

    aput p1, v1, v0

    const/4 v0, 0x3

    aput p1, v1, v0

    const/4 v0, 0x4

    aput p2, v1, v0

    const/4 v0, 0x5

    aput p2, v1, v0

    const/4 v0, 0x6

    aput p2, v1, v0

    const/4 v0, 0x7

    aput p2, v1, v0

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadii([F)V

    return-object p0
.end method

.method public static setPadding(Landroid/view/View;[I)V
    .registers 6

    if-eqz p0, :cond_17

    if-eqz p1, :cond_17

    array-length v0, p1

    const/4 v1, 0x4

    if-ne v0, v1, :cond_17

    const/4 v0, 0x0

    aget v1, p1, v0

    const/4 v0, 0x1

    aget v2, p1, v0

    const/4 v0, 0x2

    aget v3, p1, v0

    const/4 v0, 0x3

    aget v0, p1, v0

    invoke-virtual {p0, v1, v2, v3, v0}, Landroid/view/View;->setPadding(IIII)V

    :cond_17
    return-void
.end method


# virtual methods
.method public getInteger(Landroid/content/Context;Ljava/lang/String;I)I
    .registers 7

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget v2, p0, Landroidx/preference/MyXPreference;->mStorage:I

    if-eqz v2, :cond_15

    const/4 v0, 0x1

    if-eq v2, v0, :cond_10

    invoke-static {v1, p2, p3}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    goto :goto_19

    :cond_10
    invoke-static {v1, p2, p3}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    goto :goto_19

    :cond_15
    invoke-static {v1, p2, p3}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    :goto_19
    return v1
.end method

.method public getMargin()I
    .registers 2

    iget v0, p0, Landroidx/preference/MyXPreference;->mMargin:I

    mul-int/lit8 v0, v0, 0x2f

    return v0
.end method

.method public getString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 7

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget v2, p0, Landroidx/preference/MyXPreference;->mStorage:I

    if-eqz v2, :cond_15

    const/4 v0, 0x1

    if-eq v2, v0, :cond_10

    invoke-static {v1, p2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_19

    :cond_10
    invoke-static {v1, p2}, Landroid/provider/Settings$Global;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_19

    :cond_15
    invoke-static {v1, p2}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_19
    if-nez v1, :cond_1c

    move-object v1, p3

    :cond_1c
    return-object v1
.end method

.method protected handleMyClipboard(Landroidx/preference/MiuiXColorPickerPreference;)Z
    .registers 6

    const v2, 0x0

    invoke-direct {p0, p1}, Landroidx/preference/MyXPreference;->getMyClipboardValue(Landroidx/preference/MiuiXColorPickerPreference;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_39

    const-string v1, "<>"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2f

    const-string v1, "!"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_39

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_54

    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {p1, v3}, Landroidx/preference/MiuiXColorPickerPreference;->setNewColor(I)V

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, p1, v0, v1, v0}, Landroidx/preference/MyXPreference;->updateMyClipboardValue(Landroidx/preference/MiuiXColorPickerPreference;ZZLjava/lang/String;)V

    const-string/jumbo v0, "☺ Color pasted!"

    goto :goto_47

    :cond_2f
    const/4 v0, 0x0

    const-string v1, ""

    invoke-virtual {p0, p1, v0, v0, v1}, Landroidx/preference/MyXPreference;->updateMyClipboardValue(Landroidx/preference/MiuiXColorPickerPreference;ZZLjava/lang/String;)V

    const-string/jumbo v0, "☺ My Clipboard ClearEd!"

    goto :goto_47

    :cond_39
    const/4 v1, 0x1

    const/4 v0, 0x0

    iget v3, p1, Landroidx/preference/MiuiXColorPickerPreference;->mValue:I

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, p1, v0, v1, v3}, Landroidx/preference/MyXPreference;->updateMyClipboardValue(Landroidx/preference/MiuiXColorPickerPreference;ZZLjava/lang/String;)V

    const-string/jumbo v0, "☺ Color copied to My clipboard!"

    :goto_47
    const/4 v1, 0x0

    invoke-virtual {p1}, Landroidx/preference/MiuiXColorPickerPreference;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    const/4 v2, 0x1

    :cond_54
    return v2
.end method

.method public sendIntent(Landroid/content/Context;)V
    .registers 9

    iget-object v0, p0, Landroidx/preference/MyXPreference;->mIntent:Ljava/lang/String;

    if-eqz v0, :cond_37

    const-string v1, ";"

    const/4 v3, 0x0

    iget-object v4, p0, Landroidx/preference/MyXPreference;->mIntentExtra:Ljava/lang/String;

    const/4 v5, 0x0

    if-eqz v4, :cond_11

    invoke-virtual {v4, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    array-length v3, v5

    :cond_11
    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    array-length v1, v0

    const v2, -0x1

    :cond_19
    :goto_19
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v1, :cond_37

    aget-object p0, v0, v2

    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_19

    new-instance v4, Landroid/content/Intent;

    invoke-direct {v4, p0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    if-ge v2, v3, :cond_33

    aget-object p0, v5, v2

    const-string v6, "extra"

    invoke-virtual {v4, v6, p0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_33
    invoke-virtual {p1, v4}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_19

    :cond_37
    return-void
.end method

.method public setInteger(Landroid/content/Context;Ljava/lang/String;I)V
    .registers 7

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget v2, p0, Landroidx/preference/MyXPreference;->mStorage:I

    if-eqz v2, :cond_13

    const/4 v0, 0x1

    if-eq v2, v0, :cond_f

    invoke-static {v1, p2, p3}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_16

    :cond_f
    invoke-static {v1, p2, p3}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_16

    :cond_13
    invoke-static {v1, p2, p3}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :goto_16
    return-void
.end method

.method public setMargin(Landroid/view/View;Landroid/content/Context;)I
    .registers 7

    invoke-virtual {p2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "title"

    const-string v2, "id"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    const/4 v0, 0x0

    if-eqz v1, :cond_27

    invoke-virtual {p0}, Landroidx/preference/MyXPreference;->getMargin()I

    move-result v0

    invoke-virtual {v1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup$MarginLayoutParams;

    iput v0, v1, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    :cond_27
    return v0
.end method

.method public setString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .registers 7

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget v2, p0, Landroidx/preference/MyXPreference;->mStorage:I

    if-eqz v2, :cond_13

    const/4 v0, 0x1

    if-eq v2, v0, :cond_f

    invoke-static {v1, p2, p3}, Landroid/provider/Settings$Secure;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_16

    :cond_f
    invoke-static {v1, p2, p3}, Landroid/provider/Settings$Global;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_16

    :cond_13
    invoke-static {v1, p2, p3}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    :goto_16
    return-void
.end method

.method protected updateMyClipboardValue(Landroidx/preference/MiuiXColorPickerPreference;ZZLjava/lang/String;)V
    .registers 13

    const-string/jumbo v1, "clipboard"

    invoke-virtual {p1}, Landroidx/preference/MiuiXColorPickerPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/content/ClipboardManager;

    invoke-virtual {v4}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object v0

    if-eqz v0, :cond_7c

    invoke-virtual {v0}, Landroid/content/ClipData;->getItemCount()I

    move-result v7

    const-string v6, "\u0000"

    :cond_19
    add-int/lit8 v7, v7, -0x1

    if-ltz v7, :cond_82

    invoke-virtual {v0, v7}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v1

    if-eqz v1, :cond_19

    invoke-virtual {v1}, Landroid/content/ClipData$Item;->getHtmlText()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_19

    invoke-virtual {v3, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_19

    invoke-virtual {v1}, Landroid/content/ClipData$Item;->getText()Ljava/lang/CharSequence;

    move-result-object v3

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    const v2, 0x0

    invoke-virtual {v3, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    if-ltz v2, :cond_19

    if-nez p2, :cond_5a

    const/4 v5, 0x0

    invoke-virtual {v3, v5, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v3, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    :goto_4d
    if-eqz p4, :cond_50

    move-object v6, p4

    :cond_50
    if-eqz p3, :cond_5e

    invoke-virtual {p1}, Landroidx/preference/MiuiXColorPickerPreference;->getKey()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_5e

    move-object v5, v2

    goto :goto_5e

    :cond_5a
    const-string v5, ""

    const-string v6, ""

    :cond_5e
    :goto_5e
    const-string v2, "\u0000"

    invoke-virtual {v5, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v6}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "\u0000"

    new-instance v1, Landroid/content/ClipData$Item;

    invoke-direct {v1, v5, v6}, Landroid/content/ClipData$Item;-><init>(Ljava/lang/CharSequence;Ljava/lang/String;)V

    if-ltz v7, :cond_75

    invoke-virtual {v0, v7, v1}, Landroid/content/ClipData;->setItemAt(ILandroid/content/ClipData$Item;)V

    goto :goto_78

    :cond_75
    invoke-virtual {v0, v1}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V

    :cond_78
    :goto_78
    invoke-virtual {v4, v0}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    return-void

    :cond_7c
    const-string v0, ""

    invoke-static {v0, v0}, Landroid/content/ClipData;->newPlainText(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/content/ClipData;

    move-result-object v0

    :cond_82
    if-nez p2, :cond_78

    const v7, -0x1

    const-string v5, "\u0000"

    const-string v6, "\u0000"

    goto :goto_4d
.end method
