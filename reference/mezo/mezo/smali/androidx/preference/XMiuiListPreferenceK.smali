# classes10.dex

.class public Landroidx/preference/XMiuiListPreferenceK;
.super Landroidx/preference/ListPreference;
.source "XMiuiListPreferenceK.java"


# instance fields
.field private Helper:Landroidx/preference/XMiuiPreferenceHelper;

.field private mLastState:Ljava/lang/String;

.field private mPrSfSummary:[Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 5

    const/4 v1, 0x0

    invoke-direct {p0, p1, p2}, Landroidx/preference/ListPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance v0, Landroidx/preference/XMiuiPreferenceHelper;

    invoke-direct {v0, p1, p2}, Landroidx/preference/XMiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey()Z

    move-result v0

    if-eqz v0, :cond_2b

    iget-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->getStr()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->mLastState:Ljava/lang/String;

    :goto_1b
    iget-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->mLastState:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiListPreferenceK;->setValue(Ljava/lang/String;)V

    invoke-virtual {p0}, Landroidx/preference/XMiuiListPreferenceK;->getEntry()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiListPreferenceK;->setSummary(Ljava/lang/CharSequence;)V

    invoke-virtual {p0, v1}, Landroidx/preference/XMiuiListPreferenceK;->setPersistent(Z)V

    return-void

    :cond_2b
    invoke-virtual {p0}, Landroidx/preference/XMiuiListPreferenceK;->getEntryValues()[Ljava/lang/CharSequence;

    move-result-object v0

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->mLastState:Ljava/lang/String;

    goto :goto_1b
.end method

.method private getDependents(Ljava/lang/String;)Z
    .registers 4

    const/4 v0, 0x0

    :try_start_1
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_4
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_4} :catch_9

    move-result v1

    if-gtz v1, :cond_8

    const/4 v0, 0x1

    :cond_8
    :goto_8
    return v0

    :catch_9
    move-exception v1

    goto :goto_8
.end method


# virtual methods
.method public callChangeListener(Ljava/lang/Object;)Z
    .registers 7

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/XMiuiListPreferenceK;->mLastState:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    iget-object v1, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1, v0}, Landroidx/preference/XMiuiPreferenceHelper;->putStr(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    iput-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->mLastState:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiListPreferenceK;->setValue(Ljava/lang/String;)V

    invoke-virtual {p0}, Landroidx/preference/XMiuiListPreferenceK;->getEntry()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p0, v1}, Landroidx/preference/XMiuiListPreferenceK;->setSummary(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Landroidx/preference/XMiuiListPreferenceK;->getValue()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Landroidx/preference/XMiuiListPreferenceK;->getDependents(Ljava/lang/String;)Z

    move-result v1

    invoke-virtual {p0, v1}, Landroidx/preference/XMiuiListPreferenceK;->notifyDependencyChange(Z)V

    :try_start_2d
    invoke-virtual {p0}, Landroidx/preference/XMiuiListPreferenceK;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "activity"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager;

    if-eqz v1, :cond_6f

    const-string v2, "com.google.android.gms"

    invoke-virtual {v1, v2}, Landroid/app/ActivityManager;->forceStopPackage(Ljava/lang/String;)V

    const-string v2, "com.google.android.gms.unstable"

    invoke-virtual {v1, v2}, Landroid/app/ActivityManager;->forceStopPackage(Ljava/lang/String;)V

    const-string v2, "com.android.vending"

    invoke-virtual {v1, v2}, Landroid/app/ActivityManager;->forceStopPackage(Ljava/lang/String;)V

    const-string v2, "XMiuiListPreferenceK"

    const-string v3, "Killed GMS after list preference change"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_51
    .catch Ljava/lang/Exception; {:try_start_2d .. :try_end_51} :catch_52

    goto :goto_6f

    :catch_52
    move-exception v1

    const-string v2, "XMiuiListPreferenceK"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Failed to kill GMS: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_6f
    :goto_6f
    invoke-super {p0, p1}, Landroidx/preference/ListPreference;->callChangeListener(Ljava/lang/Object;)Z

    move-result v2

    return v2
.end method

.method protected onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Object;
    .registers 4

    invoke-virtual {p1, p2}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected onSetInitialValue(Ljava/lang/Object;)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey()Z

    move-result v0

    if-eqz v0, :cond_1d

    iget-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->getStr()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->mLastState:Ljava/lang/String;

    :cond_10
    :goto_10
    iget-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->mLastState:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiListPreferenceK;->setValue(Ljava/lang/String;)V

    invoke-virtual {p0}, Landroidx/preference/XMiuiListPreferenceK;->getEntry()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiListPreferenceK;->setSummary(Ljava/lang/CharSequence;)V

    return-void

    :cond_1d
    if-eqz p1, :cond_10

    check-cast p1, Ljava/lang/String;

    iput-object p1, p0, Landroidx/preference/XMiuiListPreferenceK;->mLastState:Ljava/lang/String;

    iget-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/XMiuiListPreferenceK;->mLastState:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroidx/preference/XMiuiPreferenceHelper;->putStr(Ljava/lang/String;)V

    iget-object v0, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    goto :goto_10
.end method

.method public shouldDisableDependents()Z
    .registers 3

    const/4 v0, 0x0

    :try_start_1
    iget-object v1, p0, Landroidx/preference/XMiuiListPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1}, Landroidx/preference/XMiuiPreferenceHelper;->getStr()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_a
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_a} :catch_f

    move-result v1

    if-gtz v1, :cond_e

    const/4 v0, 0x1

    :cond_e
    :goto_e
    return v0

    :catch_f
    move-exception v1

    goto :goto_e
.end method
