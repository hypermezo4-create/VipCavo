# classes10.dex

.class Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;
.super Landroid/widget/ImageView;

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ElementView"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;,
        Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;
    }
.end annotation


# static fields
.field private static final eventUp:I = 0xca

.field private static final falseTouch:I = 0xcb

.field private static final moveToPosition:I = 0xc9

.field private static final moveWithAnim:I = 0xc8

.field private static final otherElementmoveToPosition:I = 0xcc


# instance fields
.field private centerEnable:Z

.field private final elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

.field private isCenter:Z

.field private mCenterZone:Z

.field private final mCoordinate:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;",
            ">;"
        }
    .end annotation
.end field

.field private mFlag:Z

.field private mName:Ljava/lang/String;

.field private mPosition:I

.field private mTouch:Z

.field private rX:F

.field private rY:F

.field final synthetic this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;


# direct methods
.method constructor <init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;Landroid/content/Context;)V
    .registers 5

    const/4 v0, 0x0

    iput-object p1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-direct {p0, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    iput-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->centerEnable:Z

    iput-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCenterZone:Z

    iput-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mTouch:Z

    iput-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mFlag:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCoordinate:Ljava/util/ArrayList;

    new-instance v0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;-><init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$1;)V

    iput-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    invoke-virtual {p0, p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    return-void
.end method

.method static synthetic access$100(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mName:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$102(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Ljava/lang/String;)Ljava/lang/String;
    .registers 2

    iput-object p1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mName:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$202(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Z)Z
    .registers 2

    iput-boolean p1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->centerEnable:Z

    return p1
.end method

.method static synthetic access$2400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveWithAnim(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;)V

    return-void
.end method

.method static synthetic access$2500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->eventUp()V

    return-void
.end method

.method static synthetic access$2600(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;
    .registers 2

    iget-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    return-object v0
.end method

.method static synthetic access$300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I
    .registers 2

    iget v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    return v0
.end method

.method static synthetic access$308(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I
    .registers 3

    iget v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    return v0
.end method

.method static synthetic access$310(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)I
    .registers 3

    iget v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v1, v0, -0x1

    iput v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    return v0
.end method

.method static synthetic access$400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Z
    .registers 2

    iget-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mFlag:Z

    return v0
.end method

.method static synthetic access$500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Z
    .registers 2

    iget-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mTouch:Z

    return v0
.end method

.method static synthetic access$502(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Z)Z
    .registers 2

    iput-boolean p1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mTouch:Z

    return p1
.end method

.method static synthetic access$600(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;FFZ)V
    .registers 4

    invoke-direct {p0, p1, p2, p3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->onMovePosition(FFZ)V

    return-void
.end method

.method static synthetic access$700(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Z
    .registers 2

    iget-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    return v0
.end method

.method private eventUp()V
    .registers 12

    const/high16 v8, 0x40400000  # 3.0f

    const/high16 v7, 0x40000000  # 2.0f

    const/4 v10, 0x0

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v2

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1200(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v3

    const/high16 v5, 0x3f800000  # 1.0f

    invoke-virtual {p0, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setAlpha(F)V

    iget-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mFlag:Z

    if-nez v5, :cond_22

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCoordinate:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-lez v5, :cond_30

    :cond_22
    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    iget-object v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    const/16 v7, 0xca

    invoke-virtual {v6, v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->sendMessage(Landroid/os/Message;)Z

    :goto_2f
    return-void

    :cond_30
    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getX()F

    move-result v0

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getY()F

    move-result v1

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getParent()Landroid/view/ViewParent;

    move-result-object v5

    invoke-interface {v5, v10}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    iget-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    if-eqz v5, :cond_90

    iget-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->centerEnable:Z

    if-eqz v5, :cond_90

    div-float v5, v3, v7

    sub-float/2addr v5, v2

    div-float v6, v2, v8

    sub-float/2addr v5, v6

    cmpl-float v5, v0, v5

    if-lez v5, :cond_90

    div-float v5, v3, v7

    div-float v6, v2, v8

    add-float/2addr v5, v6

    cmpg-float v5, v0, v5

    if-gez v5, :cond_90

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v5, v10}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1600(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;I)Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    move-result-object v4

    if-eqz v4, :cond_7b

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    iget-boolean v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    invoke-static {v5, v0, v6}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1700(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FZ)I

    move-result v5

    iput v5, v4, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    iget-object v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    const/16 v7, 0xcc

    invoke-virtual {v6, v7, v4}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v6

    const-wide/16 v8, 0x32

    invoke-virtual {v5, v6, v8, v9}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->sendMessageDelayed(Landroid/os/Message;J)Z

    :cond_7b
    iput v10, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    :goto_7d
    const/4 v5, 0x1

    invoke-virtual {p0, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveToPosition(Z)V

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1800(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)V

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    const/16 v6, 0xcb

    const-wide/16 v8, 0x64

    invoke-virtual {v5, v6, v8, v9}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->sendEmptyMessageDelayed(IJ)Z

    goto :goto_2f

    :cond_90
    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    iget-boolean v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    invoke-static {v5, v0, v6}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1700(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FZ)I

    move-result v5

    iput v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    goto :goto_7d
.end method

.method private moveWithAnim(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;)V
    .registers 16

    const/high16 v11, 0x3f800000  # 1.0f

    const/4 v13, 0x0

    const/4 v8, 0x1

    const/4 v9, 0x0

    const/high16 v12, 0x40000000  # 2.0f

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7, v8}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$2100(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;Z)Z

    move-result v7

    if-eqz v7, :cond_21

    iget-boolean v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mTouch:Z

    if-eqz v7, :cond_21

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    iget-object v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    const/16 v9, 0xc8

    invoke-virtual {v8, v9, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->sendMessage(Landroid/os/Message;)Z

    :goto_20
    return-void

    :cond_21
    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getX()F

    move-result v4

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getY()F

    move-result v5

    iget v7, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->mX:F

    sub-float v2, v7, v4

    iget v7, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->mY:F

    sub-float v3, v7, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const/high16 v10, 0x41700000  # 15.0f

    div-float/2addr v7, v10

    cmpl-float v7, v7, v11

    if-lez v7, :cond_a2

    iget-boolean v7, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needX:Z

    if-eqz v7, :cond_a2

    cmpl-float v7, v2, v13

    if-lez v7, :cond_9f

    const/16 v7, 0xf

    :goto_46
    int-to-float v6, v7

    add-float/2addr v4, v6

    invoke-virtual {p0, v4}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setTranslationX(F)V

    :cond_4b
    :goto_4b
    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const/high16 v10, 0x41200000  # 10.0f

    div-float/2addr v7, v10

    cmpl-float v7, v7, v11

    if-lez v7, :cond_b0

    iget-boolean v7, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needY:Z

    if-eqz v7, :cond_b0

    cmpl-float v7, v3, v13

    if-lez v7, :cond_ad

    const/16 v7, 0xa

    :goto_60
    int-to-float v6, v7

    add-float/2addr v5, v6

    invoke-virtual {p0, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setTranslationY(F)V

    :cond_65
    :goto_65
    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v7

    div-float/2addr v7, v12

    iget-object v10, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v10}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v10

    div-float/2addr v10, v12

    sub-float/2addr v7, v10

    cmpl-float v7, v5, v7

    if-lez v7, :cond_bb

    move v0, v8

    :goto_79
    iget-boolean v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    if-eq v7, v0, :cond_bd

    iput-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    const/4 v0, 0x1

    :cond_80
    :goto_80
    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    cmpg-float v10, v2, v13

    if-gez v10, :cond_10d

    :goto_86
    invoke-static {v7, v4, v5, v8, v0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$2300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FFZZ)V

    iget-boolean v7, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needY:Z

    if-nez v7, :cond_91

    iget-boolean v7, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needX:Z

    if-eqz v7, :cond_110

    :cond_91
    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    iget-object v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    const/16 v9, 0xc8

    invoke-virtual {v8, v9, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_20

    :cond_9f
    const/16 v7, -0xf

    goto :goto_46

    :cond_a2
    iget-boolean v7, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needX:Z

    if-eqz v7, :cond_4b

    add-float/2addr v4, v2

    invoke-virtual {p0, v4}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setTranslationX(F)V

    iput-boolean v9, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needX:Z

    goto :goto_4b

    :cond_ad
    const/16 v7, -0xa

    goto :goto_60

    :cond_b0
    iget-boolean v7, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needY:Z

    if-eqz v7, :cond_65

    add-float/2addr v5, v3

    invoke-virtual {p0, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setTranslationY(F)V

    iput-boolean v9, p1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needY:Z

    goto :goto_65

    :cond_bb
    move v0, v9

    goto :goto_79

    :cond_bd
    const/4 v0, 0x0

    iget-boolean v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    if-eqz v7, :cond_10b

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v7

    const/high16 v10, 0x40400000  # 3.0f

    div-float/2addr v7, v10

    add-float/2addr v7, v4

    iget-object v10, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v10}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1200(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v10

    div-float/2addr v10, v12

    iget-object v11, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v11}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v11

    sub-float/2addr v10, v11

    cmpl-float v7, v7, v10

    if-lez v7, :cond_10b

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v7

    mul-float/2addr v7, v12

    const/high16 v10, 0x40400000  # 3.0f

    div-float/2addr v7, v10

    add-float/2addr v7, v4

    iget-object v10, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v10}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1200(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v10

    div-float/2addr v10, v12

    iget-object v11, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v11}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v11

    add-float/2addr v10, v11

    cmpg-float v7, v7, v10

    if-gez v7, :cond_10b

    move v1, v8

    :goto_fc
    iget-boolean v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCenterZone:Z

    if-eq v1, v7, :cond_80

    iput-boolean v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCenterZone:Z

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    iget-boolean v10, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    invoke-static {v7, v4, v10}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$2200(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FZ)V

    goto/16 :goto_80

    :cond_10b
    move v1, v9

    goto :goto_fc

    :cond_10d
    move v8, v9

    goto/16 :goto_86

    :cond_110
    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveElement()V

    goto/16 :goto_20
.end method

.method private onMovePosition(FFZ)V
    .registers 16

    const/4 v6, 0x0

    const/4 v4, -0x1

    const/high16 v11, 0x40400000  # 3.0f

    const/4 v5, 0x1

    const/high16 v10, 0x40000000  # 2.0f

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1200(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v2

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v1

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getX()F

    move-result v0

    iget v3, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    iget-boolean v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mTouch:Z

    if-nez v7, :cond_6b

    iget-boolean v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mFlag:Z

    if-nez v7, :cond_6b

    iget v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-eqz v7, :cond_6b

    iget-boolean v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v7

    div-float/2addr v7, v10

    iget-object v9, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v9}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v9

    div-float/2addr v9, v10

    sub-float/2addr v7, v9

    cmpl-float v7, p2, v7

    if-lez v7, :cond_6c

    move v7, v5

    :goto_3b
    if-ne v8, v7, :cond_6b

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1900(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)Z

    move-result v7

    if-eqz v7, :cond_99

    if-eqz p3, :cond_70

    mul-float v6, v10, v1

    div-float/2addr v6, v11

    add-float/2addr v6, v0

    cmpg-float v6, p1, v6

    if-gez v6, :cond_5e

    cmpl-float v6, p1, v0

    if-lez v6, :cond_5e

    iget v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    div-float v7, v2, v10

    cmpg-float v7, p1, v7

    if-ltz v7, :cond_6e

    :goto_5b
    add-int/2addr v4, v6

    iput v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    :cond_5e
    :goto_5e
    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-eq v4, v3, :cond_6b

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    rem-int/lit8 v4, v4, 0xa

    if-eqz v4, :cond_8b

    invoke-virtual {p0, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveToPosition(Z)V

    :cond_6b
    :goto_6b
    return-void

    :cond_6c
    move v7, v6

    goto :goto_3b

    :cond_6e
    move v4, v5

    goto :goto_5b

    :cond_70
    add-float v6, p1, v1

    mul-float v7, v10, v1

    div-float/2addr v7, v11

    add-float/2addr v7, v0

    cmpl-float v6, v6, v7

    if-lez v6, :cond_5e

    cmpg-float v6, p1, v0

    if-gez v6, :cond_5e

    iget v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    div-float v7, v2, v10

    cmpg-float v7, p1, v7

    if-ltz v7, :cond_87

    move v4, v5

    :cond_87
    add-int/2addr v4, v6

    iput v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    goto :goto_5e

    :cond_8b
    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    iget-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    invoke-static {v4, v0, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$2000(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FZ)V

    goto :goto_6b

    :cond_99
    if-eqz p3, :cond_c8

    mul-float v7, v10, v1

    div-float/2addr v7, v11

    add-float/2addr v7, v0

    cmpg-float v7, p1, v7

    if-gez v7, :cond_b8

    cmpl-float v7, p1, v0

    if-lez v7, :cond_b8

    iget v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    div-float v8, v2, v10

    cmpl-float v8, p1, v8

    if-lez v8, :cond_b0

    move v6, v5

    :cond_b0
    iget-boolean v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    xor-int/2addr v6, v8

    if-eqz v6, :cond_c6

    :goto_b5
    add-int/2addr v4, v7

    iput v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    :cond_b8
    :goto_b8
    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-eq v4, v3, :cond_6b

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    rem-int/lit8 v4, v4, 0xa

    if-eqz v4, :cond_e9

    invoke-virtual {p0, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveToPosition(Z)V

    goto :goto_6b

    :cond_c6
    move v4, v5

    goto :goto_b5

    :cond_c8
    add-float v7, p1, v1

    mul-float v8, v10, v1

    div-float/2addr v8, v11

    add-float/2addr v8, v0

    cmpl-float v7, v7, v8

    if-lez v7, :cond_b8

    cmpg-float v7, p1, v0

    if-gez v7, :cond_b8

    iget v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    div-float v8, v2, v10

    cmpl-float v8, p1, v8

    if-lez v8, :cond_df

    move v6, v5

    :cond_df
    iget-boolean v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    xor-int/2addr v6, v8

    if-eqz v6, :cond_e5

    move v4, v5

    :cond_e5
    add-int/2addr v4, v7

    iput v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    goto :goto_b8

    :cond_e9
    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    iget-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    invoke-static {v4, v0, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$2000(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;FZ)V

    goto/16 :goto_6b
.end method

.method private vibrate(I)V
    .registers 3

    invoke-static {p1}, Lmiui/util/HapticFeedbackUtil;->isSupportLinearMotorVibrate(I)Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-virtual {p0, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->performHapticFeedback(I)Z

    :cond_9
    return-void
.end method


# virtual methods
.method public moveElement()V
    .registers 4

    const/4 v2, 0x0

    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCoordinate:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_27

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mFlag:Z

    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCoordinate:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;

    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCoordinate:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    invoke-direct {p0, v0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveWithAnim(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;)V

    iget-boolean v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mTouch:Z

    if-nez v1, :cond_26

    const v1, 0x10000006

    invoke-direct {p0, v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->vibrate(I)V

    :cond_26
    :goto_26
    return-void

    :cond_27
    iput-boolean v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mFlag:Z

    goto :goto_26
.end method

.method public moveToPosition(Z)V
    .registers 12

    const/16 v9, 0x1e

    const/16 v8, 0x14

    const/high16 v7, 0x40000000  # 2.0f

    iget-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mFlag:Z

    if-eqz v5, :cond_1e

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    iget-object v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->elementHadler:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    const/16 v7, 0xc9

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v6

    const-wide/16 v8, 0xa

    invoke-virtual {v5, v6, v8, v9}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->sendMessageDelayed(Landroid/os/Message;J)Z

    :cond_1d
    :goto_1d
    return-void

    :cond_1e
    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1200(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v4

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v2

    iget-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    if-eqz v5, :cond_69

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v5

    iget-object v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v6}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v6

    sub-float v0, v5, v6

    :goto_3c
    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1900(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)Z

    move-result v5

    if-eqz v5, :cond_99

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-le v5, v9, :cond_6b

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v5, v5, -0x1e

    int-to-float v5, v5

    mul-float/2addr v5, v2

    sub-float v3, v4, v5

    :goto_50
    if-eqz p1, :cond_df

    new-instance v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;

    const/4 v5, 0x0

    invoke-direct {v1, p0, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;-><init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$1;)V

    iput v3, v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->mX:F

    iput v0, v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->mY:F

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCoordinate:Ljava/util/ArrayList;

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mFlag:Z

    if-nez v5, :cond_1d

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveElement()V

    goto :goto_1d

    :cond_69
    const/4 v0, 0x0

    goto :goto_3c

    :cond_6b
    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-le v5, v8, :cond_77

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v5, v5, -0x15

    int-to-float v5, v5

    mul-float v3, v5, v2

    goto :goto_50

    :cond_77
    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v5, v5, -0xa

    if-lez v5, :cond_86

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v5, v5, -0xa

    int-to-float v5, v5

    mul-float/2addr v5, v2

    sub-float v3, v4, v5

    goto :goto_50

    :cond_86
    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-nez v5, :cond_91

    div-float v5, v4, v7

    div-float v6, v2, v7

    sub-float v3, v5, v6

    goto :goto_50

    :cond_91
    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v5, v5, -0x1

    int-to-float v5, v5

    mul-float v3, v5, v2

    goto :goto_50

    :cond_99
    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-le v5, v9, :cond_aa

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    iget v5, v5, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mRightCenterZoneStart:F

    iget v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v6, v6, -0x1f

    int-to-float v6, v6

    mul-float/2addr v6, v2

    add-float v3, v5, v6

    goto :goto_50

    :cond_aa
    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-le v5, v8, :cond_bb

    iget-object v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    iget v5, v5, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->mLeftCenterZoneEnd:F

    iget v6, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v6, v6, -0x14

    int-to-float v6, v6

    mul-float/2addr v6, v2

    sub-float v3, v5, v6

    goto :goto_50

    :cond_bb
    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v5, v5, -0xa

    if-lez v5, :cond_ca

    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v5, v5, -0xa

    int-to-float v5, v5

    mul-float/2addr v5, v2

    sub-float v3, v4, v5

    goto :goto_50

    :cond_ca
    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-nez v5, :cond_d6

    div-float v5, v4, v7

    div-float v6, v2, v7

    sub-float v3, v5, v6

    goto/16 :goto_50

    :cond_d6
    iget v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    add-int/lit8 v5, v5, -0x1

    int-to-float v5, v5

    mul-float v3, v5, v2

    goto/16 :goto_50

    :cond_df
    invoke-virtual {p0, v3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setTranslationX(F)V

    invoke-virtual {p0, v0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setTranslationY(F)V

    goto/16 :goto_1d
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .registers 12

    const v8, 0x10000008

    const/4 v6, 0x0

    const/4 v5, 0x1

    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v4}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$900(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)Z

    move-result v4

    iget-boolean v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mTouch:Z

    if-ne v4, v7, :cond_38

    const/4 v4, 0x2

    new-array v3, v4, [I

    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-virtual {v4, v3}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->getLocationOnScreen([I)V

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v4

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1000(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v7

    sub-float v0, v4, v7

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v4

    aget v7, v3, v5

    int-to-float v7, v7

    sub-float v1, v4, v7

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->bringToFront()V

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v4

    and-int/lit16 v4, v4, 0xff

    packed-switch v4, :pswitch_data_c4

    :cond_38
    :goto_38
    return v5

    :pswitch_39  #0x1, 0x3
    invoke-direct {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->eventUp()V

    invoke-direct {p0, v8}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->vibrate(I)V

    goto :goto_38

    :pswitch_40  #0x0
    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getParent()Landroid/view/ViewParent;

    move-result-object v4

    invoke-interface {v4, v5}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    iput-boolean v5, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mTouch:Z

    const/high16 v4, 0x3f000000  # 0.5f

    invoke-virtual {p0, v4}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->setAlpha(F)V

    const/16 v4, 0x33

    iput v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getX()F

    move-result v4

    sub-float v4, v0, v4

    iput v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->rX:F

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->getY()F

    move-result v4

    sub-float v4, v1, v4

    iput v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->rY:F

    invoke-direct {p0, v8}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->vibrate(I)V

    goto :goto_38

    :pswitch_66  #0x2
    new-instance v2, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;

    const/4 v4, 0x0

    invoke-direct {v2, p0, v4}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;-><init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$1;)V

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->rX:F

    cmpl-float v4, v0, v4

    if-ltz v4, :cond_c2

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->rX:F

    sub-float v4, v0, v4

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1200(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v7

    iget-object v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v8}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1300(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v8

    sub-float/2addr v7, v8

    cmpg-float v4, v4, v7

    if-gtz v4, :cond_c2

    move v4, v5

    :goto_88
    iput-boolean v4, v2, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needX:Z

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->rX:F

    sub-float v4, v0, v4

    iput v4, v2, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->mX:F

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->rY:F

    cmpl-float v4, v1, v4

    if-ltz v4, :cond_ac

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->rY:F

    sub-float v4, v1, v4

    iget-object v7, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v7}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v7

    iget-object v8, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v8}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)F

    move-result v8

    sub-float/2addr v7, v8

    cmpg-float v4, v4, v7

    if-gtz v4, :cond_ac

    move v6, v5

    :cond_ac
    iput-boolean v6, v2, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needY:Z

    iget v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->rY:F

    sub-float v4, v1, v4

    iput v4, v2, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->mY:F

    iget-object v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCoordinate:Ljava/util/ArrayList;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-boolean v4, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mFlag:Z

    if-nez v4, :cond_38

    invoke-virtual {p0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveElement()V

    goto/16 :goto_38

    :cond_c2
    move v4, v6

    goto :goto_88

    :pswitch_data_c4
    .packed-switch 0x0
        :pswitch_40  #00000000
        :pswitch_39  #00000001
        :pswitch_66  #00000002
        :pswitch_39  #00000003
    .end packed-switch
.end method

.method public setPosition(I)V
    .registers 5

    const/4 v1, 0x1

    const/4 v2, 0x0

    iput p1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mPosition:I

    if-nez p1, :cond_15

    move v0, v1

    :goto_7
    iput-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCenterZone:Z

    iget-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->mCenterZone:Z

    if-nez v0, :cond_11

    const/16 v0, 0x14

    if-le p1, v0, :cond_12

    :cond_11
    move v2, v1

    :cond_12
    iput-boolean v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->isCenter:Z

    return-void

    :cond_15
    move v0, v2

    goto :goto_7
.end method
