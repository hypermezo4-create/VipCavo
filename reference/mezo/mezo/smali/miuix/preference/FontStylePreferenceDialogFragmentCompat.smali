# classes11.dex

.class public Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;
.super Landroidx/preference/FontStylePreferenceDialogFragment;


# instance fields
.field private final mDelegate:Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;

.field private final mImpl:Lmiuix/preference/IPreferenceDialogFragment;


# direct methods
.method public constructor <init>()V
    .registers 3

    invoke-direct {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;-><init>()V

    new-instance v0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$1;

    invoke-direct {v0, p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$1;-><init>(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;)V

    iput-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->mImpl:Lmiuix/preference/IPreferenceDialogFragment;

    new-instance v0, Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;

    iget-object v1, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->mImpl:Lmiuix/preference/IPreferenceDialogFragment;

    invoke-direct {v0, v1, p0}, Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;-><init>(Lmiuix/preference/IPreferenceDialogFragment;Landroidx/preference/PreferenceDialogFragmentCompat;)V

    iput-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->mDelegate:Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;

    return-void
.end method

.method static synthetic access$000(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;Landroid/view/View;)V
    .registers 2

    invoke-virtual {p0, p1}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->onBindDialogView(Landroid/view/View;)V

    return-void
.end method

.method static synthetic access$100(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;Landroid/content/Context;)Landroid/view/View;
    .registers 3

    invoke-virtual {p0, p1}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->onCreateDialogView(Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$200(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;I)Ljava/lang/String;
    .registers 3

    invoke-direct {p0, p1}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getSummary(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$300(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;)V
    .registers 1

    invoke-virtual {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->notifyChange()V

    return-void
.end method

.method static synthetic access$400(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;)Landroidx/preference/MiuiFontStylePreference;
    .registers 2

    invoke-virtual {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v0

    return-object v0
.end method

.method private getCustomeTitle()Landroid/view/View;
    .registers 13

    const/16 v11, 0x8

    invoke-virtual {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-static {v8}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v8

    invoke-virtual {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object v9

    const-string v10, "point_seekbar_layout"

    invoke-static {v9, v10}, Landroid/Utils/Utils;->LayoutToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v9

    const/4 v10, 0x0

    invoke-virtual {v8, v9, v10}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroidx/preference/FixedSize/PointSeekBarLayout;

    invoke-virtual {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v6

    invoke-virtual {v6}, Landroidx/preference/MiuiFontStylePreference;->getKey()Ljava/lang/String;

    move-result-object v2

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "_typefase"

    const-string v10, ""

    invoke-virtual {v2, v9, v10}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "_typefasestyle"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;)I

    move-result v0

    const/4 v8, 0x0

    const/4 v9, 0x3

    invoke-virtual {v3, v8, v9}, Landroidx/preference/FixedSize/PointSeekBarLayout;->setValues(II)V

    invoke-virtual {v3, v0}, Landroidx/preference/FixedSize/PointSeekBarLayout;->setValue(I)V

    move-object v1, v2

    invoke-virtual {v3}, Landroidx/preference/FixedSize/PointSeekBarLayout;->getMinView()Landroid/widget/TextView;

    move-result-object v5

    if-eqz v5, :cond_54

    invoke-virtual {v5, v11}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_54
    invoke-virtual {v3}, Landroidx/preference/FixedSize/PointSeekBarLayout;->getMaxView()Landroid/widget/TextView;

    move-result-object v4

    if-eqz v4, :cond_5d

    invoke-virtual {v4, v11}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_5d
    invoke-virtual {v3}, Landroidx/preference/FixedSize/PointSeekBarLayout;->getSummary()Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7, v11}, Landroid/widget/TextView;->setVisibility(I)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Font : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-direct {p0, v0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getSummary(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v3, v8}, Landroidx/preference/FixedSize/PointSeekBarLayout;->setTitle(Ljava/lang/String;)V

    new-instance v8, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;

    invoke-direct {v8, p0, v1, v3}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;-><init>(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;Ljava/lang/String;Landroidx/preference/FixedSize/PointSeekBarLayout;)V

    invoke-virtual {v3, v8}, Landroidx/preference/FixedSize/PointSeekBarLayout;->setListener(Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;)V

    return-object v3
.end method

.method private getSummary(I)Ljava/lang/String;
    .registers 8

    invoke-virtual {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const-string v3, "clock_style_entries"

    const-string v4, "array"

    invoke-virtual {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v3, v4, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v1

    aget-object v2, v1, p1

    return-object v2
.end method

.method public static newInstance(Ljava/lang/String;)Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;
    .registers 4

    new-instance v1, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

    invoke-direct {v1}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;-><init>()V

    new-instance v0, Landroid/os/Bundle;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Landroid/os/Bundle;-><init>(I)V

    const-string v2, "key"

    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->setArguments(Landroid/os/Bundle;)V

    return-object v1
.end method


# virtual methods
.method public onCreateDialog(Landroid/os/Bundle;)Landroid/app/Dialog;
    .registers 3
    .annotation build Landroidx/annotation/NonNull;
    .end annotation

    iget-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->mDelegate:Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;

    invoke-virtual {v0, p1}, Lmiuix/preference/PreferenceDialogFragmentCompatDelegate;->onCreateDialog(Landroid/os/Bundle;)Landroid/app/Dialog;

    move-result-object v0

    return-object v0
.end method

.method public onPrepareDialogBuilder(Lmiuix/appcompat/app/AlertDialog$Builder;)V
    .registers 4

    new-instance v0, Lmiuix/preference/BuilderDelegate;

    invoke-virtual {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Lmiuix/preference/BuilderDelegate;-><init>(Landroid/content/Context;Lmiuix/appcompat/app/AlertDialog$Builder;)V

    invoke-super {p0, v0}, Landroidx/preference/FontStylePreferenceDialogFragment;->onPrepareDialogBuilder(Landroidx/appcompat/app/AlertDialog$Builder;)V

    invoke-direct {p0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getCustomeTitle()Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1, v0}, Lmiuix/appcompat/app/AlertDialog$Builder;->setCustomTitle(Landroid/view/View;)Lmiuix/appcompat/app/AlertDialog$Builder;

    return-void
.end method
