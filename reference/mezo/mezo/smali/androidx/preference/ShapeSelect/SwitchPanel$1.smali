# classes10.dex

.class Landroidx/preference/ShapeSelect/SwitchPanel$1;
.super Landroid/view/GestureDetector$SimpleOnGestureListener;
.source "SwitchPanel.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/ShapeSelect/SwitchPanel;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/ShapeSelect/SwitchPanel;


# direct methods
.method constructor <init>(Landroidx/preference/ShapeSelect/SwitchPanel;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/ShapeSelect/SwitchPanel$1;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-direct {p0}, Landroid/view/GestureDetector$SimpleOnGestureListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .registers 7

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel$1;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    iget-boolean v0, v0, Landroidx/preference/ShapeSelect/SwitchPanel;->mEnableScroll:Z

    if-eqz v0, :cond_36

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    sub-float/2addr v0, v1

    float-to-int v0, v0

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    const/16 v1, 0x3c

    if-le v0, v1, :cond_36

    invoke-static {p3}, Ljava/lang/Math;->abs(F)F

    move-result v0

    invoke-static {p4}, Ljava/lang/Math;->abs(F)F

    move-result v1

    cmpl-float v0, v0, v1

    if-lez v0, :cond_36

    const/4 v0, 0x0

    cmpl-float v0, p3, v0

    if-lez v0, :cond_30

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel$1;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-virtual {v0}, Landroidx/preference/ShapeSelect/SwitchPanel;->moveRight()V

    :goto_2e
    const/4 v0, 0x1

    :goto_2f
    return v0

    :cond_30
    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel$1;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-virtual {v0}, Landroidx/preference/ShapeSelect/SwitchPanel;->moveLeft()V

    goto :goto_2e

    :cond_36
    const/4 v0, 0x0

    goto :goto_2f
.end method
