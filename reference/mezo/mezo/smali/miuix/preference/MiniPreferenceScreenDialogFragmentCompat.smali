# classes11.dex

.class public Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;
.super Landroidx/preference/MiniPreferenceScreenDialogFragment;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;
    }
.end annotation


# instance fields
.field private final mDelegate:Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;

.field private final mImpl:Lmiuix/preference/IPreferenceDialogFragment;


# direct methods
.method public constructor <init>()V
    .registers 3

    invoke-direct {p0}, Landroidx/preference/MiniPreferenceScreenDialogFragment;-><init>()V

    new-instance v0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$1;

    invoke-direct {v0, p0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$1;-><init>(Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;)V

    iput-object v0, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->mImpl:Lmiuix/preference/IPreferenceDialogFragment;

    new-instance v0, Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;

    iget-object v1, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->mImpl:Lmiuix/preference/IPreferenceDialogFragment;

    invoke-direct {v0, v1, p0}, Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;-><init>(Lmiuix/preference/IPreferenceDialogFragment;Landroidx/preference/PreferenceDialogFragmentCompat;)V

    iput-object v0, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->mDelegate:Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;

    return-void
.end method

.method static synthetic access$000(Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;Landroid/view/View;)V
    .registers 2

    invoke-virtual {p0, p1}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->onBindDialogView(Landroid/view/View;)V

    return-void
.end method

.method static synthetic access$100(Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;Landroid/content/Context;)Landroid/view/View;
    .registers 3

    invoke-virtual {p0, p1}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->onCreateDialogView(Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public static newInstance(Ljava/lang/String;)Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;
    .registers 4

    new-instance v1, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;

    invoke-direct {v1}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;-><init>()V

    new-instance v0, Landroid/os/Bundle;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Landroid/os/Bundle;-><init>(I)V

    const-string v2, "key"

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->setArguments(Landroid/os/Bundle;)V

    return-object v1
.end method


# virtual methods
.method public onCreateDialog(Landroid/os/Bundle;)Landroid/app/Dialog;
    .registers 3
    .annotation build Landroidx/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->mDelegate:Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;

    invoke-virtual {v0, p1}, Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;->onCreateDialog(Landroid/os/Bundle;)Landroid/app/Dialog;

    move-result-object v0

    return-object v0
.end method

.method protected onPrepareDialogBuilder(Lmiuix/appcompat/app/AlertDialog$Builder;)V
    .registers 7

    goto/32 :goto_7d

    nop

    :goto_4
    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setId(I)V

    goto/32 :goto_4c

    nop

    :goto_b
    invoke-direct {v1, v2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    goto/32 :goto_bd

    nop

    :goto_12
    invoke-virtual {v2}, Landroidx/fragment/app/FragmentActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v2

    goto/32 :goto_1a

    nop

    :goto_1a
    invoke-virtual {v2}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v2

    goto/32 :goto_a7

    nop

    :goto_22
    invoke-direct {v2, v3, p1}, Lmiuix/preference/BuilderDelegate;-><init>(Landroid/content/Context;Lmiuix/appcompat/app/AlertDialog$Builder;)V

    goto/32 :goto_db

    nop

    :goto_29
    invoke-virtual {p1, v2}, Lmiuix/appcompat/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Lmiuix/appcompat/app/AlertDialog$Builder;

    goto/32 :goto_99

    nop

    :goto_30
    invoke-virtual {v0, v2, v1}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;->init(ILandroid/widget/FrameLayout;)V

    goto/32 :goto_ce

    nop

    :goto_37
    invoke-virtual {v2}, Landroidx/fragment/app/FragmentTransaction;->commit()I

    :goto_3a
    goto/32 :goto_a6

    nop

    :goto_3e
    const v2, 0x102003e

    goto/32 :goto_4

    nop

    :goto_45
    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    goto/32 :goto_83

    nop

    :goto_4c
    invoke-virtual {p0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->getMiuiMiniPreferenceScreen()Landroidx/preference/MiuiMiniPreferenceScreen;

    move-result-object v2

    goto/32 :goto_e2

    nop

    :goto_54
    invoke-virtual {p0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object v2

    goto/32 :goto_b

    nop

    :goto_5c
    if-nez v2, :cond_61

    goto/32 :goto_3a

    :cond_61
    goto/32 :goto_6d

    nop

    :goto_65
    invoke-virtual {v2, v0, v3}, Landroidx/fragment/app/FragmentTransaction;->add(Landroidx/fragment/app/Fragment;Ljava/lang/String;)Landroidx/fragment/app/FragmentTransaction;

    move-result-object v2

    goto/32 :goto_37

    nop

    :goto_6d
    invoke-virtual {p0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v2

    goto/32 :goto_12

    nop

    :goto_75
    invoke-virtual {v2}, Landroidx/preference/MiuiMiniPreferenceScreen;->getXmlIds()I

    move-result v2

    goto/32 :goto_30

    nop

    :goto_7d
    new-instance v2, Lmiuix/preference/BuilderDelegate;

    goto/32 :goto_ad

    nop

    :goto_83
    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    goto/32 :goto_3e

    nop

    :goto_8a
    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    goto/32 :goto_65

    nop

    :goto_92
    invoke-direct {v0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;-><init>()V

    goto/32 :goto_b5

    nop

    :goto_99
    invoke-virtual {p1, v1}, Lmiuix/appcompat/app/AlertDialog$Builder;->setView(Landroid/view/View;)Lmiuix/appcompat/app/AlertDialog$Builder;

    goto/32 :goto_c8

    nop

    :goto_a0
    new-instance v1, Landroid/widget/FrameLayout;

    goto/32 :goto_54

    nop

    :goto_a6
    return-void

    :goto_a7
    const-class v3, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;

    goto/32 :goto_8a

    nop

    :goto_ad
    invoke-virtual {p0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v3

    goto/32 :goto_22

    nop

    :goto_b5
    invoke-virtual {p0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->getMiuiMiniPreferenceScreen()Landroidx/preference/MiuiMiniPreferenceScreen;

    move-result-object v2

    goto/32 :goto_75

    nop

    :goto_bd
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    goto/32 :goto_c3

    nop

    :goto_c3
    const/4 v3, -0x1

    goto/32 :goto_d6

    nop

    :goto_c8
    new-instance v0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;

    goto/32 :goto_92

    nop

    :goto_ce
    invoke-virtual {p0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v2

    goto/32 :goto_5c

    nop

    :goto_d6
    const/4 v4, -0x2

    goto/32 :goto_45

    nop

    :goto_db
    invoke-super {p0, v2}, Landroidx/preference/MiniPreferenceScreenDialogFragment;->onPrepareDialogBuilder(Landroidx/appcompat/app/AlertDialog$Builder;)V

    goto/32 :goto_a0

    nop

    :goto_e2
    invoke-virtual {v2}, Landroidx/preference/MiuiMiniPreferenceScreen;->getTitle()Ljava/lang/CharSequence;

    move-result-object v2

    goto/32 :goto_29

    nop
.end method
