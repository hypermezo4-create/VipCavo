# classes10.dex

.class public Lcom/xdroid/additional/BlurWallpaperView;
.super Landroid/widget/ImageView;


# instance fields
.field context:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/xdroid/additional/BlurWallpaperView;->context:Landroid/content/Context;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object p1, p0, Lcom/xdroid/additional/BlurWallpaperView;->context:Landroid/content/Context;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 4

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    iput-object p1, p0, Lcom/xdroid/additional/BlurWallpaperView;->context:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method protected onSizeChanged(IIII)V
    .registers 7

    goto/32 :goto_4

    nop

    :goto_4
    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/ImageView;->onSizeChanged(IIII)V

    goto/32 :goto_22

    nop

    :goto_b
    invoke-virtual {p1}, Landroid/app/WallpaperManager;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    goto/32 :goto_3d

    nop

    :goto_13
    invoke-static {v0, v0, v1}, Landroid/graphics/RenderEffect;->createBlurEffect(FFLandroid/graphics/Shader$TileMode;)Landroid/graphics/RenderEffect;

    move-result-object v0

    goto/32 :goto_1b

    nop

    :goto_1b
    invoke-virtual {p0, v0}, Landroid/widget/ImageView;->setRenderEffect(Landroid/graphics/RenderEffect;)V

    goto/32 :goto_28

    nop

    :goto_22
    iget-object p1, p0, Lcom/xdroid/additional/BlurWallpaperView;->context:Landroid/content/Context;

    goto/32 :goto_2f

    nop

    :goto_28
    return-void

    :goto_29
    const/high16 v0, 0x420c0000  # 35.0f

    goto/32 :goto_37

    nop

    :goto_2f
    invoke-static {p1}, Landroid/app/WallpaperManager;->getInstance(Landroid/content/Context;)Landroid/app/WallpaperManager;

    move-result-object p1

    goto/32 :goto_b

    nop

    :goto_37
    sget-object v1, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    goto/32 :goto_13

    nop

    :goto_3d
    invoke-virtual {p0, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto/32 :goto_29

    nop
.end method
