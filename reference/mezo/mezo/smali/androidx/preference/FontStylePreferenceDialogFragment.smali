# classes10.dex

.class public Landroidx/preference/FontStylePreferenceDialogFragment;
.super Landroidx/preference/PreferenceDialogFragmentCompat;
.source "FontStylePreferenceDialogFragment.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;,
        Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;
    }
.end annotation


# static fields
.field static TAG:Ljava/lang/String;


# instance fields
.field private mLoadFile:Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;

.field private mValue:Ljava/lang/String;

.field private recyclerView:Landroidx/recyclerview/widget/RecyclerView;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    const-string v0, "MiuiPreferenceHelper"

    sput-object v0, Landroidx/preference/FontStylePreferenceDialogFragment;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroidx/preference/PreferenceDialogFragmentCompat;-><init>()V

    return-void
.end method

.method static synthetic access$200(Landroidx/preference/FontStylePreferenceDialogFragment;)Landroidx/recyclerview/widget/RecyclerView;
    .registers 2

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    return-object v0
.end method

.method private createList()V
    .registers 5

    new-instance v0, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;-><init>(Landroidx/preference/FontStylePreferenceDialogFragment;Landroidx/preference/FontStylePreferenceDialogFragment$1;)V

    iput-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mLoadFile:Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v3

    invoke-virtual {v3}, Landroidx/preference/MiuiFontStylePreference;->getPath()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void
.end method

.method public static newInstance(Ljava/lang/String;)Landroidx/preference/FontStylePreferenceDialogFragment;
    .registers 4
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    new-instance v0, Landroidx/preference/FontStylePreferenceDialogFragment;

    invoke-direct {v0}, Landroidx/preference/FontStylePreferenceDialogFragment;-><init>()V

    new-instance v1, Landroid/os/Bundle;

    const/4 v2, 0x1

    invoke-direct {v1, v2}, Landroid/os/Bundle;-><init>(I)V

    const-string v2, "key"

    invoke-virtual {v1, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroidx/preference/FontStylePreferenceDialogFragment;->setArguments(Landroid/os/Bundle;)V

    return-object v0
.end method

.method private setCustomTitle()V
    .registers 1

    return-void
.end method


# virtual methods
.method protected getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;
    .registers 2

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getPreference()Landroidx/preference/DialogPreference;

    move-result-object v0

    check-cast v0, Landroidx/preference/MiuiFontStylePreference;

    return-object v0
.end method

.method public getTypeFase(Ljava/lang/String;)Landroid/graphics/Typeface;
    .registers 3

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroidx/preference/MiuiFontStylePreference;->getTypeFase(Ljava/lang/String;)Landroid/graphics/Typeface;

    move-result-object v0

    return-object v0
.end method

.method public needInputMethod()Z
    .registers 2

    const/4 v0, 0x1

    return v0
.end method

.method protected notifyChange()V
    .registers 2

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object v0

    if-eqz v0, :cond_11

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView$Adapter;->notifyDataSetChanged()V

    :cond_11
    return-void
.end method

.method protected onBindDialogView(Landroid/view/View;)V
    .registers 6
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "UseCompatLoadingForDrawables"
        }
    .end annotation

    invoke-super {p0, p1}, Landroidx/preference/PreferenceDialogFragmentCompat;->onBindDialogView(Landroid/view/View;)V

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "recycler_view"

    invoke-static {v1, v2}, Landroid/Utils/Utils;->IDtoID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;

    iput-object v1, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v1, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v2, Landroidx/recyclerview/widget/LinearLayoutManager;

    iget-object v3, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v3}, Landroidx/recyclerview/widget/RecyclerView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$LayoutManager;)V

    new-instance v0, Landroidx/recyclerview/widget/DividerItemDecoration;

    iget-object v1, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1}, Landroidx/recyclerview/widget/RecyclerView;->getContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Landroidx/recyclerview/widget/DividerItemDecoration;-><init>(Landroid/content/Context;I)V

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x1080013

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/DividerItemDecoration;->setDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v1, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v0}, Landroidx/recyclerview/widget/RecyclerView;->addItemDecoration(Landroidx/recyclerview/widget/RecyclerView$ItemDecoration;)V

    invoke-direct {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->createList()V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .registers 3

    invoke-super {p0, p1}, Landroidx/preference/PreferenceDialogFragmentCompat;->onCreate(Landroid/os/Bundle;)V

    if-nez p1, :cond_10

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/preference/MiuiFontStylePreference;->getValue()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mValue:Ljava/lang/String;

    :goto_f
    return-void

    :cond_10
    const-string v0, "FontStylePreferenceDialogFragment.text"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mValue:Ljava/lang/String;

    goto :goto_f
.end method

.method public onDialogClosed(Z)V
    .registers 4
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mValue:Ljava/lang/String;

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/preference/MiuiFontStylePreference;->callChangeListener(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_13

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/preference/MiuiFontStylePreference;->onItemClick(Ljava/lang/String;)V

    :cond_13
    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/preference/MiuiFontStylePreference;->setSummary()V

    return-void
.end method

.method public onDismiss(Landroid/content/DialogInterface;)V
    .registers 6
    .param p1  # Landroid/content/DialogInterface;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    invoke-super {p0, p1}, Landroidx/preference/PreferenceDialogFragmentCompat;->onDismiss(Landroid/content/DialogInterface;)V

    iget-object v2, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mLoadFile:Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;

    if-eqz v2, :cond_1a

    iget-object v2, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mLoadFile:Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;

    invoke-virtual {v2}, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;->getStatus()Landroid/os/AsyncTask$Status;

    move-result-object v2

    sget-object v3, Landroid/os/AsyncTask$Status;->RUNNING:Landroid/os/AsyncTask$Status;

    if-ne v2, v3, :cond_1a

    iget-object v2, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mLoadFile:Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;->cancel(Z)Z

    const/4 v2, 0x0

    iput-object v2, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mLoadFile:Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;

    :cond_1a
    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v2

    if-eqz v2, :cond_3b

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/fragment/app/FragmentActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v1

    const-class v2, Lmiuix/preference/FontTypefaceStylePreferenceDialogFragment;

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroidx/fragment/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object v0

    if-eqz v0, :cond_3b

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroidx/fragment/app/FragmentTransaction;->remove(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    :cond_3b
    return-void
.end method

.method public onItemClick(Ljava/lang/String;)V
    .registers 4

    const-string v0, "Default"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_21

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/preference/MiuiFontStylePreference;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_21
    iput-object p1, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mValue:Ljava/lang/String;

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v0

    if-eqz v0, :cond_30

    invoke-virtual {p0}, Landroidx/preference/FontStylePreferenceDialogFragment;->getDialog()Landroid/app/Dialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    :cond_30
    return-void
.end method

.method protected onPrepareDialogBuilder(Landroidx/appcompat/app/AlertDialog$Builder;)V
    .registers 3

    const/4 v0, 0x0

    invoke-virtual {p1, v0, v0}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    invoke-super {p0, p1}, Landroidx/preference/PreferenceDialogFragmentCompat;->onPrepareDialogBuilder(Landroidx/appcompat/app/AlertDialog$Builder;)V

    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .registers 4
    .param p1  # Landroid/os/Bundle;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    invoke-super {p0, p1}, Landroidx/preference/PreferenceDialogFragmentCompat;->onSaveInstanceState(Landroid/os/Bundle;)V

    const-string v0, "FontStylePreferenceDialogFragment.text"

    iget-object v1, p0, Landroidx/preference/FontStylePreferenceDialogFragment;->mValue:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putCharSequence(Ljava/lang/String;Ljava/lang/CharSequence;)V

    return-void
.end method
