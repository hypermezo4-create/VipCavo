# classes10.dex

.class public Lcom/xdroid/additional/WallpaperView;
.super Landroid/widget/ImageView;


# instance fields
.field context:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/xdroid/additional/WallpaperView;->context:Landroid/content/Context;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object p1, p0, Lcom/xdroid/additional/WallpaperView;->context:Landroid/content/Context;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 4

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    iput-object p1, p0, Lcom/xdroid/additional/WallpaperView;->context:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method protected onSizeChanged(IIII)V
    .registers 5

    goto/32 :goto_1b

    nop

    :goto_4
    invoke-virtual {p1}, Landroid/app/WallpaperManager;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    goto/32 :goto_14

    nop

    :goto_c
    invoke-static {p1}, Landroid/app/WallpaperManager;->getInstance(Landroid/content/Context;)Landroid/app/WallpaperManager;

    move-result-object p1

    goto/32 :goto_4

    nop

    :goto_14
    invoke-virtual {p0, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto/32 :goto_28

    nop

    :goto_1b
    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/ImageView;->onSizeChanged(IIII)V

    goto/32 :goto_22

    nop

    :goto_22
    iget-object p1, p0, Lcom/xdroid/additional/WallpaperView;->context:Landroid/content/Context;

    goto/32 :goto_c

    nop

    :goto_28
    return-void
.end method
