# classes10.dex

.class Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ElementHadler"
.end annotation


# instance fields
.field final synthetic this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;


# direct methods
.method private constructor <init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)V
    .registers 2

    iput-object p1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$1;)V
    .registers 3

    invoke-direct {p0, p1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;-><init>(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .registers 8

    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_60

    :cond_5
    :goto_5
    return-void

    :pswitch_6  #0xc8
    iget-object v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;

    invoke-static {v2, v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$2400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$Coordinate;)V

    goto :goto_5

    :pswitch_10  #0xc9
    iget-object v2, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {v2, v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveToPosition(Z)V

    goto :goto_5

    :pswitch_1e  #0xca
    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$2500(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)V

    goto :goto_5

    :pswitch_24  #0xcb
    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$400(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Z

    move-result v1

    if-eqz v1, :cond_3a

    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$2600(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;)Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;

    move-result-object v1

    const/16 v2, 0xcb

    const-wide/16 v4, 0x64

    invoke-virtual {v1, v2, v4, v5}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->sendEmptyMessageDelayed(IJ)Z

    goto :goto_5

    :cond_3a
    iget-object v1, p0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView$ElementHadler;->this$1:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    iget-object v1, v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->this$0:Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;

    invoke-static {v1}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;->access$2700(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_46
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->access$502(Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;Z)Z

    goto :goto_46

    :pswitch_57  #0xcc
    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/android/settings/statusbarelement/PositionsElementsStatusbarDouble$ElementView;->moveToPosition(Z)V

    goto :goto_5

    :pswitch_data_60
    .packed-switch 0xc8
        :pswitch_6  #000000c8
        :pswitch_10  #000000c9
        :pswitch_1e  #000000ca
        :pswitch_24  #000000cb
        :pswitch_57  #000000cc
    .end packed-switch
.end method
