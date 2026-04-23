# classes2.dex

.class public Lcom/android/settings/MyResizeElite;
.super Lcom/android/settings/statusbarelement/StatusBarElementBase;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/StatusBarElementBase;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreatePreferences(Landroid/os/Bundle;Ljava/lang/String;)V
    .registers 7

    invoke-virtual {p0}, Lcom/android/settings/MyResizeElite;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Lcom/android/settings/MyResizeElite;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "settings_resize_elite"

    const-string/jumbo v3, "xml"

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/android/settings/MyResizeElite;->addPreferencesFromResource(I)V

    return-void
.end method
