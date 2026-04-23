# classes11.dex

.class public Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;
.super Lcom/android/settings/SettingsPreferenceFragment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "MiuiMiniPreferenceScreenFragment"
.end annotation


# instance fields
.field private iDs:I

.field private rootView:Landroid/widget/FrameLayout;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/SettingsPreferenceFragment;-><init>()V

    return-void
.end method


# virtual methods
.method public init(ILandroid/widget/FrameLayout;)V
    .registers 3

    iput-object p2, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;->rootView:Landroid/widget/FrameLayout;

    iput p1, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;->iDs:I

    return-void
.end method

.method public onCreatePreferences(Landroid/os/Bundle;Ljava/lang/String;)V
    .registers 4

    iget v0, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;->iDs:I

    if-lez v0, :cond_9

    iget v0, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;->iDs:I

    invoke-virtual {p0, v0}, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;->addPreferencesFromResource(I)V

    :cond_9
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .registers 7
    .param p1  # Landroid/view/LayoutInflater;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    invoke-super {p0, p1, p2, p3}, Lcom/android/settings/SettingsPreferenceFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_15

    const v2, 0x102003f

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lmiuix/springback/view/SpringBackLayout;

    if-eqz v0, :cond_15

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lmiuix/springback/view/SpringBackLayout;->setSpringBackEnable(Z)V

    :cond_15
    iget-object v2, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;->rootView:Landroid/widget/FrameLayout;

    invoke-virtual {v2, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object v2, p0, Lmiuix/preference/MiniPreferenceScreenDialogFragmentCompat$MiuiMiniPreferenceScreenFragment;->rootView:Landroid/widget/FrameLayout;

    return-object v2
.end method
