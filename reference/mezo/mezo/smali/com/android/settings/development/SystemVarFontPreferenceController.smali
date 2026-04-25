# classes3.dex

.class public Lcom/android/settings/development/SystemVarFontPreferenceController;
.super Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;

# interfaces
.implements Landroidx/preference/Preference$OnPreferenceChangeListener;


# instance fields
.field private final mFragment:Landroidx/fragment/app/Fragment;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroidx/fragment/app/Fragment;)V
    .registers 3

    invoke-direct {p0, p1}, Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lcom/android/settings/development/SystemVarFontPreferenceController;->mFragment:Landroidx/fragment/app/Fragment;

    return-void
.end method


# virtual methods
.method public getPreferenceKey()Ljava/lang/String;
    .registers 1

    const-string/jumbo p0, "system_var_font"

    return-object p0
.end method

.method protected onDeveloperOptionsSwitchDisabled()V
    .registers 4

    goto/32 :goto_24

    nop

    :goto_4
    invoke-static {v2, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/32 :goto_11

    nop

    :goto_b
    check-cast p0, Landroidx/preference/SwitchPreference;

    goto/32 :goto_33

    nop

    :goto_11
    iget-object p0, p0, Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;->mPreference:Landroidx/preference/Preference;

    goto/32 :goto_b

    nop

    :goto_17
    return-void

    :goto_18
    const/4 v0, 0x1

    goto/32 :goto_2b

    nop

    :goto_1d
    const-string/jumbo v2, "persist.sys.miui_var_font"

    goto/32 :goto_4

    nop

    :goto_24
    invoke-super {p0}, Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;->onDeveloperOptionsSwitchDisabled()V

    goto/32 :goto_18

    nop

    :goto_2b
    invoke-static {v0}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v1

    goto/32 :goto_1d

    nop

    :goto_33
    invoke-virtual {p0, v0}, Landroidx/preference/TwoStatePreference;->setChecked(Z)V

    goto/32 :goto_17

    nop
.end method

.method public onPreferenceChange(Landroidx/preference/Preference;Ljava/lang/Object;)Z
    .registers 3

    iget-object p0, p0, Lcom/android/settings/development/SystemVarFontPreferenceController;->mFragment:Landroidx/fragment/app/Fragment;

    invoke-static {p0}, Lcom/android/settings/development/SystemVarFontRebootDialog;->show(Landroidx/fragment/app/Fragment;)V

    const/4 p0, 0x1

    return p0
.end method

.method public onSystemVarFontDialogConfirmed()V
    .registers 2

    iget-object p0, p0, Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;->mPreference:Landroidx/preference/Preference;

    check-cast p0, Landroidx/preference/SwitchPreference;

    invoke-virtual {p0}, Landroidx/preference/TwoStatePreference;->isChecked()Z

    move-result p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object p0

    const-string/jumbo v0, "persist.sys.miui_var_font"

    invoke-static {v0, p0}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onSystemVarFontDialogDismissed()V
    .registers 2

    iget-object p0, p0, Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;->mPreference:Landroidx/preference/Preference;

    check-cast p0, Landroidx/preference/SwitchPreference;

    invoke-virtual {p0}, Landroidx/preference/TwoStatePreference;->isChecked()Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    invoke-virtual {p0, v0}, Landroidx/preference/TwoStatePreference;->setChecked(Z)V

    return-void
.end method

.method public updateState(Landroidx/preference/Preference;)V
    .registers 3

    const-string/jumbo p1, "persist.sys.miui_var_font"

    const/4 v0, 0x1

    invoke-static {p1, v0}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    iget-object p0, p0, Lcom/android/settingslib/development/DeveloperOptionsPreferenceController;->mPreference:Landroidx/preference/Preference;

    check-cast p0, Landroidx/preference/SwitchPreference;

    invoke-virtual {p0, p1}, Landroidx/preference/TwoStatePreference;->setChecked(Z)V

    return-void
.end method
