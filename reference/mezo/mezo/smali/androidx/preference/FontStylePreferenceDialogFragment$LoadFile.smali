# classes10.dex

.class Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;
.super Landroid/os/AsyncTask;
.source "FontStylePreferenceDialogFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preference/FontStylePreferenceDialogFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "LoadFile"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask",
        "<",
        "Ljava/lang/String;",
        "Landroidx/preference/FontStylePreferenceDialogFragment;",
        "Ljava/util/List",
        "<",
        "Ljava/lang/String;",
        ">;>;"
    }
.end annotation


# instance fields
.field private final mFragment:Landroidx/preference/FontStylePreferenceDialogFragment;
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "StaticFieldLeak"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Landroidx/preference/FontStylePreferenceDialogFragment;)V
    .registers 2

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    iput-object p1, p0, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;->mFragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    return-void
.end method

.method synthetic constructor <init>(Landroidx/preference/FontStylePreferenceDialogFragment;Landroidx/preference/FontStylePreferenceDialogFragment$1;)V
    .registers 3

    invoke-direct {p0, p1}, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;-><init>(Landroidx/preference/FontStylePreferenceDialogFragment;)V

    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;->doInBackground([Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method protected varargs doInBackground([Ljava/lang/String;)Ljava/util/List;
    .registers 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v1, 0x0

    new-instance v0, Ljava/io/File;

    const/4 v5, 0x0

    aget-object v5, p1, v5

    invoke-direct {v0, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_2c

    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v4

    if-eqz v4, :cond_2c

    array-length v5, v4

    if-lez v5, :cond_2c

    array-length v2, v4

    :goto_1e
    if-ge v1, v2, :cond_2c

    aget-object v5, v4, v1

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_1e

    :cond_2c
    invoke-static {v3}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    return-object v3
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .registers 2

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;->onPostExecute(Ljava/util/List;)V

    return-void
.end method

.method protected onPostExecute(Ljava/util/List;)V
    .registers 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v3, 0x0

    const-string v4, "Default"

    invoke-interface {p1, v3, v4}, Ljava/util/List;->add(ILjava/lang/Object;)V

    iget-object v3, p0, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;->mFragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    invoke-static {v3}, Landroidx/preference/FontStylePreferenceDialogFragment;->access$200(Landroidx/preference/FontStylePreferenceDialogFragment;)Landroidx/recyclerview/widget/RecyclerView;

    move-result-object v2

    iget-object v3, p0, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;->mFragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    invoke-virtual {v3}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/preference/MiuiFontStylePreference;->getValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Landroidx/preference/MiuiFontStylePreference;->getPath()Ljava/lang/String;

    move-result-object v4

    const-string v5, ""

    invoke-virtual {v3, v4, v5}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {p1, v3}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    new-instance v3, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;

    iget-object v4, p0, Landroidx/preference/FontStylePreferenceDialogFragment$LoadFile;->mFragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    invoke-direct {v3, p1, v4, v0}, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;-><init>(Ljava/util/List;Landroidx/preference/FontStylePreferenceDialogFragment;I)V

    invoke-virtual {v2, v3}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$Adapter;)V

    invoke-virtual {v2, v0}, Landroidx/recyclerview/widget/RecyclerView;->scrollToPosition(I)V

    return-void
.end method
