# classes11.dex

.class public Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;
.super Lmiuix/preference/PreferenceFragment;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$StyleChangeListener;
    }
.end annotation


# instance fields
.field private key:Ljava/lang/String;

.field private listener:Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$StyleChangeListener;

.field private rootView:Landroid/widget/FrameLayout;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Lmiuix/preference/PreferenceFragment;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;)Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->key:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;)Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$StyleChangeListener;
    .registers 2

    iget-object v0, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->listener:Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$StyleChangeListener;

    return-object v0
.end method


# virtual methods
.method public init(Ljava/lang/String;Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$StyleChangeListener;Landroid/widget/FrameLayout;)V
    .registers 4

    iput-object p3, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->rootView:Landroid/widget/FrameLayout;

    iput-object p1, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->key:Ljava/lang/String;

    iput-object p2, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->listener:Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$StyleChangeListener;

    return-void
.end method

.method public onCreatePreferences(Landroid/os/Bundle;Ljava/lang/String;)V
    .registers 8

    invoke-virtual {p0}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "font_style_title"

    const-string v3, "xml"

    invoke-virtual {p0}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0, v1}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->addPreferencesFromResource(I)V

    invoke-virtual {p0}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->getPreferenceScreen()Landroidx/preference/PreferenceScreen;

    move-result-object v1

    const-string v2, "typeface_style"

    invoke-virtual {v1, v2}, Landroidx/preference/PreferenceScreen;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v0

    check-cast v0, Lmiuix/preference/DropDownPreference;

    if-eqz v0, :cond_36

    new-instance v1, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$1;

    invoke-direct {v1, p0}, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment$1;-><init>(Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;)V

    invoke-virtual {v0, v1}, Lmiuix/preference/DropDownPreference;->setOnPreferenceChangeListener(Landroidx/preference/Preference$OnPreferenceChangeListener;)V

    iget-object v1, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->key:Ljava/lang/String;

    invoke-static {v1}, Landroid/preference/SettingsMezoHelper;->getStringofSettings(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lmiuix/preference/DropDownPreference;->setValue(Ljava/lang/String;)V

    :cond_36
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .registers 7
    .param p1  # Landroid/view/LayoutInflater;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    invoke-super {p0, p1, p2, p3}, Lmiuix/preference/PreferenceFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_15

    const v2, 0x102003f

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lmiuix/springback/view/SpringBackLayout;

    if-eqz v0, :cond_15

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lmiuix/springback/view/SpringBackLayout;->setSpringBackEnable(Z)V

    :cond_15
    iget-object v2, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->rootView:Landroid/widget/FrameLayout;

    invoke-virtual {v2, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object v2, p0, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;->rootView:Landroid/widget/FrameLayout;

    return-object v2
.end method
