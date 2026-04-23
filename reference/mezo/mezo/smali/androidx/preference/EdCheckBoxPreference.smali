# classes10.dex

.class public Landroidx/preference/EdCheckBoxPreference;
.super Landroidx/preference/SwitchPreference;
.source "EdCheckBoxPreference.java"

# interfaces
.implements Landroid/view/View$OnLongClickListener;


# instance fields
.field private BUILD_VERSION:Ljava/lang/String;

.field private contentResolver:Landroid/content/ContentResolver;

.field private defaultValue:Z

.field private intentAction:Ljava/lang/String;

.field private isProperty:Z

.field private key:Ljava/lang/String;

.field private preferenceHelper:Landroidx/preference/EdPreferenceHelper;

.field private storeType:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 7

    invoke-direct {p0, p1, p2}, Landroidx/preference/SwitchPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const-string v0, "v4.2"

    iput-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->BUILD_VERSION:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->contentResolver:Landroid/content/ContentResolver;

    new-instance v0, Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->contentResolver:Landroid/content/ContentResolver;

    iget-object v2, p0, Landroidx/preference/EdCheckBoxPreference;->BUILD_VERSION:Ljava/lang/String;

    invoke-direct {v0, p1, p2, v1, v2}, Landroidx/preference/EdPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;Landroid/content/ContentResolver;Ljava/lang/String;)V

    iput-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    invoke-virtual {p0}, Landroidx/preference/EdCheckBoxPreference;->getKey()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->key:Ljava/lang/String;

    if-eqz p2, :cond_3a

    const-string v0, "storeType"

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-interface {p2, v1, v0, v2}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/EdCheckBoxPreference;->storeType:I

    const-string v0, "isProp"

    invoke-interface {p2, v1, v0, v2}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/EdCheckBoxPreference;->isProperty:Z

    const-string v0, "intent"

    invoke-interface {p2, v1, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->intentAction:Ljava/lang/String;

    :cond_3a
    iget-boolean v0, p0, Landroidx/preference/EdCheckBoxPreference;->isProperty:Z

    if-eqz v0, :cond_49

    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->key:Ljava/lang/String;

    iget-boolean v2, p0, Landroidx/preference/EdCheckBoxPreference;->defaultValue:Z

    invoke-virtual {v0, v1, v2}, Landroidx/preference/EdPreferenceHelper;->getPropBoolean(Ljava/lang/String;Z)Z

    move-result v0

    goto :goto_55

    :cond_49
    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->key:Ljava/lang/String;

    iget-boolean v2, p0, Landroidx/preference/EdCheckBoxPreference;->defaultValue:Z

    iget v3, p0, Landroidx/preference/EdCheckBoxPreference;->storeType:I

    invoke-virtual {v0, v1, v2, v3}, Landroidx/preference/EdPreferenceHelper;->getBool(Ljava/lang/String;ZI)Z

    move-result v0

    :goto_55
    invoke-virtual {p0, v0}, Landroidx/preference/EdCheckBoxPreference;->setChecked(Z)V

    return-void
.end method


# virtual methods
.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 3

    invoke-super {p0, p1}, Landroidx/preference/SwitchPreference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    iget-object v0, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    return-void
.end method

.method protected onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Object;
    .registers 6

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_9

    move v0, v2

    :cond_9
    iput-boolean v0, p0, Landroidx/preference/EdCheckBoxPreference;->defaultValue:Z

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method public onLongClick(Landroid/view/View;)Z
    .registers 4

    iget-boolean v0, p0, Landroidx/preference/EdCheckBoxPreference;->defaultValue:Z

    invoke-virtual {p0, v0}, Landroidx/preference/EdCheckBoxPreference;->setChecked(Z)V

    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    const-string v1, "Default Value Restored"

    invoke-virtual {v0, v1}, Landroidx/preference/EdPreferenceHelper;->showToast(Ljava/lang/String;)V

    const/4 v0, 0x1

    return v0
.end method

.method public onLongClickUseDefaultHapticFeedback(Landroid/view/View;)Z
    .registers 3

    invoke-super {p0, p1}, Landroid/view/View$OnLongClickListener;->onLongClickUseDefaultHapticFeedback(Landroid/view/View;)Z

    move-result v0

    return v0
.end method

.method protected onSetInitialValue(Ljava/lang/Object;)V
    .registers 6

    instance-of v0, p1, Ljava/lang/Boolean;

    if-eqz v0, :cond_d

    move-object v0, p1

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/EdCheckBoxPreference;->defaultValue:Z

    :cond_d
    iget-boolean v0, p0, Landroidx/preference/EdCheckBoxPreference;->isProperty:Z

    if-eqz v0, :cond_1f

    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->key:Ljava/lang/String;

    iget-boolean v2, p0, Landroidx/preference/EdCheckBoxPreference;->defaultValue:Z

    invoke-virtual {v0, v1, v2}, Landroidx/preference/EdPreferenceHelper;->getPropBoolean(Ljava/lang/String;Z)Z

    move-result v0

    invoke-virtual {p0, v0}, Landroidx/preference/EdCheckBoxPreference;->setChecked(Z)V

    goto :goto_2e

    :cond_1f
    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->key:Ljava/lang/String;

    iget-boolean v2, p0, Landroidx/preference/EdCheckBoxPreference;->defaultValue:Z

    iget v3, p0, Landroidx/preference/EdCheckBoxPreference;->storeType:I

    invoke-virtual {v0, v1, v2, v3}, Landroidx/preference/EdPreferenceHelper;->getBool(Ljava/lang/String;ZI)Z

    move-result v0

    invoke-virtual {p0, v0}, Landroidx/preference/EdCheckBoxPreference;->setChecked(Z)V

    :goto_2e
    return-void
.end method

.method public setChecked(Z)V
    .registers 6

    invoke-virtual {p0}, Landroidx/preference/EdCheckBoxPreference;->isChecked()Z

    move-result v0

    if-eq p1, v0, :cond_9

    invoke-super {p0, p1}, Landroidx/preference/SwitchPreference;->setChecked(Z)V

    :cond_9
    iget-boolean v0, p0, Landroidx/preference/EdCheckBoxPreference;->isProperty:Z

    if-eqz v0, :cond_22

    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->key:Ljava/lang/String;

    iget-boolean v2, p0, Landroidx/preference/EdCheckBoxPreference;->defaultValue:Z

    invoke-virtual {v0, v1, v2}, Landroidx/preference/EdPreferenceHelper;->getPropBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-ne p1, v0, :cond_1a

    return-void

    :cond_1a
    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->key:Ljava/lang/String;

    invoke-virtual {v0, v1, p1}, Landroidx/preference/EdPreferenceHelper;->putPropBoolean(Ljava/lang/String;Z)V

    goto :goto_3a

    :cond_22
    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->key:Ljava/lang/String;

    iget-boolean v2, p0, Landroidx/preference/EdCheckBoxPreference;->defaultValue:Z

    iget v3, p0, Landroidx/preference/EdCheckBoxPreference;->storeType:I

    invoke-virtual {v0, v1, v2, v3}, Landroidx/preference/EdPreferenceHelper;->getBool(Ljava/lang/String;ZI)Z

    move-result v0

    if-ne p1, v0, :cond_31

    return-void

    :cond_31
    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->key:Ljava/lang/String;

    iget v2, p0, Landroidx/preference/EdCheckBoxPreference;->storeType:I

    invoke-virtual {v0, v1, p1, v2}, Landroidx/preference/EdPreferenceHelper;->putInt(Ljava/lang/String;II)V

    :goto_3a
    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->intentAction:Ljava/lang/String;

    if-eqz v0, :cond_45

    iget-object v0, p0, Landroidx/preference/EdCheckBoxPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdCheckBoxPreference;->intentAction:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroidx/preference/EdPreferenceHelper;->sendIntent(Ljava/lang/String;)V

    :cond_45
    return-void
.end method
