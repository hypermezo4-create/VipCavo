# classes10.dex

.class public Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter$ViewHolder;
.super Landroidx/recyclerview/widget/RecyclerView$ViewHolder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x21
    name = "ViewHolder"
.end annotation


# instance fields
.field image1:Landroid/widget/ImageView;

.field name:Landroid/widget/TextView;

.field private final this$0:Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;


# direct methods
.method public constructor <init>(Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;Landroid/view/View;)V
    .registers 7

    invoke-direct {p0, p2}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;-><init>(Landroid/view/View;)V

    iput-object p1, p0, Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter$ViewHolder;->this$0:Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;

    iget-object v0, p0, Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter$ViewHolder;->this$0:Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;

    invoke-static {v0}, Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;->access$0(Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;)Lmobx/settings/overlay/icon/vowifi/VowifiIcons;

    move-result-object v0

    invoke-virtual {v0}, Lmobx/settings/overlay/icon/vowifi/VowifiIcons;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    iget-object v0, p0, Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter$ViewHolder;->this$0:Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;

    invoke-static {v0}, Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;->access$0(Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;)Lmobx/settings/overlay/icon/vowifi/VowifiIcons;

    move-result-object v0

    invoke-virtual {v0}, Lmobx/settings/overlay/icon/vowifi/VowifiIcons;->getContext()Landroid/content/Context;

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

    iput-object v0, p0, Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter$ViewHolder;->name:Landroid/widget/TextView;

    const-string v0, "image1"

    const-string v3, "id"

    invoke-virtual {v2, v0, v3, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter$ViewHolder;->image1:Landroid/widget/ImageView;

    iget-object v0, p0, Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter$ViewHolder;->name:Landroid/widget/TextView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setSelected(Z)V

    return-void
.end method

.method static access$0(Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter$ViewHolder;)Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;
    .registers 2

    iget-object v0, p0, Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter$ViewHolder;->this$0:Lmobx/settings/overlay/icon/vowifi/VowifiIcons$Adapter;

    return-object v0
.end method
