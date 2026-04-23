# classes10.dex

.class Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;
.super Landroid/widget/BaseAdapter;
.source "FontStylePreferenceDialogFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preference/FontStylePreferenceDialogFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "FileListAdapter"
.end annotation


# instance fields
.field private final mContext:Landroid/content/Context;

.field private final mFragment:Landroidx/preference/FontStylePreferenceDialogFragment;

.field private final mList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Landroidx/preference/FontStylePreferenceDialogFragment;Ljava/util/List;)V
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/preference/FontStylePreferenceDialogFragment;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    iput-object p2, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mList:Ljava/util/List;

    invoke-virtual {p1}, Landroidx/preference/FontStylePreferenceDialogFragment;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mContext:Landroid/content/Context;

    iput-object p1, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mFragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    return-void
.end method

.method synthetic constructor <init>(Landroidx/preference/FontStylePreferenceDialogFragment;Ljava/util/List;Landroidx/preference/FontStylePreferenceDialogFragment$1;)V
    .registers 4

    invoke-direct {p0, p1, p2}, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;-><init>(Landroidx/preference/FontStylePreferenceDialogFragment;Ljava/util/List;)V

    return-void
.end method


# virtual methods
.method public getCount()I
    .registers 3

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mList:Ljava/util/List;

    if-eqz v0, :cond_9

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    :goto_8
    return v1

    :cond_9
    const/4 v1, 0x0

    goto :goto_8
.end method

.method public getItem(I)Ljava/lang/Object;
    .registers 4

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mList:Ljava/util/List;

    if-eqz v0, :cond_b

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    :goto_a
    return-object v1

    :cond_b
    const/4 v1, 0x0

    goto :goto_a
.end method

.method public getItemId(I)J
    .registers 4

    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .registers 13

    const/4 v8, 0x1

    if-nez p2, :cond_18

    iget-object v4, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mContext:Landroid/content/Context;

    invoke-static {v4}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v4

    iget-object v5, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mContext:Landroid/content/Context;

    const-string v6, "simple_list_item_2"

    const-string v7, "android"

    invoke-static {v5, v6, v7}, Landroid/Utils/Utils;->LayoutToID(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    const/4 v6, 0x0

    invoke-virtual {v4, v5, p3, v6}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    :cond_18
    invoke-virtual {p0, p1}, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    if-eqz v2, :cond_5a

    iget-object v4, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mContext:Landroid/content/Context;

    const-string v5, "text1"

    const-string v6, "android"

    invoke-static {v4, v5, v6}, Landroid/Utils/Utils;->IDtoID(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {p2, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/TextView;

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v4, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mContext:Landroid/content/Context;

    const-string v5, "text2"

    const-string v6, "android"

    invoke-static {v4, v5, v6}, Landroid/Utils/Utils;->IDtoID(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {p2, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const-string v4, "Default"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5b

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {v8}, Landroid/graphics/Typeface;->defaultFromStyle(I)Landroid/graphics/Typeface;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    :cond_55
    :goto_55
    const/high16 v4, 0x41600000  # 14.0f

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setTextSize(F)V

    :cond_5a
    return-object p2

    :cond_5b
    const-string v4, "Font sample! Font Sample 123"

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v4, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mFragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    invoke-virtual {v4, v2}, Landroidx/preference/FontStylePreferenceDialogFragment;->getTypeFase(Ljava/lang/String;)Landroid/graphics/Typeface;

    move-result-object v3

    if-eqz v3, :cond_55

    iget-object v4, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileListAdapter;->mFragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    invoke-virtual {v4}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v4

    invoke-virtual {v4}, Landroidx/preference/MiuiFontStylePreference;->getKey()Ljava/lang/String;

    move-result-object v0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "_typefase"

    const-string v6, ""

    invoke-virtual {v0, v5, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "_typefasestyle"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v8}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;I)I

    move-result v4

    invoke-virtual {v1, v3, v4}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    goto :goto_55
.end method
