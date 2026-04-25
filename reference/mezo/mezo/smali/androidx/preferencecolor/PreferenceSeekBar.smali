# classes10.dex

.class public Landroidx/preferencecolor/PreferenceSeekBar;
.super Lmiuix/androidbasewidget/widget/SeekBar;
.source "PreferenceSeekBar.java"

# interfaces
.implements Landroidx/preferencecolor/PreferenceColorController$ColorImpl;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0, p1}, Lmiuix/androidbasewidget/widget/SeekBar;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Lmiuix/androidbasewidget/widget/SeekBar;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 4

    invoke-direct {p0, p1, p2, p3}, Lmiuix/androidbasewidget/widget/SeekBar;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method


# virtual methods
.method protected onAttachedToWindow()V
    .registers 2

    invoke-super {p0}, Lmiuix/androidbasewidget/widget/SeekBar;->onAttachedToWindow()V

    invoke-static {}, Landroidx/preferencecolor/PreferenceColorController;->getInstance()Landroidx/preferencecolor/PreferenceColorController;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroidx/preferencecolor/PreferenceColorController;->addCallBack(Landroidx/preferencecolor/PreferenceColorController$ColorImpl;)V

    new-instance v0, Landroidx/preferencecolor/PreferenceSeekBar$1;

    invoke-direct {v0, p0}, Landroidx/preferencecolor/PreferenceSeekBar$1;-><init>(Landroidx/preferencecolor/PreferenceSeekBar;)V

    invoke-virtual {p0, v0}, Landroidx/preferencecolor/PreferenceSeekBar;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method protected onDetachedFromWindow()V
    .registers 2

    invoke-super {p0}, Lmiuix/androidbasewidget/widget/SeekBar;->onDetachedFromWindow()V

    invoke-static {}, Landroidx/preferencecolor/PreferenceColorController;->getInstance()Landroidx/preferencecolor/PreferenceColorController;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroidx/preferencecolor/PreferenceColorController;->removeCallBack(Landroidx/preferencecolor/PreferenceColorController$ColorImpl;)V

    return-void
.end method

.method public onPreferenceColorChange()V
    .registers 2

    const/4 v0, 0x0

    invoke-virtual {p0, v0, v0}, Landroidx/preferencecolor/PreferenceSeekBar;->setForegroundPrimaryColor(II)V

    return-void
.end method

.method public setForegroundPrimaryColor(II)V
    .registers 8

    const/4 v4, 0x1

    invoke-static {}, Landroidx/preferencecolor/PreferenceColorController;->getInstance()Landroidx/preferencecolor/PreferenceColorController;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/preferencecolor/PreferenceColorController;->getColorData()Landroidx/preferencecolor/PreferenceColorController$ColorData;

    move-result-object v1

    iget v0, v1, Landroidx/preferencecolor/PreferenceColorController$ColorData;->seekBarColor:I

    if-nez v0, :cond_25

    invoke-virtual {p0}, Landroidx/preferencecolor/PreferenceSeekBar;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {p0}, Landroidx/preferencecolor/PreferenceSeekBar;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {}, Landroid/Utils/Utils;->isNightMode()Z

    move-result v1

    if-eqz v1, :cond_37

    const-string v1, "miuix_appcompat_progress_primary_colors_dark"

    :goto_1d
    invoke-static {v3, v1}, Landroid/Utils/Utils;->ColorToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v2, v1}, Landroid/content/Context;->getColor(I)I

    move-result v0

    :cond_25
    const-string v1, "mForegroundPrimaryColor"

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {p0, v1, v2, v4}, Landroid/Utils/ReflectionUtil;->setFieldForSuperClass(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;I)Z

    const-string v1, "updatePrimaryColor"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v4, v2}, Landroid/Utils/ReflectionUtil;->invokeInSuperClass(Ljava/lang/Object;Ljava/lang/String;I[Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_37
    const-string v1, "miuix_appcompat_progress_primary_colors_light"

    goto :goto_1d
.end method
