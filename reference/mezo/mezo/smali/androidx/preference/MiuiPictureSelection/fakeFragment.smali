# classes10.dex

.class public Landroidx/preference/MiuiPictureSelection/fakeFragment;
.super Landroidx/fragment/app/Fragment;
.source "fakeFragment.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;
    }
.end annotation


# instance fields
.field private mAspectX:I

.field private mAspectY:I

.field private mHeight:I

.field private mListener:Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;

.field private mName:Ljava/lang/String;

.field private mType:Ljava/lang/String;

.field private mWidth:I

.field private pictureSelectionHelper:Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroidx/preference/MiuiPictureSelection/fakeFragment;)Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mListener:Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;

    return-object v0
.end method


# virtual methods
.method public onActivityResult(IILandroid/content/Intent;)V
    .registers 5

    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->pictureSelectionHelper:Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;

    invoke-virtual {v0, p1, p2, p3}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->onActivityResult(IILandroid/content/Intent;)V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .registers 10

    invoke-super {p0, p1}, Landroidx/fragment/app/Fragment;->onCreate(Landroid/os/Bundle;)V

    new-instance v0, Landroidx/preference/MiuiPictureSelection/fakeFragment$1;

    invoke-direct {v0, p0}, Landroidx/preference/MiuiPictureSelection/fakeFragment$1;-><init>(Landroidx/preference/MiuiPictureSelection/fakeFragment;)V

    iput-object v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->pictureSelectionHelper:Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;

    const/4 v3, 0x4

    iget-object v1, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mType:Ljava/lang/String;

    const/4 v0, -0x1

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    sparse-switch v2, :sswitch_data_5e

    :cond_15
    :goto_15
    packed-switch v0, :pswitch_data_70

    :goto_18
    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->pictureSelectionHelper:Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;

    invoke-virtual {p0}, Landroidx/preference/MiuiPictureSelection/fakeFragment;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mName:Ljava/lang/String;

    iget v4, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mAspectX:I

    iget v5, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mAspectY:I

    iget v6, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mWidth:I

    iget v7, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mHeight:I

    invoke-virtual/range {v0 .. v7}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;->cropImage(Landroid/content/Context;Ljava/lang/String;IIIII)V

    return-void

    :sswitch_2c
    const-string/jumbo v2, "portrait"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_15

    const/4 v0, 0x0

    goto :goto_15

    :sswitch_37
    const-string v2, "landscape"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_15

    const/4 v0, 0x1

    goto :goto_15

    :sswitch_41
    const-string/jumbo v2, "square"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_15

    const/4 v0, 0x2

    goto :goto_15

    :sswitch_4c
    const-string v2, "not_defined"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_15

    const/4 v0, 0x3

    goto :goto_15

    :pswitch_56  #0x0
    const/4 v3, 0x0

    goto :goto_18

    :pswitch_58  #0x1
    const/4 v3, 0x1

    goto :goto_18

    :pswitch_5a  #0x2
    const/4 v3, 0x2

    goto :goto_18

    :pswitch_5c  #0x3
    const/4 v3, 0x3

    goto :goto_18

    :sswitch_data_5e
    .sparse-switch
        -0x3553a6e3 -> :sswitch_41
        -0x239d363 -> :sswitch_4c
        0x2b77bb9b -> :sswitch_2c
        0x5545f2bb -> :sswitch_37
    .end sparse-switch

    :pswitch_data_70
    .packed-switch 0x0
        :pswitch_56  #00000000
        :pswitch_58  #00000001
        :pswitch_5a  #00000002
        :pswitch_5c  #00000003
    .end packed-switch
.end method

.method public setArguments(Landroid/os/Bundle;)V
    .registers 3

    const-string v0, "name"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mName:Ljava/lang/String;

    const-string/jumbo v0, "type"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mType:Ljava/lang/String;

    const-string v0, "aspectX"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mAspectX:I

    const-string v0, "aspectY"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mAspectY:I

    const-string/jumbo v0, "width"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mWidth:I

    const-string v0, "height"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mHeight:I

    const-string v0, "listener"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getSerializable(Ljava/lang/String;)Ljava/io/Serializable;

    move-result-object v0

    check-cast v0, Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;

    iput-object v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment;->mListener:Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;

    return-void
.end method
