# classes10.dex

.class public Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;
.super Landroidx/recyclerview/widget/RecyclerView$ViewHolder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x21
    name = "ViewHolder"
.end annotation


# instance fields
.field image1:Landroid/widget/ImageView;

.field image2:Landroid/widget/ImageView;

.field image3:Landroid/widget/ImageView;

.field image4:Landroid/widget/ImageView;

.field name:Landroid/widget/TextView;

.field private final this$0:Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;


# direct methods
.method public constructor <init>(Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;Landroid/view/View;)V
    .registers 7

    invoke-direct {p0, p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;-><init>(Landroid/view/View;)V

    iput-object p1, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->this$0:Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->this$0:Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;

    invoke-static {v0}, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;->access$0(Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;)Lmobx/settings/overlay/icon/signal/SignalIcons;

    move-result-object v0

    invoke-virtual {v0}, Lmobx/settings/overlay/icon/signal/SignalIcons;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->this$0:Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;

    invoke-static {v0}, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;->access$0(Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;)Lmobx/settings/overlay/icon/signal/SignalIcons;

    move-result-object v0

    invoke-virtual {v0}, Lmobx/settings/overlay/icon/signal/SignalIcons;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const-string/jumbo v0, "option_label"

    const-string v3, "id"

    invoke-virtual {v2, v0, v3, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->name:Landroid/widget/TextView;

    const-string v0, "image1"

    const-string v3, "id"

    invoke-virtual {v2, v0, v3, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->image1:Landroid/widget/ImageView;

    const-string v0, "image2"

    const-string v3, "id"

    invoke-virtual {v2, v0, v3, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->image2:Landroid/widget/ImageView;

    const-string v0, "image3"

    const-string v3, "id"

    invoke-virtual {v2, v0, v3, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->image3:Landroid/widget/ImageView;

    const-string v0, "image4"

    const-string v3, "id"

    invoke-virtual {v2, v0, v3, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->image4:Landroid/widget/ImageView;

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->name:Landroid/widget/TextView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setSelected(Z)V

    return-void
.end method

.method static access$0(Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;)Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;
    .registers 2

    iget-object v0, p0, Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter$ViewHolder;->this$0:Lmobx/settings/overlay/icon/signal/SignalIcons$Adapter;

    return-object v0
.end method
