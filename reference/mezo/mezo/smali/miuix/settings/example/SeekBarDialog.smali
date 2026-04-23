# classes10.dex

.class public Lmiuix/settings/example/SeekBarDialog;
.super Lmiuix/appcompat/app/AlertDialog$Builder;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;
    }
.end annotation


# instance fields
.field private firstInitial:Z

.field private mBuilder:Lmiuix/appcompat/app/AlertDialog;

.field private mContext:Landroid/content/Context;

.field private mCurent:I

.field private mListener:Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;

.field private mMax:I

.field private mMin:I

.field private mSeekBar:Lmiuix/androidbasewidget/widget/SeekBar;

.field private mTitle:Ljava/lang/String;

.field private mTitleView:Landroid/widget/TextView;

.field private negativeClickListener:Landroid/content/DialogInterface$OnClickListener;

.field private positiveClickListener:Landroid/content/DialogInterface$OnClickListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    invoke-direct {p0, p1}, Lmiuix/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lmiuix/settings/example/SeekBarDialog;->firstInitial:Z

    iput-object p1, p0, Lmiuix/settings/example/SeekBarDialog;->mContext:Landroid/content/Context;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;IIILjava/lang/String;Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;)V
    .registers 7

    invoke-direct {p0, p1}, Lmiuix/settings/example/SeekBarDialog;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lmiuix/settings/example/SeekBarDialog;->mContext:Landroid/content/Context;

    iput p3, p0, Lmiuix/settings/example/SeekBarDialog;->mMax:I

    iput p2, p0, Lmiuix/settings/example/SeekBarDialog;->mMin:I

    iput p4, p0, Lmiuix/settings/example/SeekBarDialog;->mCurent:I

    iput-object p6, p0, Lmiuix/settings/example/SeekBarDialog;->mListener:Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;

    iput-object p5, p0, Lmiuix/settings/example/SeekBarDialog;->mTitle:Ljava/lang/String;

    invoke-virtual {p0}, Lmiuix/settings/example/SeekBarDialog;->init()Lmiuix/settings/example/SeekBarDialog;

    return-void
.end method

.method static synthetic access$000(Lmiuix/settings/example/SeekBarDialog;)Ljava/lang/String;
    .registers 2

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mTitle:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lmiuix/settings/example/SeekBarDialog;)Landroid/widget/TextView;
    .registers 2

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mTitleView:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$200(Lmiuix/settings/example/SeekBarDialog;)Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;
    .registers 2

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mListener:Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;

    return-object v0
.end method


# virtual methods
.method public init()Lmiuix/settings/example/SeekBarDialog;
    .registers 14
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetTextI18n"
        }
    .end annotation

    const/16 v12, 0x32

    const/4 v8, -0x1

    const/4 v11, 0x0

    iget-boolean v7, p0, Lmiuix/settings/example/SeekBarDialog;->firstInitial:Z

    if-eqz v7, :cond_c6

    iget-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mContext:Landroid/content/Context;

    invoke-virtual {v7}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mContext:Landroid/content/Context;

    new-instance v7, Landroid/widget/TextView;

    iget-object v9, p0, Lmiuix/settings/example/SeekBarDialog;->mContext:Landroid/content/Context;

    invoke-direct {v7, v9}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mTitleView:Landroid/widget/TextView;

    iget-object v9, p0, Lmiuix/settings/example/SeekBarDialog;->mTitleView:Landroid/widget/TextView;

    invoke-static {}, Landroid/Utils/Utils;->isNightMode()Z

    move-result v7

    if-eqz v7, :cond_c7

    move v7, v8

    :goto_22
    invoke-virtual {v9, v7}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mTitleView:Landroid/widget/TextView;

    const/high16 v9, 0x41a00000  # 20.0f

    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setTextSize(F)V

    const-string v7, "Set"

    iget-object v9, p0, Lmiuix/settings/example/SeekBarDialog;->positiveClickListener:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {p0, v7, v9}, Lmiuix/settings/example/SeekBarDialog;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lmiuix/appcompat/app/AlertDialog$Builder;

    iget-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mTitleView:Landroid/widget/TextView;

    invoke-virtual {p0, v7}, Lmiuix/settings/example/SeekBarDialog;->setCustomTitle(Landroid/view/View;)Lmiuix/appcompat/app/AlertDialog$Builder;

    iget-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mTitleView:Landroid/widget/TextView;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v10, p0, Lmiuix/settings/example/SeekBarDialog;->mTitle:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "  "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget v10, p0, Lmiuix/settings/example/SeekBarDialog;->mCurent:I

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mTitleView:Landroid/widget/TextView;

    const/16 v9, 0x1e

    invoke-virtual {v7, v9, v11, v11, v11}, Landroid/widget/TextView;->setPadding(IIII)V

    new-instance v5, Lmiuix/androidbasewidget/widget/SeekBar;

    invoke-direct {v5, v0}, Lmiuix/androidbasewidget/widget/SeekBar;-><init>(Landroid/content/Context;)V

    iget v7, p0, Lmiuix/settings/example/SeekBarDialog;->mMax:I

    invoke-virtual {v5, v7}, Lmiuix/androidbasewidget/widget/SeekBar;->setMax(I)V

    iget v7, p0, Lmiuix/settings/example/SeekBarDialog;->mMin:I

    invoke-virtual {v5, v7}, Lmiuix/androidbasewidget/widget/SeekBar;->setMin(I)V

    iget v7, p0, Lmiuix/settings/example/SeekBarDialog;->mCurent:I

    invoke-virtual {v5, v7}, Lmiuix/androidbasewidget/widget/SeekBar;->setProgress(I)V

    const/16 v7, 0x19

    invoke-virtual {v5, v11, v11, v11, v7}, Lmiuix/androidbasewidget/widget/SeekBar;->setPadding(IIII)V

    new-instance v7, Lmiuix/settings/example/SeekBarDialog$1;

    invoke-direct {v7, p0}, Lmiuix/settings/example/SeekBarDialog$1;-><init>(Lmiuix/settings/example/SeekBarDialog;)V

    invoke-virtual {v5, v7}, Lmiuix/androidbasewidget/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    iput-object v5, p0, Lmiuix/settings/example/SeekBarDialog;->mSeekBar:Lmiuix/androidbasewidget/widget/SeekBar;

    new-instance v1, Landroid/widget/LinearLayout;

    iget-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mContext:Landroid/content/Context;

    invoke-direct {v1, v7}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v8, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/4 v7, 0x1

    iput v7, v3, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    invoke-virtual {v1, v12, v11, v12, v11}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    iget-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mSeekBar:Lmiuix/androidbasewidget/widget/SeekBar;

    invoke-virtual {v1, v7, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0, v1}, Lmiuix/settings/example/SeekBarDialog;->setView(Landroid/view/View;)Lmiuix/appcompat/app/AlertDialog$Builder;

    invoke-virtual {p0}, Lmiuix/settings/example/SeekBarDialog;->create()Lmiuix/appcompat/app/AlertDialog;

    move-result-object v7

    iput-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    iget-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    invoke-virtual {v7, v11}, Lmiuix/appcompat/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    iget-object v7, p0, Lmiuix/settings/example/SeekBarDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    invoke-virtual {v7}, Lmiuix/appcompat/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v6

    const/16 v7, 0x50

    invoke-virtual {v6, v7}, Landroid/view/Window;->setGravity(I)V

    const/high16 v7, 0x3f000000  # 0.5f

    invoke-virtual {v6, v7}, Landroid/view/Window;->setDimAmount(F)V

    invoke-virtual {v6}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    invoke-static {}, Landroid/Utils/Utils;->getRealWidth()I

    move-result v7

    iput v7, v2, Landroid/view/WindowManager$LayoutParams;->width:I

    invoke-virtual {v6, v2}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    iput-boolean v11, p0, Lmiuix/settings/example/SeekBarDialog;->firstInitial:Z

    :cond_c6
    return-object p0

    :cond_c7
    const/high16 v7, -0x1000000

    goto/16 :goto_22
.end method

.method public setCurent(I)Lmiuix/settings/example/SeekBarDialog;
    .registers 4

    iput p1, p0, Lmiuix/settings/example/SeekBarDialog;->mCurent:I

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mSeekBar:Lmiuix/androidbasewidget/widget/SeekBar;

    if-eqz v0, :cond_d

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mSeekBar:Lmiuix/androidbasewidget/widget/SeekBar;

    iget v1, p0, Lmiuix/settings/example/SeekBarDialog;->mCurent:I

    invoke-virtual {v0, v1}, Lmiuix/androidbasewidget/widget/SeekBar;->setProgress(I)V

    :cond_d
    return-object p0
.end method

.method public setMax(I)Lmiuix/settings/example/SeekBarDialog;
    .registers 4

    iput p1, p0, Lmiuix/settings/example/SeekBarDialog;->mMax:I

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mSeekBar:Lmiuix/androidbasewidget/widget/SeekBar;

    if-eqz v0, :cond_d

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mSeekBar:Lmiuix/androidbasewidget/widget/SeekBar;

    iget v1, p0, Lmiuix/settings/example/SeekBarDialog;->mMax:I

    invoke-virtual {v0, v1}, Lmiuix/androidbasewidget/widget/SeekBar;->setMax(I)V

    :cond_d
    return-object p0
.end method

.method public setMin(I)Lmiuix/settings/example/SeekBarDialog;
    .registers 4

    iput p1, p0, Lmiuix/settings/example/SeekBarDialog;->mMin:I

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mSeekBar:Lmiuix/androidbasewidget/widget/SeekBar;

    if-eqz v0, :cond_d

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mSeekBar:Lmiuix/androidbasewidget/widget/SeekBar;

    iget v1, p0, Lmiuix/settings/example/SeekBarDialog;->mMin:I

    invoke-virtual {v0, v1}, Lmiuix/androidbasewidget/widget/SeekBar;->setMin(I)V

    :cond_d
    return-object p0
.end method

.method public setNegativeClickListener(Landroid/content/DialogInterface$OnClickListener;)Lmiuix/settings/example/SeekBarDialog;
    .registers 2

    iput-object p1, p0, Lmiuix/settings/example/SeekBarDialog;->negativeClickListener:Landroid/content/DialogInterface$OnClickListener;

    return-object p0
.end method

.method public setOnProgressChangeListener(Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;)Lmiuix/settings/example/SeekBarDialog;
    .registers 2

    iput-object p1, p0, Lmiuix/settings/example/SeekBarDialog;->mListener:Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;

    return-object p0
.end method

.method public setPositiveClickListener(Landroid/content/DialogInterface$OnClickListener;)Lmiuix/settings/example/SeekBarDialog;
    .registers 2

    iput-object p1, p0, Lmiuix/settings/example/SeekBarDialog;->positiveClickListener:Landroid/content/DialogInterface$OnClickListener;

    return-object p0
.end method

.method public setTitle(Ljava/lang/String;)Lmiuix/settings/example/SeekBarDialog;
    .registers 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetTextI18n"
        }
    .end annotation

    iput-object p1, p0, Lmiuix/settings/example/SeekBarDialog;->mTitle:Ljava/lang/String;

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mTitleView:Landroid/widget/TextView;

    if-eqz v0, :cond_26

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mTitleView:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lmiuix/settings/example/SeekBarDialog;->mTitle:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lmiuix/settings/example/SeekBarDialog;->mCurent:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_26
    return-object p0
.end method

.method public show()Lmiuix/appcompat/app/AlertDialog;
    .registers 2

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    invoke-virtual {v0}, Lmiuix/appcompat/app/AlertDialog;->show()V

    iget-object v0, p0, Lmiuix/settings/example/SeekBarDialog;->mBuilder:Lmiuix/appcompat/app/AlertDialog;

    return-object v0
.end method
