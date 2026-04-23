# classes10.dex

.class Landroidx/preference/XMiuiPictureSelectionPreference$1$1;
.super Ljava/lang/Object;
.source "XMiuiPictureSelectionPreference.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/XMiuiPictureSelectionPreference$1;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Landroidx/preference/XMiuiPictureSelectionPreference$1;

.field final synthetic val$imageBig:Landroid/widget/ImageView;

.field final synthetic val$mManager:Landroid/view/WindowManager;


# direct methods
.method constructor <init>(Landroidx/preference/XMiuiPictureSelectionPreference$1;Landroid/view/WindowManager;Landroid/widget/ImageView;)V
    .registers 4

    iput-object p1, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1$1;->this$1:Landroidx/preference/XMiuiPictureSelectionPreference$1;

    iput-object p2, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1$1;->val$mManager:Landroid/view/WindowManager;

    iput-object p3, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1$1;->val$imageBig:Landroid/widget/ImageView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1$1;->val$mManager:Landroid/view/WindowManager;

    iget-object v1, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1$1;->val$imageBig:Landroid/widget/ImageView;

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    return-void
.end method
