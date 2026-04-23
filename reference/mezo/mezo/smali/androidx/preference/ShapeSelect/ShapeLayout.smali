# classes10.dex

.class public Landroidx/preference/ShapeSelect/ShapeLayout;
.super Landroid/widget/LinearLayout;
.source "ShapeLayout.java"


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/ShapeLayout;->init()V

    return-void
.end method

.method private init()V
    .registers 7

    const/4 v4, 0x0

    invoke-virtual {p0, v4}, Landroidx/preference/ShapeSelect/ShapeLayout;->setOrientation(I)V

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x0

    :goto_9
    const/4 v4, 0x5

    if-ge v1, v4, :cond_28

    new-instance v3, Landroidx/preference/ShapeSelect/ShapeImageView;

    invoke-direct {v3, v0}, Landroidx/preference/ShapeSelect/ShapeImageView;-><init>(Landroid/content/Context;)V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v4, 0x64

    const/16 v5, 0x96

    invoke-direct {v2, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/16 v4, 0x31

    iput v4, v2, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    const/high16 v4, 0x3f800000  # 1.0f

    iput v4, v2, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    invoke-virtual {p0, v3, v2}, Landroidx/preference/ShapeSelect/ShapeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_9

    :cond_28
    return-void
.end method


# virtual methods
.method public setChecked(Ljava/lang/CharSequence;)Z
    .registers 8

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_2
    const/4 v4, 0x5

    if-ge v1, v4, :cond_26

    invoke-virtual {p0, v1}, Landroidx/preference/ShapeSelect/ShapeLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroidx/preference/ShapeSelect/ShapeImageView;

    invoke-virtual {v3}, Landroidx/preference/ShapeSelect/ShapeImageView;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v2

    if-eqz v2, :cond_23

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_23

    invoke-virtual {v3, v3}, Landroidx/preference/ShapeSelect/ShapeImageView;->onClick(Landroid/view/View;)V

    const/4 v0, 0x1

    :cond_23
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_26
    return v0
.end method

.method public setContent([Landroid/graphics/drawable/Drawable;[Ljava/lang/CharSequence;Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;)V
    .registers 8

    const/4 v0, 0x0

    :goto_1
    const/4 v2, 0x5

    if-ge v0, v2, :cond_36

    invoke-virtual {p0, v0}, Landroidx/preference/ShapeSelect/ShapeLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/preference/ShapeSelect/ShapeImageView;

    aget-object v2, p2, v0

    if-eqz v2, :cond_30

    aget-object v2, p2, v0

    const-string v3, "-1"

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_30

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeLayout;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "no_shape"

    invoke-static {v2, v3}, Landroid/Utils/Utils;->DrawableToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/preference/ShapeSelect/ShapeImageView;->setImageResource(I)V

    :goto_25
    aget-object v2, p2, v0

    invoke-virtual {v1, v2}, Landroidx/preference/ShapeSelect/ShapeImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    invoke-virtual {v1, p3}, Landroidx/preference/ShapeSelect/ShapeImageView;->setOnDrawableClickListener(Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_30
    aget-object v2, p1, v0

    invoke-virtual {v1, v2}, Landroidx/preference/ShapeSelect/ShapeImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_25

    :cond_36
    return-void
.end method

.method public unChecked(Ljava/lang/CharSequence;)V
    .registers 7

    const/4 v0, 0x0

    :goto_1
    const/4 v3, 0x5

    if-ge v0, v3, :cond_24

    invoke-virtual {p0, v0}, Landroidx/preference/ShapeSelect/ShapeLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroidx/preference/ShapeSelect/ShapeImageView;

    invoke-virtual {v2}, Landroidx/preference/ShapeSelect/ShapeImageView;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v1

    if-eqz v1, :cond_21

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_21

    invoke-virtual {v2}, Landroidx/preference/ShapeSelect/ShapeImageView;->normalize()V

    :cond_21
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_24
    return-void
.end method

.method public unCheckedAll()V
    .registers 5

    const/4 v0, 0x0

    :goto_1
    const/4 v3, 0x5

    if-ge v0, v3, :cond_16

    invoke-virtual {p0, v0}, Landroidx/preference/ShapeSelect/ShapeLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroidx/preference/ShapeSelect/ShapeImageView;

    invoke-virtual {v2}, Landroidx/preference/ShapeSelect/ShapeImageView;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v1

    if-eqz v1, :cond_13

    invoke-virtual {v2}, Landroidx/preference/ShapeSelect/ShapeImageView;->normalize()V

    :cond_13
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_16
    return-void
.end method
