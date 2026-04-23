# classes10.dex

.class Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;
.super Landroid/widget/LinearLayout;
.source "SwitchPanel.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preference/ShapeSelect/SwitchPanel;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ScreemIndicator"
.end annotation


# instance fields
.field private mList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/ImageView;",
            ">;"
        }
    .end annotation
.end field

.field private size:I

.field final synthetic this$0:Landroidx/preference/ShapeSelect/SwitchPanel;


# direct methods
.method public constructor <init>(Landroidx/preference/ShapeSelect/SwitchPanel;Landroid/content/Context;)V
    .registers 4

    iput-object p1, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-direct {p0, p2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/16 v0, 0x1e

    iput v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->size:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->init()V

    return-void
.end method

.method private getCircle()Landroid/graphics/drawable/Drawable;
    .registers 5

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "screen_indicator"

    invoke-static {v2, v3}, Landroid/Utils/Utils;->DrawableToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method private init()V
    .registers 2

    const-string v0, "screen_indicator"

    invoke-virtual {p0, v0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->setContentDescription(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->setOrientation(I)V

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->bringToFront()V

    return-void
.end method


# virtual methods
.method public hasOverlappingRendering()Z
    .registers 2

    const/4 v0, 0x0

    return v0
.end method

.method moveLeft()V
    .registers 9

    const-wide/16 v6, 0x12c

    const/high16 v5, 0x3f800000  # 1.0f

    const v4, 0x3e99999a  # 0.3f

    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    iget-object v3, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-static {v3}, Landroidx/preference/ShapeSelect/SwitchPanel;->access$100(Landroidx/preference/ShapeSelect/SwitchPanel;)I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v6, v7}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v5}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v4}, Landroid/view/ViewPropertyAnimator;->alphaBy(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    new-instance v3, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$1;

    invoke-direct {v3, p0, v0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$1;-><init>(Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;Landroid/view/View;)V

    invoke-virtual {v2, v3}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/ViewPropertyAnimator;->start()V

    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    iget-object v3, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-static {v3}, Landroidx/preference/ShapeSelect/SwitchPanel;->access$100(Landroidx/preference/ShapeSelect/SwitchPanel;)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v6, v7}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v4}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v5}, Landroid/view/ViewPropertyAnimator;->alphaBy(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    new-instance v3, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$2;

    invoke-direct {v3, p0, v1}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$2;-><init>(Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;Landroid/view/View;)V

    invoke-virtual {v2, v3}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/ViewPropertyAnimator;->start()V

    return-void
.end method

.method moveRight()V
    .registers 9

    const-wide/16 v6, 0x12c

    const/high16 v5, 0x3f800000  # 1.0f

    const v4, 0x3e99999a  # 0.3f

    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    iget-object v3, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-static {v3}, Landroidx/preference/ShapeSelect/SwitchPanel;->access$100(Landroidx/preference/ShapeSelect/SwitchPanel;)I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v6, v7}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v5}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v4}, Landroid/view/ViewPropertyAnimator;->alphaBy(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    new-instance v3, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$3;

    invoke-direct {v3, p0, v0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$3;-><init>(Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;Landroid/view/View;)V

    invoke-virtual {v2, v3}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/ViewPropertyAnimator;->start()V

    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    iget-object v3, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-static {v3}, Landroidx/preference/ShapeSelect/SwitchPanel;->access$100(Landroidx/preference/ShapeSelect/SwitchPanel;)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v6, v7}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v4}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v5}, Landroid/view/ViewPropertyAnimator;->alphaBy(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    new-instance v3, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$4;

    invoke-direct {v3, p0, v1}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator$4;-><init>(Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;Landroid/view/View;)V

    invoke-virtual {v2, v3}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/ViewPropertyAnimator;->start()V

    return-void
.end method

.method updateScreenCount()V
    .registers 6

    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    iget-object v3, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-static {v3}, Landroidx/preference/ShapeSelect/SwitchPanel;->access$000(Landroidx/preference/ShapeSelect/SwitchPanel;)Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-eq v2, v3, :cond_48

    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    :goto_18
    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-static {v2}, Landroidx/preference/ShapeSelect/SwitchPanel;->access$000(Landroidx/preference/ShapeSelect/SwitchPanel;)Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v0, v2, :cond_48

    new-instance v1, Landroid/widget/ImageView;

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->getCircle()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    iget v3, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->size:I

    iget v4, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->size:I

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v1, v2}, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_18

    :cond_48
    const/4 v0, 0x0

    :goto_49
    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v0, v2, :cond_78

    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->this$0:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-static {v2}, Landroidx/preference/ShapeSelect/SwitchPanel;->access$100(Landroidx/preference/ShapeSelect/SwitchPanel;)I

    move-result v2

    if-ne v0, v2, :cond_69

    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    const/high16 v3, 0x3f800000  # 1.0f

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setAlpha(F)V

    :goto_66
    add-int/lit8 v0, v0, 0x1

    goto :goto_49

    :cond_69
    iget-object v2, p0, Landroidx/preference/ShapeSelect/SwitchPanel$ScreemIndicator;->mList:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    const v3, 0x3e99999a  # 0.3f

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setAlpha(F)V

    goto :goto_66

    :cond_78
    return-void
.end method
