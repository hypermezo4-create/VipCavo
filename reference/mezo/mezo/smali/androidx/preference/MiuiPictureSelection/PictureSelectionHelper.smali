# classes10.dex

.class public abstract Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;
.super Ljava/lang/Object;
.source "PictureSelectionHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper$MyFileNameFilter;
    }
.end annotation


# static fields
.field static final CAMERA_CAPTURE:I = 0x1

.field public static PATH:Ljava/lang/String; = null

.field static final PIC_CROP:I = 0x2

.field static SMALL_PATH:Ljava/lang/String;


# instance fields
.field private mApeX:I

.field private mApeY:I

.field private mContext:Landroid/content/Context;

.field private mHeight:I

.field private mName:Ljava/lang/String;

.field private mPickUri:Landroid/net/Uri;

.field private mType:I

.field private mWidth:I


# direct methods
.method static constructor <clinit>()V
    .registers 1

    const-string v0, "/storage/emulated/0/data/myImage/"

    sput-object v0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->PATH:Ljava/lang/String;

    const-string v0, "/storage/emulated/0/data"

    sput-object v0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->SMALL_PATH:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private MyCrop()V
    .registers 6

    const/4 v3, 0x1

    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.android.camera.action.CROP"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mPickUri:Landroid/net/Uri;

    const-string v2, "image/*"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    iget v1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mType:I

    const/4 v2, 0x3

    if-eq v1, v2, :cond_2a

    iget v1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeX:I

    if-eqz v1, :cond_2a

    iget v1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeY:I

    if-eqz v1, :cond_2a

    const-string v1, "aspectX"

    iget v2, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeX:I

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "aspectY"

    iget v2, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeY:I

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    :cond_2a
    const-string/jumbo v1, "scale"

    invoke-virtual {v0, v1, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string/jumbo v1, "scaleUpIfNeeded"

    invoke-virtual {v0, v1, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string/jumbo v1, "outputFormat"

    sget-object v2, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    invoke-virtual {v2}, Landroid/graphics/Bitmap$CompressFormat;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string/jumbo v1, "output"

    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->PATH:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string/jumbo v4, "temp.png"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v2}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->goCropImage(Landroid/content/Intent;)V

    return-void
.end method

.method private MyPick()V
    .registers 5

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.PICK"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    sget-object v2, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    const-string v3, "image/*"

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    const-string/jumbo v2, "return-data"

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->goSelectImage(Landroid/content/Intent;)V

    return-void
.end method

.method private checkDir()Z
    .registers 5

    const/4 v1, 0x0

    new-instance v0, Ljava/io/File;

    sget-object v2, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->SMALL_PATH:Ljava/lang/String;

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_15

    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    move-result v2

    if-nez v2, :cond_15

    :cond_14
    :goto_14
    return v1

    :cond_15
    new-instance v0, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v3, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->SMALL_PATH:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/myImage"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_3b

    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    move-result v2

    if-eqz v2, :cond_14

    :cond_3b
    const/4 v1, 0x1

    goto :goto_14
.end method

.method private static checkFiles(Ljava/lang/String;)Z
    .registers 10

    const/4 v0, 0x0

    new-instance v3, Ljava/io/File;

    sget-object v5, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->PATH:Ljava/lang/String;

    invoke-direct {v3, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_6b

    new-instance v5, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper$MyFileNameFilter;

    const-string v6, ".png"

    const/4 v7, 0x0

    invoke-direct {v5, v6, v7}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper$MyFileNameFilter;-><init>(Ljava/lang/String;Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper$1;)V

    invoke-virtual {v3, v5}, Ljava/io/File;->listFiles(Ljava/io/FilenameFilter;)[Ljava/io/File;

    move-result-object v4

    if-eqz v4, :cond_6b

    array-length v5, v4

    if-eqz v5, :cond_6b

    new-instance v2, Ljava/io/File;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v6, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->PATH:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ".png"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_44

    const/4 v0, 0x1

    :cond_44
    array-length v6, v4

    const/4 v5, 0x0

    :goto_46
    if-ge v5, v6, :cond_6b

    aget-object v1, v4, v5

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_68

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, p0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_68

    if-nez v0, :cond_68

    invoke-virtual {v1, v2}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    const/4 v0, 0x1

    :cond_68
    add-int/lit8 v5, v5, 0x1

    goto :goto_46

    :cond_6b
    return v0
.end method

.method private static getCommonFactor(II)I
    .registers 3

    if-nez p1, :cond_3

    :goto_2
    return p0

    :cond_3
    rem-int v0, p0, p1

    invoke-static {p1, v0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->getCommonFactor(II)I

    move-result p0

    goto :goto_2
.end method

.method public static getDrawableFromPath(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .registers 4

    const/4 v0, 0x0

    invoke-static {p0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->checkFiles(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_24

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->PATH:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".png"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/graphics/drawable/Drawable;->createFromPath(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    :cond_24
    return-object v0
.end method

.method private setMetrics(Landroid/content/Context;IIIII)Z
    .registers 14

    const/4 v4, 0x1

    const-string/jumbo v5, "window"

    invoke-virtual {p1, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/view/WindowManager;

    if-eqz v3, :cond_a4

    invoke-interface {v3}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    new-instance v2, Landroid/util/DisplayMetrics;

    invoke-direct {v2}, Landroid/util/DisplayMetrics;-><init>()V

    invoke-virtual {v0, v2}, Landroid/view/Display;->getRealMetrics(Landroid/util/DisplayMetrics;)V

    iget v5, v2, Landroid/util/DisplayMetrics;->heightPixels:I

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    iget v5, v2, Landroid/util/DisplayMetrics;->widthPixels:I

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    iget v6, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    if-le v5, v6, :cond_2e

    iget v1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    iput v1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    :cond_2e
    const/4 v5, 0x4

    if-eq p2, v5, :cond_6c

    packed-switch p2, :pswitch_data_a6

    :goto_34
    return v4

    :pswitch_35  #0x0
    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    iget v6, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    invoke-static {v5, v6}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->getCommonFactor(II)I

    move-result v1

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    div-int/2addr v5, v1

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeX:I

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    div-int/2addr v5, v1

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeY:I

    goto :goto_34

    :pswitch_48  #0x1
    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    iget v6, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    invoke-static {v5, v6}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->getCommonFactor(II)I

    move-result v1

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    div-int/2addr v5, v1

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeY:I

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    div-int/2addr v5, v1

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeX:I

    iget v1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    iput v1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    goto :goto_34

    :pswitch_63  #0x2
    iput v4, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeX:I

    iput v4, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeY:I

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    goto :goto_34

    :cond_6c
    if-eqz p3, :cond_85

    if-eqz p4, :cond_85

    iput p3, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeX:I

    iput p4, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeY:I

    if-eqz p5, :cond_7a

    mul-int/lit8 v5, p5, 0x2

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    :cond_7a
    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    iget v6, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeY:I

    mul-int/2addr v5, v6

    iget v6, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeX:I

    div-int/2addr v5, v6

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    goto :goto_34

    :cond_85
    if-eqz p5, :cond_a4

    if-eqz p6, :cond_a4

    mul-int/lit8 v5, p5, 0x2

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    mul-int/lit8 v5, p6, 0x2

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    iget v6, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    invoke-static {v5, v6}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->getCommonFactor(II)I

    move-result v1

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    div-int/2addr v5, v1

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeX:I

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    div-int/2addr v5, v1

    iput v5, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mApeY:I

    goto :goto_34

    :cond_a4
    const/4 v4, 0x0

    goto :goto_34

    :pswitch_data_a6
    .packed-switch 0x0
        :pswitch_35  #00000000
        :pswitch_48  #00000001
        :pswitch_63  #00000002
    .end packed-switch
.end method


# virtual methods
.method cameraNotFound()V
    .registers 5

    const-string v0, "Whoops - your device doesn\'t support capturing images!"

    iget-object v2, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mContext:Landroid/content/Context;

    const/4 v3, 0x0

    invoke-static {v2, v0, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method cropImage(Landroid/content/Context;Ljava/lang/String;IIIII)V
    .registers 17

    iput-object p1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mContext:Landroid/content/Context;

    invoke-direct {p0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->checkDir()Z

    move-result v0

    if-eqz v0, :cond_2f

    iput-object p2, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mName:Ljava/lang/String;

    iput p3, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mType:I

    move-object v0, p0

    move-object v1, p1

    move v2, p3

    move v3, p4

    move v4, p5

    move v5, p6

    move/from16 v6, p7

    invoke-direct/range {v0 .. v6}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->setMetrics(Landroid/content/Context;IIIII)Z

    move-result v0

    if-eqz v0, :cond_1e

    invoke-direct {p0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->MyPick()V

    :goto_1d
    return-void

    :cond_1e
    const-string v7, "Whoops - wrong image size!"

    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    invoke-static {v0, v7, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v8

    invoke-virtual {v8}, Landroid/widget/Toast;->show()V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->onResult(Z)V

    goto :goto_1d

    :cond_2f
    const-string v7, "Whoops - your device doesn\'t give access to memory!"

    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    invoke-static {v0, v7, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v8

    invoke-virtual {v8}, Landroid/widget/Toast;->show()V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->onResult(Z)V

    goto :goto_1d
.end method

.method cropNotFound()V
    .registers 5

    const-string v0, "Whoops - your device doesn\'t support the crop action!"

    iget-object v2, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mContext:Landroid/content/Context;

    const/4 v3, 0x0

    invoke-static {v2, v0, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method abstract goCropImage(Landroid/content/Intent;)V
.end method

.method abstract goSelectImage(Landroid/content/Intent;)V
.end method

.method onActivityResult(IILandroid/content/Intent;)V
    .registers 16

    const/4 v6, 0x0

    const/4 v10, -0x1

    if-ne p2, v10, :cond_c4

    const/4 v10, 0x1

    if-ne p1, v10, :cond_11

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v10

    iput-object v10, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mPickUri:Landroid/net/Uri;

    invoke-direct {p0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->MyCrop()V

    :cond_10
    :goto_10
    return-void

    :cond_11
    const/4 v10, 0x2

    if-ne p1, v10, :cond_10

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v11, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->PATH:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mName:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ".png"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object v10, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mName:Ljava/lang/String;

    invoke-static {v10}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->checkFiles(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_3f

    invoke-virtual {v4}, Ljava/io/File;->delete()Z

    :cond_3f
    :try_start_3f
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v11, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->PATH:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string/jumbo v11, "temp.png"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v7

    iget v10, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mWidth:I

    div-int/lit8 v9, v10, 0x2

    iget v10, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mHeight:I

    div-int/lit8 v5, v10, 0x2

    iget v10, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mType:I

    const/4 v11, 0x3

    if-ne v10, v11, :cond_73

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v9

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    :cond_73
    const/4 v10, 0x0

    invoke-static {v7, v9, v5, v10}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v7

    sget-object v10, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v11, 0x55

    invoke-virtual {v7, v10, v11, v3}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    invoke-virtual {v3}, Ljava/io/OutputStream;->flush()V

    invoke-virtual {v3}, Ljava/io/OutputStream;->close()V

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->recycle()V

    const/4 v10, 0x1

    invoke-virtual {p0, v10}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->onResult(Z)V
    :try_end_8c
    .catch Ljava/lang/Exception; {:try_start_3f .. :try_end_8c} :catch_b2

    :goto_8c
    new-instance v4, Ljava/io/File;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v11, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->PATH:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string/jumbo v11, "temp.png"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v4, v10}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v10

    if-eqz v10, :cond_10

    invoke-virtual {v4}, Ljava/io/File;->delete()Z

    goto/16 :goto_10

    :catch_b2
    move-exception v1

    const-string v2, "Whoops - your device doesn\'t save file!"

    iget-object v10, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->mContext:Landroid/content/Context;

    const/4 v11, 0x0

    invoke-static {v10, v2, v11}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v8

    invoke-virtual {v8}, Landroid/widget/Toast;->show()V

    const/4 v10, 0x0

    invoke-virtual {p0, v10}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->onResult(Z)V

    goto :goto_8c

    :cond_c4
    const/4 v10, 0x0

    invoke-virtual {p0, v10}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->onResult(Z)V

    goto/16 :goto_10
.end method

.method abstract onResult(Z)V
.end method
