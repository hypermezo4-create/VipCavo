# classes11.dex

.class Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$1;
.super Ljava/lang/Object;

# interfaces
.implements Lmiuix/preference/IPreferenceDialogFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;


# direct methods
.method constructor <init>(Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;)V
    .registers 2

    iput-object p1, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$1;->this$0:Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;

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

    iget-object v0, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$1;->this$0:Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;

    invoke-static {v0, p1}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->access$000(Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;Landroid/view/View;)V

    return-void
.end method

.method public onCreateDialogView(Landroid/content/Context;)Landroid/view/View;
    .registers 3

    iget-object v0, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$1;->this$0:Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;

    invoke-static {v0, p1}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->access$100(Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public onPrepareDialogBuilder(Lmiuix/appcompat/app/AlertDialog$Builder;)V
    .registers 3

    iget-object v0, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$1;->this$0:Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;

    invoke-virtual {v0, p1}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->onPrepareDialogBuilder(Lmiuix/appcompat/app/AlertDialog$Builder;)V

    return-void
.end method
