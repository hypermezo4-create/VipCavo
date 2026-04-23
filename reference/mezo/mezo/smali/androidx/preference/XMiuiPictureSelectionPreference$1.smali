# classes10.dex

.class Landroidx/preference/XMiuiPictureSelectionPreference$1;
.super Ljava/lang/Object;
.source "XMiuiPictureSelectionPreference.java"

# interfaces
.implements Landroid/preference/CustomUpdater$CustomReceiver;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/XMiuiPictureSelectionPreference;->onClick()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/XMiuiPictureSelectionPreference;

.field final synthetic val$tkey:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroidx/preference/XMiuiPictureSelectionPreference;Ljava/lang/String;)V
    .registers 3

    iput-object p1, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1;->this$0:Landroidx/preference/XMiuiPictureSelectionPreference;

    iput-object p2, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1;->val$tkey:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCustomChanged(Ljava/lang/String;)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1;->val$tkey:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_16

    iget-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1;->this$0:Landroidx/preference/XMiuiPictureSelectionPreference;

    invoke-static {v0}, Landroidx/preference/XMiuiPictureSelectionPreference;->access$000(Landroidx/preference/XMiuiPictureSelectionPreference;)V

    invoke-static {}, Landroid/preference/CustomUpdater;->getInstance()Landroid/preference/CustomUpdater;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/XMiuiPictureSelectionPreference$1;->val$tkey:Ljava/lang/String;

    invoke-virtual {v0, p0, v1}, Landroid/preference/CustomUpdater;->removeCustomReceiver(Landroid/preference/CustomUpdater$CustomReceiver;Ljava/lang/String;)V

    :cond_16
    return-void
.end method
