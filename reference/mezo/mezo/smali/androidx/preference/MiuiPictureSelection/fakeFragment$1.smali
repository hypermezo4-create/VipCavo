# classes10.dex

.class Landroidx/preference/MiuiPictureSelection/fakeFragment$1;
.super Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;
.source "fakeFragment.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/MiuiPictureSelection/fakeFragment;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/MiuiPictureSelection/fakeFragment;


# direct methods
.method constructor <init>(Landroidx/preference/MiuiPictureSelection/fakeFragment;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment$1;->this$0:Landroidx/preference/MiuiPictureSelection/fakeFragment;

    invoke-direct {p0}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;-><init>()V

    return-void
.end method


# virtual methods
.method goCropImage(Landroid/content/Intent;)V
    .registers 5

    :try_start_0
    iget-object v1, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment$1;->this$0:Landroidx/preference/MiuiPictureSelection/fakeFragment;

    const/4 v2, 0x2

    invoke-virtual {v1, p1, v2}, Landroidx/preference/MiuiPictureSelection/fakeFragment;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_6
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_6} :catch_7

    :goto_6
    return-void

    :catch_7
    move-exception v0

    invoke-virtual {p0}, Landroidx/preference/MiuiPictureSelection/fakeFragment$1;->cropNotFound()V

    goto :goto_6
.end method

.method goSelectImage(Landroid/content/Intent;)V
    .registers 5

    :try_start_0
    iget-object v1, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment$1;->this$0:Landroidx/preference/MiuiPictureSelection/fakeFragment;

    const/4 v2, 0x1

    invoke-virtual {v1, p1, v2}, Landroidx/preference/MiuiPictureSelection/fakeFragment;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_6
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_6} :catch_7

    :goto_6
    return-void

    :catch_7
    move-exception v0

    invoke-virtual {p0}, Landroidx/preference/MiuiPictureSelection/fakeFragment$1;->cameraNotFound()V

    goto :goto_6
.end method

.method onResult(Z)V
    .registers 3

    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment$1;->this$0:Landroidx/preference/MiuiPictureSelection/fakeFragment;

    invoke-static {v0}, Landroidx/preference/MiuiPictureSelection/fakeFragment;->access$000(Landroidx/preference/MiuiPictureSelection/fakeFragment;)Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;

    move-result-object v0

    if-eqz v0, :cond_11

    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/fakeFragment$1;->this$0:Landroidx/preference/MiuiPictureSelection/fakeFragment;

    invoke-static {v0}, Landroidx/preference/MiuiPictureSelection/fakeFragment;->access$000(Landroidx/preference/MiuiPictureSelection/fakeFragment;)Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;

    move-result-object v0

    invoke-interface {v0, p1}, Landroidx/preference/MiuiPictureSelection/fakeFragment$OnImageCreatedListener;->onImageCreated(Z)V

    :cond_11
    return-void
.end method
