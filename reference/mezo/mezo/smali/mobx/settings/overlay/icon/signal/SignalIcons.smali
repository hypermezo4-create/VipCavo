# classes10.dex

.class public Lmobx/settings/overlay/icon/signal/SignalIcons;
.super Lcom/android/settings/SettingsPreferenceFragment;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;,
        Lmobx/settings/overlay/icon/signal/SignalIcons$Function;,
        Lmobx/settings/overlay/icon/signal/SignalIcons$Predicate;
    }
.end annotation


# instance fields
.field private xList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private xRecyclerView:Landroidx/recyclerview/widget/RecyclerView;

.field private xTarget:Ljava/lang/String;

.field private xUtils:Lmobx/settings/overlay/icon/ThemeUtils;


# direct methods
.method public constructor <init>()V
    .registers 2

    invoke-direct {p0}, Lcom/android/settings/SettingsPreferenceFragment;-><init>()V

    const-string v0, "android.theme.customization.signal_icon"

    iput-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xTarget:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$L1000000(Lmobx/settings/overlay/icon/signal/SignalIcons;)Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xTarget:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$L1000001(Lmobx/settings/overlay/icon/signal/SignalIcons;)Ljava/util/List;
    .registers 2

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xList:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$L1000002(Lmobx/settings/overlay/icon/signal/SignalIcons;)Landroidx/recyclerview/widget/RecyclerView;
    .registers 2

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xRecyclerView:Landroidx/recyclerview/widget/RecyclerView;

    return-object v0
.end method

.method static synthetic access$L1000003(Lmobx/settings/overlay/icon/signal/SignalIcons;)Lmobx/settings/overlay/icon/ThemeUtils;
    .registers 2

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xUtils:Lmobx/settings/overlay/icon/ThemeUtils;

    return-object v0
.end method

.method static synthetic access$S1000000(Lmobx/settings/overlay/icon/signal/SignalIcons;Ljava/lang/String;)V
    .registers 2

    iput-object p1, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xTarget:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$S1000001(Lmobx/settings/overlay/icon/signal/SignalIcons;Ljava/util/List;)V
    .registers 2

    iput-object p1, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xList:Ljava/util/List;

    return-void
.end method

.method static synthetic access$S1000002(Lmobx/settings/overlay/icon/signal/SignalIcons;Landroidx/recyclerview/widget/RecyclerView;)V
    .registers 2

    iput-object p1, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xRecyclerView:Landroidx/recyclerview/widget/RecyclerView;

    return-void
.end method

.method static synthetic access$S1000003(Lmobx/settings/overlay/icon/signal/SignalIcons;Lmobx/settings/overlay/icon/ThemeUtils;)V
    .registers 2

    iput-object p1, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xUtils:Lmobx/settings/overlay/icon/ThemeUtils;

    return-void
.end method


# virtual methods
.method public enableOverlays(I)V
    .registers 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    iget-object v1, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xUtils:Lmobx/settings/overlay/icon/ThemeUtils;

    iget-object v2, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xTarget:Ljava/lang/String;

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xList:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v3, "com.android.systemui"

    invoke-virtual {v1, v2, v0, v3}, Lmobx/settings/overlay/icon/ThemeUtils;->setOverlayEnabled(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public getDrawable(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .registers 6

    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android"

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1b

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    :goto_10
    const-string v1, "drawable"

    invoke-virtual {v0, p3, v1, p2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    :goto_1a
    return-object v0

    :cond_1b
    invoke-virtual {v0, p2}, Landroid/content/pm/PackageManager;->getResourcesForApplication(Ljava/lang/String;)Landroid/content/res/Resources;
    :try_end_1e
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_1e} :catch_20

    move-result-object v0

    goto :goto_10

    :catch_20
    move-exception v0

    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    const/4 v0, 0x0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    goto :goto_1a
.end method

.method public getLabel(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .registers 5

    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const/4 v1, 0x0

    :try_start_5
    invoke-virtual {v0, p2, v1}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/pm/ApplicationInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;
    :try_end_10
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_5 .. :try_end_10} :catch_12

    move-result-object p2

    :goto_11
    return-object p2

    :catch_12
    move-exception v0

    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_11
.end method

.method public getMetricsCategory()I
    .registers 2

    const/16 v0, 0xfa0

    return v0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/os/Bundle;",
            ")V"
        }
    .end annotation

    invoke-super {p0, p1}, Lcom/android/settings/SettingsPreferenceFragment;->onCreate(Landroid/os/Bundle;)V

    new-instance v0, Lmobx/settings/overlay/icon/ThemeUtils;

    invoke-virtual {p0}, Lmobx/settings/overlay/icon/signal/SignalIcons;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lmobx/settings/overlay/icon/ThemeUtils;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xUtils:Lmobx/settings/overlay/icon/ThemeUtils;

    iget-object v1, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xTarget:Ljava/lang/String;

    const-string v2, "com.android.systemui"

    invoke-virtual {v0, v1, v2}, Lmobx/settings/overlay/icon/ThemeUtils;->getOverlayPackagesForCategory(Ljava/lang/String;Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xList:Ljava/util/List;

    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .registers 9

    invoke-virtual {p0}, Lmobx/settings/overlay/icon/signal/SignalIcons;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lmobx/settings/overlay/icon/signal/SignalIcons;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string/jumbo v2, "item_view"

    const-string v3, "layout"

    invoke-virtual {v1, v2, v3, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {p1, v2, p2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v2

    const-string/jumbo v3, "recycler_view"

    const-string v4, "id"

    invoke-virtual {v1, v3, v4, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/recyclerview/widget/RecyclerView;

    iput-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xRecyclerView:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xRecyclerView:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v1, Landroidx/recyclerview/widget/GridLayoutManager;

    invoke-virtual {p0}, Lmobx/settings/overlay/icon/signal/SignalIcons;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v3

    const/4 v4, 0x2

    invoke-direct {v1, v3, v4}, Landroidx/recyclerview/widget/GridLayoutManager;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$LayoutManager;)V

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons;->xRecyclerView:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v1, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;

    invoke-virtual {p0}, Lmobx/settings/overlay/icon/signal/SignalIcons;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v3

    invoke-direct {v1, p0, v3}, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;-><init>(Lmobx/settings/overlay/icon/signal/SignalIcons;Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$Adapter;)V

    return-object v2
.end method

.method public onResume()V
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onResume()V

    return-void
.end method
