# classes10.dex

.class public Landroidx/preference/EdListPreference;
.super Landroidx/preference/ListPreference;
.source "EdListPreference.java"

# interfaces
.implements Landroid/view/View$OnLongClickListener;


# static fields
.field private static final BUILD_VERSION:Ljava/lang/String; = "v4.2"


# instance fields
.field private contentResolver:Landroid/content/ContentResolver;

.field private defaultValue:Ljava/lang/String;

.field private intentAction:Ljava/lang/String;

.field private isProperty:Z

.field private key:Ljava/lang/String;

.field private mValue:Ljava/lang/String;

.field private preferenceHelper:Landroidx/preference/EdPreferenceHelper;

.field private storeType:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    invoke-direct {p0, p1}, Landroidx/preference/ListPreference;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Landroidx/preference/EdListPreference;->init(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Landroidx/preference/ListPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-direct {p0, p1, p2}, Landroidx/preference/EdListPreference;->init(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method private init(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 7

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/EdListPreference;->contentResolver:Landroid/content/ContentResolver;

    new-instance v0, Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdListPreference;->contentResolver:Landroid/content/ContentResolver;

    const-string v2, "v4.2"

    invoke-direct {v0, p1, p2, v1, v2}, Landroidx/preference/EdPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;Landroid/content/ContentResolver;Ljava/lang/String;)V

    iput-object v0, p0, Landroidx/preference/EdListPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    invoke-virtual {p0}, Landroidx/preference/EdListPreference;->getKey()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/EdListPreference;->key:Ljava/lang/String;

    const/4 v0, 0x0

    if-eqz p2, :cond_33

    const-string v1, "storeType"

    const/4 v2, 0x0

    invoke-interface {p2, v0, v1, v2}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v1

    iput v1, p0, Landroidx/preference/EdListPreference;->storeType:I

    const-string v1, "isProp"

    invoke-interface {p2, v0, v1, v2}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, p0, Landroidx/preference/EdListPreference;->isProperty:Z

    const-string v1, "intent"

    invoke-interface {p2, v0, v1}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Landroidx/preference/EdListPreference;->intentAction:Ljava/lang/String;

    :cond_33
    iget-boolean v1, p0, Landroidx/preference/EdListPreference;->isProperty:Z

    if-eqz v1, :cond_40

    iget-object v1, p0, Landroidx/preference/EdListPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v2, p0, Landroidx/preference/EdListPreference;->key:Ljava/lang/String;

    invoke-virtual {v1, v2, v0}, Landroidx/preference/EdPreferenceHelper;->getPropString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4a

    :cond_40
    iget-object v1, p0, Landroidx/preference/EdListPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v2, p0, Landroidx/preference/EdListPreference;->key:Ljava/lang/String;

    iget v3, p0, Landroidx/preference/EdListPreference;->storeType:I

    invoke-virtual {v1, v2, v0, v3}, Landroidx/preference/EdPreferenceHelper;->getString(Ljava/lang/String;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    :goto_4a
    iput-object v0, p0, Landroidx/preference/EdListPreference;->mValue:Ljava/lang/String;

    iget-object v0, p0, Landroidx/preference/EdListPreference;->mValue:Ljava/lang/String;

    invoke-super {p0, v0}, Landroidx/preference/ListPreference;->setValue(Ljava/lang/String;)V

    iget-object v0, p0, Landroidx/preference/EdListPreference;->mValue:Ljava/lang/String;

    invoke-direct {p0, v0}, Landroidx/preference/EdListPreference;->updateSummaryWithSelectedEntry(Ljava/lang/String;)V

    return-void
.end method

.method private updateSummaryWithSelectedEntry(Ljava/lang/String;)V
    .registers 6

    if-nez p1, :cond_3

    return-void

    :cond_3
    invoke-virtual {p0}, Landroidx/preference/EdListPreference;->getSummary()Ljava/lang/CharSequence;

    move-result-object v0

    if-eqz v0, :cond_3e

    invoke-virtual {p0}, Landroidx/preference/EdListPreference;->getSummary()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "%s"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_3e

    invoke-virtual {p0}, Landroidx/preference/EdListPreference;->getEntries()[Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p0}, Landroidx/preference/EdListPreference;->getEntryValues()[Ljava/lang/CharSequence;

    move-result-object v1

    if-eqz v0, :cond_3e

    if-eqz v1, :cond_3e

    const/4 v2, 0x0

    :goto_26
    array-length v3, v1

    if-ge v2, v3, :cond_3e

    aget-object v3, v1, v2

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3b

    aget-object v3, v0, v2

    invoke-virtual {p0, v3}, Landroidx/preference/EdListPreference;->setSummary(Ljava/lang/CharSequence;)V

    goto :goto_3e

    :cond_3b
    add-int/lit8 v2, v2, 0x1

    goto :goto_26

    :cond_3e
    :goto_3e
    return-void
.end method


# virtual methods
.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 3

    invoke-super {p0, p1}, Landroidx/preference/ListPreference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    iget-object v0, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    return-void
.end method

.method protected onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Object;
    .registers 4

    invoke-virtual {p1, p2}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/EdListPreference;->defaultValue:Ljava/lang/String;

    iget-object v0, p0, Landroidx/preference/EdListPreference;->defaultValue:Ljava/lang/String;

    return-object v0
.end method

.method public onLongClick(Landroid/view/View;)Z
    .registers 4

    iget-object v0, p0, Landroidx/preference/EdListPreference;->defaultValue:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/EdListPreference;->setValue(Ljava/lang/String;)V

    iget-object v0, p0, Landroidx/preference/EdListPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    const-string v1, "Default Value Restored"

    invoke-virtual {v0, v1}, Landroidx/preference/EdPreferenceHelper;->showToast(Ljava/lang/String;)V

    const/4 v0, 0x1

    return v0
.end method

.method protected onSetInitialValue(Ljava/lang/Object;)V
    .registers 3

    instance-of v0, p1, Ljava/lang/String;

    if-eqz v0, :cond_9

    move-object v0, p1

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Landroidx/preference/EdListPreference;->defaultValue:Ljava/lang/String;

    :cond_9
    iget-object v0, p0, Landroidx/preference/EdListPreference;->mValue:Ljava/lang/String;

    if-nez v0, :cond_16

    iget-object v0, p0, Landroidx/preference/EdListPreference;->defaultValue:Ljava/lang/String;

    if-eqz v0, :cond_16

    iget-object v0, p0, Landroidx/preference/EdListPreference;->defaultValue:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/EdListPreference;->setValue(Ljava/lang/String;)V

    :cond_16
    return-void
.end method

.method public setValue(Ljava/lang/String;)V
    .registers 5

    if-eqz p1, :cond_34

    invoke-virtual {p0}, Landroidx/preference/EdListPreference;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_d

    goto :goto_34

    :cond_d
    invoke-super {p0, p1}, Landroidx/preference/ListPreference;->setValue(Ljava/lang/String;)V

    invoke-direct {p0, p1}, Landroidx/preference/EdListPreference;->updateSummaryWithSelectedEntry(Ljava/lang/String;)V

    iget-boolean v0, p0, Landroidx/preference/EdListPreference;->isProperty:Z

    if-eqz v0, :cond_1f

    iget-object v0, p0, Landroidx/preference/EdListPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdListPreference;->key:Ljava/lang/String;

    invoke-virtual {v0, v1, p1}, Landroidx/preference/EdPreferenceHelper;->putPropString(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_28

    :cond_1f
    iget-object v0, p0, Landroidx/preference/EdListPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdListPreference;->key:Ljava/lang/String;

    iget v2, p0, Landroidx/preference/EdListPreference;->storeType:I

    invoke-virtual {v0, v1, p1, v2}, Landroidx/preference/EdPreferenceHelper;->putString(Ljava/lang/String;Ljava/lang/String;I)V

    :goto_28
    iget-object v0, p0, Landroidx/preference/EdListPreference;->intentAction:Ljava/lang/String;

    if-eqz v0, :cond_33

    iget-object v0, p0, Landroidx/preference/EdListPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdListPreference;->intentAction:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroidx/preference/EdPreferenceHelper;->sendIntent(Ljava/lang/String;)V

    :cond_33
    return-void

    :cond_34
    :goto_34
    return-void
.end method
