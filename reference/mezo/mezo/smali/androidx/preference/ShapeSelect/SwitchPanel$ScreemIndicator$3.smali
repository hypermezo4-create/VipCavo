# classes10.dex

.class Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$3;
.super Ljava/lang/Object;
.source "SwitchPanel.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->moveRight()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

.field final synthetic val$view:Landroid/view/View;


# direct methods
.method constructor <init>(Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;Landroid/view/View;)V
    .registers 3

    iput-object p1, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$3;->this$1:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    iput-object p2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$3;->val$view:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 3

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$3;->val$view:Landroid/view/View;

    const/high16 v1, 0x3f800000  # 1.0f

    invoke-virtual {v0, v1}, Landroid/view/View;->setAlpha(F)V

    return-void
.end method
