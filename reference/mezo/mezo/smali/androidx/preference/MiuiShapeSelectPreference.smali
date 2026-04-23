# classes10.dex

.class public Landroidx/preference/MiuiShapeSelectPreference;
.super Landroidx/preference/Preference;
.source "MiuiShapeSelectPreference.java"


# instance fields
.field private final Helper:Landroidx/preference/MiuiPreferenceHelper;

.field private final isTile:Z

.field private mDensity:F

.field private mSelect:Landroidx/preference/ShapeSelect/ShapeSelect;

.field private mView:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 6

    invoke-direct {p0, p1, p2}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance v0, Landroidx/preference/MiuiPreferenceHelper;

    invoke-direct {v0, p1, p2}, Landroidx/preference/MiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference;->Helper:Landroidx/preference/MiuiPreferenceHelper;

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference;->Helper:Landroidx/preference/MiuiPreferenceHelper;

    const-string v1, "tile"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroidx/preference/MiuiPreferenceHelper;->getAttributeBool(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/MiuiShapeSelectPreference;->isTile:Z

    invoke-direct {p0}, Landroidx/preference/MiuiShapeSelectPreference;->init()V

    return-void
.end method

.method static synthetic access$000(Landroidx/preference/MiuiShapeSelectPreference;)Landroidx/preference/ShapeSelect/ShapeSelect;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference;->mSelect:Landroidx/preference/ShapeSelect/ShapeSelect;

    return-object v0
.end method

.method static synthetic access$002(Landroidx/preference/MiuiShapeSelectPreference;Landroidx/preference/ShapeSelect/ShapeSelect;)Landroidx/preference/ShapeSelect/ShapeSelect;
    .registers 2

    iput-object p1, p0, Landroidx/preference/MiuiShapeSelectPreference;->mSelect:Landroidx/preference/ShapeSelect/ShapeSelect;

    return-object p1
.end method

.method static synthetic access$100(Landroidx/preference/MiuiShapeSelectPreference;)Landroidx/preference/MiuiPreferenceHelper;
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference;->Helper:Landroidx/preference/MiuiPreferenceHelper;

    return-object v0
.end method

.method static synthetic access$200(Landroidx/preference/MiuiShapeSelectPreference;)V
    .registers 1

    invoke-direct {p0}, Landroidx/preference/MiuiShapeSelectPreference;->setPreview()V

    return-void
.end method

.method static synthetic access$300(Landroidx/preference/MiuiShapeSelectPreference;)Z
    .registers 2

    iget-boolean v0, p0, Landroidx/preference/MiuiShapeSelectPreference;->isTile:Z

    return v0
.end method

.method private getPreviewBitmap()Landroid/graphics/Bitmap;
    .registers 15

    const/4 v9, 0x0

    iget-object v10, p0, Landroidx/preference/MiuiShapeSelectPreference;->Helper:Landroidx/preference/MiuiPreferenceHelper;

    invoke-virtual {v10}, Landroidx/preference/MiuiPreferenceHelper;->getInt()I

    move-result v2

    invoke-virtual {p0}, Landroidx/preference/MiuiShapeSelectPreference;->getContext()Landroid/content/Context;

    move-result-object v10

    invoke-virtual {v10}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v10

    invoke-virtual {p0}, Landroidx/preference/MiuiShapeSelectPreference;->getContext()Landroid/content/Context;

    move-result-object v11

    const-string v12, "no_shape"

    invoke-static {v11, v12}, Landroid/Utils/Utils;->DrawableToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v11

    invoke-static {v10, v11}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v8

    const/4 v10, -0x1

    if-ne v2, v10, :cond_22

    move-object v9, v8

    :goto_21
    return-object v9

    :cond_22
    invoke-virtual {v8}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    const/4 v7, 0x5

    invoke-virtual {p0}, Landroidx/preference/MiuiShapeSelectPreference;->getContext()Landroid/content/Context;

    move-result-object v10

    invoke-virtual {p0}, Landroidx/preference/MiuiShapeSelectPreference;->getContext()Landroid/content/Context;

    move-result-object v11

    const-string v12, "button_position_back"

    invoke-static {v11, v12}, Landroid/Utils/Utils;->ColorToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v11

    invoke-virtual {v10, v11}, Landroid/content/Context;->getColor(I)I

    move-result v6

    :try_start_39
    sget-object v10, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v1, v1, v10}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v8

    new-instance v0, Landroid/graphics/Canvas;

    invoke-direct {v0, v8}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    invoke-virtual {v0, v10, v11, v12, v13}, Landroid/graphics/Canvas;->drawARGB(IIII)V

    div-int/lit8 v10, v1, 0x2

    int-to-float v10, v10

    const/4 v11, 0x2

    invoke-static {v2, v10, v11}, Landroidx/preference/ShapeSelect/ShapeUtil;->getPath(IFI)Landroid/graphics/Path;

    move-result-object v5

    new-instance v4, Landroid/graphics/Paint;

    invoke-direct {v4}, Landroid/graphics/Paint;-><init>()V

    const/16 v10, 0x14

    if-ne v2, v10, :cond_7f

    const/4 v10, 0x1

    invoke-virtual {v4, v10}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    new-instance v10, Landroid/graphics/CornerPathEffect;

    invoke-virtual {p0}, Landroidx/preference/MiuiShapeSelectPreference;->getContext()Landroid/content/Context;

    move-result-object v11

    invoke-virtual {v11}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v11

    invoke-virtual {p0}, Landroidx/preference/MiuiShapeSelectPreference;->getContext()Landroid/content/Context;

    move-result-object v12

    const-string v13, "shape_radius"

    invoke-static {v12, v13}, Landroid/Utils/Utils;->DimenToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v12

    invoke-virtual {v11, v12}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v11

    int-to-float v11, v11

    invoke-direct {v10, v11}, Landroid/graphics/CornerPathEffect;-><init>(F)V

    invoke-virtual {v4, v10}, Landroid/graphics/Paint;->setPathEffect(Landroid/graphics/PathEffect;)Landroid/graphics/PathEffect;

    :cond_7f
    const/4 v10, 0x0

    invoke-virtual {v4, v10}, Landroid/graphics/Paint;->setXfermode(Landroid/graphics/Xfermode;)Landroid/graphics/Xfermode;

    int-to-float v10, v7

    invoke-virtual {v4, v10}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    sget-object v10, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v4, v10}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    invoke-virtual {v4, v6}, Landroid/graphics/Paint;->setColor(I)V

    if-eqz v5, :cond_94

    invoke-virtual {v0, v5, v4}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V
    :try_end_94
    .catch Ljava/lang/OutOfMemoryError; {:try_start_39 .. :try_end_94} :catch_96

    :cond_94
    move-object v9, v8

    goto :goto_21

    :catch_96
    move-exception v3

    const-string v10, "InCall"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "CircleAvatarBitmap cause OutOfMemoryError:"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v3}, Ljava/lang/OutOfMemoryError;->getMessage()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_21
.end method

.method private init()V
    .registers 2

    new-instance v0, Landroidx/preference/MiuiShapeSelectPreference$1;

    invoke-direct {v0, p0}, Landroidx/preference/MiuiShapeSelectPreference$1;-><init>(Landroidx/preference/MiuiShapeSelectPreference;)V

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiShapeSelectPreference;->setOnPreferenceClickListener(Landroidx/preference/Preference$OnPreferenceClickListener;)V

    invoke-virtual {p0}, Landroidx/preference/MiuiShapeSelectPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Landroidx/preference/MiuiShapeSelectPreference;->mDensity:F

    return-void
.end method

.method private setPreview()V
    .registers 9

    const/4 v7, 0x0

    iget-object v3, p0, Landroidx/preference/MiuiShapeSelectPreference;->mView:Landroid/view/View;

    if-eqz v3, :cond_49

    new-instance v1, Landroid/widget/ImageView;

    invoke-virtual {p0}, Landroidx/preference/MiuiShapeSelectPreference;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v1, v3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iget-object v3, p0, Landroidx/preference/MiuiShapeSelectPreference;->mView:Landroid/view/View;

    const v4, 0x1020018

    invoke-virtual {v3, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/LinearLayout;

    if-eqz v2, :cond_49

    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->setVisibility(I)V

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getPaddingLeft()I

    move-result v3

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getPaddingTop()I

    move-result v4

    iget v5, p0, Landroidx/preference/MiuiShapeSelectPreference;->mDensity:F

    const/high16 v6, 0x41000000  # 8.0f

    mul-float/2addr v5, v6

    float-to-int v5, v5

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getPaddingBottom()I

    move-result v6

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-lez v0, :cond_3c

    invoke-virtual {v2, v7, v0}, Landroid/widget/LinearLayout;->removeViews(II)V

    :cond_3c
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->setMinimumWidth(I)V

    invoke-direct {p0}, Landroidx/preference/MiuiShapeSelectPreference;->getPreviewBitmap()Landroid/graphics/Bitmap;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    :cond_49
    return-void
.end method


# virtual methods
.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 3

    invoke-super {p0, p1}, Landroidx/preference/Preference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference;->mView:Landroid/view/View;

    if-nez v0, :cond_e

    iget-object v0, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    iput-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference;->mView:Landroid/view/View;

    invoke-direct {p0}, Landroidx/preference/MiuiShapeSelectPreference;->setPreview()V

    :cond_e
    return-void
.end method
