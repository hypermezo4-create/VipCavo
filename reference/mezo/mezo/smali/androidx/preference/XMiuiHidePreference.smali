# classes10.dex

.class public Landroidx/preference/XMiuiHidePreference;
.super Landroidx/preference/PreferenceGroup;
.source "XMiuiHidePreference.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/XMiuiHidePreference$PrefClass;
    }
.end annotation


# instance fields
.field private mEnable:Z

.field private mPrefs:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroidx/preference/XMiuiHidePreference$PrefClass;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 5

    invoke-direct {p0, p1, p2}, Landroidx/preference/PreferenceGroup;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/preference/XMiuiHidePreference;->mEnable:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/XMiuiHidePreference;->mPrefs:Ljava/util/ArrayList;

    invoke-virtual {p0}, Landroidx/preference/XMiuiHidePreference;->getKey()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_21

    sget-object v0, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    invoke-virtual {p0}, Landroidx/preference/XMiuiHidePreference;->getKey()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Landroidx/preference/XMiuiHidePreference;->mEnable:Z

    :cond_21
    return-void
.end method

.method private contais(Ljava/lang/String;)Landroidx/preference/XMiuiHidePreference$PrefClass;
    .registers 5

    iget-object v0, p0, Landroidx/preference/XMiuiHidePreference;->mPrefs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1c

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/preference/XMiuiHidePreference$PrefClass;

    iget-object v2, v1, Landroidx/preference/XMiuiHidePreference$PrefClass;->key:Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1b

    return-object v1

    :cond_1b
    goto :goto_6

    :cond_1c
    const/4 v0, 0x0

    return-object v0
.end method


# virtual methods
.method public findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    .registers 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Landroidx/preference/Preference;",
            ">(",
            "Ljava/lang/CharSequence;",
            ")TT;"
        }
    .end annotation

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Landroidx/preference/XMiuiHidePreference;->contais(Ljava/lang/String;)Landroidx/preference/XMiuiHidePreference$PrefClass;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eqz v0, :cond_83

    const/4 v3, 0x0

    const/4 v4, 0x1

    :try_start_e
    iget-object v5, v0, Landroidx/preference/XMiuiHidePreference$PrefClass;->claz:Ljava/lang/Class;

    new-array v6, v4, [Ljava/lang/Class;

    const-class v7, Landroid/content/Context;

    aput-object v7, v6, v3

    invoke-virtual {v5, v6}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v5

    new-array v6, v4, [Ljava/lang/Object;

    invoke-virtual {p0}, Landroidx/preference/XMiuiHidePreference;->getContext()Landroid/content/Context;

    move-result-object v7

    aput-object v7, v6, v3

    invoke-virtual {v5, v6}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3
    :try_end_26
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_26} :catch_28

    move-object v1, v3

    goto :goto_83

    :catch_28
    move-exception v5

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "findPreference: Error one = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_45
    iget-object v6, v0, Landroidx/preference/XMiuiHidePreference$PrefClass;->claz:Ljava/lang/Class;

    const/4 v7, 0x2

    new-array v8, v7, [Ljava/lang/Class;

    const-class v9, Landroid/content/Context;

    aput-object v9, v8, v3

    const-class v9, Landroid/util/AttributeSet;

    aput-object v9, v8, v4

    invoke-virtual {v6, v8}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v6

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {p0}, Landroidx/preference/XMiuiHidePreference;->getContext()Landroid/content/Context;

    move-result-object v8

    aput-object v8, v7, v3

    aput-object v2, v7, v4

    invoke-virtual {v6, v7}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3
    :try_end_64
    .catch Ljava/lang/Exception; {:try_start_45 .. :try_end_64} :catch_66

    move-object v1, v3

    goto :goto_83

    :catch_66
    move-exception v3

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "findPreference: Error two = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_83
    :goto_83
    if-eqz v1, :cond_88

    move-object v2, v1

    check-cast v2, Landroidx/preference/Preference;

    :cond_88
    return-object v2
.end method

.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 2

    invoke-super {p0, p1}, Landroidx/preference/PreferenceGroup;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    invoke-virtual {p0, p1}, Landroidx/preference/XMiuiHidePreference;->onMyBindViewHolder(Ljava/lang/Object;)V

    return-void
.end method

.method public onMyBindViewHolder(Ljava/lang/Object;)V
    .registers 3

    invoke-virtual {p0}, Landroidx/preference/XMiuiHidePreference;->getParent()Landroidx/preference/PreferenceGroup;

    move-result-object v0

    if-eqz v0, :cond_9

    invoke-virtual {v0, p0}, Landroidx/preference/PreferenceGroup;->removePreference(Landroidx/preference/Preference;)Z

    :cond_9
    return-void
.end method

.method protected onPrepareAddPreference(Landroidx/preference/Preference;)Z
    .registers 5

    iget-boolean v0, p0, Landroidx/preference/XMiuiHidePreference;->mEnable:Z

    if-eqz v0, :cond_f

    invoke-virtual {p0}, Landroidx/preference/XMiuiHidePreference;->getParent()Landroidx/preference/PreferenceGroup;

    move-result-object v0

    if-eqz v0, :cond_d

    invoke-virtual {v0, p1}, Landroidx/preference/PreferenceGroup;->addPreference(Landroidx/preference/Preference;)Z

    :cond_d
    const/4 v1, 0x0

    return v1

    :cond_f
    invoke-virtual {p1}, Landroidx/preference/Preference;->getKey()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    if-eqz v0, :cond_24

    new-instance v0, Landroidx/preference/XMiuiHidePreference$PrefClass;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-direct {v0, p0, v1, v2}, Landroidx/preference/XMiuiHidePreference$PrefClass;-><init>(Landroidx/preference/XMiuiHidePreference;Ljava/lang/String;Ljava/lang/Class;)V

    iget-object v2, p0, Landroidx/preference/XMiuiHidePreference;->mPrefs:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_24
    invoke-super {p0, p1}, Landroidx/preference/PreferenceGroup;->onPrepareAddPreference(Landroidx/preference/Preference;)Z

    move-result v0

    return v0
.end method
