# classes10.dex

.class public Landroidx/preference/XMiuiDropDownPreference;
.super Lmiuix/preference/DropDownPreference;
.source "XMiuiDropDownPreference.java"


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field private final Helper:Landroidx/preference/XMiuiPreferenceHelper;

.field private mEnableSummary:Z

.field private mEntries:[Ljava/lang/CharSequence;

.field private mLastState:Ljava/lang/String;

.field private mValueSet:Z


# direct methods
.method static constructor <clinit>()V
    .registers 1

    const-class v0, Landroidx/preference/XMiuiDropDownPreference;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_c

    const/4 v0, 0x1

    :goto_9
    sput-boolean v0, Landroidx/preference/XMiuiDropDownPreference;->$assertionsDisabled:Z

    return-void

    :cond_c
    const/4 v0, 0x0

    goto :goto_9
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 4

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2}, Lmiuix/preference/DropDownPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-boolean v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mValueSet:Z

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->setPersistent(Z)V

    new-instance v0, Landroidx/preference/XMiuiPreferenceHelper;

    invoke-direct {v0, p1, p2}, Landroidx/preference/XMiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-direct {p0}, Landroidx/preference/XMiuiDropDownPreference;->initial()V

    return-void
.end method

.method static synthetic access$000(Landroidx/preference/XMiuiDropDownPreference;)V
    .registers 1

    invoke-direct {p0}, Landroidx/preference/XMiuiDropDownPreference;->initial()V

    return-void
.end method

.method private checkIconsForEntries()V
    .registers 14

    const/4 v7, 0x1

    const/4 v8, 0x0

    iget-object v9, p0, Landroidx/preference/XMiuiDropDownPreference;->mEntries:[Ljava/lang/CharSequence;

    if-nez v9, :cond_62

    invoke-virtual {p0}, Landroidx/preference/XMiuiDropDownPreference;->getEntries()[Ljava/lang/CharSequence;

    move-result-object v9

    iput-object v9, p0, Landroidx/preference/XMiuiDropDownPreference;->mEntries:[Ljava/lang/CharSequence;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v1

    sget-boolean v9, Landroidx/preference/XMiuiDropDownPreference;->$assertionsDisabled:Z

    if-nez v9, :cond_20

    if-nez v1, :cond_20

    new-instance v7, Ljava/lang/AssertionError;

    invoke-direct {v7}, Ljava/lang/AssertionError;-><init>()V

    throw v7

    :cond_20
    invoke-virtual {v1}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v4

    const/4 v2, 0x0

    array-length v10, v4

    move v9, v8

    :goto_27
    if-ge v9, v10, :cond_38

    aget-object v3, v4, v9

    invoke-virtual {v3}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v11

    const-class v12, [Landroid/graphics/drawable/Drawable;

    invoke-virtual {v11, v12}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_5a

    move-object v2, v3

    :cond_38
    const/4 v6, 0x0

    if-eqz v2, :cond_62

    invoke-virtual {v2, v7}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    :try_start_3e
    invoke-virtual {v2, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_41
    .catch Ljava/lang/IllegalAccessException; {:try_start_3e .. :try_end_41} :catch_63

    move-result-object v6

    :goto_42
    if-eqz v6, :cond_5d

    :goto_44
    iput-boolean v7, p0, Landroidx/preference/XMiuiDropDownPreference;->mEnableSummary:Z

    if-eqz v7, :cond_62

    iget-object v7, p0, Landroidx/preference/XMiuiDropDownPreference;->mEntries:[Ljava/lang/CharSequence;

    array-length v7, v7

    new-array v0, v7, [Ljava/lang/CharSequence;

    const/4 v5, 0x0

    :goto_4e
    iget-object v7, p0, Landroidx/preference/XMiuiDropDownPreference;->mEntries:[Ljava/lang/CharSequence;

    array-length v7, v7

    if-ge v5, v7, :cond_5f

    const-string v7, ""

    aput-object v7, v0, v5

    add-int/lit8 v5, v5, 0x1

    goto :goto_4e

    :cond_5a
    add-int/lit8 v9, v9, 0x1

    goto :goto_27

    :cond_5d
    move v7, v8

    goto :goto_44

    :cond_5f
    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->setEntries([Ljava/lang/CharSequence;)V

    :cond_62
    return-void

    :catch_63
    move-exception v9

    goto :goto_42
.end method

.method private getDependents(Ljava/lang/String;)Z
    .registers 4

    const/4 v0, 0x0

    :try_start_1
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_4
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_4} :catch_9

    move-result v1

    if-gtz v1, :cond_8

    const/4 v0, 0x1

    :cond_8
    :goto_8
    return v0

    :catch_9
    move-exception v1

    goto :goto_8
.end method

.method private init()V
    .registers 5

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Landroidx/preference/XMiuiDropDownPreference$1;

    invoke-direct {v1, p0}, Landroidx/preference/XMiuiDropDownPreference$1;-><init>(Landroidx/preference/XMiuiDropDownPreference;)V

    const-wide/16 v2, 0x12c

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method private initial()V
    .registers 3

    iget-boolean v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mValueSet:Z

    if-nez v0, :cond_27

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey()Z

    move-result v0

    if-eqz v0, :cond_28

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->getStr()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->findIndexOfValue(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->setValueIndex(I)V

    invoke-direct {p0}, Landroidx/preference/XMiuiDropDownPreference;->checkIconsForEntries()V

    invoke-virtual {p0}, Landroidx/preference/XMiuiDropDownPreference;->getEntry()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->setSummary(Ljava/lang/CharSequence;)V

    :cond_27
    :goto_27
    return-void

    :cond_28
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->onSetInitialValue(Ljava/lang/Object;)V

    goto :goto_27
.end method


# virtual methods
.method public callChangeListener(Ljava/lang/Object;)Z
    .registers 4

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    if-eqz v1, :cond_39

    iget-object v1, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_39

    iget-object v1, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1, v0}, Landroidx/preference/XMiuiPreferenceHelper;->putStr(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    iput-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    iget-object v1, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroidx/preference/XMiuiDropDownPreference;->findIndexOfValue(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0, v1}, Landroidx/preference/XMiuiDropDownPreference;->setValueIndex(I)V

    invoke-virtual {p0}, Landroidx/preference/XMiuiDropDownPreference;->getEntry()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p0, v1}, Landroidx/preference/XMiuiDropDownPreference;->setSummary(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Landroidx/preference/XMiuiDropDownPreference;->getValue()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Landroidx/preference/XMiuiDropDownPreference;->getDependents(Ljava/lang/String;)Z

    move-result v1

    invoke-virtual {p0, v1}, Landroidx/preference/XMiuiDropDownPreference;->notifyDependencyChange(Z)V

    const/4 v1, 0x1

    :goto_38
    return v1

    :cond_39
    invoke-super {p0, p1}, Lmiuix/preference/DropDownPreference;->callChangeListener(Ljava/lang/Object;)Z

    move-result v1

    goto :goto_38
.end method

.method public getEntry()Ljava/lang/CharSequence;
    .registers 3

    invoke-virtual {p0}, Landroidx/preference/XMiuiDropDownPreference;->getValueIndex()I

    move-result v0

    if-ltz v0, :cond_a

    iget-object v1, p0, Landroidx/preference/XMiuiDropDownPreference;->mEntries:[Ljava/lang/CharSequence;

    if-nez v1, :cond_c

    :cond_a
    const/4 v1, 0x0

    :goto_b
    return-object v1

    :cond_c
    iget-object v1, p0, Landroidx/preference/XMiuiDropDownPreference;->mEntries:[Ljava/lang/CharSequence;

    aget-object v1, v1, v0

    goto :goto_b
.end method

.method public getSummary()Ljava/lang/CharSequence;
    .registers 9

    iget-object v2, p0, Landroidx/preference/XMiuiDropDownPreference;->mEntries:[Ljava/lang/CharSequence;

    invoke-virtual {p0}, Landroidx/preference/XMiuiDropDownPreference;->getValueIndex()I

    move-result v6

    const/4 v4, 0x0

    if-eqz v2, :cond_e

    array-length v7, v2

    if-ge v6, v7, :cond_e

    if-gez v6, :cond_2e

    :cond_e
    const/4 v0, 0x0

    :goto_f
    invoke-super {p0}, Lmiuix/preference/DropDownPreference;->getSummary()Ljava/lang/CharSequence;

    move-result-object v5

    if-eqz v5, :cond_27

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v7, 0x1

    new-array v3, v7, [Ljava/lang/Object;

    if-nez v0, :cond_20

    const-string v0, ""

    :cond_20
    const/4 v7, 0x0

    aput-object v0, v3, v7

    invoke-static {v1, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    :cond_27
    invoke-static {v4, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_31

    :goto_2d
    return-object v5

    :cond_2e
    aget-object v0, v2, v6

    goto :goto_f

    :cond_31
    move-object v5, v4

    goto :goto_2d
.end method

.method public getValue()Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    return-object v0
.end method

.method public getValueIndex()I
    .registers 2

    invoke-virtual {p0}, Landroidx/preference/XMiuiDropDownPreference;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->findIndexOfValue(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method protected onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Object;
    .registers 4

    invoke-virtual {p1, p2}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected onSetInitialValue(Ljava/lang/Object;)V
    .registers 4

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mValueSet:Z

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->isValidateKey()Z

    move-result v0

    if-eqz v0, :cond_27

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->getStr()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    :cond_13
    :goto_13
    invoke-direct {p0}, Landroidx/preference/XMiuiDropDownPreference;->checkIconsForEntries()V

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->findIndexOfValue(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->setValueIndex(I)V

    invoke-virtual {p0}, Landroidx/preference/XMiuiDropDownPreference;->getEntry()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->setSummary(Ljava/lang/CharSequence;)V

    return-void

    :cond_27
    if-eqz p1, :cond_13

    check-cast p1, Ljava/lang/String;

    iput-object p1, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/XMiuiDropDownPreference;->mLastState:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroidx/preference/XMiuiPreferenceHelper;->putStr(Ljava/lang/String;)V

    iget-object v0, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    goto :goto_13
.end method

.method public setSummary(Ljava/lang/CharSequence;)V
    .registers 3

    iget-boolean v0, p0, Landroidx/preference/XMiuiDropDownPreference;->mEnableSummary:Z

    if-eqz v0, :cond_7

    invoke-super {p0, p1}, Lmiuix/preference/DropDownPreference;->setSummary(Ljava/lang/CharSequence;)V

    :cond_7
    return-void
.end method

.method public setValueIndex(I)V
    .registers 4

    const/4 v0, -0x1

    if-ne p1, v0, :cond_10

    invoke-virtual {p0}, Landroidx/preference/XMiuiDropDownPreference;->getEntryValues()[Ljava/lang/CharSequence;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/XMiuiDropDownPreference;->findIndexOfValue(Ljava/lang/String;)I

    move-result p1

    :cond_10
    invoke-super {p0, p1}, Lmiuix/preference/DropDownPreference;->setValueIndex(I)V

    return-void
.end method

.method public shouldDisableDependents()Z
    .registers 3

    const/4 v0, 0x0

    :try_start_1
    iget-object v1, p0, Landroidx/preference/XMiuiDropDownPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v1}, Landroidx/preference/XMiuiPreferenceHelper;->getStr()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_a
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_a} :catch_f

    move-result v1

    if-gtz v1, :cond_e

    const/4 v0, 0x1

    :cond_e
    :goto_e
    return v0

    :catch_f
    move-exception v1

    goto :goto_e
.end method

.method public shouldPersist()Z
    .registers 2

    const/4 v0, 0x0

    return v0
.end method
