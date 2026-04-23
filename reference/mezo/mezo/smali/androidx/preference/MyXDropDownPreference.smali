# classes10.dex

.class public Landroidx/preference/MyXDropDownPreference;
.super Lmiuix/preference/DropDownPreference;
.source "MyXDropDownPreference.java"

# interfaces
.implements Landroid/view/View$OnLongClickListener;


# instance fields
.field private dependentsHide:Z

.field private disableKeyIntent:Z

.field private h:I

.field private mArrowColor:I

.field private mDisabledColor:I

.field private mEnableDependentsValues:Ljava/lang/String;

.field private mHereDefaultValue:Ljava/lang/String;

.field protected mMyPreference:Landroidx/preference/MyXPreference;

.field private mParentView:Landroid/view/View;

.field private myDependents:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroidx/preference/Preference;",
            ">;"
        }
    .end annotation
.end field

.field private position:I

.field private w:I

.field private x:I

.field private y:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 4

    sget v0, Lmiuix/preference/R$attr;->dropdownPreferenceStyle:I

    invoke-direct {p0, p1, p2, v0}, Landroidx/preference/MyXDropDownPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 5

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Landroidx/preference/MyXDropDownPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .registers 8

    invoke-direct {p0, p1, p2, p3, p4}, Lmiuix/preference/DropDownPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    new-instance v0, Landroidx/preference/MyXPreference;

    invoke-direct {v0, p1, p2}, Landroidx/preference/MyXPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mMyPreference:Landroidx/preference/MyXPreference;

    const/4 v1, 0x0

    const-string v0, "disableKeyIntent"

    invoke-interface {p2, v1, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1d

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    :cond_1d
    iput-boolean v1, p0, Landroidx/preference/MyXDropDownPreference;->disableKeyIntent:Z

    const-string v0, "enableDependentsValues"

    const/4 v1, 0x0

    invoke-interface {p2, v1, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_46

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v2, ""

    if-eq v0, v2, :cond_46

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, ";"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_46
    iput-object v1, p0, Landroidx/preference/MyXDropDownPreference;->mEnableDependentsValues:Ljava/lang/String;

    const-string v0, "dependentsHide"

    const/4 v1, 0x0

    invoke-interface {p2, v1, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5b

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    :cond_5b
    iput-boolean v1, p0, Landroidx/preference/MyXDropDownPreference;->dependentsHide:Z

    if-eqz v1, :cond_9c

    const/4 v1, 0x0

    const-string v0, "arrowPos"

    invoke-interface {p2, v1, v0, v1}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/MyXDropDownPreference;->position:I

    const-string v0, "arrowX"

    invoke-interface {p2, v1, v0, v1}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/MyXDropDownPreference;->x:I

    const-string v0, "arrowY"

    invoke-interface {p2, v1, v0, v1}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/MyXDropDownPreference;->y:I

    const v2, 0x16

    const-string v0, "arrowWidth"

    invoke-interface {p2, v1, v0, v2}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/MyXDropDownPreference;->w:I

    const v2, 0x12

    const-string v0, "arrowHeight"

    invoke-interface {p2, v1, v0, v2}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/MyXDropDownPreference;->h:I

    const-string v0, "arrowColor"

    invoke-interface {p2, v1, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_9a

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    :cond_9a
    iput v1, p0, Landroidx/preference/MyXDropDownPreference;->mArrowColor:I

    :cond_9c
    return-void
.end method

.method private addRemoveAllDependents(Z)V
    .registers 7

    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->myDependents:Ljava/util/List;

    if-nez v0, :cond_5

    return-void

    :cond_5
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x0

    invoke-direct {p0, p1}, Landroidx/preference/MyXDropDownPreference;->updateExpandButton(Z)V

    :goto_d
    if-ge v2, v1, :cond_68

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    instance-of v4, v3, Landroidx/preference/MyXListPreference;

    if-eqz v4, :cond_2e

    check-cast v3, Landroidx/preference/MyXListPreference;

    invoke-virtual {v3}, Landroidx/preference/MyXListPreference;->hasDependentsHide()Z

    move-result v4

    if-eqz v4, :cond_60

    if-eqz p1, :cond_26

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroidx/preference/MyXListPreference;->forceAddRemoveAllDependents(Z)V

    goto :goto_60

    :cond_26
    invoke-virtual {v3}, Landroidx/preference/MyXListPreference;->getValue()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroidx/preference/MyXListPreference;->checkDependents(Ljava/lang/String;)V

    goto :goto_60

    :cond_2e
    instance-of v4, v3, Landroidx/preference/MyXCheckBoxPreference;

    if-eqz v4, :cond_45

    check-cast v3, Landroidx/preference/MyXCheckBoxPreference;

    invoke-virtual {v3}, Landroidx/preference/MyXCheckBoxPreference;->hasDependentsHide()Z

    move-result v4

    if-eqz v4, :cond_60

    if-eqz p1, :cond_41

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroidx/preference/MyXCheckBoxPreference;->forceAddRemoveAllDependents(Z)V

    goto :goto_60

    :cond_41
    invoke-virtual {v3}, Landroidx/preference/MyXCheckBoxPreference;->checkDependents()V

    goto :goto_60

    :cond_45
    instance-of v4, v3, Landroidx/preference/MyXDropDownPreference;

    if-eqz v4, :cond_60

    check-cast v3, Landroidx/preference/MyXDropDownPreference;

    invoke-virtual {v3}, Landroidx/preference/MyXDropDownPreference;->hasDependentsHide()Z

    move-result v4

    if-eqz v4, :cond_60

    if-eqz p1, :cond_58

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroidx/preference/MyXDropDownPreference;->forceAddRemoveAllDependents(Z)V

    goto :goto_60

    :cond_58
    invoke-virtual {v3}, Landroidx/preference/MyXDropDownPreference;->getValue()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroidx/preference/MyXDropDownPreference;->checkDependents(Ljava/lang/String;)V

    goto :goto_60

    :cond_60
    :goto_60
    check-cast v3, Landroidx/preference/Preference;

    invoke-direct {p0, v3, p1}, Landroidx/preference/MyXDropDownPreference;->addRemoveDependent(Landroidx/preference/Preference;Z)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_d

    :cond_68
    return-void
.end method

.method private addRemoveDependent(Landroidx/preference/Preference;Z)V
    .registers 5

    if-eqz p1, :cond_1f

    invoke-direct {p0, p0}, Landroidx/preference/MyXDropDownPreference;->getParent(Landroidx/preference/Preference;)Landroidx/preference/PreferenceGroup;

    move-result-object v0

    if-eqz v0, :cond_1f

    invoke-virtual {p1}, Landroidx/preference/Preference;->getKey()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1f

    invoke-virtual {v0, v1}, Landroidx/preference/PreferenceGroup;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;

    move-result-object v1

    if-eqz p2, :cond_1a

    if-eqz v1, :cond_1f

    invoke-virtual {v0, p1}, Landroidx/preference/PreferenceGroup;->removePreference(Landroidx/preference/Preference;)Z

    goto :goto_1f

    :cond_1a
    if-nez v1, :cond_1f

    invoke-virtual {v0, p1}, Landroidx/preference/PreferenceGroup;->addPreference(Landroidx/preference/Preference;)Z

    :cond_1f
    :goto_1f
    return-void
.end method

.method private addRemoveThisDependent(Landroidx/preference/Preference;Z)V
    .registers 4

    if-eqz p1, :cond_57

    invoke-direct {p0, p2}, Landroidx/preference/MyXDropDownPreference;->updateExpandButton(Z)V

    instance-of v0, p1, Landroidx/preference/MyXListPreference;

    if-eqz v0, :cond_20

    check-cast p1, Landroidx/preference/MyXListPreference;

    invoke-virtual {p1}, Landroidx/preference/MyXListPreference;->hasDependentsHide()Z

    move-result v0

    if-eqz v0, :cond_52

    if-eqz p2, :cond_18

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroidx/preference/MyXListPreference;->forceAddRemoveAllDependents(Z)V

    goto :goto_52

    :cond_18
    invoke-virtual {p1}, Landroidx/preference/MyXListPreference;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/preference/MyXListPreference;->checkDependents(Ljava/lang/String;)V

    goto :goto_52

    :cond_20
    instance-of v0, p1, Landroidx/preference/MyXCheckBoxPreference;

    if-eqz v0, :cond_37

    check-cast p1, Landroidx/preference/MyXCheckBoxPreference;

    invoke-virtual {p1}, Landroidx/preference/MyXCheckBoxPreference;->hasDependentsHide()Z

    move-result v0

    if-eqz v0, :cond_52

    if-eqz p2, :cond_33

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroidx/preference/MyXCheckBoxPreference;->forceAddRemoveAllDependents(Z)V

    goto :goto_52

    :cond_33
    invoke-virtual {p1}, Landroidx/preference/MyXCheckBoxPreference;->checkDependents()V

    goto :goto_52

    :cond_37
    instance-of v0, p1, Landroidx/preference/MyXDropDownPreference;

    if-eqz v0, :cond_52

    check-cast p1, Landroidx/preference/MyXDropDownPreference;

    invoke-virtual {p1}, Landroidx/preference/MyXDropDownPreference;->hasDependentsHide()Z

    move-result v0

    if-eqz v0, :cond_52

    if-eqz p2, :cond_4a

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroidx/preference/MyXDropDownPreference;->forceAddRemoveAllDependents(Z)V

    goto :goto_52

    :cond_4a
    invoke-virtual {p1}, Landroidx/preference/MyXDropDownPreference;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/preference/MyXDropDownPreference;->checkDependents(Ljava/lang/String;)V

    goto :goto_52

    :cond_52
    :goto_52
    check-cast p1, Landroidx/preference/Preference;

    invoke-direct {p0, p1, p2}, Landroidx/preference/MyXDropDownPreference;->addRemoveDependent(Landroidx/preference/Preference;Z)V

    :cond_57
    return-void
.end method

.method private checkDependency()V
    .registers 3

    invoke-virtual {p0}, Landroidx/preference/Preference;->getDependency()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_26

    invoke-virtual {p0, v1}, Landroidx/preference/Preference;->findPreferenceInHierarchy(Ljava/lang/String;)Landroidx/preference/Preference;

    move-result-object v0

    instance-of v1, v0, Landroidx/preference/MyXCheckBoxPreference;

    if-eqz v1, :cond_13

    goto :goto_26

    :cond_13
    instance-of v1, v0, Landroidx/preference/MyXListPreference;

    if-eqz v1, :cond_1d

    check-cast v0, Landroidx/preference/MyXListPreference;

    invoke-virtual {v0, p0}, Landroidx/preference/MyXListPreference;->registerDependent(Landroidx/preference/Preference;)Z

    goto :goto_26

    :cond_1d
    instance-of v1, v0, Landroidx/preference/MyXDropDownPreference;

    if-eqz v1, :cond_26

    check-cast v0, Landroidx/preference/MyXDropDownPreference;

    invoke-virtual {v0, p0}, Landroidx/preference/MyXDropDownPreference;->registerDependent(Landroidx/preference/Preference;)Z

    :cond_26
    :goto_26
    return-void
.end method

.method private createColorStateList(II)Landroid/content/res/ColorStateList;
    .registers 9

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    new-array v0, v5, [[I

    new-array v1, v4, [I

    sget v2, Lcom/android/internal/R$attr;->state_enabled:I

    aput v2, v1, v3

    aput-object v1, v0, v3

    new-array v1, v4, [I

    mul-int/lit8 v2, v2, -0x1

    aput v2, v1, v3

    aput-object v1, v0, v4

    new-array v1, v5, [I

    aput p1, v1, v3

    aput p2, v1, v4

    new-instance v2, Landroid/content/res/ColorStateList;

    invoke-direct {v2, v0, v1}, Landroid/content/res/ColorStateList;-><init>([[I[I)V

    return-object v2
.end method

.method private getParent(Landroidx/preference/Preference;)Landroidx/preference/PreferenceGroup;
    .registers 4

    const/4 v1, 0x0

    if-eqz p1, :cond_13

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getPreferenceManager()Landroidx/preference/PreferenceManager;

    move-result-object v0

    if-eqz v0, :cond_13

    invoke-virtual {v0}, Landroidx/preference/PreferenceManager;->getPreferenceScreen()Landroidx/preference/PreferenceScreen;

    move-result-object v0

    if-eqz v0, :cond_13

    invoke-direct {p0, v0, p1}, Landroidx/preference/MyXDropDownPreference;->getParent(Landroidx/preference/PreferenceGroup;Landroidx/preference/Preference;)Landroidx/preference/PreferenceGroup;

    move-result-object v1

    :cond_13
    return-object v1
.end method

.method private getParent(Landroidx/preference/PreferenceGroup;Landroidx/preference/Preference;)Landroidx/preference/PreferenceGroup;
    .registers 7

    const/4 v3, 0x0

    const/4 v0, 0x0

    move v1, v0

    :goto_3
    invoke-virtual {p1}, Landroidx/preference/PreferenceGroup;->getPreferenceCount()I

    move-result v0

    if-ge v1, v0, :cond_25

    invoke-virtual {p1, v1}, Landroidx/preference/PreferenceGroup;->getPreference(I)Landroidx/preference/Preference;

    move-result-object v0

    if-ne v0, p2, :cond_10

    return-object p1

    :cond_10
    const-class v2, Landroidx/preference/PreferenceGroup;

    invoke-virtual {v2, v0}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_21

    check-cast v0, Landroidx/preference/PreferenceGroup;

    invoke-direct {p0, v0, p2}, Landroidx/preference/MyXDropDownPreference;->getParent(Landroidx/preference/PreferenceGroup;Landroidx/preference/Preference;)Landroidx/preference/PreferenceGroup;

    move-result-object v0

    if-eqz v0, :cond_21

    return-object v0

    :cond_21
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_3

    :cond_25
    return-object v3
.end method

.method private getStateDrawable(Z)Landroid/graphics/drawable/Drawable;
    .registers 6

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v2, "drawable"

    const-string v3, "android"

    if-nez p1, :cond_33

    const-string v1, "numberpicker_up_normal_holo_light"

    :goto_10
    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_32

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    iget v2, p0, Landroidx/preference/MyXDropDownPreference;->mDisabledColor:I

    if-eqz v2, :cond_2e

    const v2, 0x40

    if-eqz p1, :cond_2b

    const v2, 0x60

    :cond_2b
    invoke-virtual {v1, v2}, Landroid/graphics/drawable/Drawable;->setAlpha(I)V

    :cond_2e
    invoke-direct {p0, v1}, Landroidx/preference/MyXDropDownPreference;->updateDrawableBounds(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    :cond_32
    return-object v1

    :cond_33
    const-string v1, "numberpicker_down_normal_holo_light"

    goto :goto_10
.end method

.method private initArrowColor(Landroid/view/View;)Z
    .registers 6

    const/4 v3, 0x0

    invoke-virtual {p1}, Landroid/view/View;->getForegroundTintList()Landroid/content/res/ColorStateList;

    move-result-object v2

    if-nez v2, :cond_48

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_48

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "title"

    const-string v2, "id"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getTextColors()Landroid/content/res/ColorStateList;

    move-result-object v2

    iget v1, p0, Landroidx/preference/MyXDropDownPreference;->mArrowColor:I

    if-eqz v1, :cond_49

    const/4 v3, 0x1

    new-array v1, v3, [I

    sget v0, Lcom/android/internal/R$attr;->state_enabled:I

    mul-int/lit8 v0, v0, -0x1

    const/4 v3, 0x0

    aput v0, v1, v3

    const v3, -0x3f3f40

    invoke-virtual {v2, v1, v3}, Landroid/content/res/ColorStateList;->getColorForState([II)I

    move-result v2

    iget v1, p0, Landroidx/preference/MyXDropDownPreference;->mArrowColor:I

    invoke-direct {p0, v1, v2}, Landroidx/preference/MyXDropDownPreference;->createColorStateList(II)Landroid/content/res/ColorStateList;

    move-result-object v2

    :goto_44
    invoke-virtual {p1, v2}, Landroid/view/View;->setForegroundTintList(Landroid/content/res/ColorStateList;)V

    const/4 v3, 0x1

    :cond_48
    return v3

    :cond_49
    const/4 v3, 0x1

    new-array v1, v3, [I

    sget v0, Lcom/android/internal/R$attr;->state_enabled:I

    mul-int/lit8 v0, v0, -0x1

    const/4 v3, 0x0

    aput v0, v1, v3

    const v3, -0x3f3f40

    invoke-virtual {v2, v1, v3}, Landroid/content/res/ColorStateList;->getColorForState([II)I

    move-result v2

    iput v2, p0, Landroidx/preference/MyXDropDownPreference;->mDisabledColor:I

    invoke-direct {p0, v2, v2}, Landroidx/preference/MyXDropDownPreference;->createColorStateList(II)Landroid/content/res/ColorStateList;

    move-result-object v2

    goto :goto_44
.end method

.method private initExpandButton(Landroid/view/View;)V
    .registers 3

    iget-boolean v0, p0, Landroidx/preference/MyXDropDownPreference;->dependentsHide:Z

    if-nez v0, :cond_b

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setForeground(Landroid/graphics/drawable/Drawable;)V

    iput-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mParentView:Landroid/view/View;

    goto :goto_2d

    :cond_b
    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mParentView:Landroid/view/View;

    if-eqz v0, :cond_11

    if-eq v0, p1, :cond_2d

    :cond_11
    invoke-direct {p0, p1}, Landroidx/preference/MyXDropDownPreference;->initArrowColor(Landroid/view/View;)Z

    move-result v0

    if-eqz v0, :cond_20

    iget v0, p0, Landroidx/preference/MyXDropDownPreference;->position:I

    packed-switch v0, :pswitch_data_3e

    goto :goto_2e

    :goto_1d
    invoke-virtual {p1, v0}, Landroid/view/View;->setForegroundGravity(I)V

    :cond_20
    iput-object p1, p0, Landroidx/preference/MyXDropDownPreference;->mParentView:Landroid/view/View;

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Landroidx/preference/MyXDropDownPreference;->shouldDisableDependents(Ljava/lang/String;)Z

    move-result v0

    invoke-direct {p0, v0}, Landroidx/preference/MyXDropDownPreference;->updateExpandButton(Z)V

    :cond_2d
    :goto_2d
    return-void

    :goto_2e
    :pswitch_2e  #0x0
    const v0, 0x53

    goto :goto_1d

    :pswitch_32  #0x1
    const v0, 0x55

    goto :goto_1d

    :pswitch_36  #0x2
    const v0, 0x35

    goto :goto_1d

    :pswitch_3a  #0x3
    const v0, 0x33

    goto :goto_1d

    :pswitch_data_3e
    .packed-switch 0x0
        :pswitch_2e  #00000000
        :pswitch_32  #00000001
        :pswitch_36  #00000002
        :pswitch_3a  #00000003
    .end packed-switch
.end method

.method private setValueInternal(Ljava/lang/String;Z)V
    .registers 7

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getKey()Ljava/lang/String;

    move-result-object v2

    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mMyPreference:Landroidx/preference/MyXPreference;

    iget-object v3, p0, Landroidx/preference/MyXDropDownPreference;->mHereDefaultValue:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, v3}, Landroidx/preference/MyXPreference;->getString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_18

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_28

    :cond_18
    if-nez p1, :cond_1c

    iget-object p1, p0, Landroidx/preference/MyXDropDownPreference;->mHereDefaultValue:Ljava/lang/String;

    :cond_1c
    iget-boolean v3, p0, Landroidx/preference/MyXDropDownPreference;->disableKeyIntent:Z

    if-nez v3, :cond_28

    invoke-virtual {v0, v1, v2, p1}, Landroidx/preference/MyXPreference;->setString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p2, :cond_28

    invoke-virtual {v0, v1}, Landroidx/preference/MyXPreference;->sendIntent(Landroid/content/Context;)V

    :cond_28
    return-void
.end method

.method private shouldDisableDependents(Ljava/lang/String;)Z
    .registers 5

    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mEnableDependentsValues:Ljava/lang/String;

    if-eqz v0, :cond_27

    if-eqz p1, :cond_27

    const-string/jumbo v2, ""

    if-eq p1, v2, :cond_27

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, ";"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    :goto_26
    return v0

    :cond_27
    const/4 v0, 0x1

    goto :goto_26
.end method

.method private updateDrawableBounds(Landroid/graphics/drawable/Drawable;)Landroid/graphics/drawable/Drawable;
    .registers 8

    const/4 v0, 0x0

    if-eqz p1, :cond_16

    iget v1, p0, Landroidx/preference/MyXDropDownPreference;->x:I

    iget v5, p0, Landroidx/preference/MyXDropDownPreference;->y:I

    iget-object v2, p0, Landroidx/preference/MyXDropDownPreference;->mParentView:Landroid/view/View;

    iget v3, p0, Landroidx/preference/MyXDropDownPreference;->position:I

    packed-switch v3, :pswitch_data_56

    goto :goto_17

    :goto_f
    const/4 v0, 0x0

    new-instance v0, Landroid/graphics/drawable/InsetDrawable;

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Landroid/graphics/drawable/InsetDrawable;-><init>(Landroid/graphics/drawable/Drawable;IIII)V

    :cond_16
    return-object v0

    :goto_17
    :pswitch_17  #0x0
    invoke-virtual {v2}, Landroid/view/View;->getPaddingLeft()I

    move-result v2

    iget-object v3, p0, Landroidx/preference/MyXDropDownPreference;->mMyPreference:Landroidx/preference/MyXPreference;

    invoke-virtual {v3}, Landroidx/preference/MyXPreference;->getMargin()I

    move-result v3

    add-int/2addr v2, v3

    add-int/2addr v2, v1

    const v3, 0x7

    sub-int v5, v3, v5

    move v3, v0

    move v4, v0

    goto :goto_f

    :pswitch_2b  #0x1
    invoke-virtual {v2}, Landroid/view/View;->getPaddingRight()I

    move-result v2

    sub-int v4, v2, v1

    const v3, 0x7

    sub-int v5, v3, v5

    move v3, v0

    move v2, v0

    goto :goto_f

    :pswitch_39  #0x2
    invoke-virtual {v2}, Landroid/view/View;->getPaddingRight()I

    move-result v2

    sub-int v4, v2, v1

    add-int/lit8 v3, v5, 0x7

    move v5, v0

    move v2, v0

    goto :goto_f

    :pswitch_44  #0x3
    invoke-virtual {v2}, Landroid/view/View;->getPaddingLeft()I

    move-result v2

    iget-object v4, p0, Landroidx/preference/MyXDropDownPreference;->mMyPreference:Landroidx/preference/MyXPreference;

    invoke-virtual {v4}, Landroidx/preference/MyXPreference;->getMargin()I

    move-result v4

    add-int/2addr v2, v4

    add-int/2addr v2, v1

    add-int/lit8 v3, v5, 0x7

    move v5, v0

    move v4, v0

    goto :goto_f

    nop

    :pswitch_data_56
    .packed-switch 0x0
        :pswitch_17  #00000000
        :pswitch_2b  #00000001
        :pswitch_39  #00000002
        :pswitch_44  #00000003
    .end packed-switch
.end method

.method private updateExpandButton(Z)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mParentView:Landroid/view/View;

    if-eqz v0, :cond_b

    invoke-direct {p0, p1}, Landroidx/preference/MyXDropDownPreference;->getStateDrawable(Z)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setForeground(Landroid/graphics/drawable/Drawable;)V

    :cond_b
    return-void
.end method


# virtual methods
.method public applyDefaultValue()V
    .registers 2

    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mHereDefaultValue:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroidx/preference/MyXDropDownPreference;->setValue(Ljava/lang/String;)V

    return-void
.end method

.method public checkDependents(Ljava/lang/String;)V
    .registers 3

    iget-boolean v0, p0, Landroidx/preference/MyXDropDownPreference;->dependentsHide:Z

    if-eqz v0, :cond_b

    invoke-direct {p0, p1}, Landroidx/preference/MyXDropDownPreference;->shouldDisableDependents(Ljava/lang/String;)Z

    move-result v0

    invoke-direct {p0, v0}, Landroidx/preference/MyXDropDownPreference;->addRemoveAllDependents(Z)V

    :cond_b
    return-void
.end method

.method public forceAddRemoveAllDependents(Z)V
    .registers 2

    invoke-direct {p0, p1}, Landroidx/preference/MyXDropDownPreference;->addRemoveAllDependents(Z)V

    return-void
.end method

.method public getOnLongClickListener()Landroid/view/View$OnLongClickListener;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mMyPreference:Landroidx/preference/MyXPreference;

    iget-object v0, v0, Landroidx/preference/MyXPreference;->mOnLongClickListener:Landroid/view/View$OnLongClickListener;

    return-object v0
.end method

.method public hasDependentsHide()Z
    .registers 2

    iget-boolean v0, p0, Landroidx/preference/MyXDropDownPreference;->dependentsHide:Z

    return v0
.end method

.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 5

    invoke-super {p0, p1}, Lmiuix/preference/DropDownPreference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    iget-object v2, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mMyPreference:Landroidx/preference/MyXPreference;

    invoke-virtual {v0, v2, v1}, Landroidx/preference/MyXPreference;->setMargin(Landroid/view/View;Landroid/content/Context;)I

    invoke-direct {p0, v2}, Landroidx/preference/MyXDropDownPreference;->initExpandButton(Landroid/view/View;)V

    invoke-direct {p0}, Landroidx/preference/MyXDropDownPreference;->checkDependency()V

    return-void
.end method

.method protected onClick()V
    .registers 1

    invoke-super {p0}, Lmiuix/preference/DropDownPreference;->onClick()V

    return-void
.end method

.method protected onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Object;
    .registers 4

    invoke-virtual {p1, p2}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    iput-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mHereDefaultValue:Ljava/lang/String;

    return-object v0
.end method

.method public onLongClick(Landroid/view/View;)Z
    .registers 4

    const/4 v1, 0x0

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getOnLongClickListener()Landroid/view/View$OnLongClickListener;

    move-result-object v0

    if-eqz v0, :cond_e

    invoke-interface {v0, p1}, Landroid/view/View$OnLongClickListener;->onLongClick(Landroid/view/View;)Z

    move-result v1

    if-eqz v1, :cond_e

    goto :goto_18

    :cond_e
    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mMyPreference:Landroidx/preference/MyXPreference;

    iget-boolean v0, v0, Landroidx/preference/MyXPreference;->mDisableLongClick:Z

    if-nez v0, :cond_18

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->applyDefaultValue()V

    const/4 v1, 0x1

    :cond_18
    :goto_18
    return v1
.end method

.method protected onSetInitialValue(Ljava/lang/Object;)V
    .registers 5

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getKey()Ljava/lang/String;

    move-result-object v2

    instance-of v0, p1, Ljava/lang/String;

    if-eqz v0, :cond_18

    check-cast p1, Ljava/lang/String;

    :goto_e
    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mMyPreference:Landroidx/preference/MyXPreference;

    invoke-virtual {v0, v1, v2, p1}, Landroidx/preference/MyXPreference;->getString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroidx/preference/MyXDropDownPreference;->setValue(Ljava/lang/String;)V

    return-void

    :cond_18
    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/MyXDropDownPreference;->getPersistedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_e
.end method

.method public registerDependent(Landroidx/preference/Preference;)Z
    .registers 6

    const/4 v1, 0x0

    iget-boolean v0, p0, Landroidx/preference/MyXDropDownPreference;->dependentsHide:Z

    if-eqz v0, :cond_1f

    const/4 v1, 0x1

    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->myDependents:Ljava/util/List;

    if-nez v0, :cond_11

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/MyXDropDownPreference;->myDependents:Ljava/util/List;

    :cond_11
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0}, Landroidx/preference/MyXDropDownPreference;->getValue()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Landroidx/preference/MyXDropDownPreference;->shouldDisableDependents(Ljava/lang/String;)Z

    move-result v0

    invoke-direct {p0, p1, v0}, Landroidx/preference/MyXDropDownPreference;->addRemoveThisDependent(Landroidx/preference/Preference;Z)V

    :cond_1f
    return v1
.end method

.method public setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V
    .registers 3

    iget-object v0, p0, Landroidx/preference/MyXDropDownPreference;->mMyPreference:Landroidx/preference/MyXPreference;

    iput-object p1, v0, Landroidx/preference/MyXPreference;->mOnLongClickListener:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public setValue(Ljava/lang/String;)V
    .registers 3

    invoke-super {p0, p1}, Lmiuix/preference/DropDownPreference;->setValue(Ljava/lang/String;)V

    const/4 v0, 0x1

    invoke-virtual {p0, p1}, Landroidx/preference/MyXDropDownPreference;->checkDependents(Ljava/lang/String;)V

    invoke-direct {p0, p1, v0}, Landroidx/preference/MyXDropDownPreference;->setValueInternal(Ljava/lang/String;Z)V

    return-void
.end method
