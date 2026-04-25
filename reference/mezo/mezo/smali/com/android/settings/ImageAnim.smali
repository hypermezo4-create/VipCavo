# classes2.dex

.class public Lcom/android/settings/ImageAnim;
.super Landroid/widget/ImageView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 7

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 10

    invoke-direct {p0, p1, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-virtual {p0}, Lcom/android/settings/ImageAnim;->isInEditMode()Z

    move-result v0

    if-nez v0, :cond_c

    invoke-direct {p0}, Lcom/android/settings/ImageAnim;->ImageGoyang()V

    :cond_c
    return-void
.end method

.method private ImageGoyang()V
    .registers 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    move-object v0, p0

    move-object v4, v0

    invoke-virtual {v4}, Lcom/android/settings/ImageAnim;->getContext()Landroid/content/Context;

    move-result-object v4

    move-object v5, v0

    const-string v6, "logo_mode"

    const-string v7, "anim"

    invoke-virtual {v5, v6, v7}, Lcom/android/settings/ImageAnim;->getID(Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-static {v4, v5}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v4

    move-object v2, v4

    move-object v4, v2

    const/16 v5, 0x708

    int-to-long v5, v5

    invoke-virtual {v4, v5, v6}, Landroid/view/animation/Animation;->setDuration(J)V

    move-object v4, v0

    move-object v5, v2

    invoke-virtual {v4, v5}, Lcom/android/settings/ImageAnim;->startAnimation(Landroid/view/animation/Animation;)V

    return-void
.end method


# virtual methods
.method public getID(Ljava/lang/String;Ljava/lang/String;)I
    .registers 11

    invoke-virtual {p0}, Lcom/android/settings/ImageAnim;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Lcom/android/settings/ImageAnim;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, p2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method
