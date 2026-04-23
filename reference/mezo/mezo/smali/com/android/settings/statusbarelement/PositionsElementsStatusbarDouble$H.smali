# classes10.dex

.class Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "H"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;


# direct methods
.method private constructor <init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)V
    .registers 2

    iput-object p1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$1;)V
    .registers 3

    invoke-direct {p0, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;-><init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .registers 3

    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_12

    :goto_5
    return-void

    :pswitch_6  #0x64
    iget-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$2800(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)V

    goto :goto_5

    :pswitch_c  #0x65
    iget-object v0, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$H;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v0}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$1800(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)V

    goto :goto_5

    :pswitch_data_12
    .packed-switch 0x64
        :pswitch_6  #00000064
        :pswitch_c  #00000065
    .end packed-switch
.end method
