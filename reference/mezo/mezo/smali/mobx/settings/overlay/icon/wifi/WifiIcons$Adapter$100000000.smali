# classes10.dex

.class Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000000"
.end annotation


# instance fields
.field private final this$0:Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;

.field private final val$i:I

.field private final val$str:Ljava/lang/String;


# direct methods
.method constructor <init>(Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;Ljava/lang/String;I)V
    .registers 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->this$0:Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;

    iput-object p2, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->val$str:Ljava/lang/String;

    iput p3, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->val$i:I

    return-void
.end method

.method static access$0(Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;)Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;
    .registers 2

    iget-object v0, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->this$0:Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            ")V"
        }
    .end annotation

    iget-object v0, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->this$0:Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;

    iget-object v1, v0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;->xSelectedPackage:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;->updateActivatedStatus(Ljava/lang/String;Z)V

    iget-object v0, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->this$0:Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;

    iget-object v1, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->val$str:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;->updateActivatedStatus(Ljava/lang/String;Z)V

    iget-object v0, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->this$0:Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;

    iget-object v1, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->val$str:Ljava/lang/String;

    iput-object v1, v0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;->xSelectedPackage:Ljava/lang/String;

    iget-object v0, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->this$0:Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;

    invoke-static {v0}, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;->access$0(Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter;)Lmobx/settings/overlay/icon/wifi/WifiIcons;

    move-result-object v0

    iget v1, p0, Lmobx/settings/overlay/icon/wifi/WifiIcons$Adapter$100000000;->val$i:I

    invoke-virtual {v0, v1}, Lmobx/settings/overlay/icon/wifi/WifiIcons;->enableOverlays(I)V

    return-void
.end method
