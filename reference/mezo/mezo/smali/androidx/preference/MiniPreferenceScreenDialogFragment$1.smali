# classes10.dex

.class Landroidx/preference/MiniPreferenceScreenDialogFragment$1;
.super Ljava/lang/Object;
.source "MiniPreferenceScreenDialogFragment.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/MiniPreferenceScreenDialogFragment;->onStart()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/MiniPreferenceScreenDialogFragment;

.field final synthetic val$linearLayout:Landroid/widget/LinearLayout;


# direct methods
.method constructor <init>(Landroidx/preference/MiniPreferenceScreenDialogFragment;Landroid/widget/LinearLayout;)V
    .registers 3

    iput-object p1, p0, Landroidx/preference/MiniPreferenceScreenDialogFragment$1;->this$0:Landroidx/preference/MiniPreferenceScreenDialogFragment;

    iput-object p2, p0, Landroidx/preference/MiniPreferenceScreenDialogFragment$1;->val$linearLayout:Landroid/widget/LinearLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 3

    iget-object v1, p0, Landroidx/preference/MiniPreferenceScreenDialogFragment$1;->val$linearLayout:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout$LayoutParams;

    if-eqz v0, :cond_1d

    const/16 v1, 0x384

    iput v1, v0, Landroid/widget/FrameLayout$LayoutParams;->width:I

    const/16 v1, 0x32

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout$LayoutParams;->setMarginEnd(I)V

    const v1, 0x800015

    iput v1, v0, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    iget-object v1, p0, Landroidx/preference/MiniPreferenceScreenDialogFragment$1;->val$linearLayout:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_1d
    return-void
.end method
