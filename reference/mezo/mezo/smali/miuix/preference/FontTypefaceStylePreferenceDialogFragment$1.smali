# classes11.dex

.class Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroidx/preference/Preference$OnPreferenceChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->onCreatePreferences(Landroid/os/Bundle;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;


# direct methods
.method constructor <init>(Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;)V
    .registers 2

    iput-object p1, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$1;->this$0:Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPreferenceChange(Landroidx/preference/Preference;Ljava/lang/Object;)Z
    .registers 5

    iget-object v0, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$1;->this$0:Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;

    invoke-static {v0}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->access$000(Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "0"

    invoke-static {v0, v1}, Landroid/preference/SettingsMezoHelper;->getStringofSettings(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1e

    iget-object v0, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$1;->this$0:Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;

    invoke-static {v0}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->access$000(Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;)Ljava/lang/String;

    move-result-object v1

    move-object v0, p2

    check-cast v0, Ljava/lang/String;

    invoke-static {v1, v0}, Landroid/preference/SettingsMezoHelper;->putStringinSettings(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1e
    iget-object v0, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$1;->this$0:Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;

    invoke-static {v0}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->access$100(Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;)Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$StyleChangeListener;

    move-result-object v0

    if-eqz v0, :cond_31

    iget-object v0, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$1;->this$0:Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;

    invoke-static {v0}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->access$100(Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;)Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$StyleChangeListener;

    move-result-object v0

    check-cast p2, Ljava/lang/String;

    invoke-interface {v0, p2}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$StyleChangeListener;->onStyleChange(Ljava/lang/String;)V

    :cond_31
    const/4 v0, 0x1

    return v0
.end method
