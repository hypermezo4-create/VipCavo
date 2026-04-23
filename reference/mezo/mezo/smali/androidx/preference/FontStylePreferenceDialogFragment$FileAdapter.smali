# classes10.dex

.class Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;
.super Landroidx/recyclerview/widget/RecyclerView$Adapter;
.source "FontStylePreferenceDialogFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preference/FontStylePreferenceDialogFragment;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "FileAdapter"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/RecyclerView$Adapter",
        "<",
        "Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;",
        ">;"
    }
.end annotation


# instance fields
.field private final fragment:Landroidx/preference/FontStylePreferenceDialogFragment;

.field private final itemSelected:I

.field private final list:Ljava/util/List;
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
.method public constructor <init>(Ljava/util/List;Landroidx/preference/FontStylePreferenceDialogFragment;I)V
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Landroidx/preference/FontStylePreferenceDialogFragment;",
            "I)V"
        }
    .end annotation

    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$Adapter;-><init>()V

    iput-object p1, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->list:Ljava/util/List;

    iput-object p2, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->fragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    iput p3, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->itemSelected:I

    return-void
.end method

.method static synthetic access$100(Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;)Landroidx/preference/FontStylePreferenceDialogFragment;
    .registers 2

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->fragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    return-object v0
.end method


# virtual methods
.method public getItemCount()I
    .registers 2

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->list:Ljava/util/List;

    if-eqz v0, :cond_b

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->list:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    :goto_a
    return v0

    :cond_b
    const/4 v0, 0x0

    goto :goto_a
.end method

.method public onBindViewHolder(Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;I)V
    .registers 12
    .param p1  # Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetTextI18n"
        }
    .end annotation

    const/4 v6, 0x1

    iget-object v5, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->list:Ljava/util/List;

    invoke-interface {v5, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    iget-object v5, p1, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v5}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v5, p1, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;->itemView:Landroid/view/View;

    new-instance v7, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$1;

    invoke-direct {v7, p0, v3}, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$1;-><init>(Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;Ljava/lang/String;)V

    invoke-virtual {v5, v7}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v7, p1, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;->itemView:Landroid/view/View;

    iget v5, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->itemSelected:I

    if-ne v5, p2, :cond_5c

    move v5, v6

    :goto_20
    invoke-virtual {v7, v5}, Landroid/view/View;->setSelected(Z)V

    if-eqz v3, :cond_5b

    const-string v5, "text1"

    const-string v7, "android"

    invoke-static {v0, v5, v7}, Landroid/Utils/Utils;->IDtoID(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {p1, v5}, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/TextView;

    invoke-virtual {v5, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const-string v5, "text2"

    const-string v7, "android"

    invoke-static {v0, v5, v7}, Landroid/Utils/Utils;->IDtoID(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {p1, v5}, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    const-string v5, "Default"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5e

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {v6}, Landroid/graphics/Typeface;->defaultFromStyle(I)Landroid/graphics/Typeface;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    :cond_56
    :goto_56
    const/high16 v5, 0x41600000  # 14.0f

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setTextSize(F)V

    :cond_5b
    return-void

    :cond_5c
    const/4 v5, 0x0

    goto :goto_20

    :cond_5e
    const-string v5, "Font sample! Font sample 123"

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v5, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->fragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    invoke-virtual {v5, v3}, Landroidx/preference/FontStylePreferenceDialogFragment;->getTypeFase(Ljava/lang/String;)Landroid/graphics/Typeface;

    move-result-object v4

    if-eqz v4, :cond_56

    iget-object v5, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->fragment:Landroidx/preference/FontStylePreferenceDialogFragment;

    invoke-virtual {v5}, Landroidx/preference/FontStylePreferenceDialogFragment;->getFontStylePreference()Landroidx/preference/MiuiFontStylePreference;

    move-result-object v5

    invoke-virtual {v5}, Landroidx/preference/MiuiFontStylePreference;->getKey()Ljava/lang/String;

    move-result-object v1

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "_typefase"

    const-string v8, ""

    invoke-virtual {v1, v7, v8}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, "_typefasestyle"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v6}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;I)I

    move-result v5

    invoke-virtual {v2, v4, v5}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    goto :goto_56
.end method

.method public bridge synthetic onBindViewHolder(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V
    .registers 3
    .param p1  # Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetTextI18n"
        }
    .end annotation

    check-cast p1, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;

    invoke-virtual {p0, p1, p2}, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->onBindViewHolder(Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;I)V

    return-void
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;
    .registers 8
    .param p1  # Landroid/view/ViewGroup;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroidx/annotation/NonNull;
    .end annotation

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    const-string v3, "simple_list_item_2"

    const-string v4, "android"

    invoke-static {v0, v3, v4}, Landroid/Utils/Utils;->LayoutToID(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    const/4 v4, 0x0

    invoke-virtual {v2, v3, p1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v2

    invoke-direct {v1, v2}, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;-><init>(Landroid/view/View;)V

    return-object v1
.end method

.method public bridge synthetic onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .registers 4
    .param p1  # Landroid/view/ViewGroup;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroidx/annotation/NonNull;
    .end annotation

    invoke-virtual {p0, p1, p2}, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;

    move-result-object v0

    return-object v0
.end method
