# classes10.dex

.class public Landroidx/preference/ShapeSelect/ShapeUtil;
.super Ljava/lang/Object;
.source "ShapeUtil.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static combine(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;I)Landroid/graphics/drawable/LayerDrawable;
    .registers 7

    const/4 v3, 0x1

    new-instance v0, Landroid/graphics/drawable/LayerDrawable;

    const/4 v1, 0x2

    new-array v1, v1, [Landroid/graphics/drawable/Drawable;

    const/4 v2, 0x0

    aput-object p0, v1, v2

    aput-object p1, v1, v3

    invoke-direct {v0, v1}, Landroid/graphics/drawable/LayerDrawable;-><init>([Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, v3, p2}, Landroid/graphics/drawable/LayerDrawable;->setLayerGravity(II)V

    return-object v0
.end method

.method private static getCircle(FI)Landroid/graphics/Path;
    .registers 6

    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    int-to-float v1, p1

    add-float/2addr v1, p0

    int-to-float v2, p1

    add-float/2addr v2, p0

    sget-object v3, Landroid/graphics/Path$Direction;->CCW:Landroid/graphics/Path$Direction;

    invoke-virtual {v0, v1, v2, p0, v3}, Landroid/graphics/Path;->addCircle(FFFLandroid/graphics/Path$Direction;)V

    invoke-virtual {v0}, Landroid/graphics/Path;->close()V

    return-object v0
.end method

.method public static getPath(IFI)Landroid/graphics/Path;
    .registers 10

    const/4 v6, 0x4

    const/4 v0, 0x1

    const/4 v4, 0x0

    if-nez p0, :cond_d

    int-to-float v4, p2

    sub-float v4, p1, v4

    invoke-static {v4, p2}, Landroidx/preference/ShapeSelect/ShapeUtil;->getCircle(FI)Landroid/graphics/Path;

    move-result-object v4

    :goto_c
    return-object v4

    :cond_d
    if-eq p0, v6, :cond_13

    const/16 v5, 0x14

    if-ne p0, v5, :cond_1a

    :cond_13
    int-to-float v4, p2

    int-to-float v5, p2

    invoke-static {v4, v5, v6, p1}, Landroidx/preference/ShapeSelect/ShapeUtil;->getShape(FFIF)Landroid/graphics/Path;

    move-result-object v4

    goto :goto_c

    :cond_1a
    rem-int/lit8 v5, p0, 0x2

    if-nez v5, :cond_36

    move v1, v0

    :goto_1f
    const/16 v5, 0xa

    if-le p0, v5, :cond_38

    :goto_23
    if-eqz v1, :cond_3c

    if-eqz v0, :cond_3a

    int-to-float v2, p2

    :goto_28
    if-eqz v1, :cond_40

    if-eqz v0, :cond_3e

    move v3, p1

    :goto_2d
    if-eqz v0, :cond_31

    rem-int/lit8 p0, p0, 0xa

    :cond_31
    invoke-static {v2, v3, p0, p1}, Landroidx/preference/ShapeSelect/ShapeUtil;->getShape(FFIF)Landroid/graphics/Path;

    move-result-object v4

    goto :goto_c

    :cond_36
    move v1, v4

    goto :goto_1f

    :cond_38
    move v0, v4

    goto :goto_23

    :cond_3a
    move v2, p1

    goto :goto_28

    :cond_3c
    move v2, p1

    goto :goto_28

    :cond_3e
    int-to-float v3, p2

    goto :goto_2d

    :cond_40
    if-eqz v0, :cond_49

    const/high16 v4, 0x40000000  # 2.0f

    mul-float/2addr v4, p1

    int-to-float v5, p2

    sub-float v3, v4, v5

    goto :goto_2d

    :cond_49
    int-to-float v3, p2

    goto :goto_2d
.end method

.method private static getShape(FFIF)Landroid/graphics/Path;
    .registers 30

    new-instance v3, Landroid/graphics/Path;

    invoke-direct {v3}, Landroid/graphics/Path;-><init>()V

    move/from16 v0, p0

    move/from16 v1, p1

    invoke-virtual {v3, v0, v1}, Landroid/graphics/Path;->moveTo(FF)V

    move/from16 v0, p0

    float-to-double v0, v0

    move-wide/from16 v20, v0

    move/from16 v0, p3

    float-to-double v0, v0

    move-wide/from16 v22, v0

    sub-double v8, v20, v22

    move/from16 v0, p1

    float-to-double v0, v0

    move-wide/from16 v20, v0

    move/from16 v0, p3

    float-to-double v0, v0

    move-wide/from16 v22, v0

    sub-double v10, v20, v22

    const/4 v2, 0x1

    :goto_25
    move/from16 v0, p2

    if-ge v2, v0, :cond_8b

    const-wide/high16 v20, 0x3ff0000000000000L  # 1.0

    const-wide/high16 v22, -0x4010000000000000L  # -1.0

    invoke-static/range {v22 .. v23}, Ljava/lang/Math;->acos(D)D

    move-result-wide v22

    const-wide/high16 v24, 0x4000000000000000L  # 2.0

    mul-double v22, v22, v24

    move/from16 v0, p2

    int-to-double v0, v0

    move-wide/from16 v24, v0

    div-double v22, v22, v24

    invoke-static/range {v22 .. v23}, Ljava/lang/Math;->cos(D)D

    move-result-wide v22

    mul-double v4, v20, v22

    const-wide/high16 v20, 0x3ff0000000000000L  # 1.0

    const-wide/high16 v22, -0x4010000000000000L  # -1.0

    invoke-static/range {v22 .. v23}, Ljava/lang/Math;->acos(D)D

    move-result-wide v22

    const-wide/high16 v24, 0x4000000000000000L  # 2.0

    mul-double v22, v22, v24

    move/from16 v0, p2

    int-to-double v0, v0

    move-wide/from16 v24, v0

    div-double v22, v22, v24

    invoke-static/range {v22 .. v23}, Ljava/lang/Math;->sin(D)D

    move-result-wide v22

    mul-double v6, v20, v22

    mul-double v20, v8, v4

    mul-double v22, v10, v6

    sub-double v12, v20, v22

    mul-double v20, v8, v6

    mul-double v22, v10, v4

    add-double v14, v20, v22

    move-wide v8, v12

    move-wide v10, v14

    move/from16 v0, p3

    float-to-double v0, v0

    move-wide/from16 v20, v0

    add-double v16, v20, v8

    move/from16 v0, p3

    float-to-double v0, v0

    move-wide/from16 v20, v0

    add-double v18, v20, v10

    move-wide/from16 v0, v16

    double-to-float v0, v0

    move/from16 v20, v0

    move-wide/from16 v0, v18

    double-to-float v0, v0

    move/from16 v21, v0

    move/from16 v0, v20

    move/from16 v1, v21

    invoke-virtual {v3, v0, v1}, Landroid/graphics/Path;->lineTo(FF)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_25

    :cond_8b
    invoke-virtual {v3}, Landroid/graphics/Path;->close()V

    return-object v3
.end method
