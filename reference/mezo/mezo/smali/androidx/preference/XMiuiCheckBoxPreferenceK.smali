# classes10.dex

.class public Landroidx/preference/XMiuiCheckBoxPreferenceK;
.super Landroidx/preference/CheckBoxPreference;
.source "XMiuiCheckBoxPreferenceK.java"


# instance fields
.field private Helper:Landroidx/preference/XMiuiPreferenceHelper;

.field private mDefaultValue:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 7

    invoke-direct {p0, p1, p2}, Landroidx/preference/CheckBoxPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance v0, Landroidx/preference/XMiuiPreferenceHelper;

    invoke-direct {v0, p1, p2}, Landroidx/preference/XMiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiCheckBoxPreferenceK;->setPersistent(Z)V

    iget-object v1, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v2, "defaultValue"

    invoke-virtual {v1, v2}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeAndroidValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move-object v3, v1

    if-eqz v1, :cond_21

    const-string v1, ""

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2e

    :cond_21
    iget-object v1, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1, v2, v0}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeAndroidBool(Ljava/lang/String;Z)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiCheckBoxPreferenceK;->setDefaultValue(Ljava/lang/Object;)V

    :cond_2e
    return-void
.end method


# virtual methods
.method protected onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Object;
    .registers 4

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v0

    iput v0, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->mDefaultValue:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method protected onSetInitialValue(Ljava/lang/Object;)V
    .registers 4

    instance-of v0, p1, Ljava/lang/Boolean;

    if-eqz v0, :cond_d

    move-object v0, p1

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iput v0, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->mDefaultValue:I

    :cond_d
    iget-object v0, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget v1, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->mDefaultValue:I

    invoke-virtual {v0, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getBool(I)Z

    move-result v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiCheckBoxPreferenceK;->setChecked(Z)V

    return-void
.end method

.method public setChecked(Z)V
    .registers 6

    invoke-virtual {p0}, Landroidx/preference/XMiuiCheckBoxPreferenceK;->isChecked()Z

    move-result v0

    if-eq p1, v0, :cond_9

    invoke-super {p0, p1}, Landroidx/preference/CheckBoxPreference;->setChecked(Z)V

    :cond_9
    iget-object v0, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget v1, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->mDefaultValue:I

    invoke-virtual {v0, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getBool(I)Z

    move-result v0

    if-ne p1, v0, :cond_1b

    iget-object v0, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey()Z

    move-result v0

    if-nez v0, :cond_67

    :cond_1b
    iget-object v0, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0, p1}, Landroidx/preference/XMiuiPreferenceHelper;->setInt(I)V

    iget-object v0, p0, Landroidx/preference/XMiuiCheckBoxPreferenceK;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    :try_start_25
    invoke-virtual {p0}, Landroidx/preference/XMiuiCheckBoxPreferenceK;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "activity"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    if-eqz v0, :cond_67

    const-string v1, "com.google.android.gms"

    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->forceStopPackage(Ljava/lang/String;)V

    const-string v1, "com.google.android.gms.unstable"

    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->forceStopPackage(Ljava/lang/String;)V

    const-string v1, "com.android.vending"

    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->forceStopPackage(Ljava/lang/String;)V

    const-string v1, "XMiuiCheckBoxPreferenceK"

    const-string v2, "Killed GMS after checkbox state change"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_49
    .catch Ljava/lang/Exception; {:try_start_25 .. :try_end_49} :catch_4a

    goto :goto_67

    :catch_4a
    move-exception v0

    const-string v1, "XMiuiCheckBoxPreferenceK"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to kill GMS: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_67
    :goto_67
    return-void
.end method
