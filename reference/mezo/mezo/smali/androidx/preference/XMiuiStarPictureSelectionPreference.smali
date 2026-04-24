# classes10.dex

.class public Landroidx/preference/XMiuiStarPictureSelectionPreference;
.super Landroidx/preference/Preference;
.source "XMiuiStarPictureSelectionPreference.java"

# interfaces
.implements Ljava/io/Serializable;
.implements Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;


# instance fields
.field private Helper:Landroidx/preference/XMiuiPreferenceHelper;

.field private fragment:Landroidx/fragment/app/Fragment;

.field private isNeedCopyImage:Z

.field private mAspectX:I

.field private mAspectY:I

.field private final mContext:Landroid/content/Context;

.field private final mDensity:F

.field private mDrawableIcon:Landroid/graphics/drawable/Drawable;

.field private mHeight:I

.field private mName:Ljava/lang/String;

.field private final mOk:Z

.field private mThumb:Z

.field private mType:Ljava/lang/String;

.field private mView:Landroid/view/View;

.field private mWidth:I

.field private pictureSelectionHelper:Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 4

    invoke-direct {p0, p1, p2}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const-string v0, "none"

    iput-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mType:Ljava/lang/String;

    iput-object p1, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mContext:Landroid/content/Context;

    invoke-direct {p0, p2}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->initialize(Landroid/util/AttributeSet;)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mOk:Z

    invoke-virtual {p0}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mDensity:F

    return-void
.end method

.method static synthetic access$000(Landroidx/preference/XMiuiStarPictureSelectionPreference;)Landroid/content/Context;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$100(Landroidx/preference/XMiuiStarPictureSelectionPreference;)Landroid/graphics/drawable/Drawable;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mDrawableIcon:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method private copyToTheme()V
    .registers 10

    const/4 v8, 0x0

    const/4 v7, 0x1

    const-string v4, "mount -o rw,remount /system"

    invoke-static {v4, v7, v7}, Landroid/Utils/Shell;->execCommand(Ljava/lang/String;ZZ)Landroid/Utils/Shell$CommandResult;

    move-result-object v1

    iget v4, v1, Landroid/Utils/Shell$CommandResult;->result:I

    if-eqz v4, :cond_8c

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "copyToTheme: res = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v1, Landroid/Utils/Shell$CommandResult;->result:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " error = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v1, Landroid/Utils/Shell$CommandResult;->errorMsg:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "   succes = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v1, Landroid/Utils/Shell$CommandResult;->successMsg:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v4, "mount -o rw,remount /system-root"

    invoke-static {v4, v7, v7}, Landroid/Utils/Shell;->execCommand(Ljava/lang/String;ZZ)Landroid/Utils/Shell$CommandResult;

    move-result-object v1

    iget v4, v1, Landroid/Utils/Shell$CommandResult;->result:I

    if-eqz v4, :cond_8c

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "copyToTheme: res = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v1, Landroid/Utils/Shell$CommandResult;->result:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " error = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v1, Landroid/Utils/Shell$CommandResult;->errorMsg:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "   succes = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v1, Landroid/Utils/Shell$CommandResult;->successMsg:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v4, "mount -o rw,remount /"

    invoke-static {v4, v7, v7}, Landroid/Utils/Shell;->execCommand(Ljava/lang/String;ZZ)Landroid/Utils/Shell$CommandResult;

    move-result-object v1

    :cond_8c
    iget v4, v1, Landroid/Utils/Shell$CommandResult;->result:I

    if-nez v4, :cond_f4

    const/4 v4, 0x2

    new-array v2, v4, [Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "cp -p -f "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->PATH:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".png /system/media/theme/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".png"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v8

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "chmod 0666 /system/media/theme/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".png"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v7

    invoke-static {v2, v7, v7}, Landroid/Utils/Shell;->execCommand([Ljava/lang/String;ZZ)Landroid/Utils/Shell$CommandResult;

    move-result-object v1

    iget v4, v1, Landroid/Utils/Shell$CommandResult;->result:I

    if-nez v4, :cond_f4

    const-string/jumbo v0, "Копирование прошло успешно"

    iget-object v4, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mContext:Landroid/content/Context;

    invoke-static {v4, v0, v8}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/Toast;->show()V

    :goto_f3
    return-void

    :cond_f4
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "copyToTheme: res = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v1, Landroid/Utils/Shell$CommandResult;->result:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " error = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v1, Landroid/Utils/Shell$CommandResult;->errorMsg:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "   succes = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v1, Landroid/Utils/Shell$CommandResult;->successMsg:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_f3
.end method

.method public static getDrawableFromPath(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .registers 2

    invoke-static {p0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->getDrawableFromPath(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method private initialize(Landroid/util/AttributeSet;)Z
    .registers 6

    const/4 v2, 0x1

    const/4 v1, 0x0

    new-instance v0, Landroidx/preference/XMiuiPreferenceHelper;

    iget-object v3, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mContext:Landroid/content/Context;

    invoke-direct {v0, v3, p1}, Landroidx/preference/XMiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v3, "name"

    invoke-virtual {v0, v3}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mName:Ljava/lang/String;

    if-nez v0, :cond_18

    :goto_17
    return v1

    :cond_18
    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v3, "copytotheme"

    invoke-virtual {v0, v3, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeBool(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->isNeedCopyImage:Z

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string/jumbo v3, "thumbnail"

    invoke-virtual {v0, v3, v2}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeBool(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mThumb:Z

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string/jumbo v3, "type"

    invoke-virtual {v0, v3}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mType:Ljava/lang/String;

    if-nez v0, :cond_6e

    const-string v0, ""

    :goto_3c
    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mType:Ljava/lang/String;

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mType:Ljava/lang/String;

    const-string/jumbo v3, "portrait"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6c

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mType:Ljava/lang/String;

    const-string v3, "landscape"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6c

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mType:Ljava/lang/String;

    const-string/jumbo v3, "square"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6c

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mType:Ljava/lang/String;

    const-string v3, "not_defined"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_71

    :cond_6c
    move v1, v2

    goto :goto_17

    :cond_6e
    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mType:Ljava/lang/String;

    goto :goto_3c

    :cond_71
    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v3, "aspectx"

    invoke-virtual {v0, v3, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeInt(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mAspectX:I

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v3, "aspecty"

    invoke-virtual {v0, v3, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeInt(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mAspectY:I

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string/jumbo v3, "width"

    invoke-virtual {v0, v3, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeInt(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mWidth:I

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    const-string v3, "height"

    invoke-virtual {v0, v3, v1}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeInt(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mHeight:I

    iget v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mAspectY:I

    if-eqz v0, :cond_a2

    iget v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mAspectX:I

    if-nez v0, :cond_aa

    :cond_a2
    iget v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mHeight:I

    if-eqz v0, :cond_ae

    iget v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mWidth:I

    if-eqz v0, :cond_ae

    :cond_aa
    move v0, v2

    :goto_ab
    move v1, v0

    goto/16 :goto_17

    :cond_ae
    move v0, v1

    goto :goto_ab
.end method

.method private static sendToast(Landroid/content/Context;Ljava/lang/String;)V
    .registers 4

    const/4 v1, 0x0

    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private setPreviewPicture()V
    .registers 10

    const/4 v8, 0x0

    const/high16 v7, 0x42200000  # 40.0f

    iget-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mView:Landroid/view/View;

    if-nez v5, :cond_c

    iget-boolean v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mThumb:Z

    if-nez v5, :cond_c

    :cond_b
    :goto_b
    return-void

    :cond_c
    new-instance v1, Landroid/widget/ImageView;

    invoke-virtual {p0}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-direct {v1, v5}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iget-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mView:Landroid/view/View;

    const v6, 0x1020018

    invoke-virtual {v5, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/LinearLayout;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    iget v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mDensity:F

    mul-float/2addr v5, v7

    float-to-int v5, v5

    iget v6, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mDensity:F

    mul-float/2addr v6, v7

    float-to-int v6, v6

    invoke-direct {v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/16 v5, 0x11

    iput v5, v3, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    iget v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mDensity:F

    const/high16 v6, 0x40a00000  # 5.0f

    mul-float/2addr v5, v6

    float-to-int v2, v5

    int-to-float v5, v2

    const/high16 v6, 0x3fc00000  # 1.5f

    mul-float/2addr v5, v6

    float-to-int v5, v5

    invoke-virtual {v3, v2, v2, v5, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    sget-object v5, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    if-eqz v4, :cond_b

    invoke-virtual {v4, v8}, Landroid/widget/LinearLayout;->setVisibility(I)V

    invoke-virtual {v4}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-lez v0, :cond_55

    invoke-virtual {v4, v8, v0}, Landroid/widget/LinearLayout;->removeViews(II)V

    :cond_55
    invoke-virtual {v4, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_b

    iget-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-static {v5}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->getDrawableFromPath(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    iput-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mDrawableIcon:Landroid/graphics/drawable/Drawable;

    iget-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mDrawableIcon:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v5, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mDrawableIcon:Landroid/graphics/drawable/Drawable;

    if-eqz v5, :cond_b

    new-instance v5, Landroidx/preference/XMiuiStarPictureSelectionPreference$1;

    invoke-direct {v5, p0}, Landroidx/preference/XMiuiStarPictureSelectionPreference$1;-><init>(Landroidx/preference/XMiuiStarPictureSelectionPreference;)V

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_b
.end method


# virtual methods
.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 2

    invoke-super {p0, p1}, Landroidx/preference/Preference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    invoke-virtual {p0, p1}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->onMyBindViewHolder(Ljava/lang/Object;)V

    return-void
.end method

.method protected onClick()V
    .registers 5

    iget-boolean v1, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mOk:Z

    if-eqz v1, :cond_5c

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "name"

    iget-object v2, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string/jumbo v1, "type"

    iget-object v2, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mType:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "aspectX"

    iget v2, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mAspectX:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "aspectY"

    iget v2, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mAspectY:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string/jumbo v1, "width"

    iget v2, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mWidth:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "height"

    iget v2, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mHeight:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "listener"

    invoke-virtual {v0, v1, p0}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V

    new-instance v1, Landroidx/preference/MiuiPictureSelection/fakeFragment;

    invoke-direct {v1}, Landroidx/preference/MiuiPictureSelection/fakeFragment;-><init>()V

    iput-object v1, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->fragment:Landroidx/fragment/app/Fragment;

    iget-object v1, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->fragment:Landroidx/fragment/app/Fragment;

    invoke-virtual {v1, v0}, Landroidx/fragment/app/Fragment;->setArguments(Landroid/os/Bundle;)V

    sget-object v1, Lmiuix/appcompat/app/AppCompatActivity;->sFragmentManager:Landroidx/fragment/app/FragmentManager;

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v1

    const v2, 0x1020002

    iget-object v3, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->fragment:Landroidx/fragment/app/Fragment;

    invoke-virtual {v1, v2, v3}, Landroidx/fragment/app/FragmentTransaction;->add(ILandroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentTransaction;->commit()I

    :goto_58
    invoke-super {p0}, Landroidx/preference/Preference;->onClick()V

    return-void

    :cond_5c
    iget-object v1, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mContext:Landroid/content/Context;

    const-string v2, "Whoops - Attribute not correct!"

    invoke-static {v1, v2}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->sendToast(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_58
.end method

.method public onImageCreated(Z)V
    .registers 4

    sget-object v0, Lmiuix/appcompat/app/AppCompatActivity;->sFragmentManager:Landroidx/fragment/app/FragmentManager;

    invoke-virtual {v0}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->fragment:Landroidx/fragment/app/Fragment;

    invoke-virtual {v0, v1}, Landroidx/fragment/app/FragmentTransaction;->remove(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/fragment/app/FragmentTransaction;->commit()I

    if-eqz p1, :cond_1d

    iget-object v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->Helper:Landroidx/preference/XMiuiPreferenceHelper;

    invoke-virtual {v0}, Landroidx/preference/XMiuiPreferenceHelper;->sendIntent()V

    iget-boolean v0, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->isNeedCopyImage:Z

    if-eqz v0, :cond_1d

    invoke-direct {p0}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->copyToTheme()V

    :cond_1d
    invoke-direct {p0}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->setPreviewPicture()V

    return-void
.end method

.method public onMyBindViewHolder(Ljava/lang/Object;)V
    .registers 7

    if-eqz p1, :cond_1a

    const/4 v2, 0x0

    :try_start_3
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "itemView"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    move-object v0, v3

    check-cast v0, Landroid/view/View;

    move-object v2, v0
    :try_end_15
    .catch Ljava/lang/NoSuchFieldException; {:try_start_3 .. :try_end_15} :catch_1b
    .catch Ljava/lang/IllegalAccessException; {:try_start_3 .. :try_end_15} :catch_1d

    :goto_15
    iput-object v2, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference;->mView:Landroid/view/View;

    invoke-direct {p0}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->setPreviewPicture()V

    :cond_1a
    return-void

    :catch_1b
    move-exception v3

    goto :goto_15

    :catch_1d
    move-exception v3

    goto :goto_15
.end method
