# classes10.dex

.class public Landroidx/preference/ShapeSelect/SwitchPanel;
.super Landroid/widget/FrameLayout;
.source "SwitchPanel.java"

# interfaces
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;
    }
.end annotation


# static fields
.field private static final ANIM_DURATION:I = 0x190

.field private static final LEFT:I = 0x1

.field private static final MAJOR_MOVE:I = 0x3c

.field private static final RIGHT:I = 0x2


# instance fields
.field private inLeft:Landroid/view/animation/TranslateAnimation;

.field private inRight:Landroid/view/animation/TranslateAnimation;

.field private mChildren:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private mCurrentView:I

.field public mEnableScroll:Z

.field private final mGestureDetector:Landroid/view/GestureDetector;

.field private mIndicatorMarginBottom:I

.field private mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

.field private outLeft:Landroid/view/animation/TranslateAnimation;

.field private outRight:Landroid/view/animation/TranslateAnimation;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Landroidx/preference/ShapeSelect/SwitchPanel;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 4

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Landroidx/preference/ShapeSelect/SwitchPanel;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 6

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    const/4 v0, 0x0

    iput v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mEnableScroll:Z

    const/16 v0, 0x1e

    iput v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mIndicatorMarginBottom:I

    new-instance v0, Landroid/view/GestureDetector;

    new-instance v1, Landroidx/preference/ShapeSelect/SwitchPanel$1;

    invoke-direct {v1, p0}, Landroidx/preference/ShapeSelect/SwitchPanel$1;-><init>(Landroidx/preference/ShapeSelect/SwitchPanel;)V

    invoke-direct {v0, p1, v1}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mGestureDetector:Landroid/view/GestureDetector;

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->init()V

    return-void
.end method

.method static synthetic access$000(Landroidx/preference/ShapeSelect/SwitchPanel;)Ljava/util/ArrayList;
    .registers 2

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$100(Landroidx/preference/ShapeSelect/SwitchPanel;)I
    .registers 2

    iget v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    return v0
.end method

.method private init()V
    .registers 6

    const/4 v4, 0x0

    const/4 v3, -0x2

    new-instance v1, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, p0, v2}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;-><init>(Landroidx/preference/ShapeSelect/SwitchPanel;Landroid/content/Context;)V

    iput-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v0, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    const/16 v1, 0x51

    iput v1, v0, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    iget v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mIndicatorMarginBottom:I

    iput v1, v0, Landroid/widget/FrameLayout$LayoutParams;->bottomMargin:I

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    invoke-virtual {p0, v1, v4, v0}, Landroidx/preference/ShapeSelect/SwitchPanel;->addView(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0, v4}, Landroidx/preference/ShapeSelect/SwitchPanel;->setNestedScrollingEnabled(Z)V

    return-void
.end method

.method private updateCurrentView()V
    .registers 4

    const/4 v0, 0x0

    :goto_1
    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_1f

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    iget v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    if-ne v0, v2, :cond_1c

    const/4 v2, 0x0

    :goto_16
    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1c
    const/16 v2, 0x8

    goto :goto_16

    :cond_1f
    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    invoke-virtual {v1}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->bringToFront()V

    return-void
.end method

.method private updateView()V
    .registers 6

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getChildCount()I

    move-result v1

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    iput-object v3, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    const/4 v0, 0x0

    :goto_c
    if-ge v0, v1, :cond_2c

    invoke-virtual {p0, v0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v3

    if-eqz v3, :cond_24

    invoke-virtual {v2}, Landroid/view/View;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v3

    const-string v4, "screen_indicator"

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_29

    :cond_24
    iget-object v3, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_29
    add-int/lit8 v0, v0, 0x1

    goto :goto_c

    :cond_2c
    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->updateCurrentView()V

    iget-object v3, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    invoke-virtual {v3}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->updateScreenCount()V

    return-void
.end method


# virtual methods
.method public addView(Landroid/view/View;)V
    .registers 2

    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->updateView()V

    return-void
.end method

.method public addView(Landroid/view/View;I)V
    .registers 3

    invoke-super {p0, p1, p2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;I)V

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->updateView()V

    return-void
.end method

.method public addView(Landroid/view/View;II)V
    .registers 4

    invoke-super {p0, p1, p2, p3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;II)V

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->updateView()V

    return-void
.end method

.method public addView(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V
    .registers 4

    invoke-super {p0, p1, p2, p3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->updateView()V

    return-void
.end method

.method public addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    .registers 3

    invoke-super {p0, p1, p2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->updateView()V

    return-void
.end method

.method moveLeft()V
    .registers 3

    iget v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_56

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    invoke-virtual {v0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->moveLeft()V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    iget v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    iget v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->inLeft:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    iget v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->outLeft:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    iget v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    :cond_56
    return-void
.end method

.method moveRight()V
    .registers 3

    iget v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    if-lez v0, :cond_4e

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    invoke-virtual {v0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->moveRight()V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    iget v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    iget v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->inRight:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    iget v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->outRight:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    iget v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    :cond_4e
    return-void
.end method

.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .registers 2

    return-void
.end method

.method public onAnimationRepeat(Landroid/view/animation/Animation;)V
    .registers 2

    return-void
.end method

.method public onAnimationStart(Landroid/view/animation/Animation;)V
    .registers 2

    return-void
.end method

.method protected onFinishInflate()V
    .registers 1

    invoke-super {p0}, Landroid/widget/FrameLayout;->onFinishInflate()V

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->updateView()V

    return-void
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .registers 4

    const/4 v1, 0x1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-nez v0, :cond_1b

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_14

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :cond_14
    :goto_14
    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mGestureDetector:Landroid/view/GestureDetector;

    invoke-virtual {v0, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    :cond_1b
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-ne v0, v1, :cond_14

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_14

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    goto :goto_14
.end method

.method protected onSizeChanged(IIII)V
    .registers 11

    const-wide/16 v4, 0x190

    const/4 v3, 0x0

    move v0, p1

    new-instance v1, Landroid/view/animation/TranslateAnimation;

    int-to-float v2, v0

    invoke-direct {v1, v2, v3, v3, v3}, Landroid/view/animation/TranslateAnimation;-><init>(FFFF)V

    iput-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->inLeft:Landroid/view/animation/TranslateAnimation;

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->inLeft:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v1, p0}, Landroid/view/animation/TranslateAnimation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    new-instance v1, Landroid/view/animation/TranslateAnimation;

    neg-int v2, v0

    int-to-float v2, v2

    invoke-direct {v1, v3, v2, v3, v3}, Landroid/view/animation/TranslateAnimation;-><init>(FFFF)V

    iput-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->outLeft:Landroid/view/animation/TranslateAnimation;

    new-instance v1, Landroid/view/animation/TranslateAnimation;

    neg-int v2, v0

    int-to-float v2, v2

    invoke-direct {v1, v2, v3, v3, v3}, Landroid/view/animation/TranslateAnimation;-><init>(FFFF)V

    iput-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->inRight:Landroid/view/animation/TranslateAnimation;

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->inRight:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v1, p0}, Landroid/view/animation/TranslateAnimation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    new-instance v1, Landroid/view/animation/TranslateAnimation;

    int-to-float v2, v0

    invoke-direct {v1, v3, v2, v3, v3}, Landroid/view/animation/TranslateAnimation;-><init>(FFFF)V

    iput-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->outRight:Landroid/view/animation/TranslateAnimation;

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->inLeft:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v1, v4, v5}, Landroid/view/animation/TranslateAnimation;->setDuration(J)V

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->outLeft:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v1, v4, v5}, Landroid/view/animation/TranslateAnimation;->setDuration(J)V

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->inRight:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v1, v4, v5}, Landroid/view/animation/TranslateAnimation;->setDuration(J)V

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->outRight:Landroid/view/animation/TranslateAnimation;

    invoke-virtual {v1, v4, v5}, Landroid/view/animation/TranslateAnimation;->setDuration(J)V

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .registers 5

    const/4 v2, 0x1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-nez v0, :cond_1a

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_14

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    invoke-interface {v0, v2}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :cond_14
    :goto_14
    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mGestureDetector:Landroid/view/GestureDetector;

    invoke-virtual {v0, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    return v2

    :cond_1a
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-ne v0, v2, :cond_14

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_14

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    goto :goto_14
.end method

.method public scrollTo(I)V
    .registers 3

    if-ltz p1, :cond_a

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mChildren:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_b

    :cond_a
    :goto_a
    return-void

    :cond_b
    iput p1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mCurrentView:I

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel;->updateCurrentView()V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    invoke-virtual {v0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->updateScreenCount()V

    goto :goto_a
.end method

.method public setEnableIndicator(Z)V
    .registers 4

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    if-eqz p1, :cond_9

    const/4 v0, 0x0

    :goto_5
    invoke-virtual {v1, v0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->setVisibility(I)V

    return-void

    :cond_9
    const/16 v0, 0x8

    goto :goto_5
.end method

.method public setIndicatorMarginBottom(I)V
    .registers 4

    iput p1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mIndicatorMarginBottom:I

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    invoke-virtual {v1}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout$LayoutParams;

    iput p1, v0, Landroid/widget/FrameLayout$LayoutParams;->bottomMargin:I

    iget-object v1, p0, Landroidx/preference/ShapeSelect/SwitchPanel;->mScreenIndicator:Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;

    invoke-virtual {v1, v0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method
