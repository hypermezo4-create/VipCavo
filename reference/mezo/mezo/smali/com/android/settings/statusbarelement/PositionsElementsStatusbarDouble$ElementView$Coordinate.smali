# classes10.dex

.class Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "Coordinate"
.end annotation


# instance fields
.field mX:F

.field mY:F

.field needX:Z

.field needY:Z

.field final synthetic this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;


# direct methods
.method private constructor <init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)V
    .registers 3

    const/4 v0, 0x1

    iput-object p1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needX:Z

    iput-boolean v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;->needY:Z

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$1;)V
    .registers 3

    invoke-direct {p0, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;-><init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)V

    return-void
.end method
