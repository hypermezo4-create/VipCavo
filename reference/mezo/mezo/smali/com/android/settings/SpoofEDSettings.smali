# classes2.dex

.class public Lcom/android/settings/SpoofEDSettings;
.super Lcom/android/settings/MiuiSettingsPreferenceFragment;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/MiuiSettingsPreferenceFragment;-><init>()V

    return-void
.end method


# virtual methods
.method public getMetricsCategory()I
    .registers 2

    const/16 v0, 0x1fe

    return v0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .registers 7

    invoke-super {p0, p1}, Lcom/android/settings/MiuiSettingsPreferenceFragment;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/android/settings/SpoofEDSettings;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0}, Lcom/android/settings/SpoofEDSettings;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string/jumbo v2, "spoof_ed_settings"

    const-string/jumbo v3, "xml"

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0, v1}, Lcom/android/settings/SpoofEDSettings;->addPreferencesFromResource(I)V

    return-void
.end method
