# classes11.dex

.class Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$1;
.super Ljava/lang/Object;

# interfaces
.implements Lmiuix/preference/IPreferenceDialogFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;


# direct methods
.method constructor <init>(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;)V
    .registers 2

    iput-object p1, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$1;->this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public needInputMethod()Z
    .registers 2

    const/4 v0, 0x1

    return v0
.end method

.method public onBindDialogView(Landroid/view/View;)V
    .registers 3

    iget-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$1;->this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

    invoke-static {v0, p1}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->access$000(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;Landroid/view/View;)V

    return-void
.end method

.method public onCreateDialogView(Landroid/content/Context;)Landroid/view/View;
    .registers 3

    iget-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$1;->this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

    invoke-static {v0, p1}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->access$100(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public onPrepareDialogBuilder(Lmiuix/appcompat/app/AlertDialog$Builder;)V
    .registers 3

    iget-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$1;->this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

    invoke-virtual {v0, p1}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->onPrepareDialogBuilder(Lmiuix/appcompat/app/AlertDialog$Builder;)V

    return-void
.end method
