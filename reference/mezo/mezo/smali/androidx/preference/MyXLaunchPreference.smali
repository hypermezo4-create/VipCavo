# classes10.dex

.class public Landroidx/preference/MyXLaunchPreference;
.super Landroidx/preference/Preference;
.source "MyXLaunchPreference.java"

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/content/DialogInterface$OnClickListener;
.implements Landroid/content/DialogInterface$OnDismissListener;
.implements Landroid/view/View$OnLongClickListener;


# instance fields
.field private imView:Landroid/widget/ImageView;

.field private lvDetail:Landroid/widget/ListView;

.field private mDialog:Landroid/app/Dialog;

.field private mLoadApps:Landroidx/preference/MyXLaunchPreference$LoadApps;

.field protected mMyXPreference:Landroidx/preference/MyXPreference;

.field private mProgressContainer:Landroid/widget/LinearLayout;

.field private mSummary:Landroid/widget/TextView;

.field private mUseClassicDialog:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 5

    invoke-direct {p0, p1, p2}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mDialog:Landroid/app/Dialog;

    new-instance v0, Landroidx/preference/MyXPreference;

    invoke-direct {v0, p1, p2}, Landroidx/preference/MyXPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mMyXPreference:Landroidx/preference/MyXPreference;

    const-string v0, "classic"

    const/4 v1, 0x0

    invoke-interface {p2, v1, v0, v1}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v1

    iput-boolean v1, p0, Landroidx/preference/MyXLaunchPreference;->mUseClassicDialog:Z

    return-void
.end method

.method static synthetic access$1(Landroidx/preference/MyXLaunchPreference;)Landroid/widget/ListView;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->lvDetail:Landroid/widget/ListView;

    return-object v0
.end method

.method static synthetic access$2(Landroidx/preference/MyXLaunchPreference;)Landroid/widget/LinearLayout;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mProgressContainer:Landroid/widget/LinearLayout;

    return-object v0
.end method

.method static synthetic access$3(Landroidx/preference/MyXLaunchPreference;)Ljava/lang/String;
    .registers 3

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mSummary:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    const-string/jumbo v1, ""

    if-eqz v0, :cond_f

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_f
    return-object v1
.end method

.method private applyThemeColorsToDialog(Landroid/app/Dialog;)V
    .registers 6

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "attr"

    const-string v2, "android"

    const-string v3, "textColorPrimary"

    invoke-virtual {v0, v3, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0}, Landroidx/preference/Preference;->getContext()Landroid/content/Context;

    move-result-object v1

    new-instance v3, Landroid/util/TypedValue;

    invoke-direct {v3}, Landroid/util/TypedValue;-><init>()V

    invoke-virtual {v1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v0, v3, v2}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    iget v3, v3, Landroid/util/TypedValue;->data:I

    const-string v1, "android:id/alertTitle"

    const/4 v2, 0x0

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, v1, v2, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/app/Dialog;->findViewById(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_37

    check-cast v1, Landroid/widget/TextView;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    :cond_37
    invoke-virtual {p1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    const-string v1, "attr"

    const-string v2, "android"

    const-string v3, "windowBackground"

    invoke-virtual {v0, v3, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0}, Landroidx/preference/Preference;->getContext()Landroid/content/Context;

    move-result-object v1

    new-instance v3, Landroid/util/TypedValue;

    invoke-direct {v3}, Landroid/util/TypedValue;-><init>()V

    invoke-virtual {v1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v0, v3, v2}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    iget v1, v3, Landroid/util/TypedValue;->type:I

    const v2, 0x1c

    if-lt v1, v2, :cond_6c

    const v2, 0x1f

    if-gt v1, v2, :cond_6c

    iget v1, v3, Landroid/util/TypedValue;->data:I

    invoke-virtual {p1, v1}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_7f

    :cond_6c
    :try_start_6c
    iget v2, v3, Landroid/util/TypedValue;->resourceId:I

    invoke-virtual {p0}, Landroidx/preference/Preference;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_7f

    invoke-virtual {p1, v0}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_7f
    .catchall {:try_start_6c .. :try_end_7f} :catchall_7f

    :catchall_7f
    :cond_7f
    :goto_7f
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

.method private getDialogNegativeText()Ljava/lang/String;
    .registers 5

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const-string v1, "cancel"

    const-string v0, "string"

    const-string v3, "android"

    invoke-virtual {v2, v1, v0, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method private getID(Ljava/lang/String;)I
    .registers 5

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    const-string v0, "id"

    const-string v2, "android"

    invoke-virtual {v1, p1, v0, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private getStyleID(Ljava/lang/String;)I
    .registers 5

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "style"

    const-string v2, "android"

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private positionButtons(Landroid/app/AlertDialog;)V
    .registers 6

    const v0, 0x0

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v1, v0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const v0, 0x36

    int-to-float v0, v0

    invoke-virtual {v1, v0}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    invoke-virtual {p1}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    const v1, 0x100000

    invoke-virtual {v0, v1}, Landroid/view/Window;->addPrivateFlags(I)V

    const v1, 0x40

    move v2, v1

    const/4 v3, 0x0

    const/4 v0, -0x2

    invoke-virtual {p1, v0}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v0

    if-eqz v0, :cond_3d

    invoke-virtual {v0}, Landroid/widget/Button;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup$MarginLayoutParams;

    invoke-virtual {v0, v1, v3, v2, v1}, Landroid/view/ViewGroup$MarginLayoutParams;->setMargins(IIII)V

    :cond_3d
    return-void
.end method

.method private resolveDialogTheme(Landroid/content/Context;I)I
    .registers 7

    const/4 v0, 0x1

    if-ne p2, v0, :cond_a

    const-string v0, "Theme.Dialog.Alert"

    invoke-direct {p0, v0}, Landroidx/preference/MyXLaunchPreference;->getStyleID(Ljava/lang/String;)I

    move-result v0

    return v0

    :cond_a
    const/4 v1, 0x2

    if-ne p2, v1, :cond_14

    const-string v0, "Theme.Holo.Dialog.Alert"

    invoke-direct {p0, v0}, Landroidx/preference/MyXLaunchPreference;->getStyleID(Ljava/lang/String;)I

    move-result v0

    return v0

    :cond_14
    const/4 v1, 0x3

    if-ne p2, v1, :cond_1e

    const-string v0, "Theme.Holo.Light.Dialog.Alert"

    invoke-direct {p0, v0}, Landroidx/preference/MyXLaunchPreference;->getStyleID(Ljava/lang/String;)I

    move-result v0

    return v0

    :cond_1e
    const/4 v1, 0x4

    if-ne p2, v1, :cond_28

    const-string v0, "Theme.DeviceDefault.Dialog.Alert"

    invoke-direct {p0, v0}, Landroidx/preference/MyXLaunchPreference;->getStyleID(Ljava/lang/String;)I

    move-result v0

    return v0

    :cond_28
    const/4 v1, 0x5

    if-ne p2, v1, :cond_32

    const-string v0, "Theme.DeviceDefault.Light.Dialog.Alert"

    invoke-direct {p0, v0}, Landroidx/preference/MyXLaunchPreference;->getStyleID(Ljava/lang/String;)I

    move-result v0

    return v0

    :cond_32
    invoke-static {p2}, Landroid/content/res/ResourceId;->isValid(I)Z

    move-result v1

    if-eqz v1, :cond_39

    return p2

    :cond_39
    const/4 v3, 0x0

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v2

    const-string v1, "android:attr/alertDialogTheme"

    invoke-virtual {v2, v1, v3, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    new-instance v1, Landroid/util/TypedValue;

    invoke-direct {v1}, Landroid/util/TypedValue;-><init>()V

    invoke-virtual {p1}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v2

    invoke-virtual {v2, v3, v1, v0}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    iget v0, v1, Landroid/util/TypedValue;->resourceId:I

    return v0
.end method

.method private setIconAndSummary(Ljava/lang/String;Z)V
    .registers 7

    if-eqz p1, :cond_2b

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_2b

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    :try_start_c
    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const/16 v1, 0x80

    invoke-virtual {v0, p1, v1}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/pm/ApplicationInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v2
    :try_end_1a
    .catchall {:try_start_c .. :try_end_1a} :catchall_2b

    iget-object v3, p0, Landroidx/preference/MyXLaunchPreference;->mSummary:Landroid/widget/TextView;

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v1, v0}, Landroid/content/pm/ApplicationInfo;->loadIcon(Landroid/content/pm/PackageManager;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    :goto_23
    iget-object v1, p0, Landroidx/preference/MyXLaunchPreference;->imView:Landroid/widget/ImageView;

    if-eqz v1, :cond_3a

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    :goto_2a
    return-void

    :catchall_2b
    :cond_2b
    const-string v2, "UserXP setIconAndSummary error"

    invoke-static {v2, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    const-string/jumbo v2, ""

    iget-object v3, p0, Landroidx/preference/MyXLaunchPreference;->mSummary:Landroid/widget/TextView;

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_23

    :cond_3a
    const-string v2, "UserXP error_imView"

    invoke-static {v2, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2a
.end method

.method private updateValue(Ljava/lang/String;Ljava/lang/String;)V
    .registers 6

    if-eqz p1, :cond_4

    if-nez p2, :cond_9

    :cond_4
    const-string p1, ""

    const-string p2, ""

    goto :goto_15

    :cond_9
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4

    :goto_15
    const/4 v1, 0x1

    invoke-direct {p0, p2, v1}, Landroidx/preference/MyXLaunchPreference;->setIconAndSummary(Ljava/lang/String;Z)V

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getKey()Ljava/lang/String;

    move-result-object v2

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mMyXPreference:Landroidx/preference/MyXPreference;

    invoke-virtual {v0, v1, v2, p2}, Landroidx/preference/MyXPreference;->setString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroidx/preference/MyXPreference;->sendIntent(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method public clear()V
    .registers 2

    const/4 v0, 0x0

    invoke-direct {p0, v0, v0}, Landroidx/preference/MyXLaunchPreference;->updateValue(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public getOnLongClickListener()Landroid/view/View$OnLongClickListener;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mMyXPreference:Landroidx/preference/MyXPreference;

    iget-object v0, v0, Landroidx/preference/MyXPreference;->mOnLongClickListener:Landroid/view/View$OnLongClickListener;

    return-object v0
.end method

.method protected onBindDialogView(Landroid/view/View;)V
    .registers 6

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "list"

    const-string v2, "id"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ListView;

    iput-object v1, p0, Landroidx/preference/MyXLaunchPreference;->lvDetail:Landroid/widget/ListView;

    invoke-virtual {v1, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->setChoiceMode(I)V

    const-string v1, "list_divider_holo_light"

    const-string v2, "drawable"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    iget-object v1, p0, Landroidx/preference/MyXLaunchPreference;->lvDetail:Landroid/widget/ListView;

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->setDivider(Landroid/graphics/drawable/Drawable;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->setDividerHeight(I)V

    const-string v2, "id"

    const-string v1, "progressContainer"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    iput-object v1, p0, Landroidx/preference/MyXLaunchPreference;->mProgressContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    const v0, 0x40

    invoke-virtual {v1, v0, v0, v0, v0}, Landroid/widget/FrameLayout;->setPadding(IIII)V

    const/4 v0, 0x0

    new-array v1, v0, [Ljava/lang/Void;

    new-instance v0, Landroidx/preference/MyXLaunchPreference$LoadApps;

    invoke-direct {v0, p0}, Landroidx/preference/MyXLaunchPreference$LoadApps;-><init>(Landroidx/preference/MyXLaunchPreference;)V

    iput-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mLoadApps:Landroidx/preference/MyXLaunchPreference$LoadApps;

    invoke-virtual {v0, v1}, Landroidx/preference/MyXLaunchPreference$LoadApps;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void
.end method

.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 6

    invoke-super {p0, p1}, Landroidx/preference/Preference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    const-string v0, "icon"

    invoke-direct {p0, v0}, Landroidx/preference/MyXLaunchPreference;->getID(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p1, v1}, Landroidx/preference/PreferenceViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_6a

    invoke-virtual {v1}, Landroid/widget/ImageView;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    iget-object v3, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_29

    check-cast v2, Landroid/view/ViewGroup;

    invoke-virtual {v2, v1}, Landroid/view/ViewGroup;->indexOfChild(Landroid/view/View;)I

    move-result v3

    invoke-virtual {v2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    if-eq v3, v0, :cond_6a

    :cond_29
    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Landroidx/preference/MyXLaunchPreference;->imView:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    invoke-virtual {v2, v1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    iget-object v2, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    check-cast v2, Lmiuix/flexible/view/HyperCellLayout;

    invoke-virtual {v2}, Lmiuix/flexible/view/HyperCellLayout;->getChildCount()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v2, v0}, Lmiuix/flexible/view/HyperCellLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v2, v1, v0}, Lmiuix/flexible/view/HyperCellLayout;->addView(Landroid/view/View;I)V

    const/4 v0, 0x0

    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    const/4 v0, 0x0

    invoke-virtual {v1, v0, v0, v0, v0}, Landroid/view/View;->setPadding(IIII)V

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "summary"

    const-string v2, "id"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iget-object v2, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Landroidx/preference/MyXLaunchPreference;->mSummary:Landroid/widget/TextView;

    :cond_6a
    iget-object v3, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v3, p0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v3, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mMyXPreference:Landroidx/preference/MyXPreference;

    invoke-virtual {v0, v3, v1}, Landroidx/preference/MyXPreference;->setMargin(Landroid/view/View;Landroid/content/Context;)I

    const-string/jumbo v0, ""

    invoke-virtual {p0, v0}, Landroidx/preference/MyXLaunchPreference;->onSetInitialValue(Ljava/lang/Object;)V

    invoke-direct {p0}, Landroidx/preference/MyXLaunchPreference;->checkDependency()V

    return-void
.end method

.method protected onClick()V
    .registers 2

    invoke-super {p0}, Landroidx/preference/Preference;->onClick()V

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mDialog:Landroid/app/Dialog;

    if-nez v0, :cond_a

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->showDialog()V

    :cond_a
    return-void
.end method

.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 3

    return-void
.end method

.method protected onCreateDialogView(Landroid/app/AlertDialog$Builder;)Landroid/view/View;
    .registers 6

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "list_content"

    const-string v2, "layout"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    const/4 v1, 0x0

    if-nez v3, :cond_16

    return-object v1

    :cond_16
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-virtual {v0, v3, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    return-object v1
.end method

.method public onDismiss(Landroid/content/DialogInterface;)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mLoadApps:Landroidx/preference/MyXLaunchPreference$LoadApps;

    if-eqz v0, :cond_15

    invoke-virtual {v0}, Landroidx/preference/MyXLaunchPreference$LoadApps;->getStatus()Landroid/os/AsyncTask$Status;

    move-result-object v0

    sget-object v1, Landroid/os/AsyncTask$Status;->RUNNING:Landroid/os/AsyncTask$Status;

    if-ne v0, v1, :cond_12

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mLoadApps:Landroidx/preference/MyXLaunchPreference$LoadApps;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroidx/preference/MyXLaunchPreference$LoadApps;->cancel(Z)Z

    :cond_12
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mLoadApps:Landroidx/preference/MyXLaunchPreference$LoadApps;

    :cond_15
    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mDialog:Landroid/app/Dialog;

    return-void
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .registers 8

    invoke-virtual {p1, p3}, Landroid/widget/AdapterView;->getItemAtPosition(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/preference/MyXLaunchPreference$AppData;

    iget-object v0, v1, Landroidx/preference/MyXLaunchPreference$AppData;->name:Ljava/lang/String;

    iget-object v1, v1, Landroidx/preference/MyXLaunchPreference$AppData;->packageName:Ljava/lang/String;

    invoke-direct {p0, v0, v1}, Landroidx/preference/MyXLaunchPreference;->updateValue(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mDialog:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    return-void
.end method

.method public onLongClick(Landroid/view/View;)Z
    .registers 4

    const/4 v1, 0x0

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getOnLongClickListener()Landroid/view/View$OnLongClickListener;

    move-result-object v0

    if-eqz v0, :cond_e

    invoke-interface {v0, p1}, Landroid/view/View$OnLongClickListener;->onLongClick(Landroid/view/View;)Z

    move-result v1

    if-eqz v1, :cond_e

    goto :goto_18

    :cond_e
    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mMyXPreference:Landroidx/preference/MyXPreference;

    iget-boolean v0, v0, Landroidx/preference/MyXPreference;->mDisableLongClick:Z

    if-nez v0, :cond_18

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->clear()V

    const/4 v1, 0x1

    :cond_18
    :goto_18
    return v1
.end method

.method protected onSetInitialValue(Ljava/lang/Object;)V
    .registers 6

    invoke-super {p0, p1}, Landroidx/preference/Preference;->onSetInitialValue(Ljava/lang/Object;)V

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0}, Landroidx/preference/MyXLaunchPreference;->getKey()Ljava/lang/String;

    move-result-object v2

    iget-object v1, p0, Landroidx/preference/MyXLaunchPreference;->mMyXPreference:Landroidx/preference/MyXPreference;

    const-string/jumbo v3, ""

    invoke-virtual {v1, v0, v2, v3}, Landroidx/preference/MyXPreference;->getString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-direct {p0, v2, v3}, Landroidx/preference/MyXLaunchPreference;->setIconAndSummary(Ljava/lang/String;Z)V

    return-void
.end method

.method public setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V
    .registers 3

    iget-object v0, p0, Landroidx/preference/MyXLaunchPreference;->mMyXPreference:Landroidx/preference/MyXPreference;

    iput-object p1, v0, Landroidx/preference/MyXPreference;->mOnLongClickListener:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method protected showDialog()V
    .registers 6

    invoke-virtual {p0}, Landroidx/preference/Preference;->getContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/app/AlertDialog$Builder;

    :try_start_6
    const/4 v2, 0x0

    invoke-direct {p0, v0, v2}, Landroidx/preference/MyXLaunchPreference;->resolveDialogTheme(Landroid/content/Context;I)I

    move-result v2

    if-eqz v2, :cond_11

    iget-boolean v3, p0, Landroidx/preference/MyXLaunchPreference;->mUseClassicDialog:Z

    if-nez v3, :cond_15

    :cond_11
    sget v2, Landroidx/appcompat/R$attr;->alertDialogTheme:I

    sget v2, Lmiuix/appcompat/R$attr;->miuiAlertDialogTheme:I
    :try_end_15
    .catchall {:try_start_6 .. :try_end_15} :catchall_15

    :catchall_15
    :cond_15
    invoke-direct {v1, v0, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    invoke-virtual {p0}, Landroidx/preference/Preference;->getTitle()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    invoke-virtual {p0, v4}, Landroidx/preference/MyXLaunchPreference;->onCreateDialogView(Landroid/app/AlertDialog$Builder;)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_2d

    invoke-virtual {p0, v1}, Landroidx/preference/MyXLaunchPreference;->onBindDialogView(Landroid/view/View;)V

    invoke-virtual {v4, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    goto :goto_2d

    :cond_2d
    :goto_2d
    invoke-direct {p0}, Landroidx/preference/MyXLaunchPreference;->getDialogNegativeText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1, p0}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v4}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v2

    iput-object v2, p0, Landroidx/preference/MyXLaunchPreference;->mDialog:Landroid/app/Dialog;

    invoke-virtual {v2, p0}, Landroid/app/Dialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    iget-boolean v4, p0, Landroidx/preference/MyXLaunchPreference;->mUseClassicDialog:Z

    if-nez v4, :cond_69

    invoke-virtual {v2}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    const v1, 0x50

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    const v3, 0x3e99999a  # 0.3f

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->dimAmount:F

    iget v3, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/4 v1, 0x6

    or-int/2addr v3, v1

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    iget v3, v0, Landroid/view/WindowManager$LayoutParams;->privateFlags:I

    const v1, 0x100000

    or-int/2addr v3, v1

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->privateFlags:I

    invoke-virtual {v4, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    const/4 v0, -0x1

    const/4 v1, -0x2

    invoke-virtual {v4, v0, v1}, Landroid/view/Window;->setLayout(II)V

    :cond_69
    invoke-virtual {v2}, Landroid/app/Dialog;->show()V

    iget-boolean v4, p0, Landroidx/preference/MyXLaunchPreference;->mUseClassicDialog:Z

    if-nez v4, :cond_74

    invoke-direct {p0, v2}, Landroidx/preference/MyXLaunchPreference;->positionButtons(Landroid/app/AlertDialog;)V

    goto :goto_77

    :cond_74
    invoke-direct {p0, v2}, Landroidx/preference/MyXLaunchPreference;->applyThemeColorsToDialog(Landroid/app/Dialog;)V

    :goto_77
    return-void
.end method
