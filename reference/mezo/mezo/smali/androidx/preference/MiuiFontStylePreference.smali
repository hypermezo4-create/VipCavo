# classes10.dex

.class public Landroidx/preference/MiuiFontStylePreference;
.super Landroidx/preference/DialogPreference;
.source "MiuiFontStylePreference.java"


# instance fields
.field private final Helper:Landroidx/preference/XMiuiPreferenceHelper;

.field private mPath:Ljava/lang/String;

.field private mSummary:Landroid/widget/TextView;

.field private mValue:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 6

    invoke-direct {p0, p1, p2}, Landroidx/preference/DialogPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const-string v1, ""

    iput-object v1, p0, Landroidx/preference/MiuiFontStylePreference;->mValue:Ljava/lang/String;

    const-string v1, "/product/media/fonts/"

    iput-object v1, p0, Landroidx/preference/MiuiFontStylePreference;->mPath:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Landroidx/preference/MiuiFontStylePreference;->setPersistent(Z)V

    new-instance v1, Landroidx/preference/XMiuiPreferenceHelper;

    invoke-direct {v1, p1, p2}, Landroidx/preference/XMiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v1, p0, Landroidx/preference/MiuiFontStylePreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/MiuiFontStylePreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v2, "path"

    invoke-virtual {v1, v2}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_22

    iput-object v0, p0, Landroidx/preference/MiuiFontStylePreference;->mPath:Ljava/lang/String;

    :cond_22
    iget-object v1, p0, Landroidx/preference/MiuiFontStylePreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey()Z

    move-result v1

    if-eqz v1, :cond_3f

    iget-object v1, p0, Landroidx/preference/MiuiFontStylePreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1}, Landroidx/preference/XMiuiPreferenceHelper;->getStr()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Landroidx/preference/MiuiFontStylePreference;->mValue:Ljava/lang/String;

    :goto_32
    const-string v1, "miuix_dialog_preference_layout"

    invoke-static {p1, v1}, Landroid/Utils/Utils;->LayoutToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0, v1}, Landroidx/preference/MiuiFontStylePreference;->setDialogLayoutResource(I)V

    invoke-virtual {p0}, Landroidx/preference/MiuiFontStylePreference;->setSummary()V

    return-void

    :cond_3f
    const-string v1, "Default"

    invoke-virtual {p0, v1}, Landroidx/preference/MiuiFontStylePreference;->onItemClick(Ljava/lang/String;)V

    goto :goto_32
.end method


# virtual methods
.method public getPath()Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiFontStylePreference;->mPath:Ljava/lang/String;

    return-object v0
.end method

.method public getPreferenceIntent()Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiFontStylePreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget-object v0, v0, Landroidx/preference/XMiuiPreferenceHelper;->mIntent:Ljava/lang/String;

    return-object v0
.end method

.method getTypeFase(Ljava/lang/String;)Landroid/graphics/Typeface;
    .registers 6

    :try_start_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Landroidx/preference/MiuiFontStylePreference;->mPath:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/graphics/Typeface;->createFromFile(Ljava/lang/String;)Landroid/graphics/Typeface;
    :try_end_16
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_16} :catch_18

    move-result-object v2

    :goto_17
    return-object v2

    :catch_18
    move-exception v0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-static {v2}, Landroidx/preference/MiuiPreferenceHelper;->getTAG(Ljava/lang/Class;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "getTypeFase : fonts not found"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, 0x0

    goto :goto_17
.end method

.method public getValue()Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiFontStylePreference;->mValue:Ljava/lang/String;

    return-object v0
.end method

.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 6

    invoke-super {p0, p1}, Landroidx/preference/DialogPreference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    const v0, 0x1020010

    invoke-virtual {p1, v0}, Landroidx/preference/PreferenceViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Landroidx/preference/MiuiFontStylePreference;->mSummary:Landroid/widget/TextView;

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Landroidx/preference/MiuiFontStylePreference$1;

    invoke-direct {v1, p0}, Landroidx/preference/MiuiFontStylePreference$1;-><init>(Landroidx/preference/MiuiFontStylePreference;)V

    const-wide/16 v2, 0x64

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method onItemClick(Ljava/lang/String;)V
    .registers 3

    iget-object v0, p0, Landroidx/preference/MiuiFontStylePreference;->mValue:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_17

    iput-object p1, p0, Landroidx/preference/MiuiFontStylePreference;->mValue:Ljava/lang/String;

    iget-object v0, p0, Landroidx/preference/MiuiFontStylePreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0, p1}, Landroidx/preference/XMiuiPreferenceHelper;->putStr(Ljava/lang/String;)V

    iget-object v0, p0, Landroidx/preference/MiuiFontStylePreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    invoke-virtual {p0}, Landroidx/preference/MiuiFontStylePreference;->setSummary()V

    :cond_17
    return-void
.end method

.method public sendIntent()V
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiFontStylePreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    return-void
.end method

.method public setSummary()V
    .registers 8

    const/4 v6, 0x1

    iget-object v3, p0, Landroidx/preference/MiuiFontStylePreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v4, "Default"

    invoke-virtual {v3, v4}, Landroidx/preference/XMiuiPreferenceHelper;->getStr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Landroidx/preference/MiuiFontStylePreference;->mSummary:Landroid/widget/TextView;

    if-eqz v3, :cond_1e

    const-string v3, "Default"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_22

    iget-object v3, p0, Landroidx/preference/MiuiFontStylePreference;->mSummary:Landroid/widget/TextView;

    invoke-static {v6}, Landroid/graphics/Typeface;->defaultFromStyle(I)Landroid/graphics/Typeface;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    :cond_1e
    :goto_1e
    invoke-super {p0, v1}, Landroidx/preference/DialogPreference;->setSummary(Ljava/lang/CharSequence;)V

    return-void

    :cond_22
    iget-object v3, p0, Landroidx/preference/MiuiFontStylePreference;->mPath:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Landroidx/preference/MiuiFontStylePreference;->getTypeFase(Ljava/lang/String;)Landroid/graphics/Typeface;

    move-result-object v2

    if-eqz v2, :cond_1e

    invoke-virtual {p0}, Landroidx/preference/MiuiFontStylePreference;->getKey()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "_typefase"

    const-string v5, ""

    invoke-virtual {v0, v4, v5}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "_typefasestyle"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v3, p0, Landroidx/preference/MiuiFontStylePreference;->mSummary:Landroid/widget/TextView;

    invoke-static {v0, v6}, Landroid/preference/SettingsMezoHelper;->getIntofSettings(Ljava/lang/String;I)I

    move-result v4

    invoke-virtual {v3, v2, v4}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    goto :goto_1e
.end method
