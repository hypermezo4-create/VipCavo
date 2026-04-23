# classes10.dex

.class public Landroidx/preference/FixedSize/PointSeekBarLayout;
.super Landroid/widget/LinearLayout;
.source "PointSeekBarLayout.java"

# interfaces
.implements Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;
    }
.end annotation


# static fields
.field public static TAG:Ljava/lang/String;


# instance fields
.field public labels:[Ljava/lang/String;

.field private listener:Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;

.field private max:Landroid/widget/TextView;

.field private min:Landroid/widget/TextView;

.field private seekBar:Landroidx/preference/FixedSize/PointSeekBar;

.field private summary:Landroid/widget/TextView;

.field private title:Landroid/widget/TextView;

.field private titleValue:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    const-class v0, Landroidx/preference/FixedSize/PointSeekBarLayout;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroidx/preference/FixedSize/PointSeekBarLayout;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 3
    .param p2  # Landroid/util/AttributeSet;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0, p1, p2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 4
    .param p2  # Landroid/util/AttributeSet;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .registers 5

    invoke-direct {p0, p1, p2, p3, p4}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    return-void
.end method


# virtual methods
.method public getMaxView()Landroid/widget/TextView;
    .registers 2

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->max:Landroid/widget/TextView;

    return-object v0
.end method

.method public getMinView()Landroid/widget/TextView;
    .registers 2

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->min:Landroid/widget/TextView;

    return-object v0
.end method

.method public getSummary()Landroid/widget/TextView;
    .registers 2

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->summary:Landroid/widget/TextView;

    return-object v0
.end method

.method public getValue()I
    .registers 3

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v1}, Landroidx/preference/FixedSize/PointSeekBar;->getmCurrentPointIndex()I

    move-result v1

    aget-object v0, v0, v1

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method protected onFinishInflate()V
    .registers 2

    invoke-super {p0}, Landroid/widget/LinearLayout;->onFinishInflate()V

    const v0, 0x102000d

    invoke-virtual {p0, v0}, Landroidx/preference/FixedSize/PointSeekBarLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/preference/FixedSize/PointSeekBar;

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v0, p0}, Landroidx/preference/FixedSize/PointSeekBar;->setSeekBarChangeListener(Landroidx/preference/FixedSize/PointSeekBar$SeekBarChangeListener;)V

    const v0, 0x1020014

    invoke-virtual {p0, v0}, Landroidx/preference/FixedSize/PointSeekBarLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->min:Landroid/widget/TextView;

    const v0, 0x1020015

    invoke-virtual {p0, v0}, Landroidx/preference/FixedSize/PointSeekBarLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->max:Landroid/widget/TextView;

    const v0, 0x1020010

    invoke-virtual {p0, v0}, Landroidx/preference/FixedSize/PointSeekBarLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->summary:Landroid/widget/TextView;

    const v0, 0x1020016

    invoke-virtual {p0, v0}, Landroidx/preference/FixedSize/PointSeekBarLayout;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->title:Landroid/widget/TextView;

    return-void
.end method

.method public onSeekBarChange(I)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->summary:Landroid/widget/TextView;

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    aget-object v1, v1, p1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->listener:Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;

    if-eqz v0, :cond_27

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->listener:Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    aget-object v1, v1, p1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v0, p0, v1}, Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;->OnPointChange(Landroidx/preference/FixedSize/PointSeekBarLayout;I)V

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->listener:Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    aget-object v1, v1, p1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v0, v1}, Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;->OnPointChange(I)V

    :cond_27
    return-void
.end method

.method public setEnabled(Z)V
    .registers 3

    invoke-super {p0, p1}, Landroid/widget/LinearLayout;->setEnabled(Z)V

    if-eqz p1, :cond_14

    const/high16 v0, 0x3f800000  # 1.0f

    :goto_7
    invoke-virtual {p0, v0}, Landroidx/preference/FixedSize/PointSeekBarLayout;->setAlpha(F)V

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    if-eqz v0, :cond_13

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    invoke-virtual {v0, p1}, Landroidx/preference/FixedSize/PointSeekBar;->setEnabled(Z)V

    :cond_13
    return-void

    :cond_14
    const v0, 0x3ecccccd  # 0.4f

    goto :goto_7
.end method

.method public setListener(Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->listener:Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;

    return-void
.end method

.method public setTitle(Ljava/lang/String;)V
    .registers 3

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->title:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public setValue(I)V
    .registers 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetTextI18n"
        }
    .end annotation

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    iget-object v1, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/preference/FixedSize/PointSeekBar;->setCurrentPointIndex(I)V

    iget-object v0, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->summary:Landroid/widget/TextView;

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public setValues(II)V
    .registers 7
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetTextI18n"
        }
    .end annotation

    sub-int v2, p2, p1

    add-int/lit8 v2, v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    iput-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    const/4 v1, 0x0

    move v0, p1

    :goto_a
    add-int/lit8 v2, p2, 0x1

    if-ge v0, v2, :cond_1b

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v1

    add-int/lit8 v1, v1, 0x1

    add-int/lit8 v0, v0, 0x1

    goto :goto_a

    :cond_1b
    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    iget-object v3, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroidx/preference/FixedSize/PointSeekBar;->setLabels([Ljava/lang/String;)V

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    sub-int v3, p2, p1

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v2, v3}, Landroidx/preference/FixedSize/PointSeekBar;->setPointCount(I)V

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->min:Landroid/widget/TextView;

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->max:Landroid/widget/TextView;

    invoke-static {p2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public setValues(III)V
    .registers 8
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "SetTextI18n"
        }
    .end annotation

    sub-int v2, p2, p1

    div-int/2addr v2, p3

    add-int/lit8 v2, v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    iput-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    const/4 v1, 0x0

    move v0, p1

    :goto_b
    add-int/lit8 v2, p2, 0x1

    if-ge v0, v2, :cond_1b

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v1

    add-int/2addr v0, p3

    add-int/lit8 v1, v1, 0x1

    goto :goto_b

    :cond_1b
    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    iget-object v3, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->labels:[Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroidx/preference/FixedSize/PointSeekBar;->setLabels([Ljava/lang/String;)V

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->seekBar:Landroidx/preference/FixedSize/PointSeekBar;

    sub-int v3, p2, p1

    div-int/2addr v3, p3

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v2, v3}, Landroidx/preference/FixedSize/PointSeekBar;->setPointCount(I)V

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->min:Landroid/widget/TextView;

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Landroidx/preference/FixedSize/PointSeekBarLayout;->max:Landroid/widget/TextView;

    invoke-static {p2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
