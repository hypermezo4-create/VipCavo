# classes10.dex

.class public Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;
.super Landroid/graphics/drawable/Drawable;
.source "ColorPickerAlphaPatternDrawable.java"


# instance fields
.field private mBitmap:Landroid/graphics/Bitmap;

.field private mPaint:Landroid/graphics/Paint;

.field private mPaintGray:Landroid/graphics/Paint;

.field private mPaintWhite:Landroid/graphics/Paint;

.field private mRectangleSize:I

.field private numRectanglesHorizontal:I

.field private numRectanglesVertical:I


# direct methods
.method public constructor <init>(I)V
    .registers 4

    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    const/16 v0, 0xa

    iput v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mRectangleSize:I

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mPaintWhite:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mPaintGray:Landroid/graphics/Paint;

    iput p1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mRectangleSize:I

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mPaintWhite:Landroid/graphics/Paint;

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mPaintGray:Landroid/graphics/Paint;

    const v1, -0x343435

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    return-void
.end method

.method private generatePatternBitmap()V
    .registers 11

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v0

    if-lez v0, :cond_7a

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    if-gtz v0, :cond_15

    goto :goto_7a

    :cond_15
    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v0

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v1

    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mBitmap:Landroid/graphics/Bitmap;

    new-instance v0, Landroid/graphics/Canvas;

    iget-object v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mBitmap:Landroid/graphics/Bitmap;

    invoke-direct {v0, v1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    const/4 v2, 0x1

    const/4 v3, 0x0

    :goto_3b
    iget v4, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->numRectanglesVertical:I

    if-gt v3, v4, :cond_76

    move v4, v2

    const/4 v5, 0x0

    :goto_41
    iget v6, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->numRectanglesHorizontal:I

    const/4 v7, 0x0

    const/4 v8, 0x1

    if-gt v5, v6, :cond_6f

    iget v6, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mRectangleSize:I

    mul-int v9, v3, v6

    iput v9, v1, Landroid/graphics/Rect;->top:I

    mul-int/2addr v6, v5

    iput v6, v1, Landroid/graphics/Rect;->left:I

    iget v6, v1, Landroid/graphics/Rect;->top:I

    iget v9, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mRectangleSize:I

    add-int/2addr v6, v9

    iput v6, v1, Landroid/graphics/Rect;->bottom:I

    iget v6, v1, Landroid/graphics/Rect;->left:I

    iget v9, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mRectangleSize:I

    add-int/2addr v6, v9

    iput v6, v1, Landroid/graphics/Rect;->right:I

    if-eqz v4, :cond_63

    iget-object v6, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mPaintWhite:Landroid/graphics/Paint;

    goto :goto_65

    :cond_63
    iget-object v6, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mPaintGray:Landroid/graphics/Paint;

    :goto_65
    invoke-virtual {v0, v1, v6}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    if-nez v4, :cond_6b

    move v7, v8

    :cond_6b
    move v4, v7

    add-int/lit8 v5, v5, 0x1

    goto :goto_41

    :cond_6f
    if-nez v2, :cond_72

    move v7, v8

    :cond_72
    move v2, v7

    add-int/lit8 v3, v3, 0x1

    goto :goto_3b

    :cond_76
    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->setRoundedCornerBitmap()V

    return-void

    :cond_7a
    :goto_7a
    return-void
.end method

.method private setRoundedCornerBitmap()V
    .registers 8

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iget-object v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    new-instance v1, Landroid/graphics/Canvas;

    invoke-direct {v1, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    new-instance v2, Landroid/graphics/Paint;

    invoke-direct {v2}, Landroid/graphics/Paint;-><init>()V

    new-instance v3, Landroid/graphics/Rect;

    iget-object v4, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v4}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v4

    iget-object v5, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    const/4 v6, 0x0

    invoke-direct {v3, v6, v6, v4, v5}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v4, Landroid/graphics/RectF;

    invoke-direct {v4, v3}, Landroid/graphics/RectF;-><init>(Landroid/graphics/Rect;)V

    const/4 v5, 0x1

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    invoke-virtual {v1, v6, v6, v6, v6}, Landroid/graphics/Canvas;->drawARGB(IIII)V

    const/high16 v5, 0x41c80000  # 25.0f

    invoke-virtual {v1, v4, v5, v5, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    new-instance v5, Landroid/graphics/PorterDuffXfermode;

    sget-object v6, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v5, v6}, Landroid/graphics/PorterDuffXfermode;-><init>(Landroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setXfermode(Landroid/graphics/Xfermode;)Landroid/graphics/Xfermode;

    iget-object v5, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v1, v5, v3, v3, v2}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    iput-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mBitmap:Landroid/graphics/Bitmap;

    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .registers 6

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    iget-object v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mPaint:Landroid/graphics/Paint;

    const/4 v3, 0x0

    invoke-virtual {p1, v0, v3, v1, v2}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    return-void
.end method

.method public getOpacity()I
    .registers 2

    const/4 v0, 0x0

    return v0
.end method

.method protected onBoundsChange(Landroid/graphics/Rect;)V
    .registers 6

    invoke-super {p0, p1}, Landroid/graphics/drawable/Drawable;->onBoundsChange(Landroid/graphics/Rect;)V

    invoke-virtual {p1}, Landroid/graphics/Rect;->height()I

    move-result v0

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result v1

    iget v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mRectangleSize:I

    div-int v2, v1, v2

    int-to-double v2, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v2

    double-to-int v2, v2

    iput v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->numRectanglesHorizontal:I

    iget v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->mRectangleSize:I

    div-int v2, v0, v2

    int-to-double v2, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v2

    double-to-int v2, v2

    iput v2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->numRectanglesVertical:I

    invoke-direct {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerAlphaPatternDrawable;->generatePatternBitmap()V

    return-void
.end method

.method public setAlpha(I)V
    .registers 4

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Alpha is not supported by this drawwable."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .registers 4

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "ColorFilter is not supported by this drawwable."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
