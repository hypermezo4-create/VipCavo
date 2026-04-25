# classes10.dex

.class public Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;
.super Landroidx/recyclerview/widget/RecyclerView$Adapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmobx/settings/overlay/icon/battery/BatteryIcons;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x21
    name = "Adapter"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;,
        Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$100000000;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/RecyclerView$Adapter",
        "<",
        "Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;",
        ">;"
    }
.end annotation


# instance fields
.field private final this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

.field xAppliedPackage:Ljava/lang/String;

.field xContext:Landroid/content/Context;

.field xSelectedPackage:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lmobx/settings/overlay/icon/battery/BatteryIcons;Landroid/content/Context;)V
    .registers 3

    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$Adapter;-><init>()V

    iput-object p1, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    iput-object p2, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->xContext:Landroid/content/Context;

    return-void
.end method

.method static access$0(Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;)Lmobx/settings/overlay/icon/battery/BatteryIcons;
    .registers 2

    iget-object v0, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    return-object v0
.end method

.method private setClickAnimation(Landroid/view/View;)V
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            ")V"
        }
    .end annotation

    const/4 v1, 0x0

    const/4 v0, 0x1

    new-array v0, v0, [Landroid/view/View;

    aput-object p1, v0, v1

    invoke-static {v0}, Lmiuix/animation/Folme;->useAt([Landroid/view/View;)Lmiuix/animation/IFolme;

    move-result-object v0

    invoke-interface {v0}, Lmiuix/animation/IFolme;->touch()Lmiuix/animation/ITouchStyle;

    move-result-object v0

    invoke-interface {v0}, Lmiuix/animation/ITouchStyle;->clearTintColor()Lmiuix/animation/ITouchStyle;

    move-result-object v0

    new-array v1, v1, [Lmiuix/animation/base/AnimConfig;

    invoke-interface {v0, p1, v1}, Lmiuix/animation/ITouchStyle;->handleTouchOf(Landroid/view/View;[Lmiuix/animation/base/AnimConfig;)V

    return-void
.end method


# virtual methods
.method public getItemCount()I
    .registers 2

    iget-object v0, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    invoke-static {v0}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->access$L1000001(Lmobx/settings/overlay/icon/battery/BatteryIcons;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public bridge onBindViewHolder(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V
    .registers 3

    check-cast p1, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;

    invoke-virtual {p0, p1, p2}, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->onBindViewHolder(Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;I)V

    return-void
.end method

.method public onBindViewHolder(Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;I)V
    .registers 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;",
            "I)V"
        }
    .end annotation

    iget-object v0, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    invoke-static {v0}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->access$L1000001(Lmobx/settings/overlay/icon/battery/BatteryIcons;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v1, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    invoke-static {v1}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->access$L1000003(Lmobx/settings/overlay/icon/battery/BatteryIcons;)Lmobx/settings/overlay/icon/ThemeUtils;

    move-result-object v1

    iget-object v2, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    invoke-static {v2}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->access$L1000000(Lmobx/settings/overlay/icon/battery/BatteryIcons;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lmobx/settings/overlay/icon/ThemeUtils;->getOverlayInfos(Ljava/lang/String;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->stream()Ljava/util/stream/Stream;

    move-result-object v1

    sget-object v2, Lmobx/settings/overlay/icon/battery/BatteryIcons$Predicate;->INSTANCE:Lmobx/settings/overlay/icon/battery/BatteryIcons$Predicate;

    invoke-interface {v1, v2}, Ljava/util/stream/Stream;->filter(Ljava/util/function/Predicate;)Ljava/util/stream/Stream;

    move-result-object v1

    sget-object v2, Lmobx/settings/overlay/icon/battery/BatteryIcons$Function;->INSTANCE:Lmobx/settings/overlay/icon/battery/BatteryIcons$Function;

    invoke-interface {v1, v2}, Ljava/util/stream/Stream;->map(Ljava/util/function/Function;)Ljava/util/stream/Stream;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/stream/Stream;->findFirst()Ljava/util/Optional;

    move-result-object v1

    const-string v2, "com.android.systemui"

    invoke-virtual {v1, v2}, Ljava/util/Optional;->orElse(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v2, p1, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;->image1:Landroid/widget/ImageView;

    iget-object v3, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    iget-object v4, p1, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;->image1:Landroid/widget/ImageView;

    invoke-virtual {v4}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v4

    const-string/jumbo v5, "battery_style"

    invoke-virtual {v3, v4, v0, v5}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->getDrawable(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v3, p1, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;->name:Landroid/widget/TextView;

    const-string v2, "com.android.systemui"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_83

    const-string v2, "Default"

    :goto_58
    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_69

    iput-object v0, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->xAppliedPackage:Ljava/lang/String;

    iget-object v1, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->xSelectedPackage:Ljava/lang/String;

    if-nez v1, :cond_69

    iput-object v0, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->xSelectedPackage:Ljava/lang/String;

    :cond_69
    iget-object v2, p1, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->itemView:Landroid/view/View;

    iget-object v1, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->xSelectedPackage:Ljava/lang/String;

    if-eq v0, v1, :cond_90

    const/4 v1, 0x0

    :goto_70
    invoke-virtual {v2, v1}, Landroid/view/View;->setActivated(Z)V

    iget-object v1, p1, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->itemView:Landroid/view/View;

    invoke-direct {p0, v1}, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->setClickAnimation(Landroid/view/View;)V

    iget-object v1, p1, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->itemView:Landroid/view/View;

    new-instance v2, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$100000000;

    invoke-direct {v2, p0, v0, p2}, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$100000000;-><init>(Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;Ljava/lang/String;I)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void

    :cond_83
    iget-object v2, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    iget-object v4, p1, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;->name:Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v2, v4, v0}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->getLabel(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_58

    :cond_90
    const/4 v1, 0x1

    goto :goto_70
.end method

.method public bridge onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .registers 4

    invoke-virtual {p0, p1, p2}, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->onCreateViewHolder(Landroid/view/ViewGroup;I)Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;

    move-result-object v0

    return-object v0
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;
    .registers 9

    iget-object v0, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    invoke-virtual {v0}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    invoke-virtual {v1}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    new-instance v2, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v3

    const-string/jumbo v4, "icon_option_battery"

    const-string v5, "layout"

    invoke-virtual {v1, v4, v5, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {v3, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    invoke-direct {v2, p0, v0}, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter$ViewHolder;-><init>(Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;Landroid/view/View;)V

    return-object v2
.end method

.method public updateActivatedStatus(Ljava/lang/String;Z)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Z)V"
        }
    .end annotation

    iget-object v0, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    invoke-static {v0}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->access$L1000001(Lmobx/settings/overlay/icon/battery/BatteryIcons;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    if-ltz v0, :cond_1f

    iget-object v1, p0, Lmobx/settings/overlay/icon/battery/BatteryIcons$Adapter;->this$0:Lmobx/settings/overlay/icon/battery/BatteryIcons;

    invoke-static {v1}, Lmobx/settings/overlay/icon/battery/BatteryIcons;->access$L1000002(Lmobx/settings/overlay/icon/battery/BatteryIcons;)Landroidx/recyclerview/widget/RecyclerView;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/recyclerview/widget/RecyclerView;->findViewHolderForAdapterPosition(I)Landroidx/recyclerview/widget/RecyclerView$ViewHolder;

    move-result-object v0

    if-eqz v0, :cond_1f

    iget-object v0, v0, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->itemView:Landroid/view/View;

    if-eqz v0, :cond_1f

    invoke-virtual {v0, p2}, Landroid/view/View;->setActivated(Z)V

    :cond_1f
    return-void
.end method
