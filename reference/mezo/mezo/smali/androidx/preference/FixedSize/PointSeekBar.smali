# classes10.dex

.class public Landroidx/preference/FixedSize/PointSeekBar;
.super Landroid/view/View;
.source "PointSeekBar.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/FixedSize/PointSeekBar$RecommendListener;,
        Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;,
        Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;
    }
.end annotation


# instance fields
.field private mAccessHelper:Landroidx/customview/widget/ExploreByTouchHelper;

.field private mBigPointCenterColor:I

.field private mBigPointColor:I

.field private mBigPointsRadius:F

.field private mCurrentPointIndex:I

.field private mLabels:[Ljava/lang/String;

.field private mLastCurrentPointIndex:I

.field private mListener:Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;

.field private mPointCount:I

.field private mPointPaint:Landroid/graphics/Paint;

.field private mPointsRadius:F

.field private final mPointsXList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Float;",
            ">;"
        }
    .end annotation
.end field

.field private mPointsY:F

.field private mRecommendListener:Landroidx/preference/FixedSize/PointSeekBar$RecommendListener;

.field private mSmallPointColor:I

.field private final mVirtualPointsXList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/Float;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 4

    const/4 v1, 0x1

    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x4

    iput v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    iput v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    iput v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLastCurrentPointIndex:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsXList:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mVirtualPointsXList:Ljava/util/List;

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Landroidx/preference/FixedSize/PointSeekBar;->init(Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 5

    const/4 v1, 0x1

    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 v0, 0x4

    iput v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    iput v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    iput v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLastCurrentPointIndex:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsXList:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mVirtualPointsXList:Ljava/util/List;

    const/4 v0, 0x0

    invoke-direct {p0, p2, v0}, Landroidx/preference/FixedSize/PointSeekBar;->init(Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 6

    const/4 v1, 0x1

    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 v0, 0x4

    iput v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    iput v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    iput v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLastCurrentPointIndex:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsXList:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mVirtualPointsXList:Ljava/util/List;

    invoke-direct {p0, p2, p3}, Landroidx/preference/FixedSize/PointSeekBar;->init(Landroid/util/AttributeSet;I)V

    return-void
.end method

.method static synthetic access$000(Landroidx/preference/FixedSize/PointSeekBar;)I
    .registers 2

    iget v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    return v0
.end method

.method static synthetic access$100(Landroidx/preference/FixedSize/PointSeekBar;)Ljava/util/List;
    .registers 2

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mVirtualPointsXList:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$200(Landroidx/preference/FixedSize/PointSeekBar;)I
    .registers 2

    iget v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    return v0
.end method

.method static synthetic access$202(Landroidx/preference/FixedSize/PointSeekBar;I)I
    .registers 2

    iput p1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    return p1
.end method

.method static synthetic access$300(Landroidx/preference/FixedSize/PointSeekBar;)Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;
    .registers 2

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mListener:Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;

    return-object v0
.end method

.method static synthetic access$400(Landroidx/preference/FixedSize/PointSeekBar;)Z
    .registers 2

    invoke-direct {p0}, Landroidx/preference/FixedSize/PointSeekBar;->isRtl()Z

    move-result v0

    return v0
.end method

.method static synthetic access$500(Landroidx/preference/FixedSize/PointSeekBar;)[Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLabels:[Ljava/lang/String;

    return-object v0
.end method

.method private ensurePerformHapticFeedback(I)V
    .registers 3

    const/4 v0, 0x4

    invoke-virtual {p0, v0}, Landroidx/preference/FixedSize/PointSeekBar;->performHapticFeedback(I)Z

    return-void
.end method

.method private init(Landroid/util/AttributeSet;I)V
    .registers 9

    const/4 v5, 0x0

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const-string v4, "font_size_seekbar_big_pointer_blue"

    invoke-static {v0, v4}, Landroid/Utils/Utils;->ColorToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4, v5}, Landroid/content/res/Resources;->getColor(ILandroid/content/res/Resources$Theme;)I

    move-result v3

    iput v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mBigPointColor:I

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const-string v4, "font_size_view_small_color"

    invoke-static {v0, v4}, Landroid/Utils/Utils;->ColorToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4, v5}, Landroid/content/res/Resources;->getColor(ILandroid/content/res/Resources$Theme;)I

    move-result v3

    iput v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mSmallPointColor:I

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const-string v4, "font_size_view_big_center_color"

    invoke-static {v0, v4}, Landroid/Utils/Utils;->ColorToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v3, v4, v5}, Landroid/content/res/Resources;->getColor(ILandroid/content/res/Resources$Theme;)I

    move-result v3

    iput v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mBigPointCenterColor:I

    const-string v3, "font_size_view_small_radius"

    invoke-static {v0, v3}, Landroid/Utils/Utils;->getDimen(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    int-to-float v3, v3

    iput v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsRadius:F

    const-string v3, "font_size_view_big_radius"

    invoke-static {v0, v3}, Landroid/Utils/Utils;->getDimen(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    int-to-float v3, v3

    iput v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mBigPointsRadius:F

    new-instance v2, Landroid/graphics/Paint;

    invoke-direct {v2}, Landroid/graphics/Paint;-><init>()V

    iput-object v2, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointPaint:Landroid/graphics/Paint;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    iget-object v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointPaint:Landroid/graphics/Paint;

    sget-object v4, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v3, v4}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointPaint:Landroid/graphics/Paint;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    new-instance v1, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;

    invoke-direct {v1, p0, p0}, Landroidx/preference/FixedSize/PointSeekBar$LabeledSeekBarExploreByTouchHelper;-><init>(Landroidx/preference/FixedSize/PointSeekBar;Landroid/view/View;)V

    iput-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mAccessHelper:Landroidx/customview/widget/ExploreByTouchHelper;

    invoke-static {p0, v1}, Landroidx/core/view/ViewCompat;->setAccessibilityDelegate(Landroid/view/View;Landroidx/core/view/AccessibilityDelegateCompat;)V

    return-void
.end method

.method private isRtl()Z
    .registers 3

    const/4 v0, 0x1

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->getLayoutDirectionFromLocale(Ljava/util/Locale;)I

    move-result v1

    if-ne v1, v0, :cond_c

    :goto_b
    return v0

    :cond_c
    const/4 v0, 0x0

    goto :goto_b
.end method


# virtual methods
.method public dispatchHoverEvent(Landroid/view/MotionEvent;)Z
    .registers 3

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mAccessHelper:Landroidx/customview/widget/ExploreByTouchHelper;

    invoke-virtual {v0, p1}, Landroidx/customview/widget/ExploreByTouchHelper;->dispatchHoverEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    if-nez v0, :cond_e

    invoke-super {p0, p1}, Landroid/view/View;->dispatchHoverEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    if-eqz v0, :cond_10

    :cond_e
    const/4 v0, 0x1

    :goto_f
    return v0

    :cond_10
    const/4 v0, 0x0

    goto :goto_f
.end method

.method public getmCurrentPointIndex()I
    .registers 2

    iget v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    return v0
.end method

.method public onDraw(Landroid/graphics/Canvas;)V
    .registers 7

    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    const/4 v0, 0x0

    :goto_4
    iget v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    if-ge v0, v1, :cond_64

    iget v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    if-ne v0, v1, :cond_47

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointPaint:Landroid/graphics/Paint;

    iget v2, p0, Landroidx/preference/FixedSize/PointSeekBar;->mBigPointColor:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsXList:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    iget v2, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsY:F

    iget v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mBigPointsRadius:F

    iget-object v4, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointPaint:Landroid/graphics/Paint;

    iget v2, p0, Landroidx/preference/FixedSize/PointSeekBar;->mBigPointCenterColor:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsXList:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    iget v2, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsY:F

    iget v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsRadius:F

    iget-object v4, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    :goto_44
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    :cond_47
    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointPaint:Landroid/graphics/Paint;

    iget v2, p0, Landroidx/preference/FixedSize/PointSeekBar;->mSmallPointColor:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsXList:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    iget v2, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsY:F

    iget v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsRadius:F

    iget-object v4, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    goto :goto_44

    :cond_64
    return-void
.end method

.method public onLayout(ZIIII)V
    .registers 11

    invoke-super/range {p0 .. p5}, Landroid/view/View;->onLayout(ZIIII)V

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->getHeight()I

    move-result v3

    div-int/lit8 v3, v3, 0x2

    int-to-float v3, v3

    iput v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsY:F

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->getHeight()I

    move-result v4

    sub-int/2addr v3, v4

    iget v4, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    add-int/lit8 v4, v4, -0x1

    div-int/2addr v3, v4

    int-to-float v2, v3

    iget-object v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsXList:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->clear()V

    const/4 v1, 0x0

    :goto_21
    iget v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    if-ge v1, v3, :cond_45

    int-to-float v3, v1

    mul-float v0, v3, v2

    iget-object v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsXList:Ljava/util/List;

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->getHeight()I

    move-result v4

    div-int/lit8 v4, v4, 0x2

    int-to-float v4, v4

    add-float/2addr v4, v0

    invoke-static {v4}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mVirtualPointsXList:Ljava/util/List;

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_21

    :cond_45
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .registers 14
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ClickableViewAccessibility"
        }
    .end annotation

    const/4 v11, 0x1

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->getParent()Landroid/view/ViewParent;

    move-result-object v9

    invoke-interface {v9, v11}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->isEnabled()Z

    move-result v9

    if-nez v9, :cond_f

    :cond_e
    :goto_e
    return v11

    :cond_f
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v1

    if-eqz v1, :cond_1a

    if-eq v1, v11, :cond_1a

    const/4 v9, 0x2

    if-ne v1, v9, :cond_e

    :cond_1a
    const/high16 v2, 0x4f000000

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_1e
    iget v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    if-ge v5, v9, :cond_41

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v10

    iget-object v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointsXList:Ljava/util/List;

    invoke-interface {v9, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Float;

    invoke-virtual {v9}, Ljava/lang/Float;->floatValue()F

    move-result v9

    sub-float v9, v10, v9

    invoke-static {v9}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpg-float v9, v0, v2

    if-gez v9, :cond_3e

    move v4, v5

    move v2, v0

    :cond_3e
    add-int/lit8 v5, v5, 0x1

    goto :goto_1e

    :cond_41
    iget v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    if-eq v4, v9, :cond_65

    iput v4, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    iget-object v8, p0, Landroidx/preference/FixedSize/PointSeekBar;->mListener:Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;

    if-eqz v8, :cond_5b

    invoke-direct {p0}, Landroidx/preference/FixedSize/PointSeekBar;->isRtl()Z

    move-result v9

    if-eqz v9, :cond_94

    iget v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    add-int/lit8 v9, v9, -0x1

    iget v10, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    sub-int/2addr v9, v10

    :goto_58
    invoke-interface {v8, v9}, Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;->onSeekBarChange(I)V

    :cond_5b
    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->invalidate()V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v9

    invoke-direct {p0, v9}, Landroidx/preference/FixedSize/PointSeekBar;->ensurePerformHapticFeedback(I)V

    :cond_65
    if-ne v11, v1, :cond_e

    iget-object v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mRecommendListener:Landroidx/preference/FixedSize/PointSeekBar$RecommendListener;

    if-eqz v9, :cond_e

    const/4 v6, 0x5

    invoke-direct {p0}, Landroidx/preference/FixedSize/PointSeekBar;->isRtl()Z

    move-result v9

    if-eqz v9, :cond_78

    iget v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    add-int/lit8 v9, v9, -0x1

    add-int/lit8 v6, v9, -0x5

    :cond_78
    iget v7, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    if-ne v7, v6, :cond_83

    iput v7, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLastCurrentPointIndex:I

    iget-object v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mRecommendListener:Landroidx/preference/FixedSize/PointSeekBar$RecommendListener;

    invoke-interface {v9}, Landroidx/preference/FixedSize/PointSeekBar$RecommendListener;->showRecommendLayout()V

    :cond_83
    iget v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLastCurrentPointIndex:I

    if-ne v9, v6, :cond_e

    iget v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    if-eq v3, v6, :cond_e

    iput v3, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLastCurrentPointIndex:I

    iget-object v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mRecommendListener:Landroidx/preference/FixedSize/PointSeekBar$RecommendListener;

    invoke-interface {v9}, Landroidx/preference/FixedSize/PointSeekBar$RecommendListener;->scrollViewToHideRecommend()V

    goto/16 :goto_e

    :cond_94
    iget v9, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    goto :goto_58
.end method

.method public setCurrentPointIndex(I)V
    .registers 3

    iput p1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    invoke-direct {p0}, Landroidx/preference/FixedSize/PointSeekBar;->isRtl()Z

    move-result v0

    if-eqz v0, :cond_f

    iget v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    add-int/lit8 v0, v0, -0x1

    sub-int/2addr v0, p1

    iput v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mCurrentPointIndex:I

    :cond_f
    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->invalidate()V

    return-void
.end method

.method public setLabels([Ljava/lang/String;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLabels:[Ljava/lang/String;

    return-void
.end method

.method public setLastCurrentPointIndex(I)V
    .registers 3

    iput p1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLastCurrentPointIndex:I

    invoke-direct {p0}, Landroidx/preference/FixedSize/PointSeekBar;->isRtl()Z

    move-result v0

    if-eqz v0, :cond_f

    iget v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    add-int/lit8 v0, v0, -0x1

    sub-int/2addr v0, p1

    iput v0, p0, Landroidx/preference/FixedSize/PointSeekBar;->mLastCurrentPointIndex:I

    :cond_f
    invoke-virtual {p0}, Landroidx/preference/FixedSize/PointSeekBar;->invalidate()V

    return-void
.end method

.method public setPointCount(I)V
    .registers 2

    if-lez p1, :cond_4

    iput p1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mPointCount:I

    :cond_4
    return-void
.end method

.method public setRecommendListener(Landroidx/preference/FixedSize/PointSeekBar$RecommendListener;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mRecommendListener:Landroidx/preference/FixedSize/PointSeekBar$RecommendListener;

    return-void
.end method

.method public setSeekBarChangeListener(Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/FixedSize/PointSeekBar;->mListener:Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;

    return-void
.end method
