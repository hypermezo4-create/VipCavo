# classes10.dex

.class public Landroidx/preference/MiniPreferenceScreenDialogFragment;
.super Landroidx/preference/PreferenceDialogFragmentCompat;
.source "MiniPreferenceScreenDialogFragment.java"


# static fields
.field public static TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    sget-object v0, Landroidx/preference/MiuiPreferenceHelper;->TAG:Ljava/lang/String;

    sput-object v0, Landroidx/preference/MiniPreferenceScreenDialogFragment;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroidx/preference/PreferenceDialogFragmentCompat;-><init>()V

    return-void
.end method

.method public static newInstance(Ljava/lang/String;)Landroidx/preference/MiniPreferenceScreenDialogFragment;
    .registers 4
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    new-instance v0, Landroidx/preference/MiniPreferenceScreenDialogFragment;

    invoke-direct {v0}, Landroidx/preference/MiniPreferenceScreenDialogFragment;-><init>()V

    new-instance v1, Landroid/os/Bundle;

    const/4 v2, 0x1

    invoke-direct {v1, v2}, Landroid/os/Bundle;-><init>(I)V

    const-string v2, "key"

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroidx/preference/MiniPreferenceScreenDialogFragment;->setArguments(Landroid/os/Bundle;)V

    return-object v0
.end method


# virtual methods
.method protected getMiuiMiniPreferenceScreen()Landroidx/preference/MiuiMiniPreferenceScreen;
    .registers 2

    invoke-virtual {p0}, Landroidx/preference/MiniPreferenceScreenDialogFragment;->getPreference()Landroidx/preference/DialogPreference;

    move-result-object v0

    check-cast v0, Landroidx/preference/MiuiMiniPreferenceScreen;

    return-object v0
.end method

.method public needInputMethod()Z
    .registers 2

    const/4 v0, 0x1

    return v0
.end method

.method public onDialogClosed(Z)V
    .registers 2

    return-void
.end method

.method public onDismiss(Landroid/content/DialogInterface;)V
    .registers 5
    .param p1  # Landroid/content/DialogInterface;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "CommitTransaction"
        }
    .end annotation

    invoke-super {p0, p1}, Landroidx/preference/PreferenceDialogFragmentCompat;->onDismiss(Landroid/content/DialogInterface;)V

    invoke-virtual {p0}, Landroidx/preference/MiniPreferenceScreenDialogFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v2

    if-eqz v2, :cond_24

    invoke-virtual {p0}, Landroidx/preference/MiniPreferenceScreenDialogFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/fragment/app/FragmentActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v1

    const-class v2, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroidx/fragment/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object v0

    if-eqz v0, :cond_24

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroidx/fragment/app/FragmentTransaction;->remove(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    :cond_24
    return-void
.end method

.method protected onPrepareDialogBuilder(Landroidx/appcompat/app/AlertDialog$Builder;)V
    .registers 3

    const/4 v0, 0x0

    invoke-virtual {p1, v0, v0}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    invoke-virtual {p1, v0, v0}, Landroidx/appcompat/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    invoke-super {p0, p1}, Landroidx/preference/PreferenceDialogFragmentCompat;->onPrepareDialogBuilder(Landroidx/appcompat/app/AlertDialog$Builder;)V

    return-void
.end method

.method public onStart()V
    .registers 7

    invoke-super {p0}, Landroidx/preference/PreferenceDialogFragmentCompat;->onStart()V

    invoke-virtual {p0}, Landroidx/preference/MiniPreferenceScreenDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v0

    if-eqz v0, :cond_43

    invoke-virtual {v0}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-static {}, Landroid/Utils/Utils;->isNightMode()Z

    move-result v4

    if-eqz v4, :cond_44

    const-string v4, "#ef000000"

    :goto_1a
    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v1, v4}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/high16 v4, 0x42700000  # 60.0f

    invoke-virtual {v1, v4}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {p0}, Landroidx/preference/MiniPreferenceScreenDialogFragment;->getContext()Landroid/content/Context;

    move-result-object v4

    const-string v5, "parentPanel"

    invoke-static {v4, v5}, Landroid/Utils/Utils;->IDtoID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/view/Window;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/LinearLayout;

    if-eqz v2, :cond_43

    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    new-instance v4, Landroidx/preference/MiniPreferenceScreenDialogFragment$1;

    invoke-direct {v4, p0, v2}, Landroidx/preference/MiniPreferenceScreenDialogFragment$1;-><init>(Landroidx/preference/MiniPreferenceScreenDialogFragment;Landroid/widget/LinearLayout;)V

    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->post(Ljava/lang/Runnable;)Z

    :cond_43
    return-void

    :cond_44
    const-string v4, "#efffffff"

    goto :goto_1a
.end method
