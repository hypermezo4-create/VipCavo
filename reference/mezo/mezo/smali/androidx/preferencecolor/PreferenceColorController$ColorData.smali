# classes10.dex

.class public Landroidx/preferencecolor/PreferenceColorController$ColorData;
.super Ljava/lang/Object;
.source "PreferenceColorController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preferencecolor/PreferenceColorController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "ColorData"
.end annotation


# instance fields
.field public backGround:Landroid/graphics/drawable/Drawable;

.field public seekBarColor:I

.field public slidingOff:I

.field public slidingOffBg:I

.field public slidingOn:I

.field public slidingOnBg:I

.field public summaryColor:I

.field final synthetic this$0:Landroidx/preferencecolor/PreferenceColorController;

.field public titleColor:I


# direct methods
.method public constructor <init>(Landroidx/preferencecolor/PreferenceColorController;)V
    .registers 2

    iput-object p1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->this$0:Landroidx/preferencecolor/PreferenceColorController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public copy()Landroidx/preferencecolor/PreferenceColorController$ColorData;
    .registers 3

    new-instance v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;

    iget-object v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->this$0:Landroidx/preferencecolor/PreferenceColorController;

    invoke-direct {v0, v1}, Landroidx/preferencecolor/PreferenceColorController$ColorData;-><init>(Landroidx/preferencecolor/PreferenceColorController;)V

    iget v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->titleColor:I

    iput v1, v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->titleColor:I

    iget v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->summaryColor:I

    iput v1, v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->summaryColor:I

    iget-object v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->backGround:Landroid/graphics/drawable/Drawable;

    if-eqz v1, :cond_1f

    iget-object v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->backGround:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    iput-object v1, v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->backGround:Landroid/graphics/drawable/Drawable;

    :cond_1f
    iget v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->seekBarColor:I

    iput v1, v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->seekBarColor:I

    iget v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOn:I

    iput v1, v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOn:I

    iget v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOff:I

    iput v1, v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOff:I

    iget v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOnBg:I

    iput v1, v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOnBg:I

    iget v1, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOffBg:I

    iput v1, v0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOffBg:I

    return-object v0
.end method

.method public update()V
    .registers 3

    const-string v0, "preference_title_color"

    invoke-static {v0}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->titleColor:I

    const-string v0, "preference_title_color"

    invoke-static {v0}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->summaryColor:I

    const-string v0, "preference_seekbar_progress_color"

    const v1, -0x63801a

    invoke-static {v0, v1}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->seekBarColor:I

    const-string v0, "preference_sliding_on_color"

    invoke-static {v0}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOn:I

    const-string v0, "preference_sliding_off_color"

    invoke-static {v0}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOff:I

    const-string v0, "preference_sliding_on_bg_color"

    const v1, -0xff0051

    invoke-static {v0, v1}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOnBg:I

    const-string v0, "preference_sliding_off_bg_color"

    invoke-static {v0}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/preferencecolor/PreferenceColorController$ColorData;->slidingOffBg:I

    return-void
.end method
