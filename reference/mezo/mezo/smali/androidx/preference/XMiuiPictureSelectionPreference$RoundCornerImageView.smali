# classes10.dex

.class Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;
.super Landroid/widget/ImageView;
.source "XMiuiPictureSelectionPreference.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preference/XMiuiPictureSelectionPreference;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "RoundCornerImageView"
.end annotation


# instance fields
.field private final mPath:Landroid/graphics/Path;

.field private mRadius:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    iput-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->mPath:Landroid/graphics/Path;

    const/16 v0, 0x2d

    iput v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->mRadius:I

    return-void
.end method


# virtual methods
.method public onDraw(Landroid/graphics/Canvas;)V
    .registers 10

    const/4 v1, 0x0

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    iget-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->mPath:Landroid/graphics/Path;

    invoke-virtual {v0}, Landroid/graphics/Path;->reset()V

    iget v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->mRadius:I

    int-to-float v5, v0

    iget-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->mPath:Landroid/graphics/Path;

    invoke-virtual {p0}, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->getMeasuredWidth()I

    move-result v2

    int-to-float v3, v2

    invoke-virtual {p0}, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->getMeasuredHeight()I

    move-result v2

    int-to-float v4, v2

    sget-object v7, Landroid/graphics/Path$Direction;->CW:Landroid/graphics/Path$Direction;

    move v2, v1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Path;->addRoundRect(FFFFFFLandroid/graphics/Path$Direction;)V

    iget-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->mPath:Landroid/graphics/Path;

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->clipPath(Landroid/graphics/Path;)Z

    invoke-super {p0, p1}, Landroid/widget/ImageView;->onDraw(Landroid/graphics/Canvas;)V

    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    return-void
.end method

.method public setRadius(I)Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;
    .registers 2

    iput p1, p0, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->mRadius:I

    return-object p0
.end method
