# classes10.dex

.class public Landroidx/preference/ShapeSelect/ShapeSelect;
.super Lmiuix/appcompat/app/AlertDialog$Builder;
.source "ShapeSelect.java"

# interfaces
.implements Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/ShapeSelect/ShapeSelect$OnShapeChangeListener;
    }
.end annotation


# instance fields
.field private mBuilder:Lmiuix/appcompat/app/AlertDialog;

.field private final mContext:Landroid/content/Context;

.field private mCurShapetoAdd:I

.field private mCurrentShape:I

.field private mListener:Landroidx/preference/ShapeSelect/ShapeSelect$OnShapeChangeListener;

.field private mPanel:Landroidx/preference/ShapeSelect/SwitchPanel;

.field private final mShapeLayout:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroidx/preference/ShapeSelect/ShapeLayout;",
            ">;"
        }
    .end annotation
.end field

.field private final shapes:[I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, v0}, Landroidx/preference/ShapeSelect/ShapeSelect;-><init>(Landroid/content/Context;IZ)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;IZ)V
    .registers 5

    invoke-direct {p0, p1}, Lmiuix/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mShapeLayout:Ljava/util/ArrayList;

    iput-object p1, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mContext:Landroid/content/Context;

    iput p2, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurShapetoAdd:I

    if-eqz p3, :cond_1d

    const/16 v0, 0xf

    new-array v0, v0, [I

    fill-array-data v0, :array_28

    iput-object v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->shapes:[I

    :goto_19
    invoke-direct {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->init()V

    return-void

    :cond_1d
    const/16 v0, 0xd

    new-array v0, v0, [I

    fill-array-data v0, :array_4a

    iput-object v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->shapes:[I

    goto :goto_19

    nop

    :array_28
    .array-data 4
        -0x1
        0x0
        0x4
        0x14
        0xe
        0x5
        0xf
        0x6
        0x10
        0x7
        0x11
        0x8
        0x12
        0x9
        0xa
    .end array-data

    :array_4a
    .array-data 4
        0x0
        0x4
        0xe
        0x5
        0xf
        0x6
        0x10
        0x7
        0x11
        0x8
        0x12
        0x9
        0xa
    .end array-data
.end method

.method static synthetic access$000(Landroidx/preference/ShapeSelect/ShapeSelect;)Landroidx/preference/ShapeSelect/SwitchPanel;
    .registers 2

    iget-object v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mPanel:Landroidx/preference/ShapeSelect/SwitchPanel;

    return-object v0
.end method

.method private createLayout()Landroidx/preference/ShapeSelect/ShapeLayout;
    .registers 12

    const/4 v10, 0x5

    new-instance v3, Landroidx/preference/ShapeSelect/ShapeLayout;

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroidx/preference/ShapeSelect/ShapeLayout;-><init>(Landroid/content/Context;)V

    new-array v1, v10, [Landroid/graphics/drawable/Drawable;

    new-array v0, v10, [Ljava/lang/CharSequence;

    const/4 v2, 0x0

    :goto_f
    if-ge v2, v10, :cond_4e

    const/16 v4, 0x12c

    iget-object v5, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->shapes:[I

    iget v6, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurShapetoAdd:I

    aget v5, v5, v6

    const/high16 v6, 0x41a00000  # 20.0f

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->getContext()Landroid/content/Context;

    move-result-object v8

    const-string v9, "button_position_back"

    invoke-static {v8, v9}, Landroid/Utils/Utils;->ColorToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v8

    invoke-virtual {v7, v8}, Landroid/content/Context;->getColor(I)I

    move-result v7

    invoke-direct {p0, v4, v5, v6, v7}, Landroidx/preference/ShapeSelect/ShapeSelect;->getShapeDrawable(IIFI)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    aput-object v4, v1, v2

    iget-object v4, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->shapes:[I

    iget v5, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurShapetoAdd:I

    aget v4, v4, v5

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v0, v2

    iget v4, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurShapetoAdd:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurShapetoAdd:I

    iget v4, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurShapetoAdd:I

    iget-object v5, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->shapes:[I

    array-length v5, v5

    add-int/lit8 v5, v5, -0x1

    if-le v4, v5, :cond_52

    :cond_4e
    invoke-virtual {v3, v1, v0, p0}, Landroidx/preference/ShapeSelect/ShapeLayout;->setContent([Landroid/graphics/drawable/Drawable;[Ljava/lang/CharSequence;Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;)V

    return-object v3

    :cond_52
    add-int/lit8 v2, v2, 0x1

    goto :goto_f
.end method

.method private getShapeDrawable(IIFI)Landroid/graphics/drawable/Drawable;
    .registers 15

    const/4 v6, 0x0

    :try_start_1
    sget-object v5, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p1, p1, v5}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v4

    new-instance v0, Landroid/graphics/Canvas;

    invoke-direct {v0, v4}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    const/4 v5, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-virtual {v0, v5, v7, v8, v9}, Landroid/graphics/Canvas;->drawARGB(IIII)V

    div-int/lit8 v5, p1, 0x2

    int-to-float v5, v5

    const/high16 v7, 0x40000000  # 2.0f

    div-float v7, p3, v7

    float-to-int v7, v7

    invoke-static {p2, v5, v7}, Landroidx/preference/ShapeSelect/ShapeUtil;->getPath(IFI)Landroid/graphics/Path;

    move-result-object v3

    new-instance v2, Landroid/graphics/Paint;

    invoke-direct {v2}, Landroid/graphics/Paint;-><init>()V

    const/16 v5, 0x14

    if-ne p2, v5, :cond_4b

    const/4 v5, 0x1

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    new-instance v5, Landroid/graphics/CornerPathEffect;

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->getContext()Landroid/content/Context;

    move-result-object v8

    const-string v9, "shape_radius"

    invoke-static {v8, v9}, Landroid/Utils/Utils;->DimenToID(Landroid/content/Context;Ljava/lang/String;)I

    move-result v8

    invoke-virtual {v7, v8}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    int-to-float v7, v7

    invoke-direct {v5, v7}, Landroid/graphics/CornerPathEffect;-><init>(F)V

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setPathEffect(Landroid/graphics/PathEffect;)Landroid/graphics/PathEffect;

    :cond_4b
    const/4 v5, 0x0

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setXfermode(Landroid/graphics/Xfermode;)Landroid/graphics/Xfermode;

    invoke-virtual {v2, p3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    sget-object v5, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    invoke-virtual {v2, p4}, Landroid/graphics/Paint;->setColor(I)V

    if-eqz v3, :cond_5f

    invoke-virtual {v0, v3, v2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    :cond_5f
    new-instance v5, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    invoke-direct {v5, v7, v4}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V
    :try_end_6c
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_6c} :catch_6d

    :goto_6c
    return-object v5

    :catch_6d
    move-exception v1

    const-string v5, "InCall"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "CircleAvatarBitmap cause OutOfMemoryError:"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v1}, Ljava/lang/OutOfMemoryError;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v5, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-object v5, v6

    goto :goto_6c
.end method

.method private init()V
    .registers 8

    const/4 v4, 0x0

    const-string v3, "Selecting a figure"

    invoke-virtual {p0, v3}, Landroidx/preference/ShapeSelect/ShapeSelect;->setTitle(Ljava/lang/CharSequence;)Lmiuix/appcompat/app/AlertDialog$Builder;

    const-string v3, "<"

    invoke-virtual {p0, v3, v4}, Landroidx/preference/ShapeSelect/ShapeSelect;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lmiuix/appcompat/app/AlertDialog$Builder;

    const-string v3, ">"

    invoke-virtual {p0, v3, v4}, Landroidx/preference/ShapeSelect/ShapeSelect;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lmiuix/appcompat/app/AlertDialog$Builder;

    new-instance v0, Landroidx/preference/ShapeSelect/ShapeMarginsView;

    iget-object v3, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mContext:Landroid/content/Context;

    invoke-direct {v0, v3}, Landroidx/preference/ShapeSelect/ShapeMarginsView;-><init>(Landroid/content/Context;)V

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->initSwitchPanel()Landroidx/preference/ShapeSelect/SwitchPanel;

    move-result-object v3

    iput-object v3, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mPanel:Landroidx/preference/ShapeSelect/SwitchPanel;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-static {}, Landroid/Utils/Utils;->getRealWidth()I

    move-result v5

    const/4 v6, -0x1

    invoke-direct {v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v4}, Landroidx/preference/ShapeSelect/ShapeMarginsView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0, v0}, Landroidx/preference/ShapeSelect/ShapeSelect;->setView(Landroid/view/View;)Lmiuix/appcompat/app/AlertDialog$Builder;

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->create()Lmiuix/appcompat/app/AlertDialog;

    move-result-object v3

    iput-object v3, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    iget-object v3, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    invoke-virtual {v3}, Lmiuix/appcompat/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/16 v3, 0x50

    invoke-virtual {v2, v3}, Landroid/view/Window;->setGravity(I)V

    invoke-virtual {v2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    invoke-static {}, Landroid/Utils/Utils;->getRealWidth()I

    move-result v3

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    const/16 v3, 0xc8

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-virtual {v2, v1}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    return-void
.end method

.method private initSwitchPanel()Landroidx/preference/ShapeSelect/SwitchPanel;
    .registers 6

    new-instance v1, Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v1, v3}, Landroidx/preference/ShapeSelect/SwitchPanel;-><init>(Landroid/content/Context;)V

    const/16 v3, 0xa

    invoke-virtual {v1, v3}, Landroidx/preference/ShapeSelect/SwitchPanel;->setIndicatorMarginBottom(I)V

    const/4 v0, 0x0

    :goto_f
    const/4 v3, 0x3

    if-ge v0, v3, :cond_31

    iget-object v3, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mShapeLayout:Ljava/util/ArrayList;

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->createLayout()Landroidx/preference/ShapeSelect/ShapeLayout;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v3, -0x1

    const/16 v4, 0xc8

    invoke-direct {v2, v3, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    iget-object v3, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mShapeLayout:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/view/View;

    invoke-virtual {v1, v3, v2}, Landroidx/preference/ShapeSelect/SwitchPanel;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_f

    :cond_31
    return-object v1
.end method

.method private unChecked(Ljava/lang/CharSequence;)V
    .registers 5

    iget-object v1, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mShapeLayout:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_6
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_16

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/preference/ShapeSelect/ShapeLayout;

    invoke-virtual {v0, p1}, Landroidx/preference/ShapeSelect/ShapeLayout;->unChecked(Ljava/lang/CharSequence;)V

    goto :goto_6

    :cond_16
    return-void
.end method

.method private unCheckedAll()V
    .registers 4

    iget-object v1, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mShapeLayout:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_6
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_16

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/preference/ShapeSelect/ShapeLayout;

    invoke-virtual {v0}, Landroidx/preference/ShapeSelect/ShapeLayout;->unCheckedAll()V

    goto :goto_6

    :cond_16
    return-void
.end method


# virtual methods
.method public OnDrawableClick(Ljava/lang/CharSequence;)V
    .registers 5

    if-eqz p1, :cond_22

    check-cast p1, Ljava/lang/String;

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iget v1, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurrentShape:I

    if-eq v0, v1, :cond_22

    iget v1, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurrentShape:I

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Landroidx/preference/ShapeSelect/ShapeSelect;->unChecked(Ljava/lang/CharSequence;)V

    iput v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurrentShape:I

    iget-object v1, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mListener:Landroidx/preference/ShapeSelect/ShapeSelect$OnShapeChangeListener;

    if-eqz v1, :cond_22

    iget-object v1, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mListener:Landroidx/preference/ShapeSelect/ShapeSelect$OnShapeChangeListener;

    iget v2, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurrentShape:I

    invoke-interface {v1, v2}, Landroidx/preference/ShapeSelect/ShapeSelect$OnShapeChangeListener;->OnShapeChange(I)V

    :cond_22
    return-void
.end method

.method public setCurrentShape(I)Landroidx/preference/ShapeSelect/ShapeSelect;
    .registers 6

    invoke-direct {p0}, Landroidx/preference/ShapeSelect/ShapeSelect;->unCheckedAll()V

    iput p1, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mCurrentShape:I

    const/4 v0, 0x0

    iget-object v2, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mShapeLayout:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_c
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2a

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/preference/ShapeSelect/ShapeLayout;

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroidx/preference/ShapeSelect/ShapeLayout;->setChecked(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_27

    iget-object v3, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mPanel:Landroidx/preference/ShapeSelect/SwitchPanel;

    invoke-virtual {v3, v0}, Landroidx/preference/ShapeSelect/SwitchPanel;->scrollTo(I)V

    :cond_27
    add-int/lit8 v0, v0, 0x1

    goto :goto_c

    :cond_2a
    return-object p0
.end method

.method public setOnShapeChangeListener(Landroidx/preference/ShapeSelect/ShapeSelect$OnShapeChangeListener;)Landroidx/preference/ShapeSelect/ShapeSelect;
    .registers 2

    iput-object p1, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mListener:Landroidx/preference/ShapeSelect/ShapeSelect$OnShapeChangeListener;

    return-object p0
.end method

.method public show()Lmiuix/appcompat/app/AlertDialog;
    .registers 3

    iget-object v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    invoke-virtual {v0}, Lmiuix/appcompat/app/AlertDialog;->show()V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    const/4 v1, -0x2

    invoke-virtual {v0, v1}, Lmiuix/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v0

    new-instance v1, Landroidx/preference/ShapeSelect/ShapeSelect$1;

    invoke-direct {v1, p0}, Landroidx/preference/ShapeSelect/ShapeSelect$1;-><init>(Landroidx/preference/ShapeSelect/ShapeSelect;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    const/4 v1, -0x3

    invoke-virtual {v0, v1}, Lmiuix/appcompat/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v0

    new-instance v1, Landroidx/preference/ShapeSelect/ShapeSelect$2;

    invoke-direct {v1, p0}, Landroidx/preference/ShapeSelect/ShapeSelect$2;-><init>(Landroidx/preference/ShapeSelect/ShapeSelect;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/ShapeSelect;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    return-object v0
.end method
