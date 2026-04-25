# classes10.dex

.class public Landroidx/preference/MiuiPictureSelection/PicturesSelection;
.super Ljava/lang/Object;
.source "PicturesSelection.java"

# interfaces
.implements Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/MiuiPictureSelection/PicturesSelection$OnImageCreatedListener;
    }
.end annotation


# instance fields
.field private fragment:Landroidx/fragment/app/Fragment;

.field private mAspectX:I

.field private mAspectY:I

.field private mContext:Landroid/content/Context;

.field private mHeight:I

.field private mIntent:Ljava/lang/String;

.field private mListener:Landroidx/preference/MiuiPictureSelection/PicturesSelection$OnImageCreatedListener;

.field private mName:Ljava/lang/String;

.field private mType:Ljava/lang/String;

.field private mWidth:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;IIIILandroidx/preference/MiuiPictureSelection/PicturesSelection$OnImageCreatedListener;)V
    .registers 10

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "none"

    iput-object v0, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mIntent:Ljava/lang/String;

    iput-object p2, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mName:Ljava/lang/String;

    if-nez p3, :cond_d

    const-string p3, "none"

    :cond_d
    iput-object p3, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mType:Ljava/lang/String;

    iput p4, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mAspectX:I

    iput p5, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mAspectY:I

    iput p6, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mWidth:I

    iput p7, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mHeight:I

    iput-object p8, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mListener:Landroidx/preference/MiuiPictureSelection/PicturesSelection$OnImageCreatedListener;

    iput-object p1, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mContext:Landroid/content/Context;

    return-void
.end method

.method private static sendToast(Landroid/content/Context;Ljava/lang/String;)V
    .registers 4

    const/4 v1, 0x0

    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method


# virtual methods
.method public onImageCreated(Z)V
    .registers 4

    sget-object v0, Lmiuix/appcompat/app/AppCompatActivity;->sFragmentManager:Landroidx/fragment/app/FragmentManager;

    invoke-virtual {v0}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->fragment:Landroidx/fragment/app/Fragment;

    invoke-virtual {v0, v1}, Landroidx/fragment/app/FragmentTransaction;->remove(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/fragment/app/FragmentTransaction;->commit()I

    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mListener:Landroidx/preference/MiuiPictureSelection/PicturesSelection$OnImageCreatedListener;

    if-eqz v0, :cond_18

    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mListener:Landroidx/preference/MiuiPictureSelection/PicturesSelection$OnImageCreatedListener;

    invoke-interface {v0, p1}, Landroidx/preference/MiuiPictureSelection/PicturesSelection$OnImageCreatedListener;->onImageCreated(Z)V

    :cond_18
    return-void
.end method

.method public start()V
    .registers 5

    iget-object v1, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mContext:Landroid/content/Context;

    instance-of v1, v1, Landroid/app/Activity;

    if-eqz v1, :cond_5b

    new-instance v1, Landroidx/preference/MiuiPictureSelection/fakeFragment;

    invoke-direct {v1}, Landroidx/preference/MiuiPictureSelection/fakeFragment;-><init>()V

    iput-object v1, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->fragment:Landroidx/fragment/app/Fragment;

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "name"

    iget-object v2, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mName:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string/jumbo v1, "type"

    iget-object v2, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mType:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "aspectX"

    iget v2, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mAspectX:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "aspectY"

    iget v2, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mAspectY:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string/jumbo v1, "width"

    iget v2, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mWidth:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "height"

    iget v2, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mHeight:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "listener"

    invoke-virtual {v0, v1, p0}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V

    iget-object v1, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->fragment:Landroidx/fragment/app/Fragment;

    invoke-virtual {v1, v0}, Landroidx/fragment/app/Fragment;->setArguments(Landroid/os/Bundle;)V

    sget-object v1, Lmiuix/appcompat/app/AppCompatActivity;->sFragmentManager:Landroidx/fragment/app/FragmentManager;

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v1

    const v2, 0x1020002

    iget-object v3, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->fragment:Landroidx/fragment/app/Fragment;

    invoke-virtual {v1, v2, v3}, Landroidx/fragment/app/FragmentTransaction;->add(ILandroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentTransaction;->commit()I

    :goto_5a
    return-void

    :cond_5b
    iget-object v1, p0, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->mContext:Landroid/content/Context;

    const-string v2, "Whoops - Context not checkcast activity!"

    invoke-static {v1, v2}, Landroidx/preference/MiuiPictureSelection/PicturesSelection;->sendToast(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_5a
.end method
