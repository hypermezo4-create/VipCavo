# classes.dex

.class Lcom/android/settings/AodAndLockScreenSettings$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroidx/preference/Preference$OnPreferenceChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/android/settings/AodAndLockScreenSettings;->setupPowerMenuUnderKeyguard()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/settings/AodAndLockScreenSettings;


# direct methods
.method constructor <init>(Lcom/android/settings/AodAndLockScreenSettings;)V
    .registers 2

    iput-object p1, p0, Lcom/android/settings/AodAndLockScreenSettings$5;->this$0:Lcom/android/settings/AodAndLockScreenSettings;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPreferenceChange(Landroidx/preference/Preference;Ljava/lang/Object;)Z
    .registers 3

    iget-object p0, p0, Lcom/android/settings/AodAndLockScreenSettings$5;->this$0:Lcom/android/settings/AodAndLockScreenSettings;

    invoke-virtual {p0}, Lcom/android/settings/SettingsPreferenceFragment;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string/jumbo p1, "power_menu_under_keyguard"

    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p2

    invoke-static {p0, p1, p2}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const/4 p0, 0x1

    return p0
.end method
