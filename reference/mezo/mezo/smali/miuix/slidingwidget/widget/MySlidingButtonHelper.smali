# classes10.dex

.class public Lmiuix/slidingwidget/widget/MySlidingButtonHelper;
.super Lmiuix/slidingwidget/widget/SlidingButtonHelper;


# direct methods
.method public constructor <init>(Landroid/widget/CompoundButton;)V
    .registers 2

    invoke-direct {p0, p1}, Lmiuix/slidingwidget/widget/SlidingButtonHelper;-><init>(Landroid/widget/CompoundButton;)V

    return-void
.end method

.method private getmMaskCheckedSlideBar()Landroid/graphics/drawable/Drawable;
    .registers 3

    const-string v0, "mMaskCheckedSlideBar"

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Landroid/Utils/ReflectionUtil;->getFieldFromSuperClass(Ljava/lang/Object;Ljava/lang/String;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method private getmMaskUnCheckedPressedSlideBar()Landroid/graphics/drawable/Drawable;
    .registers 3

    const-string v0, "mMaskUnCheckedPressedSlideBar"

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Landroid/Utils/ReflectionUtil;->getFieldFromSuperClass(Ljava/lang/Object;Ljava/lang/String;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method private getmMaskUnCheckedSlideBar()Landroid/graphics/drawable/Drawable;
    .registers 3

    const-string v0, "mMaskUnCheckedSlideBar"

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Landroid/Utils/ReflectionUtil;->getFieldFromSuperClass(Ljava/lang/Object;Ljava/lang/String;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method private getmSliderOff()Landroid/graphics/drawable/Drawable;
    .registers 3

    const-string v0, "mSliderOff"

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Landroid/Utils/ReflectionUtil;->getFieldFromSuperClass(Ljava/lang/Object;Ljava/lang/String;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    return-object v0
.end method


# virtual methods
.method public initResource(Landroid/content/Context;Landroid/content/res/TypedArray;)V
    .registers 4

    invoke-super {p0, p1, p2}, Lmiuix/slidingwidget/widget/SlidingButtonHelper;->initResource(Landroid/content/Context;Landroid/content/res/TypedArray;)V

    invoke-static {}, Landroidx/preferencecolor/PreferenceColorController;->getInstance()Landroidx/preferencecolor/PreferenceColorController;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/preferencecolor/PreferenceColorController;->getColorData()Landroidx/preferencecolor/PreferenceColorController$ColorData;

    move-result-object v0

    invoke-virtual {p0, v0}, Lmiuix/slidingwidget/widget/MySlidingButtonHelper;->updateColors(Landroidx/preferencecolor/PreferenceColorController$ColorData;)V

    return-void
.end method

.method public updateColors(Landroidx/preferencecolor/PreferenceColorController$ColorData;)V
    .registers 8

    const/4 v1, 0x0

    :try_start_1
    invoke-virtual {p0}, Lmiuix/slidingwidget/widget/MySlidingButtonHelper;->getSliderOn()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    iget v2, p1, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOn:I

    if-nez v2, :cond_31

    move-object v2, v1

    :goto_a
    invoke-virtual {v3, v2}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    invoke-direct {p0}, Lmiuix/slidingwidget/widget/MySlidingButtonHelper;->getmSliderOff()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    iget v2, p1, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOff:I

    if-nez v2, :cond_5b

    move-object v2, v1

    :goto_16
    invoke-virtual {v3, v2}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    invoke-direct {p0}, Lmiuix/slidingwidget/widget/MySlidingButtonHelper;->getmMaskCheckedSlideBar()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    iget v2, p1, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOnBg:I

    if-nez v2, :cond_65

    move-object v2, v1

    :goto_22
    invoke-virtual {v3, v2}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    invoke-direct {p0}, Lmiuix/slidingwidget/widget/MySlidingButtonHelper;->getmMaskUnCheckedSlideBar()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    iget v3, p1, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOffBg:I

    if-nez v3, :cond_6f

    :goto_2d
    invoke-virtual {v2, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    :goto_30
    return-void

    :cond_31
    new-instance v2, Landroid/graphics/PorterDuffColorFilter;

    iget v4, p1, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOn:I

    sget-object v5, Landroid/graphics/PorterDuff$Mode;->SRC:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v2, v4, v5}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V
    :try_end_3a
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_3a} :catch_3b

    goto :goto_a

    :catch_3b
    move-exception v0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "initResource: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_30

    :cond_5b
    :try_start_5b
    new-instance v2, Landroid/graphics/PorterDuffColorFilter;

    iget v4, p1, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOff:I

    sget-object v5, Landroid/graphics/PorterDuff$Mode;->SRC:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v2, v4, v5}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    goto :goto_16

    :cond_65
    new-instance v2, Landroid/graphics/PorterDuffColorFilter;

    iget v4, p1, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOnBg:I

    sget-object v5, Landroid/graphics/PorterDuff$Mode;->SRC:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v2, v4, v5}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    goto :goto_22

    :cond_6f
    new-instance v1, Landroid/graphics/PorterDuffColorFilter;

    iget v3, p1, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOffBg:I

    sget-object v4, Landroid/graphics/PorterDuff$Mode;->SRC:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v1, v3, v4}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V
    :try_end_78
    .catch Ljava/lang/Exception; {:try_start_5b .. :try_end_78} :catch_3b

    goto :goto_2d
.end method
