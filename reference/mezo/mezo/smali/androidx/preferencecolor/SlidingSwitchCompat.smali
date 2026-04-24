# classes10.dex

.class public Landroidx/preferencecolor/SlidingSwitchCompat;
.super Lmiuix/slidingwidget/widget/SlidingSwitchCompat;
.source "SlidingSwitchCompat.java"

# interfaces
.implements Landroidx/preferencecolor/PreferenceColorController$ColorImpl;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0, p1}, Lmiuix/slidingwidget/widget/SlidingSwitchCompat;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lmiuix/slidingwidget/widget/SlidingSwitchCompat;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 4

    invoke-direct {p0, p1, p2, p3}, Lmiuix/slidingwidget/widget/SlidingSwitchCompat;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method private getHelper()Lmiuix/slidingwidget/widget/MySlidingButtonHelper;
    .registers 3

    const-string v0, "mHelper"

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Landroid/Utils/ReflectionUtil;->getFieldFromSuperClass(Ljava/lang/Object;Ljava/lang/String;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lmiuix/slidingwidget/widget/MySlidingButtonHelper;

    return-object v0
.end method


# virtual methods
.method protected onAttachedToWindow()V
    .registers 2

    invoke-super {p0}, Lmiuix/slidingwidget/widget/SlidingSwitchCompat;->onAttachedToWindow()V

    invoke-static {}, Landroidx/preferencecolor/PreferenceColorController;->getInstance()Landroidx/preferencecolor/PreferenceColorController;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroidx/preferencecolor/PreferenceColorController;->addCallBack(Landroidx/preferencecolor/PreferenceColorController$ColorImpl;)V

    new-instance v0, Landroidx/preferencecolor/SlidingSwitchCompat$1;

    invoke-direct {v0, p0}, Landroidx/preferencecolor/SlidingSwitchCompat$1;-><init>(Landroidx/preferencecolor/SlidingSwitchCompat;)V

    invoke-virtual {p0, v0}, Landroidx/preferencecolor/SlidingSwitchCompat;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method protected onDetachedFromWindow()V
    .registers 2

    invoke-super {p0}, Lmiuix/slidingwidget/widget/SlidingSwitchCompat;->onDetachedFromWindow()V

    invoke-static {}, Landroidx/preferencecolor/PreferenceColorController;->getInstance()Landroidx/preferencecolor/PreferenceColorController;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroidx/preferencecolor/PreferenceColorController;->removeCallBack(Landroidx/preferencecolor/PreferenceColorController$ColorImpl;)V

    return-void
.end method

.method public onPreferenceColorChange()V
    .registers 3

    invoke-direct {p0}, Landroidx/preferencecolor/SlidingSwitchCompat;->getHelper()Lmiuix/slidingwidget/widget/MySlidingButtonHelper;

    move-result-object v0

    invoke-static {}, Landroidx/preferencecolor/PreferenceColorController;->getInstance()Landroidx/preferencecolor/PreferenceColorController;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/preferencecolor/PreferenceColorController;->getColorData()Landroidx/preferencecolor/PreferenceColorController$ColorData;

    move-result-object v1

    invoke-virtual {v0, v1}, Lmiuix/slidingwidget/widget/MySlidingButtonHelper;->updateColors(Landroidx/preferencecolor/PreferenceColorController$ColorData;)V

    return-void
.end method
