# classes10.dex

.class public Lcom/android/settings/statusbarelement/StatusBarElementNotif;
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

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/StatusBarElementNotif;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/StatusBarElementNotif;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "elem_bg_fullscreen_notification"

    const-string v3, "xml"

    invoke-virtual {v0, v2, v3, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/android/settings/statusbarelement/StatusBarElementNotif;->addPreferencesFromResource(I)V

    return-void
.end method
