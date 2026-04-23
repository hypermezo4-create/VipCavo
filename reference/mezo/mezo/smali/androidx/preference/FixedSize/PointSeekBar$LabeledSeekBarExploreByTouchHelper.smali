# classes10.dex

.class public Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;
.super Landroidx/customview/widget/ExploreByTouchHelper;
.source "PointSeekBar.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preference/FixedSize/PointSeekBar;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "LabeledSeekBarExploreByTouchHelper"
.end annotation


# instance fields
.field private final mIsLayoutRtl:Z

.field final synthetic this$0:Landroidx/preference/FixedSize/PointSeekBar;


# direct methods
.method public constructor <init>(Landroidx/preference/FixedSize/PointSeekBar;Landroid/view/View;)V
    .registers 5

    const/4 v0, 0x1

    iput-object p1, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-direct {p0, p2}, Landroidx/customview/widget/ExploreByTouchHelper;-><init>(Landroid/view/View;)V

    invoke-virtual {p2}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Configuration;->getLayoutDirection()I

    move-result v1

    if-ne v1, v0, :cond_17

    :goto_14
    iput-boolean v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->mIsLayoutRtl:Z

    return-void

    :cond_17
    const/4 v0, 0x0

    goto :goto_14
.end method

.method private getBoundsInParentFromVirtualViewId(I)Landroid/graphics/Rect;
    .registers 8

    iget-boolean v2, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->mIsLayoutRtl:Z

    if-eqz v2, :cond_e

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v2}, Landroidx/preference/FixedSize/PointSeekBar;->access$000(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    sub-int p1, v2, p1

    :cond_e
    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v2}, Landroidx/preference/FixedSize/PointSeekBar;->access$100(Landroidx/preference/FixedSize/PointSeekBar;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v0

    float-to-int v2, v0

    const/4 v3, 0x0

    iget-object v4, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v4}, Landroidx/preference/FixedSize/PointSeekBar;->getHeight()I

    move-result v4

    int-to-float v4, v4

    add-float/2addr v4, v0

    float-to-int v4, v4

    iget-object v5, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v5}, Landroidx/preference/FixedSize/PointSeekBar;->getHeight()I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/graphics/Rect;->set(IIII)V

    return-object v1
.end method

.method private getHalfVirtualViewWidth()I
    .registers 4

    const/4 v0, 0x0

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v1}, Landroidx/preference/FixedSize/PointSeekBar;->getWidth()I

    move-result v1

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v2}, Landroidx/preference/FixedSize/PointSeekBar;->getPaddingStart()I

    move-result v2

    sub-int/2addr v1, v2

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v2}, Landroidx/preference/FixedSize/PointSeekBar;->getPaddingEnd()I

    move-result v2

    sub-int/2addr v1, v2

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v2}, Landroidx/preference/FixedSize/PointSeekBar;->access$000(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    mul-int/lit8 v2, v2, 0x2

    div-int/2addr v1, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method

.method private getVirtualViewIdIndexFromX(F)I
    .registers 6

    const/4 v1, 0x0

    float-to-int v2, p1

    iget-object v3, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v3}, Landroidx/preference/FixedSize/PointSeekBar;->getPaddingStart()I

    move-result v3

    sub-int/2addr v2, v3

    invoke-direct {p0}, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->getHalfVirtualViewWidth()I

    move-result v3

    div-int/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    div-int/lit8 v1, v1, 0x2

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v2}, Landroidx/preference/FixedSize/PointSeekBar;->access$000(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    iget-boolean v1, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->mIsLayoutRtl:Z

    if-eqz v1, :cond_30

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v1}, Landroidx/preference/FixedSize/PointSeekBar;->access$000(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    sub-int v0, v1, v0

    :cond_30
    return v0
.end method


# virtual methods
.method public getVirtualViewAt(FF)I
    .registers 4

    invoke-direct {p0, p1}, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->getVirtualViewIdIndexFromX(F)I

    move-result v0

    return v0
.end method

.method public getVisibleVirtualViews(Ljava/util/List;)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v2}, Landroidx/preference/FixedSize/PointSeekBar;->access$000(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v0

    const/4 v1, 0x0

    :goto_7
    if-ge v1, v0, :cond_13

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {p1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_7

    :cond_13
    return-void
.end method

.method public onPerformActionForVirtualView(IILandroid/os/Bundle;)Z
    .registers 8

    const/4 v1, 0x1

    iget-boolean v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->mIsLayoutRtl:Z

    if-eqz v0, :cond_f

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0}, Landroidx/preference/FixedSize/PointSeekBar;->access$000(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    sub-int p1, v0, p1

    :cond_f
    const/4 v0, -0x1

    if-eq p1, v0, :cond_16

    const/16 v0, 0x10

    if-eq p2, v0, :cond_18

    :cond_16
    const/4 v0, 0x0

    :goto_17
    return v0

    :cond_18
    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0}, Landroidx/preference/FixedSize/PointSeekBar;->access$200(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v0

    if-eq p1, v0, :cond_58

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0, p1}, Landroidx/preference/FixedSize/PointSeekBar;->access$202(Landroidx/preference/FixedSize/PointSeekBar;I)I

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0}, Landroidx/preference/FixedSize/PointSeekBar;->access$300(Landroidx/preference/FixedSize/PointSeekBar;)Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;

    move-result-object v0

    if-eqz v0, :cond_4d

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0}, Landroidx/preference/FixedSize/PointSeekBar;->access$300(Landroidx/preference/FixedSize/PointSeekBar;)Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;

    move-result-object v2

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0}, Landroidx/preference/FixedSize/PointSeekBar;->access$400(Landroidx/preference/FixedSize/PointSeekBar;)Z

    move-result v0

    if-eqz v0, :cond_5d

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0}, Landroidx/preference/FixedSize/PointSeekBar;->access$000(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    iget-object v3, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v3}, Landroidx/preference/FixedSize/PointSeekBar;->access$200(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v3

    sub-int/2addr v0, v3

    :goto_4a
    invoke-interface {v2, v0}, Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;->onSeekBarChange(I)V

    :cond_4d
    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v0}, Landroidx/preference/FixedSize/PointSeekBar;->invalidate()V

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    const/4 v2, 0x4

    invoke-virtual {v0, v2}, Landroidx/preference/FixedSize/PointSeekBar;->performHapticFeedback(I)Z

    :cond_58
    invoke-virtual {p0, p1, v1}, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->sendEventForVirtualView(II)Z

    move v0, v1

    goto :goto_17

    :cond_5d
    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0}, Landroidx/preference/FixedSize/PointSeekBar;->access$200(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v0

    goto :goto_4a
.end method

.method public onPopulateEventForVirtualView(ILandroid/view/accessibility/AccessibilityEvent;)V
    .registers 4

    const-class v0, Landroid/widget/Button;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/view/accessibility/AccessibilityEvent;->setClassName(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0}, Landroidx/preference/FixedSize/PointSeekBar;->access$500(Landroidx/preference/FixedSize/PointSeekBar;)[Ljava/lang/String;

    move-result-object v0

    aget-object v0, v0, p1

    invoke-virtual {p2, v0}, Landroid/view/accessibility/AccessibilityEvent;->setContentDescription(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v0}, Landroidx/preference/FixedSize/PointSeekBar;->access$200(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v0

    if-ne p1, v0, :cond_21

    const/4 v0, 0x1

    :goto_1d
    invoke-virtual {p2, v0}, Landroid/view/accessibility/AccessibilityEvent;->setChecked(Z)V

    return-void

    :cond_21
    const/4 v0, 0x0

    goto :goto_1d
.end method

.method public onPopulateNodeForVirtualView(ILandroidx/core/view/accessibility/AccessibilityNodeInfoCompat;)V
    .registers 6

    const/4 v2, 0x1

    const-class v1, Landroid/widget/Button;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->setClassName(Ljava/lang/CharSequence;)V

    invoke-direct {p0, p1}, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->getBoundsInParentFromVirtualViewId(I)Landroid/graphics/Rect;

    move-result-object v1

    invoke-virtual {p2, v1}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->setBoundsInParent(Landroid/graphics/Rect;)V

    const/16 v1, 0x10

    invoke-virtual {p2, v1}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->addAction(I)V

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v1}, Landroidx/preference/FixedSize/PointSeekBar;->access$500(Landroidx/preference/FixedSize/PointSeekBar;)[Ljava/lang/String;

    move-result-object v1

    aget-object v1, v1, p1

    invoke-virtual {p2, v1}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->setContentDescription(Ljava/lang/CharSequence;)V

    const/4 v0, 0x1

    invoke-virtual {p2, v2}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->setClickable(Z)V

    invoke-virtual {p2, v2}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->setCheckable(Z)V

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;->this$0:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-static {v1}, Landroidx/preference/FixedSize/PointSeekBar;->access$200(Landroidx/preference/FixedSize/PointSeekBar;)I

    move-result v1

    if-eq p1, v1, :cond_31

    const/4 v0, 0x0

    :cond_31
    invoke-virtual {p2, v0}, Landroidx/core/view/accessibility/AccessibilityNodeInfoCompat;->setChecked(Z)V

    return-void
.end method
