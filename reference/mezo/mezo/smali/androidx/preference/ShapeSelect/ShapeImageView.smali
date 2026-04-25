# classes10.dex

.class public Landroidx/preference/ShapeSelect/ShapeImageView;
.super Landroid/widget/ImageView;
.source "ShapeImageView.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;
    }
.end annotation


# instance fields
.field private mListener:Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0, p0}, Landroidx/preference/ShapeSelect/ShapeImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method


# virtual methods
.method public normalize()V
    .registers 2

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/preference/ShapeSelect/ShapeImageView;->setColorFilter(Landroid/graphics/ColorFilter;)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .registers 5

    new-instance v0, Landroid/graphics/PorterDuffColorFilter;

    const v1, -0xffff01

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v0, v1, v2}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {p0, v0}, Landroidx/preference/ShapeSelect/ShapeImageView;->setColorFilter(Landroid/graphics/ColorFilter;)V

    iget-object v0, p0, Landroidx/preference/ShapeSelect/ShapeImageView;->mListener:Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;

    invoke-virtual {p0}, Landroidx/preference/ShapeSelect/ShapeImageView;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v0, v1}, Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;->OnDrawableClick(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public setOnDrawableClickListener(Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/ShapeSelect/ShapeImageView;->mListener:Landroidx/preference/ShapeSelect/ShapeImageView$OnDrawableClickListener;

    return-void
.end method
