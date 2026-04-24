# classes2.dex

.class public Lcom/android/settings/DartPiston;
.super Lcom/android/settings/MiuiSettingsPreferenceFragment;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/MiuiSettingsPreferenceFragment;-><init>()V

    return-void
.end method


# virtual methods
.method public getIDinternalXml(Ljava/lang/String;)I
    .registers 5

    invoke-virtual {p0}, Lcom/android/settings/DartPiston;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string/jumbo v1, "xml"

    const-string v2, "com.android.settings"

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getName()Ljava/lang/String;
    .registers 2

    const-class v0, Lcom/android/settings/DartPiston;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .registers 10

    invoke-super {p0, p1}, Lcom/android/settings/MiuiSettingsPreferenceFragment;->onCreate(Landroid/os/Bundle;)V

    const-string v0, "dart_piston"

    invoke-virtual {p0, v0}, Lcom/android/settings/DartPiston;->getIDinternalXml(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/android/settings/DartPiston;->addPreferencesFromResource(I)V

    return-void
.end method
